-- https://github.com/atrnh/vim-rst-sections
-- TODO: gonna just use this file for all my curriculum writing plugins.

return {
  "atrnh/vim-rst-sections",
  ft = { "rst" },
  keys = {
    { "<leader>d", "<cmd>call RstSectionDownCycle()<cr>", desc = "Demote heading", silent = true },
    { "<leader>u", "<cmd>call RstSectionUpCycle()<cr>", desc = "Promote heading", silent = true },
  },
}
