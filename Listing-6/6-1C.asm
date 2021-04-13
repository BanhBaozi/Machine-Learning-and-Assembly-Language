comment~
Listing6-1C
Output using Win API WriteConsoleA
~

CONSOLE	equ			-11

extern	GetStdHandle:	PROTO
extern	WriteConsoleA:	PROTO

.data?
numWrite	qword	?			;number bytes actually written

.code

;Get handle id to console window
;no parms, handle returned to caller in rax
OpenCon		PROC	
			sub rsp, 32				;reserve shadow space
			mov rcx, CONSOLE		;/subsystem:console
			call GetStdHandle		;handle in rax
			add rsp, 32				;restore shadow
			ret
OpenCon	ENDP

;Display message on console window
;parm1 = console handle
;parm2 = ascii message
;parm3 = # bytes to display
WriteCon	PROC	
			sub rsp, 32				;reserve shadow space
			lea r9,  numWrite		;& to store #bytes actually written
			call WriteConsoleA		;display message
			add rsp, 32				;restore shadow space
			ret
WriteCon	ENDP
END
