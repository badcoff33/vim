vim9script

var g_title: string
var prompt = ""
var hint = "type to filter  "
var items_dict: list<dict<any>>
var filtered_items: list<any>

augroup GroupSelectorCore
  au!
  au ColorScheme * call prop_type_delete('PropSelectorNatch')
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
  if empty(prop_type_get('PropSelectorNatch'))
    hi def link SelectorNatch IncSearch
    prop_type_add('PropSelectorNatch', {
      highlight: "SelectorNatch",
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
          return {col: c + 1, length: 1, type: 'PropSelectorNatch'}
        })}
    })
  else
    return itemsAny[0]->mapnew((_, v) => {
      return {text: v.text}
    })
  endif
enddef

def IsKey(list_of_keys: list<string>, key: string): bool
  if index(list_of_keys, key) > -1
    return true
  else
    return false
  endif
enddef

def FilterKey(id: number, key: string): bool
  if IsKey(["\<esc>"], key)
    popup_close(id, -1)
  elseif IsKey(["\<cr>", "\<C-y>"], key) && filtered_items[0]->len() > 0
    popup_close(id, {idx: getcurpos(id)[1], key: key})
  elseif IsKey(["\<ScrollWheelDown>", "\<tab>", "\<C-j>", "\<Down>", "\<C-n>"], key)
    var ln = getcurpos(id)[1]
    win_execute(id, "normal! j")
    if ln == getcurpos(id)[1]
      win_execute(id, "normal! gg")
    endif
  elseif IsKey(["\<ScrollWheelUp>", "\<S-tab>", "\<C-k>", "\<Up>", "\<C-p>"], key)
    var ln = getcurpos(id)[1]
    win_execute(id, "normal! k")
    if ln == getcurpos(id)[1]
      win_execute(id, "normal! G")
    endif
  elseif !IsKey(["\<cursorhold>", "\<ignore>"], key)
    if key == "\<C-U>" && !empty(prompt)
      prompt = ""
      filtered_items = [items_dict]
    elseif IsKey(["\<C-h>", "\<bs>"], key)
      if empty(prompt)
        popup_close(id, {idx: getcurpos(id)[1], key: key})
      endif
      prompt = prompt->strcharpart(0, prompt->strchars() - 1)
      if empty(prompt)
        filtered_items = [items_dict]
      else
        filtered_items = items_dict->matchfuzzypos(prompt, {key: "text"})
      endif
    elseif  key =~ '\p'
      prompt ..= key
      filtered_items = items_dict->matchfuzzypos(prompt, {key: "text"})
    endif
    popup_settext(id, Printify(filtered_items, []))
    popup_setoptions(id, {
      title: $" {g_title}: {prompt ?? hint} ",
      minheight: len(filtered_items[0]),
      maxheight: (&lines - 10)
    })
  endif
  return true
enddef


export def OpenMenu( title: string, items: list<any>, Callback: func(any, string) )
  g_title = title
  prompt = ""
  if len(items) < 1
    items_dict = [{text: ""}]
  elseif items[0]->type() != v:t_dict
    items_dict = items->mapnew((_, v) => {
      return {text: v}
    })
  else
    items_dict = items
  endif

  filtered_items = [items_dict]
  var height = min([&lines - 6, items->len()])
  var winid = popup_create(Printify(filtered_items, []), {
    title: $" {title}: {hint} ",
    highlight: "Pmenu",
    line: 2,
    col: 2,
    minwidth: (&columns * 0.6)->float2nr(),
    maxwidth: (&columns - 5),
    minheight: height,
    maxheight: (&lines - 10),
    drag: 0,
    wrap: 1,
    cursorline: 1,
    padding: [1, 1, 1, 1],
    mapping: 0,
    filter: FilterKey,
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
  win_execute(winid, "setl nonumber")
enddef

defcompile

