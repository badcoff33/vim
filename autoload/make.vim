vim9script

import "run.vim"
import "torchlight.vim"

def MakeCallback()
  torchlight.TorchlightUpdate()
enddef

export def MakeStart(cmd: string)
  torchlight.ClearAll()
  run.RunStart({
    cmd: &makeprg .. " " .. cmd,
    regexp: &errorformat,
    callback: MakeCallback
  })
enddef
