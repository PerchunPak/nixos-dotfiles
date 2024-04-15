# Collection of various small independent plugins/modules
{
  inputs,
  system,
  ...
}: let
  nixvimHelpers = inputs.nixvim.lib.${system}.helpers;
in {
  programs.nixvim = {
    plugins.mini = {
      enable = true;
      modules = {
        # Better Around/Inside textobjects
        #
        # Examples:
        #  - va)  - [V]isually select [A]round [)]paren
        #  - yinq - [Y]ank [I]nside [N]ext [']quote
        #  - ci'  - [C]hange [I]nside [']quote
        ai = {
          n_lines = 500;
        };
        # Add/delete/replace surroundings (brackets, quotes, etc.)
        #
        # - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        # - sd'   - [S]urround [D]elete [']quotes
        # - sr)'  - [S]urround [R]eplace [)] [']
        surround = {};
        # Simple and easy statusline.
        #  You could remove this setup call if you don't like it,
        #  and try some other statusline plugin
        statusline.use_icons = true;
        indentscope = {
          draw = {
            delay = 0;
            animation = nixvimHelpers.mkRaw "function() return 0 end"; # disable animation
            priority = 2;
          };
          options = {
            try_as_border = true;
            border = "top";
          };
          symbol = "▎";
        };
        basics = {};
        bracketed = {};
        comment = {};
      };
    };
    extraConfigLua = ''
      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      MiniStatusline.section_location = function()
        return "%2l:%-2v"
      end
    '';
  };
}
