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
    "finish
endif

let g:loaded_pod_search = 1

" make sure we have podsearch script
if ! executable('podsearch')
    " echomsg 'podsearch is not found in PATH. plugin is not loaded.'
    " Skip loading the plugin
    " finish
endif



" pod search window &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

let s:podsrh_window = copy( swindow#class  )

fun! s:podsrh_window.init_buffer()

endf

fun! s:podsrh_window.buffer_reload_init()

endf

fun! s:podsrh_window.init_mapping()

endf

fun! s:podsrh_window.init_syntax()

endf

fun! s:podsrh_window.update_search()

endf

" pod search window &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

" test code
"
call s:podsrh_window.open('topleft','split',10)

fun! s:perldoc_search()
  let re = input("Pod Search:")
  if strlen(re) == 0 | redraw | return | endif
  let path = input("Path:","","file")
  if strlen(path) == 0 | redraw | return | endif

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
    let command = add(["podsearch"],a:args)
    return system( join(command," ") )
endf

"command! -nargs=* -complete=file PerldocSearch :call s:PerldocSearch(<f-args>)
" call s:perldoc_search()
com! PodSearch            :cal s:perldoc_search()
com! OpenPodSearchWindow  :cal s:CPANWindow.open('topleft', 'split',10)
nmap     <C-c><C-p> :PodSearch<CR>



