{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz";
in
{
  imports = [
    ./hardware-configuration.nix
    (import "${home-manager}/nixos")
  ];

  # Bootloader (VM Grub)
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Toronto";

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

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.firefox.enable = true;
  programs.dconf.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.rocket = {
    isNormalUser = true;
    description = "rocket";
    extraGroups = [ "networkmanager" "wheel" ];
    home = "/home/rocket";
  };

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "rocket";
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  services.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.desktop.interface]
    color-scheme='prefer-dark'
  '';

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

  environment.systemPackages = with pkgs; [
    curl wget yad git just gnome-tweaks gnome-extension-manager
    gnomeExtensions.dash-to-dock
    wl-clipboard xclip # Clipboard tools needed by the app
  ];

  ####################################################################
  ### HOME MANAGER SETTINGS
  ####################################################################
  home-manager.users.rocket = { pkgs, ... }: 
  let
    # Build ClipCascade directly in Nix
    clipcascade = pkgs.python3Packages.buildPythonApplication {
      pname = "clipcascade";
      version = "latest";
      src = pkgs.fetchFromGitHub {
        owner = "Sathvik-Rao";
        repo = "ClipCascade";
        rev = "main";
        # RERUN REBUILD: Change this to the hash Nix gives you in the error message
        sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; 
      };
      propagatedBuildInputs = with pkgs.python3Packages; [
        pyqt5
        requests
        pynput
      ];
      doCheck = false;
      # This fixes the "no entry point" issue
      format = "other";
      installPhase = ''
        mkdir -p $out/bin $out/share/clipcascade
        cp -r * $out/share/clipcascade
        makeWrapper ${pkgs.python3}/bin/python $out/bin/clipcascade \
          --add-flags "$out/share/clipcascade/main.py" \
          --prefix PYTHONPATH : "$PYTHONPATH:$out/share/clipcascade"
      '';
      nativeBuildInputs = [ pkgs.makeWrapper ];
    };
  in {
    home.stateVersion = "25.11";
    xdg.enable = true;
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };

    # Systemd service defined inside Home Manager
    systemd.user.services.clipcascade = {
      Unit = {
        Description = "ClipCascade Clipboard Sync";
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${clipcascade}/bin/clipcascade";
        Restart = "always";
        RestartSec = 5;
        Environment = "PATH=${pkgs.lib.makeBinPath [ pkgs.wl-clipboard pkgs.xclip ]}";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    programs.bash = {
      enable = true;
      shellAliases = {
        rebuild = "sudo nixos-rebuild switch";
        edit = "sudo nano /etc/nixos/configuration.nix";
      };
    };

    gtk.gtk3.bookmarks = [
      "file:///home/rocket/Downloads"
      "file:///etc/nixos Nix Config"
    ];

    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "dash-to-dock@micxgx.gmail.com"
          "clipboard-indicator@tudmotu.com"
          "appindicatorsupport@rgcjonas.gmail.com"
        ];
      };
    };
  };

  system.stateVersion = "25.11";
}