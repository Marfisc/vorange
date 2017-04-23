# Vorange

A minimalistic dark [Vim](https://github.com/roosta/vim-srcery) color scheme
for GUI and Terminal. It is based on
[Srcery](https://github.com/roosta/vim-srcery).

[My personal homepage](http://marcelfischer.eu/)

## Screens

![Screen2](screen2.png)

![Screen](screen.png)

## Configuration

Put this in your `.vimrc` to load the Vorange color scheme:

```vim
colorscheme vorange
```

To make the visual mode cursor work as intended put this in your `.vimrc`.
The cursor should stop blinking and the selection should look like a 'long' cursor.

```vim
set guicursor+=v:vCursor
```


This color scheme can be configured by setting global variables before loading.

```vim
"disable italics
let g:vorange_italic = 0

"disable bold
let g:vorange_bold = 0

"disable underline
let g:vorange_underline=0

"disable undercurl
let g:vorange_undercurl=0
```

Currently color inversion cannot be  disabled. Because of the lack of fallback this would make the cursor and visual mode invisible.

## Airline Theme

A fitting [Airline](https://github.com/vim-airline/vim-airline) theme is included! To activate, put this in your `.vimrc`:

```vim
let g:airline_theme="vorange"
```
