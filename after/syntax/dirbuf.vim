syntax clear DirbufHash
syntax match DirbufHash /^#\x\{8}\t/ms=s-1 conceal cchar=→
syntax match DirbufNewFile /^[^#].*/
highlight default link DirbufNewFile SpecialKey
" or for `hash_first = false`
" syntax match DirbufHash /\t#\x\{8}\s*$/ms=s+1 conceal
setlocal conceallevel=2
setlocal concealcursor=n
