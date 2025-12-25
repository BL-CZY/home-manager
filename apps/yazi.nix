{ ... }: 
{
    programs.yazi = {
        enable = true;
        enableZshIntegration = true;
        settings = {
            opener = {
                edit = [
                    {
                        run = "nvim \"$@\"";
                        block = true;
                        desc = "Neovim";
                        for = "unix";
                    }
                ];
            };

            open = {
                rules = [
                    {
                        mime = "text/*";
                        use = "edit";
                    }
                ];
            };
        };
    };
}
