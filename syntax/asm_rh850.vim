" Vim syntax file
" Language:             Renesas RH850 Assembler
" Maintainer:           Markus Prepens <markus.prepens@gmail.com>

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case ignore

" storage types
syn match asmType "\.long"
syn match asmType "\.ascii"
syn match asmType "\.asciz"
syn match asmType "\.byte"
syn match asmType "\.double"
syn match asmType "\.float"
syn match asmType "\.hword"
syn match asmType "\.int"
syn match asmType "\.octa"
syn match asmType "\.quad"
syn match asmType "\.short"
syn match asmType "\.single"
syn match asmType "\.space"
syn match asmType "\.string"
syn match asmType "\.word"
syn match asmType "\.weak"

syn keyword asm850Reg r0 r2 r3 r4 r5 r6 r7 r8 r9 r10 r11 r12 r13 r14 r15 r16 r17 r18 r19 r20 r21 r22 r23 r24 r25 r26 r27 r28 r29 r30 r31
syn keyword asm850Reg sp zero pc eipc eipsw fepc fepsw psw eiic feic ctpc ctpsw ctbp eiwr fewr
syn keyword asm850Reg MCFG0 MCFG1 RBASE EBASE INTBP MCTL PID FPIPR TCSEL SCCFG SCBP HVCCFG HVCBP VCSEL VMPRT0
syn keyword asm850Reg VMPRT1 VMPRT2 VMSCCTL VMSCTBL0 VMSCTBL1 VMSCTBL2 VMSCTBL3 HTCFG0 HTCTL MEA
syn keyword asm850Reg ASID MEI ISPR PMR ICSR INTCFG
syn keyword asm850Reg HTSCCTL HTSCTBL0 HTSCTBL1 HTSCTBL2 HTSCTBL3 HTSCTBL4 HTSCTBL5 HTSCTBL6 HTSCTBL7 BWERRL BWERRH BRERRL BRERRH ICTAGL
syn keyword asm850Reg ICTAGH ICDATL ICDATH DCTAGL DCTAGH DCDATL DCDATH ICCTRL DCCTRL ICCFG DCCFG ICERR DCERR MPLA0 MPUA0 MPAT0 MPLA1 MPUA1
syn keyword asm850Reg MPAT1 MPLA2 MPUA2 MPAT2 MPLA3 MPUA3 MPAT3 MPLA4 MPUA4 MPAT4 MPLA5 MPUA5 MPAT5 MPLA6 MPUA6 MPAT6 MPLA7 MPUA7 MPAT7 MPLA8
syn keyword asm850Reg MPUA8 MPAT8 MPLA9 MPUA9 MPAT9 MPLA10 MPUA10 MPAT10 MPLA11 MPUA11 MPAT11 MPLA12 MPUA12 MPAT12 MPLA13 MPUA13 MPAT13 MPLA14
syn keyword asm850Reg MPUA14 MPAT14 MPLA15 MPUA15 MPAT15 fpsr fpepc fpst fpcc fpcfg fpec MPM MPRC MPBRGN MPTRGN MCA MCS MCC MCR MPPRT0 MPPRT1 MPPRT2

syn keyword asm850OpCode ABSF.S ADD ADDF.S ADDI ADF AND ANDI
syn keyword asm850OpCode Bcond BINS BSH BSW
syn keyword asm850OpCode CACHE CALLT CAXI CEILF.SL CEILF.SUL CEILF.SUW CEILF.SW CLL CLR1 CMOV CMOVF.S CMP CMPF.S CTRET CVTF.HS CVTF.LS CVTF.SH CVTF.SL CVTF.SUL CVTF.SUW CVTF.SW CVTF.ULS CVTF.UWS CVTF.WS
syn keyword asm850OpCode DI DISPOSE DIV DIVF.S DIVH DIVHU DIVQ DIVQU DIVU
syn keyword asm850OpCode EI EIRET FERET
syn keyword asm850OpCode FETRAP FLOORF.SL FLOORF.SUL FLOORF.SUW FLOORF.SW FMAF.S FMSF.S FNMAF.S FNMSF.S
syn keyword asm850OpCode HALT HSH HSW
syn keyword asm850OpCode JARL JMP JR
syn keyword asm850OpCode LD.B LD.BU LD.DW LD.H LD.HU LD.W LDL.W LDSR LOOP
syn keyword asm850OpCode MAC MACU MAXF.S MINF.S MOV MOVEA MOVHI MUL MULF.S MULH MULHI MULU
syn keyword asm850OpCode NEGF.S NOP NOT NOT1
syn keyword asm850OpCode OR ORI POPSP
syn keyword asm850OpCode PREF PREPARE PUSHSP RECIPF.S ,355, 356,358, 359
syn keyword asm850OpCode RIE ROTL RSQRTF.S
syn keyword asm850OpCode SAR SASF SATADD SATSUB SATSUBI SATSUBR SBF SCH0L SCH0R SCH1L SCH1R SET1 SETF SHL SHR SLD.B SLD.BU SLD.H SLD.HU SLD.W SNOOZE SQRTF.S SST.B SST.H SST.W ST.B ST.DW ST.H ST.W STC.W STSR SUB SUBF.S
syn keyword asm850OpCode SUBR SWITCH SXB SXH SYNCE SYNCI SYNCM SYNCP SYSCALL
syn keyword asm850OpCode TRAP TRFSR TRNCF.SL TRNCF.SUL TRNCF.SUW TRNCF.SW TST TST1
syn keyword asm850OpCode XOR XORI
syn keyword asm850OpCode ZXB ZXH

syn match asm850OpCode   "JARL\d\d"
syn match asmLabel       "[a-z_][a-z0-9_]*:"he=e-1

" Various #'s as defined by GAS ref manual sec 3.6.2.1
" Technically, the first asmDecimal def is actually octal,
" since the value of 0-7 octal is the same as 0-7 decimal,
" I (Kevin) prefer to map it as decimal:
syn match asmDecimal            "\<0\+[1-7]\=\>"         display
syn match asmDecimal            "\<[1-9]\d*\>"           display
syn match asmOctal              "\<0[0-7][0-7]\+\>"      display
syn match asmHexadecimal        "\<0[xX][0-9a-fA-F]\+\>" display
syn match asmBinary             "\<0[bB][0-1]\+\>"       display

syn match asmFloat              "\<\d\+\.\d*\%(e[+-]\=\d\+\)\=\>" display
syn match asmFloat              "\.\d\+\%(e[+-]\=\d\+\)\=\>"      display
syn match asmFloat              "\<\d\%(e[+-]\=\d\+\)\>"          display
syn match asmFloat              "[+-]\=Inf\>\|\<NaN\>"            display

syn match asmFloat              "\%(0[edfghprs]\)[+-]\=\d*\%(\.\d\+\)\%(e[+-]\=\d\+\)\="    display
syn match asmFloat              "\%(0[edfghprs]\)[+-]\=\d\+\%(\.\d\+\)\=\%(e[+-]\=\d\+\)\=" display
" Avoid fighting the hexadecimal match for unicorn-like '0x' prefixed floats
syn match asmFloat              "\%(0x\)[+-]\=\d*\%(\.\d\+\)\%(e[+-]\=\d\+\)\="             display

" Allow all characters to be escaped (and in strings) as these vary across
" architectures [See sec 3.6.1.1 Strings]
syn match asmCharacterEscape    "\\."    contained
syn match asmCharacter          "'\\\=." contains=asmCharacterEscape

syn match asmStringEscape       "\\\_."                 contained
syn match asmStringEscape       "\\\%(\o\{3}\|00[89]\)" contained display
syn match asmStringEscape       "\\x\x\+"               contained display

syn region asmString            start="\"" end="\"" skip="\\\\\|\\\"" contains=asmStringEscape

syn keyword asmTodo             contained TODO FIXME XXX NOTE

" GAS supports one type of multi line comments:
syn region asmComment           start="/\*" end="\*/" contains=asmTodo,@Spell

" GAS (undocumentedly?) supports C++ style comments. Unlike in C/C++ however,
" a backslash ending a C++ style comment does not extend the comment to the
" next line (hence the syntax region does not define 'skip="\\$"')
syn region asmComment           start="//" end="$" keepend contains=asmTodo,@Spell

" The following are used as line comment characters:
syn match asmComment            "[-#;!|].*" contains=asmTodo,@Spell

" Side effects of this include:
" - When `;' is used to separate statements on the same line (many targets
"   support this), all statements except the first get highlighted as
"   comments. As a remedy, remove `;' from the above.
" - ARM comments are not highlighted correctly. For ARM, uncomment the
"   following two lines and comment the one above.
"syn match asmComment           "@.*" contains=asmTodo
"syn match asmComment           "^#.*" contains=asmTodo

" Advanced users of specific architectures will probably want to change the
" comment highlighting or use a specific, more comprehensive syntax file.

syn match asmInclude            "\.include"
syn match asmCond               "\.if"
syn match asmCond               "\.else"
syn match asmCond               "\.endif"
syn match asmMacro              "\.macro"
syn match asmMacro              "\.endm"

" Assembler directives start with a '.' and may contain upper case (e.g.,
" .ABORT), numbers (e.g., .p2align), dash (e.g., .app-file) and underscore in
" CFI directives (e.g., .cfi_startproc). This will also match labels starting
" with '.', including the GCC auto-generated '.L' labels.
syn match asmDirective  "\.[A-Za-z][0-9A-Za-z-_]*"
syn match asmDirective  "\<hi\(\.S\)\="
syn match asmDirective  "\<lo\(\.S\)\="

syn case match

" Define the default highlighting.
" Only when an item doesn't have highlighting yet

" The default methods for highlighting.  Can be overridden later
hi def link asmSection          Special
hi def link asmLabel            Label
hi def link asmComment          Comment
hi def link asmTodo             Todo
hi def link asmDirective        Statement

hi def link asmInclude          Include
hi def link asmCond             PreCondit
hi def link asmMacro            Macro

if exists('g:asm_legacy_syntax_groups')
  hi def link hexNumber         Number
  hi def link decNumber         Number
  hi def link octNumber         Number
  hi def link binNumber         Number
  hi def link asmHexadecimal    hexNumber
  hi def link asmDecimal        decNumber
  hi def link asmOctal          octNumber
  hi def link asmBinary         binNumber
else
  hi def link asmHexadecimal    Number
  hi def link asmDecimal        Number
  hi def link asmOctal          Number
  hi def link asmBinary         Number
endif
hi def link asmFloat            Float

hi def link asmString           String
hi def link asmStringEscape     Special
hi def link asmCharacter        Character
hi def link asmCharacterEscape  Special

hi def link asm850Reg           Macro
hi def link asm850OpCode        Statement
hi def link asmType             Type

let b:current_syntax = "asm"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8 noet
