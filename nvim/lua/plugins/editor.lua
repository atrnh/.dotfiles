return {
  { "tpope/vim-repeat", event = "VeryLazy" },
  { "machakann/vim-sandwich", lazy = false },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "z",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump({
            search = { multi_window = false },
          })
        end,
        desc = "Flash",
      },
      {
        "Z",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter({
            search = { multi_window = false },
          })
        end,
        desc = "Flash Treesitter",
      },
    },
  }
}

