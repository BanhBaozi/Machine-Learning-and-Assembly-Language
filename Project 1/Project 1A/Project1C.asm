comment~
Author: Jenny Nguyen
Project: Project1C
Description: User name prompt
~

CONSOLE		equ		-11
KEYBOARD	equ		-10

extern GetStdHandle:	PROTO
extern WriteConsoleA:	PROTO
extern ReadConsoleA:	PROTO
extern ExitProcess:		PROTO

.data
prompt				byte	'What is your name? '
hello				byte	'hello, '
myname				byte	40 dup(0)


.data?				
stdin				qword ?		;handle to sonsole standard in
stdout				qword ?		;handle to console standard out
numWrite			qword ?		;number of bytes actually written
numRead				qword ?		;number of bytes actually read

.code

mainCRTStartup		PROC					;initialize the program
					sub rsp, 40				;reserve shadow space


					;Get handle id to console window & keyboard
					mov rcx, CONSOLE		;/subsystem:console
					call GetStdHandle;		;handle in rax
					mov stdout, rax			;save out handle
					mov rcx, KEYBOARD		;keyboard code
					call GetStdHandle		;handle in rax
					mov stdin, rax			;save in handle

					;Display message on console window
					mov rcx, stdout			;parm1 = console handle
					lea rdx, prompt			;parm2 = ascii message
					mov r8, lengthof prompt ;# pf bytes to display(write)
					lea r9, numWrite		;& to store # of bytes written
					call WriteConsoleA		;display message


											;Read ASCII from the keyboard
					mov rcx, stdin			;parm1 = keyboard handle
					lea rdx, myname			;parm2 = ascii buffer
					mov r8, lengthof myname ;# of bytes to read
					lea r9, numRead			;& to store #bytes actually read
					call ReadConsoleA		;get keystrokes

					;Display message on console window
					mov rcx, stdout			;parm1 = console handle
					lea rdx, hello			;parm2 = ascii message


					;#bytes to display (write)
					mov r8, lengthof hello	;length 'hello,'
					add r8, numRead			;add length name

					sub r8, 2				;optional: remove the newLine
					lea r9, numWrite		;& to store #bytes written
					call WriteConsoleA		;display message
					
					;Finalize program and exit
					add rsp, 40				;restore shadow space
					mov rcx, 0				;return code %errorlevel%
					call ExitProcess		;exit
mainCRTStartup		ENDP

END
		
