return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = '0.1.x',
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


      -- Define the dropdown theme configuration once
      local dropdown_theme = require('telescope.themes').get_dropdown({
        previewer = true,
        layout_config = {
          width = 0.9,
        },
        -- Preserve default sorting and search behavior
        sorting_strategy = "ascending",
        file_sorter = require('telescope.sorters').get_fuzzy_file,
        generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
      })

      -- Modify the live_grep_git_root function to use the dropdown theme
      local function live_grep_git_root()
        local git_root = find_git_root()
        if git_root then
          require('telescope.builtin').live_grep(vim.tbl_extend("force",
            dropdown_theme,
            { search_dirs = { git_root } }
          ))
        end
      end

      vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

      -- Modified telescope_live_grep_open_files function
      local function telescope_live_grep_open_files()
        require('telescope.builtin').live_grep(vim.tbl_extend("force",
          dropdown_theme,
          {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        ))
      end

      -- All keymappings with consistent dropdown theme
      vim.keymap.set('n', '<leader><leader>', function()
        require('telescope.builtin').buffers(dropdown_theme)
      end, { desc = '[ ] Find existing buffers' })

      vim.keymap.set('n', '<leader>fo', function()
        require('telescope.builtin').oldfiles(dropdown_theme)
      end, { desc = '[?] Find recently opened files' })

      vim.keymap.set('n', '<leader>fd', function()
        require('telescope.builtin').find_files(dropdown_theme)
      end, { desc = 'Search Files Working Directory' })

      vim.keymap.set('n', '<leader>ff', function()
        require('telescope.builtin').git_files(dropdown_theme)
      end, { desc = 'Search Git Files' })

      vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = 'Search [/] in Open Files' })

      vim.keymap.set('n', '<leader>sT', function()
        require('telescope.builtin').builtin(dropdown_theme)
      end, { desc = 'Search Select Telescope' })

      vim.keymap.set('n', '<leader>sH', function()
        require('telescope.builtin').help_tags(dropdown_theme)
      end, { desc = 'Search Help' })

      vim.keymap.set('n', '<leader>sw', function()
        require('telescope.builtin').grep_string(dropdown_theme)
      end, { desc = 'Search current Word' })

      vim.keymap.set('n', '<leader>sd', function()
        require('telescope.builtin').live_grep(dropdown_theme)
      end, { desc = 'Search Working Directory' })

      vim.keymap.set('n', '<leader>ss', live_grep_git_root, { desc = 'Search Git Root' })

      vim.keymap.set('n', '<leader>sD', function()
        require('telescope.builtin').diagnostics(dropdown_theme)
      end, { desc = 'Search Diagnostics' })

      vim.keymap.set('n', '<leader>sr', function()
        require('telescope.builtin').resume(dropdown_theme)
      end, { desc = 'Search Resume' })

      vim.keymap.set('n', '<leader>/', function()
        require('telescope.builtin').current_buffer_fuzzy_find(dropdown_theme)
      end, { desc = '[/] Fuzzily search in current buffer' })



    end,
  },
}
