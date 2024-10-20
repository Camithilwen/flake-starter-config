# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs,  ... }:
#remember to add inputs back ^
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
#      ./main-user.nix
#      inputs.home-manager.nixosModules.default
#      <home-manager/nixos>
    ];

#  main-user.enable = true;
#  main-user.userName = "jam";

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
 #  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
#   security.pki.certificateFiles = ["~/networking/certificates/shepherd/OnboardCertificate.pkcs12"];
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = lib.optionalString (config.nix.package == pkgs.nixFlakes)
      "experimental-features = nix-command flakes";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jam = {
    isNormalUser = true;
    description = "Jamie Kemman";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      kate
      thunderbird
    ];
  };

#  home-manager.users.jam = { pkgs, ... }: {
 #  home.packages = with pkgs; [];
  # programs.bash.enable = true;
   #home.stateVersion = "23.11";
#  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	pkgs.bluej
	pkgs.jdk21
	(python311.withPackages(ps: with ps; [ pandas ipykernel pip jupyter jupytext tkinter]))
#	pkgs.python311Packages.jupyter
#	pkgs.python311Packages.jupytext
	pkgs.jupyter-all
	pkgs.git
	pkgs.obsidian
	pkgs.gimp
	pkgs.vlc
	pkgs.steam
	pkgs.discord
	pkgs.wireshark
	pkgs.rustup
	pkgs.brave
	pkgs.libreoffice-fresh
	pkgs.throttled
	pkgs.fwupd
	pkgs.thunderbird
	pkgs.protonmail-bridge
	pkgs.spotifyd
	pkgs.zoom-us
	pkgs.qemu
	pkgs.gns3-gui
	pkgs.blender
	pkgs.openssl 	
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  	pkgs.wget
#	pkgs.home-manager
	pkgs.vscodium-fhs
	pkgs.vscode-fhs
	pkgs.qemu
	pkgs.wine	
	pkgs.virt-manager
	pkgs.libvirt
	pkgs.dconf
	pkgs.spotify
	pkgs.rustdesk
	pkgs.remmina
	pkgs.kdePackages.krdc
	pkgs.openvpn
	pkgs.openvpn3
	pkgs.gtk4
	pkgs.gtk3
	pkgs.gtk2
#	pkgs.python311Packages.ipykernel
#	pkgs.python311Packages.pip
	pkgs.ollama
#	pkgs.python311Packages.pandas
#	pkgs.kooha
#	pkgs.gpu-screen-recorder
	pkgs.simplescreenrecorder
	pkgs.olive-editor
	pkgs.bfg-repo-cleaner
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };
   virtualisation.libvirtd.enable = true;
   programs.virt-manager.enable = true;


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
