if exists('g:loaded_nvim_rooter') | finish | endif

let s:save_cpo = &cpo
set cpo&vim


let g:loaded_nvim_rooter = 1

command! Root lua require'rooter'.root()

augroup rooter
  autocmd!
  autocmd BufEnter,BufNewFile,BufReadPost * lua require'rooter'.root()
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo

