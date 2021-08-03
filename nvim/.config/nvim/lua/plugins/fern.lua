require 'util'
local vim = vim

vim.g['fern#smart_cursor'] = 'hide'
vim.g['fern#mark_symbol'] = ''
vim.g['fern#renderer'] = 'nerdfont'

function FernInit()
	-- vim.api.nvim_buf_set_keymap(0, )
	vim.api.nvim_win_set_option(0, 'numberwidth', 2)
	vim.api.nvim_win_set_option(0, 'number', false)
	vim.api.nvim_win_set_option(0, 'signcolumn', 'number')
end

nnoremap('<c-b>', [[<cmd>Fern . -drawer -toggle<cr>]], {silent = true})
