local colorscheme = "catppuccin"
if vim.g.vscode then
  colorscheme = "default"
end

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 5000,
    opts = {
      flavour = "mocha",
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = colorscheme,
    },
  },
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },
}
