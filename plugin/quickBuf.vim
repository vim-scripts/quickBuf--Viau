" Documentation
    " Name: quickBuf.vim
    " Version: 1.0
    " Description: Simple and quick buffer explorer
    " Author: Alexandre Viau (alexandreviau@gmail.com)
    " Installation: Copy the plugin to the vim plugin directory.
    
" Usage:
    " Press <tab>b to show the buffer list in a split window
    " Press <tab>B to show the buffer list in a new tab
    " Press <Enter> once on the buffer list to open a buffer
    " Press <Del> once on the buffer list to delete a buffer
    " Press ctrl-o after selecting a buffer to return to the buffer list

" History:
    " 1.0 Initial release

com! OpenBuffer exe 'norm 0f"l"fyt"' | exe 'edit! ' . @f
com! DeleteBuffer exe 'norm 0f"l"fyt"' | exe 'bd! ' . @f | exe 'norm dd'
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
    " Write the buffers list to disk, so after selecting a file we can go back to the buffer list with ctrl+o
        silent! w! c:/temp/buffers.txt
    endfu
    nmap <tab>b :call g:ShowBuffers('tabe')<cr>
    nmap <tab>B :call g:ShowBuffers('new')<cr>
