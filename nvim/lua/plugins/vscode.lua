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
  "snacks.nvim",
}

local Config = require("lazy.core.config")
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
  return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end
vim.g.snacks_animate = false

-- Keymap
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimKeymapsDefaults",
  callback = function()
    local vscode = require("vscode")
    local map = vim.keymap.set

    map({ "n", "v" }, "<leader>cr", function()
      vscode.call("rewrap.rewrapComment")
      vscode.notify("Rewrapped block")
    end, { desc = "Rewrap block with VS Code" })

    map({ "n", "v" }, "<leader>ww", function()
      vscode.call("rewrap.rewrapComment")
      vscode.notify("Rewrapped block")
    end, { desc = "Rewrap block with VS Code" })

    map({ "n", "v" }, "<leader>cf", function()
      vscode.call("editor.action.formatSelection")
      vscode.notify("Called formatSelection")
    end, { desc = "Format selection with VS Code" })

    map({ "o", "x" }, "gc", function()
      vscode.call("editor.action.commentLine")
    end, { desc = "Toggle comment for selection", silent = true })

    map("n", "<leader>sw", function()
      local curr_line = vim.fn.line(".") - 1 -- 0-indexed
      vscode.with_insert(function()
        vscode.action("editor.action.surroundWithSnippet", {
          range = { curr_line, curr_line },
        })
      end)
    end, { desc = "Surround with snippet", silent = true })

    map("v", "sw", function()
      vscode.with_insert(function()
        vscode.call("editor.action.surroundWithSnippet")
      end)
    end, { desc = "Surround with snippet", silent = true })

    -- -- Format current document
    -- vscode.action("editor.action.formatDocument")

    -- do -- Comment the three lines below the cursor
    --   local curr_line = vim.fn.line(".") - 1  -- 0-indexed
    --   vscode.action("editor.action.commentLine", {
    --     range = { curr_line + 1, curr_line + 3 },
    --   })
    -- end

    -- do -- Comment the previous line
    --   local curr_line = vim.fn.line(".") - 1 -- 0-indexed
    --   local prev_line = curr_line - 1
    --   if prev_line >= 0 then
    --     vscode.action("editor.action.commentLine", {
    --       range = { prev_line , prev_line },
    --     })
    --   end
    -- end

    -- do -- Find in files for word under cursor
    --   vscode.action("workbench.action.findInFiles", {
    --     args = { query = vim.fn.expand('<cword>') }
    --   })
    -- end

  end,
})

local function init(_)
  local nvim_set_hl = vim.api.nvim_set_hl
  nvim_set_hl(0, "FlashCurrent", { fg = "#6c7086", underline = true })
  nvim_set_hl(0, "FlashBackdrop", { fg = "#6c7086" })
  nvim_set_hl(0, "FlashMatch", { fg = "#cdd6f4", bg = "#2b2b3c" })
  nvim_set_hl(0, "FlashLabel", { fg = "#e3ff61", bold = true, underline = true })
end

function LazyVim.terminal()
  require("vscode").action("workbench.action.terminal.toggleTerminal")
end

return {
  {
    "folke/snacks.nvim",
    opts = {
      bigfile = { enabled = false },
      dashboard = { enabled = false },
      indent = { enabled = false },
      input = { enabled = false },
      notifier = { enabled = false },
      picker = { enabled = false },
      quickfile = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
    },
    config = function(_, opts)
      require("snacks").setup(opts)
    end,
  },
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
