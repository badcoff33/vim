vim9script
import autoload 'popnews.vim'

# TODO
# - cope with engineering units m,k,u,n
# - keep the trailing chars behind result (may be a added comment you want to keep)

export def EvalPyLine()
    try
        py3 import decimal
        execute "py3" getline('.')
        popnews.Open(getline('.'))
    catch /.*/
        popnews.Open("no complete math on this line")
    finally
    endtry
enddef

export def CalcPyLine()
    try
        py3 import decimal
        py3 import re
        py3 line = vim.current.line
        py3 m = re.search("([^=]*)", line)
        py3 eq = m.group(1)
        py3 r = eval(eq.replace(" ", ""))
        py3 d = decimal.Decimal(f"{r}")
        py3 s = "{}= {}".format(eq, d.normalize().to_eng_string())
        py3 vim.current.line = s
    catch /.*/
        popnews.Open("trouble in math" .. py3eval("eq.replace(' ', '')"))
    finally
    endtry
enddef

