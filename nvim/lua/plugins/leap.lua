-- https://github.com/ggandor/leap.nvim

return {
  {
    "ggandor/leap.nvim",
    enabled = false, -- disable
    lazy = false,
    keys = {
      { "z", "<Plug>(leap-forward-to)", desc = "Leap forward to", mode = { "n", "x", "o" } },
      { "Z", "<Plug>(leap-backward-to)", desc = "Leap backward to", mode = { "n", "x", "o" } },
    },
  },
}
