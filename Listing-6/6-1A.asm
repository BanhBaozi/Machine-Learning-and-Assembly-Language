comment~
Listing6-1A
MASM calls I/O methods using Win API
~

extrn OpenKey:		PROC	;InAPI.asm
extrn ReadKey: 		PROC	;InAPI.asm
extrn OpenCon:		PROC	;OutAPI.asm
extrn WriteCon:		PROC	;OutAPI.asm
extrn ExitProcess:	PROC	;Windows kernel32.lib

.data
stdout	qword	?
stdin	qword	?
prompt	byte	"Please enter some text: ", 0
prefix	byte	"You typed: "
string	byte	256 dup(0)

.code
mainCRTStartup	PROC
		sub	rsp, 32		;reserve shadow space 
	
		call OpenCon		;Get Console Handle
		mov stdout, rax		; and save it
		
		call OpenKey		;Get Keyboard Handle
		mov stdin, rax		; and save it

		;Display prompt
		mov rcx, stdout		;parm2: stdout handle 
		mov rdx, offset prompt	;parm1: &prompt string
		mov r8, lengthof prompt	;parm3: length string
		call WriteCon		;display prompt

		;Read the Keyboard into a string buffer
		mov rcx, stdin		;parm2: stdin handle 
		lea rdx, string		;parm2 = ascii buffer
		mov r8, lengthof string	;# bytes to read
		call ReadKey

		;Display the text entered by the user
		mov rcx, stdout		;parm2: stdout handle 
		mov rdx, offset prefix	;parm1: &string
		mov r8, lengthof prefix + lengthof string	;parm3: length string
		call WriteCon		;display user text

		add rsp, 32			;restore stack pointer
		mov rcx, 0			;return code 
  		call ExitProcess	;Windows exit
mainCRTStartup	ENDP
END
