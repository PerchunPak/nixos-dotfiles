{ ... }:
final: prev: {
  hashcat = prev.hashcat.overrideAttrs (old: {
    version = "6716447";

    src = final.fetchFromGitHub {
      owner = "hashcat";
      repo = "hashcat";
      rev = "6716447dfce969ddde42a9abe0681500bee0df48";
      hash = "sha256-adDVPpeVAw917IpFeOq2FT/VUaKHQh1k8ljgDEcWi/k=";
    };
  });
}
