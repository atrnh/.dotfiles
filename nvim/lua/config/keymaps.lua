-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

if vim.g.vscode then
  local vscode = require("vscode")

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
    "<Cmd>call VSCodeCall('editor.action.commentLine')<CR><Escc>",
    { desc = "Toggle comment linewise", noremap = true }
  )

  map("n", "<leader>f", "<Plug>(leap-forward-to)", { desc = "Leap forward" })
  map("n", "<leader>F", "<Plug>(leap-forward-to)", { desc = "Leap backward" })

  -- map(
  --   "x",
  --   "=",
  --   "<Cmd>call VSCodeCall('editor.action.formatSelection')<CR>",
  --   { desc = "Format selection", noremap = true }
  -- )
  -- map(
  --   "n",
  --   "=",
  --   "<Cmd>call VSCodeCall('editor.action.formatSelection')<CR><Esc>",
  --   { desc = "Format selection", noremap = true }
  -- )
  -- map(
  --   "n",
  --   "==",
  --   "<Cmd>call VSCodeCall('editor.action.formatSelection')<CR>",
  --   { desc = "Format selection", noremap = true }
  -- )

  -- map("n", "gt", "", {
  --   callback = function()
  --     switchEditor(vim.v.count, "next")
  --   end,
  --   noremap = true,
  -- })
  -- map("n", "gT", "", {
  --   callback = function()
  --     switchEditor(vim.v.count, "prev")
  --   end,
  --   noremap = true,
  -- })
end
