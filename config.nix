{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "froko-tools";
      paths = [
        fd
        fzf
        ripgrep
        starship
        bash-completion
        neovim
        tmux
        nodejs_20
        corepack_20
        dotnet-sdk_8
        lazygit
      ];
    };
  };
}
