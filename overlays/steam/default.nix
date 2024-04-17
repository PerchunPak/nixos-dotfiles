{...}: final: prev: {
  steam = prev.steam.override {
    extraPkgs = pkgs:
      with pkgs; [
        openssl_1_1
      ];
  };
}
