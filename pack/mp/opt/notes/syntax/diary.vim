syn case ignore

syn match diaryHeadEven "^\(Feb\|Apr\|Jun\|Aug\|Okt\|Dec\)\s*[0-9]*,\s20[0-9][0-9]"
syn match diaryHeadOdd "^\(Jan\|Mar\|May\|Jul\|Sep\|Nov\)\s*[0-9]*,\s20[0-9][0-9]"

hi def link diaryHeadEven   String
hi def link diaryHeadOdd   Number
