if exists('loaded_transparent')
    finish
endif
let loaded_transparent = 1

augroup transparent
    autocmd!
    autocmd VimEnter,ColorScheme * call background#clear_background()
    command -bar -nargs=0 ClearBackground call background#clear_background()
    command -bar -nargs=0 TransparentDisable call background#disable()
    command -bar -nargs=0 TransparentEnable call background#enable()
    command -bar -nargs=0 TransparentToggle call background#toggle()
augroup END
