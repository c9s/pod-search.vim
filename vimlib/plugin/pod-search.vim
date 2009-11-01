
fun! s:perldoc_search()
  let re = input("Pod Search:")
  if strlen(re) == 0 | redraw | return | endif

  let path = input("Path:","","file")
  if strlen(path) == 0 | redraw | return | endif

  let output = s:search_from_pod([ re , path ])
  let items = split(output,"\n")

  let qflist = []
  for item in items 
    let [path,name] = split(item," | ")
    call add(qflist, { 'filename':path, 'text':name , 'pattern': re })
  endfor
  call setqflist( qflist )
  copen
endf

fun! s:search_from_pod(args)
    let command = [  "perl" , "bin/podsearch" ]
    let command += a:args
    let cmd = join(command," ")
    echo cmd
    return system( cmd )
endf

"command! -nargs=* -complete=file PerldocSearch :call s:PerldocSearch(<f-args>)
" call s:perldoc_search()
