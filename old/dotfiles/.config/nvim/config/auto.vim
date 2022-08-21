au BufWritePre * %s/\s\+$//e
au BufWritePre * %s/\n\+\%$//e
au BufWritePre *.[ch] %s/\%$/\r/e
au BufRead,BufNewFile xresources,xdefaults set filetype=xdefaults
au BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %
au! BufRead,BufWrite,BufWritePost,BufNewFile *.org
au BufEnter *.org            call org#SetOrgFileType()
