comment~
Author: Jenny Nguyen
Project: Project3B
Description:
~
extrn		publicCppString:	byte
extrn		DisplayString:		PROC
extrn		DisplayNewline:		PROC
extrn		ExitProcess:		PROC


CR		 equ		0dh
LF		 equ		0ah

.data
privateMasmString		byte	'hello, private masm world', 0ah, 0dh, 0	;(a private data item)
publicMasmString		byte	'hello, public masm world', 0ah, 0dh, 0		;(a public data item)

.data?


.code
main		PROC
						sub		rsp, 32								;reserve shadow space
						mov		rcx, offset privateMasmString		;point to register of privateMasmString
						call	DisplayString						;print privateMasmString to display
						push	rbp									;save base pointer
						mov		rcx, offset publicMasmString		;point to register of publicMasmString
						call	DisplayString						;display publicMasmString to screen
						pop		rbp									;restore original rpb
						mov		rcx, offset publicCppString			;point to register of publicCppString
						call	DisplayString						;print string arrays
						mov		rcx, offset publicCppString			;point to register of the public again
						sub		rcx, 32								;get the private 
						call	DisplayString						;display private string


						;Exit program
						add		rsp,32								;release shadow space
						mov		rcx,0								;return 0 = ok
						call	ExitProcess							;exit
				
main		ENDP
END

//output
hello, private masm world
hello, public masm world
hello, public C++ world
hello, private C++ world
