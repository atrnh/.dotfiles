return {
  {
    "dhruvasagar/vim-table-mode",
    ft = { "rst", "md" },
    keys = {
      { "<leader>tm", "<cmd>TableModeToggle<cr>", desc = "Table Mode" },
    },
    config = function()
      vim.g.table_mode_corner_corner = "+"
      vim.g.table_mode_header_fillchar = "="
    end,
  },
}
