-- Required Plugins: 
-- vim-nerdtree, vim-tagbar, vim-ctrlp, nvim-lspconfig 
--
-- Default functionality: 
-- f2 to toggle tagbar
-- f3 to toggle file tree
-- ctrl+p for fuzzy finder (default)

vim.cmd("syntax on")
vim.opt.number = true
vim.opt.expandtab = false
vim.opt.autoindent = true
vim.opt.preserveindent = true
vim.opt.softtabstop = 0
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.hlsearch = false
vim.opt.scrolloff = 4
vim.opt.relativenumber = true

-- vim-tagbar config 
vim.g.tagbar_sort = 0
vim.keymap.set('i', '<F2>', '<C-O>:TagbarToggle<CR>', {noremap = true})
vim.keymap.set('n', '<F2>', ':TagbarToggle<CR>', {noremap = true})

-- vim-nerdtree configuration
vim.g.NERDTreeWinPos = 'right'
vim.keymap.set('i', '<F3>', '<C-O>:NERDTreeToggle<CR>', {noremap=true})
vim.keymap.set('n', '<F3>', ':NERDTreeToggle<CR>', {noremap=true})

-- buffer switching 
vim.keymap.set('n', '<Tab>', ':bnext<CR>, {noremap=true}')
vim.keymap.set('n', '<S-Tab>', ':bnext<CR>, {noremap=true}')

-- Automatic closing 
vim.cmd[[
inoremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>
inoremap ' ''<Left>
inoremap " ""<Left>
inoremap < <><Left>
]]

-- Smart enter key indenting
vim.cmd[[
function! Enter()
	if getline('.')[col('.')-2] == '{' && getline('.')[col('.')-1] == '}' || 
		\ getline('.')[col('.')-2] == '(' && getline('.')[col('.')-1] == ')' || 
		\ getline('.')[col('.')-2] == '[' && getline('.')[col('.')-1] == ']'
		return "\<CR>\<CR>\<Up>".repeat("\<C-t>", 1+indent('.') / &shiftwidth)
	else
		return "\<CR>"
	endif
endfunction
inoremap <expr> <CR> Enter()
]]

-- Skip over closing brackets 
vim.cmd[[
inoremap <expr> ) getline('.')[col('.')-1] == ')' ? "\<Right>" : ")"
inoremap <expr> } getline('.')[col('.')-1] == '}' ? "\<Right>" : "}"
inoremap <expr> ] getline('.')[col('.')-1] == ']' ? "\<Right>" : "]"
inoremap <expr> > getline('.')[col('.')-1] == '>' ? "\<Right>" : ">"
]]

-- Configure how omnicomplete behaves 
vim.opt.completeopt = 'menuone,noinsert'
vim.opt.pumheight = 10 -- limit the number of autocomplete suggestions
vim.cmd[[ 
function! TriggerOmniComplete() " trigger after "." or multi character word
	if !empty(&omnifunc) && 
		\ getline('.')[col('.')-2] =~ '\w'&& 
		\ getline('.')[col('.')-3] =~ '\w'||
		\ getline('.')[col('.')-2] == '.'
		call feedkeys("\<C-x>\<C-o>", 'n')
	endif
endfunction

augroup OmniCompleteAuto
	autocmd!
		autocmd TextChangedI * call TriggerOmniComplete()
augroup END
set shortmess+=c " hide messages for completion/not found
]]

-- Autocomplete language configuration
require("lspconfig").rust_analyzer.setup({})

-- Diagnostic information configuration 
vim.o.updatetime = 200
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float({focusable=false})
	end
})

-- Diagnostic information window display settings 
vim.diagnostic.config({
	float = {
		border = "single",
		max_width = 64,
	}
})

-- Colour configuration, highlight hex codes in their colour 
local function text_col(bg_col) 
	local r = tonumber(bg_col:sub(2,3), 16)
	local g = tonumber(bg_col:sub(4,5), 16)
	local b = tonumber(bg_col:sub(6,7), 16)
	if r + g + b > 384 then 
		return "#000000"
	else
		return "#FFFFFF"
	end
end

vim.api.nvim_create_autocmd({'BufEnter', 'TextChanged', 'TextChangedI'}, {
	callback = function()
		vim.fn.clearmatches()
		for lnum, line in ipairs(vim.api.nvim_buf_get_lines(0,0,-1,false)) do 
			for hex in line:gmatch('#%x%x%x%x%x%x') do 
				vim.cmd('highlight hex_'..hex:sub(2)..' guibg='..hex..' guifg='..text_col(hex))
				vim.fn.matchaddpos('hex_'..hex:sub(2), {{lnum, line:find(hex), #hex}})
			end
		end
	end
})

vim.cmd("colorscheme uelani")

-- Status bar configuration
vim.cmd[[
function! GetModeString()
	let m = mode()
	if m == 'i'
		return '%#ModeI# I %*'
	elseif m == 'n'
		return '%#ModeN# N %*'
	elseif m == 'c'
		return '%#ModeC# C %*'
	elseif m == 'v'
		return '%#ModeN# V %*'
	elseif m == "CTRL-V"
		return '%#ModeN# B %*'
	endif
	return '   '
endfunction

set noshowmode
set statusline=
set statusline+=%=%#Error#%m%*\ 
set statusline+=%#TabLineSel#\ %f\ \ L:\%L\ %*
set statusline+=\  
set statusline+=%{%GetModeString()%}\ 
]]

-- Font configuration when using neovide
vim.opt.guifont='Fira_Mono:h14'
