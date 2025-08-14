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

let g:voblue_bg       = ["#1C1B19", 234]
let g:voblue_bg2      = ["#2D2C29", 235]
let g:voblue_fg       = ["#FCE8C3", 223]
let g:voblue_muted    = ["#918175", 240] "131
let g:voblue_key1     = ["#5573A3", 61]
let g:voblue_key2     = ["#c3a000", 3]
let g:voblue_string   = ["#98BC37", 10]
let g:voblue_meta     = ["#729fcf", 12]
let g:voblue_error    = ["#FF0000", 9]

call vorange_util#apply_colors()

