" Uelani colour scheme 

hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = ""

set background=dark

" ========================
" SEMANTIC COLOR DEFINITIONS
" ========================

" Base 
let s:background_normal = '#2c2c2c'   " Dark background
let s:text_normal       = '#c0e1e1'   " Primary text color
let s:text_inactive     = '#768787'   " Less important text
let s:text_highlight    = '#c6c5b9'   " Highlighted text

" UI 
let s:ui_background     = '#454a4a'   " Panels, statusline, etc.
let s:ui_border         = '#5d6868'   " Borders, separators
let s:ui_cursorline     = '#454a4a'   " Cursor line background
let s:ui_selection      = '#768787'   " Visual selection
let s:mode_normal       = '#768787'   " Mode indicator (N)
let s:mode_insert       = '#c7522a'   " Mode indicator (I)
let s:mode_cmd          = '#fabd2f'   " Mode indicator (C)
let s:mode_text         = '#FFFFFF'   " Text in mode indicator 

" Syntax 
let s:syntax_comment    = '#768787'   " Comments
let s:syntax_string     = '#74a892'   " Strings
let s:syntax_number     = '#80c2c2'   " Numbers, booleans
let s:syntax_function   = '#e5c185'   " Functions, methods
let s:syntax_keyword    = '#c7522a'   " Keywords, control flow
let s:syntax_type       = '#fabd2f'   " Types, classes
let s:syntax_constant   = '#d68a58'   " Constants
let s:syntax_operator   = '#e5c185'   " Operators

" Special 
let s:color_error       = '#c7522a'   " Errors
let s:color_warning     = '#fabd2f'   " Warnings
let s:color_info        = '#768787'   " Info, links
let s:color_success     = '#9dee79'   
let s:color_accent1     = '#83a598'   
let s:color_accent2     = '#8ec07c'   
let s:color_accent3     = '#d3869b'   

" ========================
" HIGHLIGHT GROUP FUNCTION
" ========================

function! s:HL(group, fg, bg, ...)
  let l:attr = a:0 > 0 ? a:1 : 'NONE'
  let l:fg = empty(a:fg) ? 'NONE' : a:fg
  let l:bg = empty(a:bg) ? 'NONE' : a:bg
  execute 'highlight' a:group 'guifg='.l:fg 'guibg='.l:bg 'gui='.l:attr
endfunction

" ========================
" HIGHLIGHT DEFINITIONS
" ========================

" Base UI
call s:HL('Normal',       s:text_normal, s:background_normal)
call s:HL('NormalNC',     s:text_normal, s:background_normal)
call s:HL('CursorLine',   '',            s:ui_cursorline)
call s:HL('CursorColumn', '',            s:ui_cursorline)
call s:HL('ColorColumn',  '',            s:ui_cursorline)
call s:HL('LineNr',       s:text_inactive, '')
call s:HL('CursorLineNr', s:text_highlight, s:ui_cursorline)

" Window UI
call s:HL('VertSplit',    s:ui_border,   '')
call s:HL('StatusLine',   s:text_normal, s:background_normal)
call s:HL('StatusLineNC', s:text_inactive, s:background_normal)
call s:HL('TabLine',      s:text_inactive, s:ui_background)
call s:HL('TabLineSel',   s:text_normal, s:ui_border)
call s:HL('ModeN',        s:mode_text, s:mode_normal, 'bold')
call s:HL('ModeI',        s:mode_text, s:mode_insert, 'bold')
call s:HL('ModeC',        s:mode_text, s:mode_cmd, 'bold')

" Floating windows 
call s:HL('NormalFloat',  s:text_normal, s:ui_background)
call s:HL('FloatBorder',  s:ui_border, s:ui_background)

" Visual modes
call s:HL('Visual',       '',            s:ui_selection)
call s:HL('VisualNOS',    '',            s:ui_selection)
call s:HL('Search',       '',            s:ui_selection)
call s:HL('IncSearch',    s:background_normal, s:color_warning)

" Syntax groups
call s:HL('Comment',      s:syntax_comment, '', 'italic')
call s:HL('String',       s:syntax_string, '')
call s:HL('Number',       s:syntax_number, '')
call s:HL('Function',     s:syntax_function, '')
call s:HL('Keyword',      s:syntax_keyword, '')
call s:HL('Type',         s:syntax_type, '')
call s:HL('Constant',     s:syntax_constant, '')
call s:HL('Operator',     s:syntax_operator, '')

" Diagnostics
call s:HL('Error',        s:color_error, '', 'bold')
call s:HL('ErrorMsg',     s:color_error, '')
call s:HL('WarningMsg',   s:color_warning, '')
call s:HL('Todo',         s:background_normal, s:color_warning, 'bold')

" Links and interactive elements
call s:HL('Underlined',   s:color_info, '', 'underline')
call s:HL('Directory',    s:color_info, '')
call s:HL('MatchParen',   s:text_normal, s:ui_border, 'bold')

" Completion menu
call s:HL('Pmenu',        s:text_normal, s:ui_background)
call s:HL('PmenuSel',     s:background_normal, s:color_accent1)
call s:HL('PmenuSbar',    '',            s:ui_background)
call s:HL('PmenuThumb',   '',            s:ui_border)

" ========================
" TERMINAL COLORS
" ========================

if has('nvim')
    let g:terminal_color_0 = s:background_normal
    let g:terminal_color_1 = s:color_error
    let g:terminal_color_2 = s:color_success
    let g:terminal_color_3 = s:syntax_function
    let g:terminal_color_4 = s:color_accent1
    let g:terminal_color_5 = s:color_accent3
    let g:terminal_color_6 = s:color_accent2
    let g:terminal_color_7 = s:text_normal
    let g:terminal_color_8 = s:syntax_comment
    let g:terminal_color_9 = s:color_error
    let g:terminal_color_10 = s:color_success
    let g:terminal_color_11 = s:syntax_function
    let g:terminal_color_12 = s:color_accent1
    let g:terminal_color_13 = s:color_accent3
    let g:terminal_color_14 = s:color_accent2
    let g:terminal_color_15 = s:text_normal
endif

" ========================
" CLEANUP
" ========================

delfunction s:HL

" Unset all color variables to avoid pollution
for color in [
    \ 'background_normal', 'text_normal', 'text_inactive', 'text_highlight',
    \ 'ui_background', 'ui_border', 'ui_cursorline', 'ui_selection',
    \ 'syntax_comment', 'syntax_string', 'syntax_number', 'syntax_function',
    \ 'syntax_keyword', 'syntax_type', 'syntax_constant', 'syntax_operator',
    \ 'color_error', 'color_warning', 'color_info', 'color_success',
    \ 'color_accent1', 'color_accent2', 'color_accent3'
    \ ]
    execute 'unlet s:' . color
endfor
