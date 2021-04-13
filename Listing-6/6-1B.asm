comment~
Listing6-1B
Read the Keyboard using Win10 API
~

KEYBOARD		equ		-10

extrn GetStdHandle:	PROTO
extrn ReadConsoleA:	PROTO

.data?
numRead		qword	?		;number bytes actually read

.code

;Get handle id to keyboard
;no parms, handle returned to caller in rax
OpenKey		PROC	
			sub rsp, 32				;reserve shadow space
			mov rcx, KEYBOARD			;/subsystem:console
			call GetStdHandle			;handle in rax
			add rsp, 32				;restore shadow
			ret
OpenKey	ENDP

;Read ASCII from the keyboard
;parm1 = keyboard handle
;parm2 = ascii buffer
;parm3 = # bytes to read
ReadKey		PROC
			sub rsp, 32				;reserve shadow space
			lea r9,  numRead		;& to store #bytes actually read
			call ReadConsoleA			;get keystrokes
			add rsp, 32				;restore shadow space
			ret
ReadKey		ENDP
END
