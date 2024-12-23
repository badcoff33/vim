vim9script

import 'popnews.vim'

# TODO
# - cope with engineering units m,k,u,n
# - keep the trailing chars behind result (may be a added comment you want to keep)

# var mlist = matchlist("abc= 33 + 55", '^\s*\(\w\+\)\s*=\s*\(.*\)')
# echo mlist
# echo mlist[1] " : " mlist[2]

# Try to calculate math on current line
# First, try to update variables `a = 2`
# Second, try to run a calculation
export def EvalPyLine()
  py3 import decimal
  py3 import math
  py3 import re
  try
    execute "py3" getline('.')
  catch /.*/
  endtry
  try
    py3 line = vim.current.line
    py3 m = re.search("([^=]*)", line)
    py3 eq = m.group(1)
    py3 r = eval(eq.replace(" ", ""))
    py3 d = decimal.Decimal(f"{r}")
    py3 s = "{}= {}".format(eq, d.normalize().to_eng_string())
    py3 vim.current.line = s
  catch /.*/
    popnews.Open("trouble in math " .. py3eval("eq.replace(' ', '')"))
  endtry
enddef

python3 << END_OF_PY

# global space for variables
gg = {}

def DoCalcCurrLine():
  import math
  import decimal
  import re
  line_ = vim.current.line
  line = line_.replace(" ", "")
  m = re.search("([a-z]+)(.*)=(.+)", line)
  if (m != None) and (len(m.groups()) == 3):
    lhs = m.group(1)
    lhs_rest = m.group(2)
    rhs = m.group(3)
    if m.group(2) == "":
      gg[lhs] = eval(rhs)
      return
    else:
      equotation = lhs + lhs_rest
      # print("guessing formula with ",lhs + lhs_rest)
      try:
        r = eval(equotation, gg)
        d = decimal.Decimal(f"{r}")
        s = "{}={}".format(equotation, d.normalize().to_eng_string())
        vim.current.line = re.sub(r"([=\+\-\*/])", r" \1 ", s)
      finally:
        return

END_OF_PY
