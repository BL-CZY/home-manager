{ config, pkgs, ... }:

{
  gtk = {
      enable = true;
      colorScheme = "dark";
      iconTheme = {
          package = pkgs.papirus-icon-theme;
          name = "Papirus-Dark";
      };
  };

  qt = {
      enable = true;
      platformTheme.name = "gtk";
      style = {
        name = "qt6gtk2";
      };
  };

  home.pointerCursor = {
      enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      x11.enable = true;
      gtk.enable = true;
      size = 24;
  };
}
