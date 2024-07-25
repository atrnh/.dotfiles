-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("User", {
  pattern = { "VeryLazy" },
  callback = function()
    -- Leap colors
    vim.api.nvim_set_hl(0, "LeapMatch", { fg = "#c8d3f5", bg = "#fca7ea", bold = true })
    vim.api.nvim_set_hl(0, "LeapLabelPrimary", { fg = "#fca7ea", underline = true, bold = true })

    if vim.g.vscode then
      vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = "#919191" })
      vim.api.nvim_set_hl(0, "LeapLabelPrimary", { fg = "#EF85DE", underline = true, bold = true })
      vim.api.nvim_set_hl(0, "LeapMatch", { fg = "#DBE6F1", bg = "#EF85DE", bold = true })
    end

    -- Treesitter customizations
    vim.api.nvim_set_hl(0, "@text.reference", { link = "PreProc" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "rst" },
  callback = function()
    -- disable wrapping when writing PRs/issues through gh cli
    if vim.g.ghcli then
      vim.opt_local.formatoptions:remove("t")
    end

    vim.opt_local.textwidth = 98
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rst" },
  callback = function()
    vim.g.table_mode_corner_corner = "+"
    vim.g.table_mode_header_fillchar = "="
  end,
})

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = { "*" },
--   callback = function()
--     vim.cmd("%s/s+$//e")
--   end,
-- })
