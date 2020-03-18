comment~
Author: Jenny Nguyen
Project: Project4E
Description: Loan calculator
~

extrn	DisplayString:		PROTO
extrn	ReadChar:			PROTO
extrn	DisplayFloat:		PROTO
extrn	ExitProcess:		PROTO


.data
promptCollege		byte	'Are you a college graduate (Y/N): ', 0
promptEmploy		byte	'Are you currently employed (Y/N): ', 0
promptRate			byte 	'Your loan rate will be: ', 0
rate				real4	?
rate1				real4	0.03
rate2				real4	0.035
rate3				real4	0.041
rate4				real4	0.045

.data?
graduate	byte		?, ?			;2nd byte is for the Enter \n
employed	byte		?, ?			;

.code
main		PROC
					;prepare for stacks
					sub		rsp, 32					;reserve shadow space
					push	rbp						;save non-volatile base pointer
					mov		rbp, rsp				;make frame pointer for direct access
					
					;storing parameters
					lea		rcx,promptCollege		;store in address the prompt
					call	DisplayString			;display promptCollege
					lea		rcx, graduate			;store in address the 
					call	ReadChar				;read input
					lea		rcx, promptEmploy		;store in address the prompt
					call	DisplayString			;display promptEmployed
					lea		rcx, employed			;
					call	ReadChar				;read input

					mov		cl, graduate			;store graduate in lower 8 bit reg
					cmp		cl, employed			;compare graduate and employed


					;jumps
					je		yesYes					;jump if equal to rate1
					jl		noYes					;jump if graduate is less than employed
					jg		yesNo					;jump if gradate is greater than employed
					jz		noNo					;jump straight to noNo
			

yesYes:			;yes1 rate for college grad			
					cmp		graduate, 'N'			;check before yesYes msg if both are 'N'
					je		noNo					;jump if graduate and employed are equal to 'N'
					lea		rcx, rate				;store rate msg in address
					call	DisplayString			;print rate msg
					lea		rcx, rate1				;store rate1 in address
					call	DisplayFloat			;print rate1

					jp		done					;jump when finished to exit

noYes:			;no1 rate for college grad
					lea		rcx, rate				;store rate msg in address
					call	DisplayString			;print rate msg
					lea		rcx, rate2				;store rate2 in address
					call	DisplayFloat			;print rate2

					jp		done					;jump when finished to exit

yesNo:			;no1 rate for college grad
					lea		rcx, rate				;store rate msg in address
					call	DisplayString			;print rate msg
					lea		rcx, rate3				;store rate3 in address
					call	DisplayFloat			;print rate3

					jp		done					;jump when finished to exit

noNo:			;no1 rate for college grad			
					lea		rcx, rate				;store rate msg in address
					call	DisplayString			;print rate msg
					lea		rcx, rate4				;store rate4 in address
					call	DisplayFloat			;print rate4
					jp		done					;jump when finished to exit

done:				;Prepare to exit code
					pop		rbp						;r
					add		rsp, 32					;restore shadow space
					mov		rcx, 0					;return code 0
					call	ExitProcess				;exit code
main		ENDP

END

//

loan rates: 

1=Y,  2=Y then rate = .03
1=N, 2=Y then rate =.035
1=Y, 2=N then rate =.041
1=N ,2=N then rate = .045


Are you a college graduate (Y/N): Y
Are you currently employed (Y/N): Y
Your loan rate will be: 0.03

Are you a college graduate (Y/N): N
Are you currently employed (Y/N): Y
Your loan rate will be: 0.035

Are you a college graduate (Y/N): Y
Are you currently employed (Y/N): N
Your loan rate will be: 0.041

Are you a college graduate (Y/N): N
Are you currently employed (Y/N): N
Your loan rate will be: 0.045
