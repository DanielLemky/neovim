vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "

vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.wo.number = true
vim.wo.relativenumber = true

-- Setting fixendofline
vim.opt.fixendofline = true

-- Setting fileformat to 'unix' for consistent Unix line endings
vim.opt.fileformat = 'unix'

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- This Lua function in 'init.lua' will correctly set up autocommands for Markdown files
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.md",
    callback = function()
        vim.opt_local.wrap = true         -- Enable wrapping of lines
        vim.opt_local.linebreak = true    -- Break lines at word boundaries
    end
})

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.wrap = false

vim.keymap.set("n", "<leader>vl", vim.cmd.Ex) -- vl to exit current buffer
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = 'Format the current bufffer' })
vim.keymap.set("n", "J", "10jzz", { noremap = true, silent = true })
vim.keymap.set("n", "K", "10kzz", { noremap = true, silent = true })
vim.keymap.set("n", "j", "jzz", { noremap = true, silent = true })
vim.keymap.set("n", "k", "kzz", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>t", "gg", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>b", "G", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>i", "v=", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ip", "ggvG=", { noremap = true, silent = true })
vim.keymap.set("n", "yp", "gg0vG$y", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>r', '<Cmd>redo<CR>', { desc = 'redo the last', noremap = true, silent = true })

-- Map Option+H to move to the left window
vim.keymap.set('n', '<leader>wh', '<C-w>h', { noremap = true, silent = true, desc = 'Move pane focus left' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true, desc = 'Move pane focus left' })
-- Map Option+J to move to the window below
vim.keymap.set('n', '<leader>wj', '<C-w>j', { noremap = true, silent = true, desc = 'Move pane focus down' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true, desc = 'Move pane focus down' })
-- Map Option+K to move to the window above
vim.keymap.set('n', '<leader>wk', '<C-w>k', { noremap = true, silent = true, desc = 'Move pane focus up' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true, desc = 'Move pane focus up' })
vim.g.zellij_navigator_no_mappings = 1
vim.keymap.set('n', '<C-h>', '<cmd>ZellijNavigateLeft<CR>', { silent = true })
vim.keymap.set('n', '<C-j>', '<cmd>ZellijNavigateDown<CR>', { silent = true })
vim.keymap.set('n', '<C-k>', '<cmd>ZellijNavigateUp<CR>', { silent = true })
vim.keymap.set('n', '<C-l>', '<cmd>ZellijNavigateRight<CR>', { silent = true })
vim.keymap.set('n', '<leader>wl', '<C-w>l', { noremap = true, silent = true, desc = 'Move pane focus right' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true, desc = 'Move pane focus right' })

vim.keymap.set('n', '<leader>wq', '<C-w>q', { noremap = true, silent = true, desc = 'Close pane in focus' })
vim.keymap.set('n', '<leader>ws', '<C-w>s', { noremap = true, silent = true, desc = 'Split pane' })
vim.keymap.set('n', '<leader>wv', '<C-w>v', { noremap = true, silent = true, desc = 'Split pane vertically' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


vim.keymap.set('n', '<C-e>', ':cnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-w>', ':cprevious<CR>', { noremap = true, silent = true })
