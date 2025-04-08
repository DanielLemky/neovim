return {
  'augmentcode/augment.vim',
  config = function()
    vim.keymap.set("n", "<leader>a", "<cmd>Augment chat<CR>")
  end
}
