comment~
Author: Jenny Nguyen
Project: Project1B
Description: Display "hello, assembly language"
~

CONSOLE		equ	 -11
CR			equ 0dh
LF			equ 0ah

extern	GetStdHandle:	PROTO
extern	WriteConsoleA:	PROTO
extern	ExitProcess:	PROTO


.data
hello	byte	"hello, assembly language", LF, CR

.data?
stdout		qword	?
numwrit		qword	?

.code
mainCRTStartup	PROC
				sub	rsp, 40				;reserve shadow space
				
				move rcx, CONSOLE		;Win handle
				call GetStdHandle		;empty
				mov stdout, rax			;save handle

				mov rcx, stdout			;parm 1(handle)
				lea rdx, hello			;parm 2(string)
				mov rdx, offset hello   ;address 
				mov r8, lengthof hello  ;bytes requested. sending the number of characters
				lea r9, numwrit		    ;bytes written
				call WriteConsoleA		

				add rsp, 40				;release shadow space
				mov rcx, 0				;return 0 = OK
				call ExitProcess		

mainCRTStartup	ENDP
END
