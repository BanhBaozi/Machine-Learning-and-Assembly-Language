comment~ 
Author: Jenny Nguyen
Project: Project1A 
Description: First asm program
~

includelib kernel32.lib

extrn ExitProcess:	PROTO

.data

.data?

.code
mainCRTStartup	PROC
						sub  rsp, 32			;reserve shadow space
						push rbp				;save non-volatile
						mov  rbp, rsp			;make frame pointer for stack

						nop

						pop  rbp				;restore non-volatile reg
						add  rsp, 32		    ;reset shadow space
						mov  rcx, 0				;return code
						call ExitProcess		;Win exit
mainCRTStartup	ENDP
END
