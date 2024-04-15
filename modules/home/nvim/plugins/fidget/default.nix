# bottom left notifications
{
  programs.nixvim.plugins = {
    fidget = {
      enable = true;
      notification.window.winblend = 0;
    };
  };
}
