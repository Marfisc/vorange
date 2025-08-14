"vorange
set background=dark

hi clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name='vorange'

if !has('gui_running') && &t_Co != 256
    finish
endif

" Palette

let g:vorange_bg       = ["#1C1B19", 234]
let g:vorange_bg2      = ["#2D2C29", 235]
let g:vorange_fg       = ["#FCE8C3", 223]
let g:vorange_muted    = ["#918175", 240] "131
let g:vorange_key1     = ['#D75F00', 166]
let g:vorange_key2     = ["#FBB829", 3]
let g:vorange_string   = ["#98BC37", 10]
let g:vorange_meta     = ["#5573A3", 4]
let g:vorange_error    = ["#FF0000", 9]

call vorange_util#apply_colors()

