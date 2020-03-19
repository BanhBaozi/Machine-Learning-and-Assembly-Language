comment~
Author: Jenny Nguyen
Project: Project4G
Description: String comparisons
~
extrn DisplayString:		PROTO
extrn DisplayNewline:       PROTO
extrn ReadString:			PROTO
extrn ExitProcess:		    PROTO

.data
msg1			byte   'Enter string1: ', 0
msg2			byte   'Enter string2: ',0
notequalmsg		byte   'Strings are not equal',0
equalmsg		byte   'Strings are equal',0
string1		    byte	?, ?
string2			byte	?, ?

.code

main       PROC
					sub		rsp, 32					;reserve shadow space
					push	rbp						;save non-volatile base pointer
					mov		rbp, rsp				;make frame pointer for direct access
					
					;storing parameters
					;reading for string1
					lea		rcx,msg1				;store in address the prompt
					call	DisplayString			;display prompt 1
					lea		rcx, string1			;prep for prompt
					call	ReadString				;read input

					;reading for string2
					lea		rcx, msg2				;store in address the prompt
					call	DisplayString			;display promptEmployed
					lea		rcx, string2			;prep for input
					call	ReadString				;read input

					call	CompareStrings			;function call
main		ENDP


CompareStrings	PROC
					mov		al, byte ptr[string1]	;fast call
					mov		ah, byte ptr[string2]	;fast call
					cmp		al,ah					;compare the strings
					;jumps
					jl		NotEqual				;if strings are less than each other jp to NotEqual
					jg		NotEqual				;if strings are greater than each other jp to NotEqual
					je		YesEqual				;

YesEqual:				
					lea		rcx, equalmsg			;point to equal message
					call	DisplayString			;print to console
					jmp		Continue				;jump to exit code

NotEqual:
					lea		rcx, notequalmsg		;point to not equal message
					call	DisplayString			;Print to console
					jmp		Continue				;jump to exit code

Continue:
					pop		rbp						;clear stack
					add		rsp, 32					;restore shadow space
					mov		rcx, 0					;return code 0
					call 	ExitProcess				;exit code
CompareStrings	ENDP
END

