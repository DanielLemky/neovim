return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
      modifiablle = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.ruby_lsp.setup({
        capabilities = capabilities
      })
      lspconfig.rubocop.setup({
        capabilities = capabilities
      })


      vim.keymap.set("n", "G", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Definition" })
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "References" })
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format" })
      vim.keymap.set("n", "<leader>gc", vim.lsp.buf.code_action, { desc = "Code Action" })
      vim.keymap.set('n', '<leader>grn', vim.lsp.buf.rename, { desc = "Rename" })
    end,
  },
}
