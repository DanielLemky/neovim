return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            -- NOTE: If you are having trouble with this installation,
            --       refer to the README for telescope-fzf-native for more instructions.
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
    },
    config = function()
      require("telescope").setup({
        pickers = {
          find_files = {
            hidden = true,
            theme = "ivy",
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Search Files' })
      vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, { desc = 'Search Git Files' })
      vim.keymap.set("n", "<leader>ss", builtin.live_grep, { desc = "Search Working Directory" })
      vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})
      vim.keymap.set('n', '<leader>sT', require('telescope.builtin').builtin, { desc = 'Search Select Telescope' })
      vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = 'Search Resume' })

      require("telescope").load_extension("ui-select")

      pcall(require('telescope').load_extension, 'fzf')
    end,
  },
}
