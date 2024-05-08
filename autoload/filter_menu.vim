vim9script

# Source:
#   https://www.reddit.com/r/vim/comments/wjxo3k/diy_fuzzy_completion/
#   https://github.com/habamax/.vim/blob/920e6ca906bb6f2890e6379ad794e09f0e4954d5/autoload/popup.vim

# Popup menu with fuzzy filtering
# Example usage 1:
# FilterMenu("Echo Text",
#            ["He was aware there were numerous wonders of this world including the",
#             "unexplained creations of humankind that showed the wonder of our",
#             "ingenuity. There are huge heads on Easter Island. There are the",
#             "Egyptian pyramids. There's Stonehenge."]
#            (res, key) => {
#               echo res
#            })
# Example usage 2:
# FilterMenu("Buffers",
#         getbufinfo({'buflisted': 1})->mapnew((_, v) => {
#                 return {bufnr: v.bufnr, text: (v.name ?? $'[{v.bufnr}: No Name]')}
#             }),
#         (res, key) => {
#             if key == "\<c-t>"
#                 exe $":tab sb {res.bufnr}"
#             elseif key == "\<c-j>"
#                 exe $":sb {res.bufnr}"
#             elseif key == "\<c-v>"
#                 exe $":vert sb {res.bufnr}"
#             else
#                 exe $":b {res.bufnr}"
#             endif
#         })

augroup GroupFilterMenu
  au!
  au ColorScheme * call prop_type_delete('FilterMenuMatch')
augroup END

def CleanCR(text: any): any
  if type(text) == v:t_string
    return trim(text, "\<CR>", 2)
  elseif type(text) == v:t_list
    return text->mapnew((_, v) => trim(v, "\<CR>", 2))
  endif
  return text
enddef

def Printify(itemsAny: list<any>, props: list<any>): list<any>
  if empty(prop_type_get('FilterMenuMatch'))
    hi def link FilterMenuMatch IncSearch
    prop_type_add('FilterMenuMatch', {
      highlight: "FilterMenuMatch",
      override: true,
      priority: 1000,
      combine: true
    })
  endif
  if itemsAny[0]->len() == 0 | return [] | endif
  if itemsAny->len() > 1
    return itemsAny[0]->mapnew((idx, v) => {
      return {
        text: v.text,
        props: itemsAny[1][idx]->mapnew((_, c) => {
          return {col: v.text->byteidx(c) + 1, length: 1, type: 'FilterMenuMatch'}
        })}
    })
  else
    return itemsAny[0]->mapnew((_, v) => {
      return {text: v.text}
    })
  endif
enddef

export def FilterMenu(
    title: string,
    items: list<any>,
    Callback: func(any, string))
  var prompt = ""
  var hint = "type to filter  "
  var items_dict: list<dict<any>>
  if len(items) < 1
    items_dict = [{text: ""}]
  elseif items[0]->type() != v:t_dict
    items_dict = items->mapnew((_, v) => {
      return {text: v}
    })
  else
    items_dict = items
  endif

  var filtered_items: list<any> = [items_dict]
  var height = min([&lines - 6, items->len()])
  var pos_top = ((&lines - height) / 2) - 1
  var winid = popup_create(Printify(filtered_items, []), {
    title: $" {title}: {hint} ",
    highlight: "Search",
    line: pos_top,
    minwidth: (&columns * 0.6)->float2nr(),
    maxwidth: (&columns - 5),
    minheight: height,
    maxheight: height,
    drag: 0,
    wrap: 1,
    cursorline: false,
    padding: [1, 1, 1, 1],
    mapping: 0,
    filter: (id, key) => {
      if key == "\<esc>"
        popup_close(id, -1)
      elseif ["\<cr>", "\<C-y>", "\<C-t>", "\<C-w>"]->index(key) > -1
          && filtered_items[0]->len() > 0
        popup_close(id, {idx: getcurpos(id)[1], key: key})
      elseif key == "\<tab>" || key == "\<C-j>" || key == "\<Down>" || key == "\<C-n>"
        var ln = getcurpos(id)[1]
        win_execute(id, "normal! j")
        if ln == getcurpos(id)[1]
          win_execute(id, "normal! gg")
        endif
      elseif key == "\<S-tab>" || key == "\<C-k>" || key == "\<Up>" || key == "\<C-p>"
        var ln = getcurpos(id)[1]
        win_execute(id, "normal! k")
        if ln == getcurpos(id)[1]
          win_execute(id, "normal! G")
        endif
      elseif key != "\<cursorhold>" && key != "\<ignore>"
        if key == "\<C-U>" && !empty(prompt)
          prompt = ""
          filtered_items = [items_dict]
        elseif (key == "\<C-h>" || key == "\<bs>")
          if empty(prompt)
            popup_close(id, {idx: getcurpos(id)[1], key: key})
            return true
          endif
          prompt = prompt->strcharpart(0, prompt->strchars() - 1)
          if empty(prompt)
            filtered_items = [items_dict]
          else
            filtered_items = items_dict->matchfuzzypos(prompt, {key: "text"})
          endif
        elseif key =~ '\p'
          prompt ..= key
          filtered_items = items_dict->matchfuzzypos(prompt, {key: "text"})
        endif
        popup_settext(id, Printify(filtered_items, []))
        popup_setoptions(id, {title: $" {title}: {prompt ?? hint} "})
      endif
      return true
    },
    callback: (id, result) => {
      if result->type() == v:t_number
        if result > 0
          Callback(filtered_items[0][result - 1], "")
        endif
      else
        Callback(filtered_items[0][result.idx - 1], result.key)
      endif
    }
  })

  win_execute(winid, "setl nonumber cursorline cursorlineopt=line")
enddef
