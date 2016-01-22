if exists('loaded_transparent')
    finish
endif
let loaded_transparent = 1

autocmd! ColorScheme * call background#clear_background()
command! -bar -nargs=0 ClearBackground call background#clear_background()
