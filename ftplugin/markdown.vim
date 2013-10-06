let s:root_path = exists('g:reveal_root_path')? g:reveal_root_path : $HOME.'/reveal.js/'
let s:root_path = s:root_path =~ '\/$'? s:root_path : s:root_path.'/'
let s:reveal_file_name = exists('g:reveal_file_name')? g:reveal_file_name : 'test.html'
let s:tempalte_path = expand('<sfile>:p:h').'/../template/'
let s:default_config = {
            \'controls': 'true',
            \'progress': 'true',
            \'history': 'false',
            \'keyboard': 'true',
            \'touch': 'true',
            \'center': 'true',
            \'loop': 'false',
            \'rtl': 'false',
            \'mouseWheel': 'false',
            \'margin': '0.1',
            \'minScale': '0.2',
            \'maxScale': '1.0',
            \'autoSlide': '0',
            \'width': '960',
            \'height': '900',
            \'theme': '"default"',
            \'transition': '"default"',
            \'transitionSpeed': '"default"',
            \'backgroundTransition': '"default"',
            \'title': 'title',
            \'author':'"author"',
            \'description':'"description"'}

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
    1
    write!
endfunction

function! s:GetContent()
    let content = []
    1
    while 1
        let line1 = search('^\s*<!--\s*sec.*-->\s*$', 'eW')
        let line2 = search('^\s*<!--\s*sec.*-->\s*$', 'nW')
        let secno1 = matchstr(getline(line1), 'secp\=\s*\zs\d\+')
        let secno2 = matchstr(getline(line2), 'secp\=\s*\zs\d\+')
        let subsecno = matchstr(getline(line1), 'secp\=\s*\d\+\.\zs\d\+')
        let sectype = matchstr(getline(line1), 'sec\zs.')
        let opt = matchstr(getline(line1), 'secp\=\s*[.0-9]*\s*\zs.*\ze-->')
        let opt = substitute(opt, 'bg="', 'data-background="', 'g')
        let opt = substitute(opt, 'tr="', 'data-transition="', 'g')
        let opt = substitute(opt, 'bgtr="', 'data-background-transition="', 'g')
        let opt = substitute(opt, 'bgrp="', 'data-background-repeat="', 'g')
        let opt = substitute(opt, 'bgsz="', 'data-background-size="', 'g')
        let endlineno = line2? line2-1: line('$')
        if line1
            let sechead = ['<section data-markdown '.opt.'>']
            let sectail = ['</section>']
            let subhead = ['<script type="text/template">']
            let subtail = ['</script>']
            if sectype == 'p'
                let sechead = ['<section '.opt.'>']
                let subhead = []
                let subtail = []
            endif
            if subsecno != ''
                if subsecno == '1'
                    let sechead = ['<section>']+sechead
                endif
                let sectail = (secno1 != secno2)? sectail+sectail : sectail
            endif
            let content += sechead+subhead+getline(line('.')+1, endlineno)+subtail+sectail
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
