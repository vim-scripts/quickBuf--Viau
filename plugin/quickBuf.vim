" Documentation
    " Name: quickBuf.vim
    " Version: 1.2.2
    " Description: Simple and quick buffer explorer
    " Author: Alexandre Viau (alexandreviau@gmail.com)
    " Installation: Copy the plugin to the vim plugin directory.
    
" Usage:
    " Press <tab>b to show the buffer list in a new tab
    " Press <tab>B to show the buffer list in a split window
    " Press <Enter> once on the buffer list to open a buffer
    " Press <Del> once on the buffer list to delete a buffer
    " Press ctrl-o after selecting a buffer to return to the buffer list
" Todo:
"   s0 When they are more than 1 match for a buffer, delete all

" History:
    " 1.0 Initial release
    " 1.1 Switched <tab>b for <tab>B
    " 1.2 I changed the fixed path c:/temp/buffers.txt to $tmp/buffers.txt
    " 1.2.1 I put the buffers.txt path to a variable
    " 1.2.2 I added 'dd' to delete the buffer under the current line

let s:bufPath = substitute($tmp, '\', '/', 'g') . '/buffers.txt'

com! OpenBuffer exe 'norm 0f"l"fyt"' | exe 'edit! ' . @f
com! DeleteBuffer exe 'norm 0f"l"fyt"' | exe 'silent! bd! ' . @f | exe 'delete'

fu! g:ShowBuffers(winType)
    " Redirect the buffers command output to the bufvar variable 
        redir! => bufvar
        " Run the buffer command to and output via redirection to the bufvar variable
        silent buffers
        redir END
    " Open a split window or a new tab for display
        exe a:winType
    " Put the content of the bufvar variable to the paste register
        exe 'let @0 = bufvar'
    " Paste the buffer list to the new buffer/tab
        norm "0Pggdd
    " Add a mapping to Enter to open the buffer on the current line 
        exe 'nmap <buffer> <Enter> :OpenBuffer<cr>'
    " Add a mapping to Del to delete the buffer on the current line
        exe 'nmap <buffer> <Del> :DeleteBuffer<cr>'
        exe 'nmap <buffer> dd :DeleteBuffer<cr>'
    " Write the buffers list to disk, so after selecting a file we can go back to the buffer list with ctrl+o
        "silent! w! c:/temp/buffers.txt
        exe 'silent! w! ' . s:bufPath
    endfu

nmap <tab>b :call g:ShowBuffers('tabe')<cr>
nmap <tab>B :call g:ShowBuffers('new')<cr>

" Mappings I used before this plugin
    " Open a buffer
        " nmap <tab>B :b! 
    " Show the list of buffers from the command window and open one (this is the mapping I used before this plugin)
        " nmap <tab>b :buffers<CR>:b! 

