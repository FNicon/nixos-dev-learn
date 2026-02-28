let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-25.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.testers.runNixOSTest {
  name = "minimal-test";

  nodes.machine = { config, pkgs, ... }: {
    imports = [ 
      ./../vm/configuration.nix
    ];
    #   users.users.alice = {
    #     isNormalUser = true;
    #     extraGroups = [ "wheel" ];
    #     packages = with pkgs; [
    #       firefox
    #       tree
    #     ];
    #   };

    #   system.stateVersion = "25.11";
  };

  testScript = ''
    machine.wait_for_unit("default.target")
    machine.succeed("su -- alice -c 'which firefox'")
    machine.fail("su -- root -c 'which firefox'")
  '';
}