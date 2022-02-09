aug md_ft
    au!
    au BufWritePre *.md :%s/\s\+$//e
    au BufEnter *.md set textwidth=80 | set scrolloff=10
    au BufLeave *.md set textwidth=0 | set scrolloff=0
aug END
