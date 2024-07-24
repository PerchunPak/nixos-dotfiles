{
  xdg.configFile =
    let
      icons = [
        # name & hash
        [
          "hibernate"
          "sha256:02b7ydrksg6gr8hh24ydlngm57qvg2r37lihc1572hxgbxlcgxr3"
        ]
        [
          "lock"
          "sha256:1kx16df8npaxxi80g9wc6jj3n79pwn40g498v38nicsg12dpahc4"
        ]
        [
          "logout"
          "sha256:1kq5lq05nl3b56v595h3frdfshnjipd2pq642xhhvd3s2balqk39"
        ]
        [
          "reboot"
          "sha256:1j3m6k7n1sdsh380w4hcarak3xdkrhybpczrcg6p2f156d6x271j"
        ]
        [
          "shutdown"
          "sha256:12zcdqcj6yb5kvg56dqh8sp2y4pmgj2254grzmpjdxhvmgsvqv89"
        ]
        [
          "suspend"
          "sha256:1kyq2pnmhhzv8n5z18az7h8z9hrw103m3dn4zp597y439xx584hy"
        ]
      ];
    in
    builtins.listToAttrs (
      map (value: {
        name = "wlogout/icons/${builtins.elemAt value 0}.png";
        value = {
          source = builtins.fetchurl {
            url = "https://raw.githubusercontent.com/PerchunPak/storage/6645de6e8280ee0a6d0839ad550a5246972e3eec/wlogout-icons/${builtins.elemAt value 0}.png";
            sha256 = builtins.elemAt value 1;
          };
        };
      }) icons
    );
}
