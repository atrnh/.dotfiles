local obsidian_vault = string.format("%s/work/Notes/Work", os.getenv("HOME"))
return {
  {
    "epwalsh/obsidian.nvim",
    name = "obsidian",
    lazy = false,
    cond = not vim.g.vscode
      and string.find(vim.api.nvim_cmd({ cmd = "pwd" }, { output = true }) or "", "^" .. obsidian_vault .. "*"),
    dependencies = {
      "nvim-telescope/telescope.nvim",
      opts = {
        defaults = {
          mappings = {
            i = {
              ["<C-n>"] = function(prompt_bufnr)
                local action_state = require("telescope.actions.state")
                local input = action_state.get_current_line()
                print("Current line: " .. input)
                require("telescope.actions").close(prompt_bufnr)
                vim.cmd("ObsidianNew " .. input)
              end,
            },
          },
        },
      },
    },
    opts = {
      dir = obsidian_vault,
      use_advanced_uri = true,
      completion = {
        nvim_cmp = true,
      },
      ensure_installed = { "markdown", "markdown_inline" },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "markdown" },
      },
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. "-" .. suffix
      end,
    },
    keys = {
      {
        "gf",
        function()
          if require("obsidian").util.cursor_on_markdown_link() then
            return "<cmd>ObsidianFollowLink<cr>"
          else
            return "gf"
          end
        end,
        desc = "➡️ Follow link",
        noremap = false,
        expr = true,
      },
      {
        "<leader>/",
        "<cmd>ObsidianSearch<cr>",
        desc = "🔍 Search vault",
        noremap = true,
        expr = true,
      },
    },
    init = function()
      vim.opt_local.wrap = false
      vim.cmd("set tw=88")
    end,
  },
}
