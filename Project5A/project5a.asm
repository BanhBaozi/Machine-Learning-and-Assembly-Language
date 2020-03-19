comment~
Author: Jenny Nguyen
Project: Project5A
Description: User name prompt
~
extrn ExitProcess:		 PROTO
extrn ReadFile:			 PROTO
extrn WriteFile:		 PROTO
extrn GetStdHandle:		 PROTO

extrn ExitProcess:		 PROTO
extrn ReadFile:			 PROTO
extrn WriteFile:		 PROTO
extrn GetStdHandle:		 PROTO

mGetHandles				MACRO
CONSOLE equ				-11
KEYBOARD equ			-10

						mov rcx, CONSOLE						;move register to console
						call GetStdHandle						; calling GetStdHandle
						mov stdout, rax							;save out handle
						mov rcx, KEYBOARD						; moving registers to keyboard
						call GetStdHandle						; calling GetStdHandle
						mov stdin, rax							;save in the handle
ENDM


mWriteFile			MACRO			parm

						mov rcx, stdout							;parm1 = console handle
						lea rdx, parm							;calling the parm
						mov r8, lengthof parm					; the length off parm
						lea r9, numWrite						;store number of the bits
						mov qword ptr [rsp + 32], 0				;parameter needed for write file
						call WriteFile							;display msg 


ENDM

mReadFile				MACRO			parm1

						mov rcx, stdin							;call the keybord parm
						lea rdx, parm1							;calling the parm1
						mov r8, lengthof parm1					;the size of the input
						lea r9, numRead							;number of bits read
						call ReadFile							;calling the read file 

ENDM

.data
nameProm				byte			'What is your name? '
addresProm				byte			'What is your address? '
prompt					byte			'Nice to meet you, ', 0ah
userName				byte			40 dup(0), 0dh
address					byte			40 dup(0)



.data?

stdin					qword			 ?
stdout					qword			 ?
numWrite				qword			 ?
numRead					qword			 ?

.code

mainCRTStartup		PROC
					sub rsp, 32									;reserve shadow space
					push rbp									;save the base of the printer
					mov rbp, rsp								; move ptr to stack 

					mGetHandles									;calles for macro


					mWriteFile		nameProm				;calling writefile for the nameProm
					mReadFile		userName				;calling readfile for the username
					mWriteFile		addresProm				;calling writefile for the addresProm
					mReadFile		address					;calling readfile for the address

					mWriteFile		prompt					;calling writefile for the prompt
					mWriteFile		userName				;calling writefile for the userName
					mWriteFile		address					;calling writefile for the address

	

					pop rbp						;to clear the base
					add rsp, 32					;restore shadow space
					call ExitProcess			;exit
mainCRTStartup		ENDP
END

What is your name? Bob Smith
What is your address? 1234 Main St., El Cajon
Nice to meet you,
Bob Smith
1234 Main St., El Cajon
