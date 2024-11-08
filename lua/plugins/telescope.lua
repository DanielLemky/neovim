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
            defaults = {
                mappings = {
                    i = {
                        ['<C-u>'] = false,
                        ['<C-d>'] = false,
                    },
                },
            },
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

      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')

      -- Telescope live_grep in git root
      -- Function to find the git root directory based on the current buffer's path
      local function find_git_root()
          -- Use the current buffer's path as the starting point for the git search
          local current_file = vim.api.nvim_buf_get_name(0)
          local current_dir
          local cwd = vim.fn.getcwd()
          -- If the buffer is not associated with a file, return nil
          if current_file == '' then
              current_dir = cwd
          else
              -- Extract the directory from the current file's path
              current_dir = vim.fn.fnamemodify(current_file, ':h')
          end

          -- Find the Git root directory from the current file's path
          local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
          if vim.v.shell_error ~= 0 then
              print 'Not a git repository. Searching on current working directory'
              return cwd
          end
          return git_root
      end

      -- Custom live_grep function to search in git root
      local function live_grep_git_root()
          local git_root = find_git_root()
          if git_root then
              require('telescope.builtin').live_grep {
                  search_dirs = { git_root },
              }
          end
      end

      vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

      -- See `:help telescope.builtin`

      local function telescope_live_grep_open_files()
          require('telescope.builtin').live_grep {
              grep_open_files = true,
              prompt_title = 'Live Grep in Open Files',
          }
      end
      vim.keymap.set('n', '<leader><leader>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>fo', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
      vim.keymap.set('n', '<leader>fd', require('telescope.builtin').find_files, { desc = 'Search Files Working Directory' })
      vim.keymap.set('n', '<leader>ff', require('telescope.builtin').git_files, { desc = 'Search Git Files' })

      vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = 'Search [/] in Open Files' })
      vim.keymap.set('n', '<leader>sT', require('telescope.builtin').builtin, { desc = 'Search Select Telescope' })
      vim.keymap.set('n', '<leader>sH', require('telescope.builtin').help_tags, { desc = 'Search Help' })
      vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = 'Search current Word' })
      vim.keymap.set('n', '<leader>sd', require('telescope.builtin').live_grep, { desc = 'Search Working Directory' })
      vim.keymap.set('n', '<leader>ss', ':LiveGrepGitRoot<cr>', { desc = 'Search Git Root' })
      vim.keymap.set('n', '<leader>sD', require('telescope.builtin').diagnostics, { desc = 'Search Diagnostics' })
      vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = 'Search Resume' })
      vim.keymap.set('n', '<leader>/', function()
          -- You can pass additional configuration to telescope to change theme, layout, etc.
          require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
              winblend = 10,
              previewer = false,
          })
      end, { desc = '[/] Fuzzily search in current buffer' })




      -- vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Search Files' })
      -- vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, { desc = 'Search Git Files' })
      -- vim.keymap.set('n', '<leader>ss', ':LiveGrepGitRoot<cr>', { desc = 'Search Git Root' })
      -- vim.keymap.set('n', '<leader>sT', require('telescope.builtin').builtin, { desc = 'Search Select Telescope' })
      -- vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = 'Search Resume' })
      --
      -- require("telescope").load_extension("ui-select")
      --
      --


    end,
  },
}
