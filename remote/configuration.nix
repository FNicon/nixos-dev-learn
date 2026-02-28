{ modulesPath, ... }:

let
  diskDevice = "/dev/sda";
  sources = import ./npins;
in
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    (sources.disko + "/module.nix")
    ./single-disk-layout.nix
  ];

  disko.devices.disk.main.device = diskDevice;

  boot.loader.grub = {
    devices = [ diskDevice ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  services.openssh.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    "<your SSH key here>"
  ];

  system.stateVersion = "24.11";
}