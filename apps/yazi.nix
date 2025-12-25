{ ... }: 
{
    programs.yazi = {
        enable = true;
        enableZshIntegration = true;
        settings = {
            openner = {
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
