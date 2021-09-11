local vim = vim
local keymap = vim.api.nvim_set_keymap

vim.g.nvim_tree_ignore = {'.git', 'node_modules', '.cache'}
vim.g.nvim_tree_auto_open = 0
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_hide_dotfiles = 0
vim.g.nvim_tree_git_hl = 1

vim.g.nvim_tree_show_icons = {
	git = 0,
	folders = 1,
	files = 1,
 }

keymap('n', '<C-n>', '<cmd>NvimTreeToggle<cr>', {silent=true, noremap = true})
