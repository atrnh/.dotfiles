if not vim.g.vscode then
  return {}
end

local enabled = {
  "vim-repeat",
  "vim-sandwich",
  "flash.nvim",
  "nvim-treesitter",
  "nvim-treesitter-textobjects",
  "nvim-ts-context-commentstring",
  "ts-comments.nvim",
  "vim-table-mode",
  "vim-rst-sections",
  "LazyVim",
}

local Config = require("lazy.core.config")
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
  return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end

-- VS Code keymap and command overrides
local vscode = require("vscode")
-- Keymap
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimKeymapsDefaults",
  callback = function()
    local map = vim.keymap.set

    map({ "n", "v" }, "<leader>cr", function()
      vscode.call("rewrap.rewrapComment")
      vscode.notify("Called rewrap")
    end, { desc = "Rewrap", noremap = true })

    map({ "n", "v" }, "<leader>cf", function()
      vscode.call("editor.action.formatSelection")
      vscode.notify("Called formatSelection")
    end, { desc = "Format" })

    map(
      { "o", "x" },
      "gc",
      "<Cmd>call VSCodeCall('editor.action.commentLine')<CR><Esc>",
      { desc = "Toggle comment", noremap = true }
    )

    map(
      "n",
      "gc",
      "<Cmd>call VSCodeCall('editor.action.commentLine')<CR><Esc>",
      { desc = "Toggle comment linewise", noremap = true }
    )

    map("v", "sw", function()
      vscode.call("editor.action.surroundWithSnippet")
    end, { desc = "Surround with snippet", noremap = true })
  end,
})

local function init(_)
  local nvim_set_hl = vim.api.nvim_set_hl
  nvim_set_hl(0, "FlashCurrent", { fg = "#6c7086", underline = true })
  nvim_set_hl(0, "FlashBackdrop", { fg = "#6c7086" })
  nvim_set_hl(0, "FlashMatch", { fg = "#cdd6f4", bg = "#2b2b3c" })
  nvim_set_hl(0, "FlashLabel", { fg = "#e3ff61", bold = true, underline = true })
end

return {
  {
    "LazyVim/LazyVim",
    init = init,
    config = function(_, opts)
      opts = opts or {}
      -- disable the colorscheme
      opts.colorscheme = function() end
      require("lazyvim").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { highlight = { enable = false } },
  },
}
