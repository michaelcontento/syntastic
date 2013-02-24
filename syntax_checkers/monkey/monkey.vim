"============================================================================
"File:        monkey.vim
"Description: Syntax checking plugin for syntastic.vim
"Maintainer:  Michael Contento <michaelcontento at gmail dot com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
"============================================================================
"

function! SyntaxCheckers_monkey_monkey_IsAvailable()
    " TODO: Implement IsAvailable check
    return 1
endfunction

function! SyntaxCheckers_monkey_GetHighlightRegex(item)
    let unexpected = matchstr(a:item['text'], "unexpected '[^']\\+'")
    if len(unexpected) < 1
        return ''
    endif
    return '\V'.split(unexpected, "'")[1]
endfunction

function! SyntaxCheckers_monkey_monkey_GetLocList()
    " TODO: trans path must be configurable
    " TODO: target setting must be configurable
    let makeprg = syntastic#makeprg#build({
                \ 'exe': '/Applications/Monkey/bin/trans_macos',
                \ 'args': '-check -config=release -target=glfw'})
    let errorformat='%f<%l> : Error : %m'
    return SyntasticMake({ 'makeprg': makeprg, 'errorformat': errorformat })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'monkey',
    \ 'name': 'monkey'})
