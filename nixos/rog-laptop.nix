{ config, pkgs, ... }:

let
  # Fetching the 25.11 compatible Home Manager
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz";
in
{
  imports = [ 
    ./hardware-configuration.nix
    (import "${home-manager}/nixos")
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # VM Bootloader
  #boot.loader.grub.enable = true;
  #boot.loader.grub.device = "/dev/sda";

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

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

  # GNOME Setup
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = true;
  services.desktopManager.gnome.enable = true;

  # Keymap
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Printing
  services.printing.enable = true;

  # Sound with pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Programs
  programs.firefox.enable = true;
  programs.dconf.enable = true;

  # Nix Settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # User Account
  users.users.rocket = {
    isNormalUser = true;
    description = "rocket";
    extraGroups = [ "networkmanager" "wheel" ];
    home = "/home/rocket";
  };

  # Automatic login
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "rocket";

  # Workaround for GNOME autologin
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # System-wide GNOME Customization
  services.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.desktop.interface]
    color-scheme='prefer-dark'
  '';

  # Flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gnome ];

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    deskflow
    blackbox-terminal
    curl
    wget
    yad
    git
    just
    dconf-editor
    gnome-tweaks
    gnome-extension-manager
    gnomeExtensions.open-bar
    gnomeExtensions.gsconnect
    gnomeExtensions.dash-to-dock
    gnomeExtensions.dash-to-panel
    gnomeExtensions.accent-gtk-theme
    gnomeExtensions.accent-icons-theme
    gnomeExtensions.arcmenu
    gnomeExtensions.blur-my-shell
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.gtk4-desktop-icons-ng-ding
    gnomeExtensions.media-controls
    gnomeExtensions.network-stats
    gnomeExtensions.removable-drive-menu
    gnomeExtensions.simpleweather
    gnomeExtensions.tiling-assistant
    gnomeExtensions.user-themes
    gnomeExtensions.appindicator
    gnomeExtensions.burn-my-windows
    gnomeExtensions.compiz-windows-effect
  ];

  ####################################################################
  ### HOME MANAGER SETTINGS (User specific)
  ####################################################################
  home-manager.users.rocket = { pkgs, ... }: {
    home.stateVersion = "25.11";

#    # Git Config
#    programs.git = {
#      enable = true;
#      userName = "rocket";
#      userEmail = "rocket@example.com"; # Change this to your actual email
#    };

    # Bash Aliases
    programs.bash = {
      enable = true;
      shellAliases = {
        rebuild = "sudo nixos-rebuild switch";
        pull-rebuild ="sudo curl -fsSL https://raw.githubusercontent.com/rocketpowerinc/dotfiles/refs/heads/main/nixos/rog-laptop.nix | sudo tee /etc/nixos/configuration.nix > /dev/null && sudo nixos-rebuild switch"
        edit = "sudo nano /etc/nixos/configuration.nix";
      };
    };

    # GNOME Dconf settings
    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        # Automatically enables these extensions on login
        enabled-extensions = [
          "openbar@openbar.org"
          "gsconnect@andyholmes.github.io"
          "dash-to-dock@micxgx.gmail.com"
          "dash-to-panel@jderose9.github.com"
          "accent-gtk-theme@pavel-v-p.github.io"
          "accent-icons-theme@pavel-v-p.github.io"
          "arcmenu@arcmenu.com"
          "blur-my-shell@aunetx"
          "clipboard-indicator@tudmotu.com"
          "ding@rastersoft.com"
          "mediacontrols@cliffniff.github.com"
          "netstats@mivoligo.org"
          "removable-drive-menu@gnome-shell-extensions.gcampax.github.com"
          "simpleweather@mivoligo.org"
          "tiling-assistant@leleat-on-github"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "appindicatorsupport@rgcjonas.gmail.com"
          "burn-my-windows@tomaszgasior.pl"
          "compiz-windows-effect@hermes81"
        ];
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        clock-show-weekday = true;
        clock-show-seconds = false;
      };
    };
  };

  # System State Version
  system.stateVersion = "25.11";
}