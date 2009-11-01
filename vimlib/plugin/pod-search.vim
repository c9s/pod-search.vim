" 
" Author: Cornelius ( cornelius.howl@delete-me.gmail.com )
"         Takatoshi Kitano
"
" Last Change:  2009/10/31
" Licence: MIT Licence
"
"=VERSION 0.1
"
"=DESCRIPTION 
"
" This is Perldoc search integration of vim plugin.
" Type <C-c><C-p> to search keyword in pods
"
" Recommended script: Quickfix Toggle
"
"=cut

if exists("g:loaded_pod_search") || v:version < 700
    finish
endif
let g:loaded_pod_search = 1

" XXX:
if ! executable('podsearch')
    " echomsg 'podsearch is not found in PATH. plugin is not loaded.'
    " Skip loading the plugin
    " finish
endif

fun! s:perldoc_search()
  let re = input("Pod Search:")
  if strlen(re) == 0 | redraw | return | endif
  let path = input("Path:","","file")
  if strlen(path) == 0 | redraw | return | endif

  return
  let output = s:search_from_pod([ re , path ])
  let qflist = []
  for item in split(output,"\n") 
    let [path,name] = split(item," | ")
    call add(qflist, { 'filename':path, 'text':name , 'pattern': re })
  endfor
  call setqflist( qflist )
  copen
endf

fun! s:search_from_pod(args)
    let command = add(["perl","bin/podsearch"],a:args)  "XXX: path
    return system( join(command," ") )
endf

"command! -nargs=* -complete=file PerldocSearch :call s:PerldocSearch(<f-args>)
" call s:perldoc_search()
command! PodSearch  :cal s:perldoc_search()
nmap     <C-c><C-p> :PodSearch<CR>



