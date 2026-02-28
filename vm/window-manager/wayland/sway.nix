{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  # SWAY
  programs.sway.enable = true;

  # hardware.graphics.extraPackages = [ rocmPackages.clr.icd ];

}