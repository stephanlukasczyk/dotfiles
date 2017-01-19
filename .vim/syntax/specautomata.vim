if exists("b:current_syntax")
  finish
endif

syn keyword basicKeywords OBSERVER CONTROL AUTOMATON INITIAL STATE USEALL END
syn keyword triggerKeywords TRUE FALSE EXCLAMATION MATCH CALL RETURN LABEL ASSERT ASSUME ENTRY EXIT
syn keyword actionKeywords GOTO ERROR SPLIT NEGATION DO PRINT MODIFY

syn match comment "/\/\/.*$/"
syn match operator "->"

hi def link comment Comment
hi def link basicKeywords Statement
hi def link operator Operator
hi def link triggerKeywords Type
hi def link actionKeywords Constant

let b:current_syntax = "specautomata"
