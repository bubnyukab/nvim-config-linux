return {
  {
    "vim-test/vim-test",
    config = function()
      vim.keymap.set("n", "<leader>tn", "<cmd>TestNearest<cr>", { desc = "Test nearest" })
      vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<cr>",    { desc = "Test file" })
      vim.keymap.set("n", "<leader>ts", "<cmd>TestSuite<cr>",   { desc = "Test suite" })
      vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<cr>",    { desc = "Test last" })
      vim.keymap.set("n", "<leader>tv", "<cmd>TestVisit<cr>",   { desc = "Test visit" })
    end,
  },
}
