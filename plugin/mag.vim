
if exists('g:loaded_ag') || &cp
    finish
endif

let g:loaded_ag = 1

if !executable('ag')
    echoerr "Ag program is not executable"
endif

let s:agprg = "ag\ --vimgrep $*"
let s:agformat = "%f:%l:%c:%m,%f:%m,%f"

function s:Mag(args)
    let l:grepprg_old = &grepprg
    let l:grepformat_old = &grepformat

    let &grepprg = s:agprg
    let &grepformat = s:agformat
    execute 'silent grep! ' . a:args 

    let &grepprg = l:grepprg_old
    let &grepformat = l:grepformat_old

    let l:result_items_count = len(getqflist())

    if l:result_items_count
        copen
        echom "Mag: found " . l:result_items_count . " items ( " . a:args . " )"
    else
        cclose
        echom "Mag: not found items ( " . a:args . " )"
    endif

endfunction

command -bang -nargs=+ Mag call <SID>Mag(<q-args>)
