let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_sign_column_background ='none'

" undercurl support
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"

" underdouble, underdotted, underdashed support
let &t_Us = "\e[4:2m"
let &t_ds = "\e[4:4m"
let &t_Ds = "\e[4:5m"

color gruvbox-material

hi! link PMenu StatusLine
hi! link NormalFloat StatusLine

hi! link CocFloating StatusLine
hi! link CocMenuSel PMenuSel
hi! link CocPum StatusLine
