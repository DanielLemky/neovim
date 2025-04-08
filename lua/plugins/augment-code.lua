return {
  'augmentcode/augment.vim',
  config = function()
    vim.keymap.set("n", "<leader>am", "<cmd>Augment chat<CR>", { desc = "Send message to Augment" })
    vim.keymap.set("n", "<leader>an", "<cmd>Augment chat-new<CR>", { desc = "Create new Augment chat" })
    vim.keymap.set("n", "<leader>at", "<cmd>Augment chat-toggle<CR>", { desc = "Toggle Augment chat window" })
  end
}
