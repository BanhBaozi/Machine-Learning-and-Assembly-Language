comment~
Author: Jenny Nguyen
Project: Project1CNew
Description: User name prompt
~

CONSOLE		equ		-11
KEYBOARD	equ		-10
CR			equ		 13		;Carriage Return
LF			equ		 10		;Line Feed

extern GetStdHandle:	 PROTO
extern WriteFile:		PROTO
extern ReadFile:		PROTO
extern ExitProcess:		PROTO

.data
prompt	byte  'What is your name?'
msg     byte  32 dup('*'), LF, CR, "*"
msg2	byte  30 dup(' '), ('*'), CR, LF, 32 dup('*'), CR, LF


.data?
stdin		qword	?	;handle to console standard in
stdout		qword	?	;handle to console standard out
numWrite	qword	?	;number of bytes actually written
numRead		qword	?	;number of bytes actually read

.code
mainCRTStartup	PROC

		;intialize the program
		sub			rsp,40		;reserve shadow spacee

		;get handle ID to console window & keyboard
		mov		rcx, CONSOLE	;/subsystem:console
		call	GetStdHandle	;handle in rax
		mov		stdout, rax		;Save out handle
		mov		rcx, KEYBOARD	;keyboard code
		call	GetStdHandle	;handle in rax
		mov		stdin, rax		;save in handle


		;Display message on console window
		mov		rcx, stdout				;parm1 = console handle
		lea		rdx, prompt				;parm2 = ascii message
		mov		r8, lengthof prompt		;parm3 = #of bytes written
		lea		r9, numWrite			;parm4 = & to store #bytes written
		mov		qword ptr[rsp+32],0		;parm5 = 0 (unused)
		call	WriteFile				;display message [First call of WriteFile]
					

		;Read ASCII from the keyboard
		mov		rcx, stdin				;parm1 = keyboard handle
		lea		rdx, msg2				;parm2 = ascii buffer
		mov		r8,lengthof msg2		;parm3 = bytes to read
		lea		r9, numRead				;parm4 = & to store #bytes actually read
		mov		qword ptr[rsp+32], 0    ;parm5 = 0 (unused)
		call	ReadFile				;get keystrokes[First call of ReadFile]
		lea		r10, msg2				;point msg2 to register
		add		r10, numread			;add length of input
		sub		r10, 2					;remove the newline & return to LF and CR
		mov		word ptr[r10], " "		;2 spaces will replace previous LF and CR
		lea		r10, msg2				;point msg2 back to register
		add		r10, 30					;add contents to last byte of register
		mov		word ptr[r10], '*'		;replace last byte of register with asterik



		;Display message on console window
		mov		rcx, stdout		;parm1 = console handle
		lea		rdx, msg		;parm2 = ASCII message
				
				
		;#Bytes to display (write)
		mov		r8, lengthof msg		;length 'msg,'
		add		r8, lengthof msg2		;add length of input
		lea		r9, numWrite			;& to store #bytes written
		mov		qword ptr[rsp+32],0		;parm5 = 0(unused)
		call	WriteFile				;Display msg2[Second call of WriteFiel]


				
		;Finalize program and exit
		add		rsp, 40			;restore shadow space
		mov		rcx, 0			;return code %errorlevel%
		call	ExitProcess		;exit


mainCRTStartup ENDP
END


//output

What is your name? jenny
********************************
*jenny *
********************************
What is your name?
********************************
* *
********************************
What is your name? jenny nguyen jenny nguyen
********************************
*jenny nguyen jenny nguyen *
********************************




//notes

output byte 32 dup('*'), 0ah, 0dh, "*"
myname byte 34 dup(' '), 32 dup('*'), 0ah,0dh
12 dup('*'), 0ah, 0dh, '*', 14 dup(' '),12 dup('*'), 0ah,0dh
***************LC* *************LC
after entering name
**********LC*JoeLC *******LC
^Replace 2 bytes(LC)

