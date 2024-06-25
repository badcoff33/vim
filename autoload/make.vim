vim9script

import autoload "torchlight.vim"

def MakeCallback()
  torchlight.TorchlightUpdate()
enddef

export def MakeStart(cmd: string)
  torchlight.TorchlightClearAll()
  run.RunStart({
    cmd: &makeprg .. " " .. cmd,
    callback: MakeCallback
  })
enddef

