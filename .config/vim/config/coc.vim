ino <silent><expr> <c-@> coc#refresh()
nn <silent> gd <plug>(coc-definition)
nn <silent> gy <plug>(coc-type-definition)
nn <silent> gi <plug>(coc-implementation)
nn <silent> gr <plug>(coc-references)
nn <silent> [e <plug>(coc-diagnostic-prev)
nn <silent> ]e <plug>(coc-diagnostic-next)
nn <leader>e <cmd>CocFzfList diagnostics<cr>
nn <leader>ce <cmd>call CocAction('diagnosticPreview')<cr>
nn <leader>s <cmd>CocFzfList outline<cr>
nn <leader>ca <plug>(coc-codeaction)
xn <leader>ca <plug>(coc-codeaction-selected)
nn <leader>cr <plug>(coc-rename)
nn <leader>cf <plug>(coc-fix-current)
nn <leader>cA <cmd>CocFzfList commands<cr>
ino <c-h> <cmd>call CocActionAsync('showSignatureHelp')<cr>
nn gh <cmd>if CocAction('hasProvider', 'hover')<cr>call CocActionAsync('doHover')<cr>endif<cr>

nn <silent><nowait><expr> <c-e> coc#float#has_scroll() ? coc#float#scroll(1) : "\<c-e>"
nn <silent><nowait><expr> <c-y> coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-y>"
ino <silent><nowait><expr> <c-e> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<c-e>"
ino <silent><nowait><expr> <c-y> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<c-y>"
vn <silent><nowait><expr> <c-e> coc#float#has_scroll() ? coc#float#scroll(1) : "\<c-e>"
vn <silent><nowait><expr> <c-y> coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-y>"

" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <plug>(coc-funcobj-i)
omap if <plug>(coc-funcobj-i)
xmap af <plug>(coc-funcobj-a)
omap af <plug>(coc-funcobj-a)
xmap ic <plug>(coc-classobj-i)
omap ic <plug>(coc-classobj-i)
xmap ac <plug>(coc-classobj-a)
omap ac <plug>(coc-classobj-a)

com! -nargs=0 Fmt :call CocActionAsync('format')
com! -nargs=0 OI :call CocActionAsync('runCommand', 'editor.action.organizeImport')

" clangd
nn <leader><c-^> <cmd>CocCommand clangd.switchSourceHeader<cr>
