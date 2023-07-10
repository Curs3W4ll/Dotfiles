" Location path of arduino binary
let g:arduino_cmd = '/usr/share/arduino/arduino'
" Location path of arduino directory
let g:arduino_dir = '/usr/share/arduino'

command -nargs=0 DelArduinoBuf :execute('bdelete'.bufnr('%'))

augroup arduinodelete
  autocmd!

  autocmd BufNewFile,BufRead *.ino :lua require("plenary.async").run(function() require("notify").async("Detecting an arduino workspace, using arduino configuration") end)
  autocmd FileType arduinobuild ab q DelArduinoBuf
augroup END
