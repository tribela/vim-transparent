function! background#get_highlight_colors(group)
    redir => highlight
    silent execute 'silent highlight ' . a:group
    redir END

    let link_matches = matchlist(highlight, 'links to \(\S\+\)')
    if len(link_matches) > 0
        return background#get_highlight_colors(link_matches[1])
    endif

    let term_attr = background#match_highlight(highlight, 'term=\(\S\+\)')
    let gui_attr = background#match_highlight(highlight, 'gui=\(\S\+\)')
    let ctermfg = background#match_highlight(highlight, 'ctermfg=\([0-9A-Za-z]\+\)')
    let guifg = background#match_highlight(highlight, 'guifg=\([#0-9A-Za-z]\+\)')

    return [term_attr, gui_attr, ctermfg, guifg]
endfunction

function! background#match_highlight(highlight, pattern)
    let matches = matchlist(a:highlight, a:pattern)
    if len(matches) == 0
        return 'NONE'
    endif
    return matches[1]
endfunction

function! background#clear_bg(group)
    let [term_attr, gui_attr, ctermfg, guifg] = background#get_highlight_colors(a:group)

    execute 'hi ' . a:group . ' term=' . term_attr . ' ctermbg=none ctermfg=' . ctermfg
endfunction

function! background#clear_background()
    for group in ['Normal', 'Comment', 'Constant', 'Special', 'Identifier',
                \'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String',
                \'Function', 'Conditional', 'Repeat', 'Operator', 'Structure',
                \'LineNr']
        call background#clear_bg(group)
    endfor
endfunction

autocmd ColorScheme * call background#clear_background()
