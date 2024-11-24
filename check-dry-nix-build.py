import concurrent.futures
import json
import re
import subprocess
import sys
from pathlib import Path


def get_blacklist() -> list[str]:
    with (Path(__file__).parent / "blacklist.txt").open("r") as f:
        return [line.strip() for line in f.readlines()]


def handle_line(line: str) -> None:
    raw_data = subprocess.check_output(
        ["nix", "derivation", "show", line], stderr=subprocess.DEVNULL
    )
    data = json.loads(raw_data)
    return data[line]["env"].get("pname", data[line]["name"])


def parse_stdin(
    pool: concurrent.futures.ThreadPoolExecutor,
) -> dict[concurrent.futures.Future, str]:
    start_handling = False
    future_to_line = dict()
    for line in sys.stdin:
        line = line.strip()
        if not start_handling:
            start_handling = (
                re.match(r"^these \d+ derivations will be built:$", line) is not None
            )
            continue
        if re.match(r"^these \d+ paths will be fetched", line) is not None:
            break

        future_to_line[pool.submit(handle_line, line)] = line

    return future_to_line


def handle_results(
    future_to_line: dict[concurrent.futures.Future, str], blacklist: list[str]
) -> bool:
    for future in concurrent.futures.as_completed(future_to_line.keys()):
        line = future_to_line[future]
        try:
            name = future.result(60)
        except Exception as e:
            print(f"{line!r} generated an error: {e!r}")
        else:
            if name in blacklist:
                print(f"{name!r} is blacklisted!")
                return False

    return True


def main() -> None:
    blacklist = get_blacklist()

    with concurrent.futures.ThreadPoolExecutor(max_workers=100) as pool:
        future_to_line = parse_stdin(pool)

    result = handle_results(future_to_line, blacklist)
    if result is False:
        sys.exit(1)


if __name__ == "__main__":
    main()
