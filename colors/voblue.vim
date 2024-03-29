"voblue
set background=dark

hi clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name='voblue'

if !has('gui_running') && &t_Co != 256
    finish
endif

" Palette

let s:bg       = ["#1C1B19", 234]
let s:bg2      = ["#2D2C29", 235]
let s:fg       = ["#FCE8C3", 223]
let s:muted    = ["#918175", 240] "131
let s:key1     = ["#5573A3", 61]
let s:key2     = ["#c3a000", 3]
let s:string   = ["#98BC37", 10]
let s:special  = ["#729fcf", 12]
let s:error    = ["#FF0000", 9]


" Setup Variables:

let s:none = ['NONE', 'NONE']

if !exists('g:voblue_bold')
    let g:voblue_bold=1
endif

if !exists('g:voblue_italic')
    if has('gui_running') || $TERM_ITALICS == 'true'
        let g:voblue_italic=1
    else
        let g:voblue_italic=0
    endif
endif

if !exists('g:voblue_undercurl')
    let g:voblue_undercurl=1
endif

if !exists('g:voblue_underline')
    let g:voblue_underline=1
endif

if !exists('g:voblue_inverse')
    let g:voblue_inverse=1
endif

" Setup Emphasis:

let s:bold = 'bold,'
if g:voblue_bold == 0
    let s:bold = ''
endif

let s:italic = 'italic,'
if g:voblue_italic == 0
    let s:italic = ''
endif

let s:underline = 'underline,'
if g:voblue_underline == 0
    let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:voblue_undercurl == 0
    let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:voblue_inverse == 0
    let s:inverse = ''
endif

" Highlighting Function:

function! s:HL(group, fg, ...)
    " Arguments: group, guifg, guibg, gui, guisp

    " foreground
    let fg = a:fg

    " background
    if a:0 >= 1
        let bg = a:1
    else
        let bg = s:none
    endif

    " emphasis
    if a:0 >= 2 && strlen(a:2)
        let emstr = a:2
    else
        let emstr = 'NONE,'
    endif

    let histring = [ 'hi', a:group,
                \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
                \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
                \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
                \ ]

    " special
    if a:0 >= 3
        call add(histring, 'guisp=' . a:3[0])
    endif

    execute join(histring, ' ')
endfunction

" Color definitions
call s:HL('Normal', s:fg, s:bg)

if version >= 700
    call s:HL('CursorLine',   s:none, s:bg2)

    " Tab pages line filler
    call s:HL('TabLineFill', s:bg, s:bg)
    " Active tab page label
    call s:HL('TabLineSel', s:bg, s:bg, s:bold)
    " Not active tab page label
    hi! link TabLine TabLineFill

    " Match paired bracket under the cursor
    call s:HL('MatchParen', s:key2, s:bg2, s:bold)
endif

if version >= 703
    " Highlighted screen columns
    call s:HL('ColorColumn',  s:none, s:bg)

    " Concealed element: \lambda → λ
    call s:HL('Conceal', s:special, s:none)

    " Line number of CursorLine
    call s:HL('CursorLineNr', s:key2, s:bg)
endif

call s:HL('NonText', s:muted)
call s:HL('SpecialKey', s:muted)

call s:HL('Visual', s:none, s:bg, s:inverse)

call s:HL('Search',    s:bg, s:key2)
call s:HL('IncSearch', s:bg, s:key2)

highlight! link QuickFixLine NONE
call s:HL('QuickFixLine', s:none, s:bg2)
call s:HL('qfFileName', s:key1, s:none)
call s:HL('qfLineNr', s:muted, s:none)

"call s:HL('Underlined', s:key2, s:none, s:underline)
call s:HL('Underlined', s:key2, s:none)

call s:HL('StatusLine',   s:fg, s:bg2)
call s:HL('StatusLineNC', s:muted, s:bg2)

" The column separating vertically split windows
call s:HL('VertSplit', s:fg, s:bg)

" Current match in wildmenu completion
call s:HL('WildMenu', s:key1, s:bg2, s:bold)

" Error messages on the command line
call s:HL('ErrorMsg',   s:fg, s:error)
call s:HL('MoreMsg',   s:key2)

" Current mode message: -- INSERT --
call s:HL('ModeMsg',   s:fg, s:bg)
" 'Press enter' prompt and yes/no questions
hi! link Question MoreMsg
" Warning messages
hi! link WarningMsg ErrorMsg

" Line number for :number and :# commands
call s:HL('LineNr', s:muted)

" Column where signs are displayed
call s:HL('SignColumn', s:none, s:bg)

" Line used for closed folds
call s:HL('Folded', s:muted, s:bg, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:muted, s:bg)

" Character under cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
" Visual mode cursor, selection
call s:HL('vCursor', s:none, s:none, s:underline)
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

"""" Syntax
"Dont highlight to much
call s:HL('Special', s:key1)

call s:HL('Comment', s:muted, s:none, s:italic)
"TODO
call s:HL('Todo', s:fg, s:bg, s:bold)
call s:HL('Error', s:error, s:bg, s:bold . s:inverse)

" String constant: "this is a string"
call s:HL('String',  s:string)
call s:HL('EscSequence', s:key2, s:none, s:bold)

call s:HL('Statement',  s:key1)
" if, then, else, endif, swicth, etc.
hi! link Conditional Statement
" for, do, while, etc.
hi! link Repeat Statement
" case, default, etc.
hi! link Label Statement
" try, catch, throw
hi! link Exception Statement
" sizeof, "+", "*", etc.
""" MF
hi! link Operator Statement
" Any other keyword
hi! link Keyword Statement

call s:HL('Identifier',  s:special)
call s:HL('Function',  s:special)
call s:HL('Title', s:special)

" Generic preprocessor
call s:HL('PreProc', s:special)

" Preprocessor #include
hi! link Include PreProc
" Preprocessor #define
hi! link Define PreProc
" Same as Define
hi! link Macro PreProc
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit PreProc

" Generic constant
call s:HL('Constant', s:key2)

" Character constant: 'c', '/n'
hi! link Character Constant
" Boolean constant: TRUE, false
hi! link Boolean Constant
" Number constant: 234, 0xff
hi! link Number Constant
" Floating point constant: 2.3e10
hi! link Float Constant

" Generic type
call s:HL('Type', s:key2)
" static, register, volatile, etc
call s:HL('StorageClass', s:key1)
" struct, union, enum, etc.
call s:HL('Structure', s:key1)
" typedef
call s:HL('Typedef', s:key1)

if version >= 700
  " Popup menu: normal item
  """ MF
  call s:HL('Pmenu', s:muted, s:bg2)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:bg, s:special, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:bg)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:special)
  " Nvim-Cmp-Menu match highlight
  call s:HL('CmpItemAbbrMatch', s:key2, s:none, s:bold)
endif

" Spelling

if has("spell")
  " Not capitalised word, or compile warnings
  call s:HL('SpellCap',   s:special, s:none, s:bold . s:italic)
  " Not recognized word
  call s:HL('SpellBad',   s:none, s:none, s:undercurl, s:key1)
  " Wrong spelling for selected region
  call s:HL('SpellLocal', s:none, s:none, s:undercurl, s:key2)
  " Rare word
  call s:HL('SpellRare',  s:none, s:none, s:undercurl, s:special)
endif

" Diff

call s:HL('DiffDelete', s:error, s:bg, s:inverse)
call s:HL('DiffAdd',    s:string, s:bg, s:inverse)

" Alternative setting
call s:HL('DiffChange', s:special, s:bg, s:inverse)
call s:HL('DiffText',   s:key2, s:bg, s:inverse)

" HTML
call s:HL('htmlTag', s:key1, s:none)
call s:HL('htmlEndTag', s:key1, s:none)
call s:HL('htmlTagName', s:key1, s:none)
call s:HL('htmlArg', s:key1, s:none)

call s:HL('htmlSpecialChar', s:key2, s:none)

call s:HL('htmlBold', s:fg, s:bg, s:bold)
call s:HL('htmlBoldUnderline', s:fg, s:bg, s:bold . s:underline)
call s:HL('htmlBoldItalic', s:fg, s:bg, s:bold . s:italic)
call s:HL('htmlBoldUnderlineItalic', s:fg, s:bg, s:bold . s:underline . s:italic)

call s:HL('htmlUnderline', s:fg, s:bg, s:underline)
call s:HL('htmlUnderlineItalic', s:fg, s:bg, s:underline . s:italic)
call s:HL('htmlItalic', s:fg, s:bg, s:italic)

" Markdown
call s:HL('markdownH1', s:key1, s:none, s:bold)
hi! link markdownH2 markdownH1
hi! link markdownH3 markdownH1
hi! link markdownH4 markdownH1
hi! link markdownH5 markdownH1
hi! link markdownHeadingDelimiter markdownH1
hi! link markdownUrl String
hi! link markdownLinkTextDelimiter markdownLinkText
hi! link markdownLinkDelimiter markdownLinkText
call s:HL('markdownCode', s:key2)
call s:HL('markdownCodeBlock', s:key2)
hi! link markdownCodeDelimiter markdownCode
hi! link markdownCodeBlockDelimiter markdownCodeBlock

" Python
call s:HL('pythonDecorator', s:key2, s:none)
call s:HL('pythonInclude', s:special, s:none)
call s:HL('pythonImport', s:special, s:none)
call s:HL('pythonBoolean', s:key2, s:none)
call s:HL('pythonFunction', s:special, s:none)
call s:HL('pythonBuiltin', s:key2, s:none)
hi! link pythonCoding Comment
hi! link pythonEscape EscSequence
hi! link pythonBytesEscape EscSequence

"Vim
call s:HL('vimBracket', s:key2, s:none)
hi! link vimNotation vimBracket
hi! link vimMapModKey vimBracket
hi! link vimCommentTitle Todo

"C
hi! link cSpecial EscSequence

"D
hi! link dEscSequence EscSequence

"Ruby
hi! link rubyModule Statement
hi! link rubyClass Statement
hi! link rubyDefine Statement
hi! link rubyBlockParameter Normal
hi! link rubyInstanceVariable Normal
call s:HL('rubyFunction', s:key2, s:none)

"LaTeX
hi! link texRefZone Keyword
