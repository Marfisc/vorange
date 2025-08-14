

let s:none = ['NONE', 'NONE']

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

function vorange_util#apply_colors()
    " Palette
    let s:bg       = g:{g:colors_name}_bg
    let s:bg2      = g:{g:colors_name}_bg2
    let s:fg       = g:{g:colors_name}_fg
    let s:muted    = g:{g:colors_name}_muted
    let s:key1     = g:{g:colors_name}_key1
    let s:key2     = g:{g:colors_name}_key2
    let s:string   = g:{g:colors_name}_string
    let s:meta     = g:{g:colors_name}_meta
    let s:error    = g:{g:colors_name}_error

    " Setup Variables:

    if !exists('g:' . g:colors_name . '_bold')
        let g:{g:colors_name}_bold=1
    endif

    if !exists('g:' . g:colors_name . '_italic')
        if has('gui_running') || $TERM_ITALICS == 'true'
            let g:{g:colors_name}_italic=1
        else
            let g:{g:colors_name}_italic=0
        endif
    endif

    if !exists('g:' . g:colors_name . '_undercurl')
        let g:{g:colors_name}_undercurl=1
    endif

    if !exists('g:' . g:colors_name . '_underline')
        let g:{g:colors_name}_underline=1
    endif

    if !exists('g:' . g:colors_name . '_inverse')
        let g:{g:colors_name}_inverse=1
    endif

    " Setup Emphasis:

    let s:bold = 'bold,'
    if g:{g:colors_name}_bold == 0
        let s:bold = ''
    endif

    let s:italic = 'italic,'
    if g:{g:colors_name}_italic == 0
        let s:italic = ''
    endif

    let s:underline = 'underline,'
    if g:{g:colors_name}_underline == 0
        let s:underline = ''
    endif

    let s:undercurl = 'undercurl,'
    if g:{g:colors_name}_undercurl == 0
        let s:undercurl = ''
    endif

    let s:inverse = 'inverse,'
    if g:{g:colors_name}_inverse == 0
        let s:inverse = ''
    endif


    " Color definitions
    call s:HL('Normal', s:fg, s:bg)

    if version >= 700
        call s:HL('CursorLine',  s:none, s:bg2)

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
        call s:HL('ColorColumn', s:none, s:bg)

        " Concealed element: \lambda → λ
        call s:HL('Conceal', s:meta, s:none)

        " Line number of CursorLine
        call s:HL('CursorLineNr', s:key2, s:bg)
    endif

    call s:HL('NonText', s:muted)
    call s:HL('SpecialKey', s:muted)

    call s:HL('Visual', s:none, s:bg, s:inverse)

    call s:HL('Search', s:bg, s:key2)
    call s:HL('IncSearch', s:bg, s:key2)

    hi! link QuickFixLine NONE
    call s:HL('QuickFixLine', s:none, s:bg2)
    call s:HL('qfFileName', s:key1, s:none)
    call s:HL('qfLineNr', s:muted, s:none)

    "call s:HL('Underlined', s:key2, s:none, s:underline)
    call s:HL('Underlined', s:key2, s:none)

    call s:HL('StatusLine', s:fg, s:bg2)
    call s:HL('StatusLineNC', s:muted, s:bg2)

    " The column separating vertically split windows
    call s:HL('VertSplit', s:fg, s:bg)

    " Current match in wildmenu completion
    call s:HL('WildMenu', s:key1, s:bg2, s:bold)

    " Error messages on the command line
    call s:HL('ErrorMsg', s:fg, s:error)
    call s:HL('MoreMsg', s:key2)

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
    call s:HL('Special', s:key2)

    call s:HL('Comment', s:muted, s:none, s:italic)
    "TODO
    call s:HL('Todo', s:fg, s:bg, s:bold)
    call s:HL('Error', s:error, s:bg, s:bold . s:inverse)

    " String constant: "this is a string"
    call s:HL('String', s:string)
    call s:HL('EscSequence', s:key2, s:none, s:bold)

    call s:HL('Statement', s:key1)
    " if, then, else, endif, switch, etc.
    hi! link Conditional Statement
    " for, do, while, etc.
    hi! link Repeat Statement
    " case, default, etc.
    hi! link Label Statement
    " try, catch, throw
    hi! link Exception Statement
    " sizeof, "+", "*", etc.
    hi! link Operator Statement
    " Any other keyword
    hi! link Keyword Statement

    call s:HL('Identifier', s:fg)
    call s:HL('Delimiter', s:fg)
    call s:HL('Function', s:fg)
    call s:HL('Title', s:meta, s:none, s:bold)

    " Generic preprocessor
    call s:HL('PreProc', s:meta)

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
    call s:HL('PmenuSel', s:bg, s:meta, s:bold)
    " Popup menu: scrollbar
    call s:HL('PmenuSbar', s:none, s:bg)
    " Popup menu: scrollbar thumb
    call s:HL('PmenuThumb', s:none, s:meta)
    " Nvim-Cmp-Menu match highlight
    call s:HL('CmpItemAbbrMatch', s:key2, s:none, s:bold)
    endif

    " Spelling

    if has("spell")
    " Not capitalised word, or compile warnings
    call s:HL('SpellCap',   s:meta, s:none, s:bold . s:italic)
    " Not recognized word
    call s:HL('SpellBad',   s:none, s:none, s:undercurl, s:error)
    " Wrong spelling for selected region
    call s:HL('SpellLocal', s:none, s:none, s:undercurl, s:key2)
    " Rare word
    call s:HL('SpellRare',  s:none, s:none, s:undercurl, s:meta)
    endif

    " Diff

    call s:HL('DiffDelete', s:error, s:bg, s:inverse)
    call s:HL('DiffAdd',    s:string, s:bg, s:inverse)

    " Alternative setting
    call s:HL('DiffChange', s:meta, s:bg, s:inverse)
    call s:HL('DiffText',   s:key2, s:bg, s:inverse)

    " HTML
    hi! link htmlTag Keyword
    hi! link htmlEndTag Keyword
    hi! link htmlTagName Keyword
    hi! link htmlArg Keyword

    hi! link  htmlSpecialChar Special

    call s:HL('htmlBold', s:none, s:none, s:bold)
    call s:HL('htmlBoldUnderline', s:none, s:none, s:bold . s:underline)
    call s:HL('htmlBoldItalic', s:none, s:none, s:bold . s:italic)
    call s:HL('htmlBoldUnderlineItalic', s:none, s:none, s:bold . s:underline . s:italic)

    call s:HL('htmlUnderline', s:none, s:none, s:underline)
    call s:HL('htmlUnderlineItalic', s:none, s:none, s:underline . s:italic)
    call s:HL('htmlItalic', s:none, s:none, s:italic)

    " Markdown
    hi! link markdownH1 Title
    hi! link markdownH2 markdownH1
    hi! link markdownH3 markdownH1
    hi! link markdownH4 markdownH1
    hi! link markdownH5 markdownH1
    hi! link markdownHeadingDelimiter markdownH1
    hi! link markdownUrl Comment
    hi! link markdownLinkTextDelimiter markdownLinkText
    hi! link markdownLinkDelimiter markdownLinkText
    hi! link markdownCode String
    hi! link markdownCodeBlock String
    hi! link markdownCodeDelimiter markdownCode
    hi! link markdownCodeBlockDelimiter markdownCodeBlock

    " Python
    hi! link pythonFunction Special
    hi! link pythonBoolean Special
    hi! link pythonInclude PreProc
    hi! link pythonBuiltin Special
    hi! link pythonImport PreProc
    hi! link pythonDecorator PreProc
    hi! link pythonDecoratorName PreProc
    hi! link pythonCoding Comment
    hi! link pythonEscape EscSequence
    hi! link pythonBytesEscape EscSequence

    "Vim
    hi! link vimBracket Special
    hi! link vimNotation vimBracket
    hi! link vimMapModKey vimBracket
    hi! link vimCommentTitle Todo

    "C
    hi! link cType Special
    hi! link cSpecial EscSequence

    "D
    hi! link dEscSequence EscSequence

    "Ruby
    hi! link rubyModule Statement
    hi! link rubyClass Statement
    hi! link rubyDefine Statement
    hi! link rubyBlockParameter Identifier
    hi! link rubyInstanceVariable Identifier
    hi! link rubyFunction Special

    "LaTeX
    hi! link texRefZone Keyword

    " Treesitter

    if has("nvim")
        hi! link @variable Identifier

        hi! link @character.special.vim vimBracket
        hi! link @operator.vim vimBracket
        hi! link @module.vim Special

        hi! link @function.builtin.python pythonBuiltin
        hi! link @constructor.python None
        hi! link @function.python Special
        hi! link @function.method.python Special
        hi! link @function.call.python Function
        hi! link @function.method.call.python Function
        hi! link @module.python None
        hi! link @type.python PreProc

        hi! link @keyword.directive PreProc
        hi! link @keyword.import PreProc
        hi! link @constant.macro PreProc
        hi! link @string.escape EscSequence

        hi! link @markup.link.url Comment
        hi! link @markup.raw String
        "call s:HL('@markup.raw.block', s:none, s:bg2)
        hi! link @label.markdown String

        hi! link @tag Keyword
        hi! link @tag.attribute Special
        hi! link @tag.delimiter.html Keyword
        "hi! link @string.css None

        hi! link @property.json Keyword
        hi! link @property.yaml Keyword
    endif
endfunction
