vim9script

finish " do not run

prop_type_delete('test')
prop_type_add('test', {highlight: 'ModeMsg'})

prop_add(3, 0, {
    text:  '└─ Virtual text below the 3rd line',
    type: 'test',
    text_align: 'below',
    text_padding_left: 3
})

prop_add(4, 0, {
    text:  '┌─ Virtual text above the 4th line',
    type: 'test',
    text_align: 'below',
    text_padding_left: 3
})
