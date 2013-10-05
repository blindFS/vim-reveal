let s:root_path = exists('g:reveal_root_path')? g:reveal_root_path : $HOME.'/reveal.js/'
let s:root_path = s:root_path =~ '\/$'? s:root_path : s:root_path.'/'
let s:reveal_file_name = exists('g:reveal_file_name')? g:reveal_file_name : 'test.html'
let s:tempalte_path = expand('<sfile>:p:h').'/../template/'
let s:section_head = ['<script type="text/template">']
let s:section_tail = ['</script>', '</section>']
let s:default_config = {
            \'title':'title',
            \'author':'"author"',
            \'description':'"description"',
            \'theme':'"default"',
            \'transition':'"default"',
            \'height':'900',
            \'width':'960'}

for [key,value] in items(s:default_config)
    if exists('g:reveal_default_config["'.key.'"]')
        let s:default_config[key] = g:reveal_default_config[key]
    endif
endfor

function! s:Md2Reveal()
    let content = s:GetContent()
    let Metadata = s:GetMetadata()
    for [key,value] in items(s:default_config)
        if !exists('Metadata["'.key.'"]')
            let Metadata[key] = value
        endif
    endfor
    execute 'edit '.s:root_path.s:reveal_file_name
    normal ggdG
    execute '0read '.s:tempalte_path.'head'
    call append('$', content)
    execute '$read '.s:tempalte_path.'tail'
    for [mkey, mvalue] in items(Metadata)
        execute '%s/{%\s*'.mkey.'\s*%}/'.mvalue.'/g'
    endfor
    write!
endfunction

function! s:GetContent()
    let content = []
    1
    while 1
        let line1 = search('^\s*<!--\s*sec.*-->\s*$', 'eW')
        let line2 = search('^\s*<!--\s*sec.*-->\s*$', 'nW')
        let secno1 = matchstr(getline(line1), 'sec\s*\zs\d\+')
        let secno2 = matchstr(getline(line2), 'sec\s*\zs\d\+')
        let subsecno = matchstr(getline(line1), 'sec\s*\d\+\.\zs\d\+')
        let opt = matchstr(getline(line1), 'sec\s*[.0-9]*\s*\zs.*\ze-->')
        let opt = substitute(opt, 'bg="', 'data-background="', 'g')
        let opt = substitute(opt, 'tr="', 'data-transition="', 'g')
        let opt = substitute(opt, 'bgtr="', 'data-background-transition="', 'g')
        let opt = substitute(opt, 'bgrp="', 'data-background-repeat="', 'g')
        let opt = substitute(opt, 'bgsz="', 'data-background-size="', 'g')
        let endlineno = line2? line2-1: line('$')
        if line1
            let newhead = ['<section data-markdown '.opt.'>']
            let newtail = []
            if subsecno != ''
                if subsecno == '1'
                    let newhead = ['<section>', '<section data-markdown '.opt.'>']
                endif
                let newtail = (secno1 != secno2)? ['</section>']: []
            endif
            let content += newhead+s:section_head+getline(line('.')+1, endlineno)+s:section_tail+newtail
        endif
        if line2 == 0
            return content
        endif
    endwhile
endfunction

function! s:GetMetadata()
    let Metadata = {}
    let lineno = 1
    while getline(lineno) =~ '^\(<!--Meta\s\+.*-->\)\=$'
        execute lineno
        while search('[^ ]*\s*:', 'e', lineno)
            let key = matchstr(getline(lineno)[:getpos('.')[2]-1], '[^ ]*\ze\s*:$')
            let value = matchstr(getline(lineno)[getpos('.')[2]:], '^\s*\zs.\{-}\ze\(\s\+[^ ]*\s*:\|-->\)')
            if key != ''
                let Metadata[key] = value
            endif
        endwhile
        let lineno += 1
    endwhile
    return Metadata
endfunction

command! RevealIt call s:Md2Reveal()
