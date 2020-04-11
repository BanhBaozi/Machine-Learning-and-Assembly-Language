comment~
Author: Jenny Nguyen
Project: Project7A
Descriptions: get a ascii decimal
string from c++ and convert to a signed
integer(binary number)
~

extrn	ExitProcess:			PROTO
extrn	DisplayString:			PROTO
extrn	ReadString:				PROTO
extrn	DisplayInt:				PROTO

.data
iNum		qword		0
base10		qword		1
.data?
userStr		byte		?
strLength	word		?

.code
main	PROC
		sub		rsp,32					;reserve shadow space
		push	rbp						;save non-volatile
		mov		rbp, rsp				;make frame ptr for stack

		lea		rcx, userStr			;point to address to store user string
		call	ReadString				;get string to conver
		mov		r8w, strLength			;
		dec		strLength				;

		lea		rcx, userStr			;load address of user input
		call	StringToInt				;call conversion proc
		lea		rcx, iNum				;pass int output
		call	DisplayInt				;print with display function

		;finishing up code
		pop		rbp						;restore non volatile reg
		add		rsp, 32					;restore shadow space
		mov		rcx, 0					;return code 0
		call	ExitProcess				;exit windows
main	ENDP


;convert the ascii decimal string array to signed integers
;rcx = qword value to convert
StringToInt	PROC
		lea		r12,byte ptr[iNum]		;byte ptr for solution output non volatile reg
		lea		r13,byte ptr[userStr]	;byte ptr for user string input non volatile reg
		mov		rbx, base10				;base10 = 1 in base ptr
		mov		r8, 0					;move zero into register for input
		mov		r9, 1					;the index for positive
		mov		r10, 2					;the index for negative
		
		cmp		byte ptr[userStr], '-'	;compare string for a negative #
		cmove	rcx, r10				;move if equal to negative index
		cmovne	rcx,r9					;move if not equal to the positive index
		mov		r8w, strLength			;store user string length to end array
sToi:
		dec		r11						;decrement the counter
		mov		r9b, byte ptr[r13+r11]	;store ptr of input along with counter
		sub		r9b, '0'				;array index subtract with '0'
		mov		rax, r8					;store in accumulator reg the first number
		mov		rdx, rbx				;base10 goes in next to multiply
		mul		rdx						;multiple first and second #

		add		iNum, rax				;add results to store for iNum in rax

		mov		rax, rbx				;get next number
		mov		rdx, 10					;store 10 to multiply with results
		mul		rdx						;multiply the number with 10
		mov		rbx, rax				;store number in with base10
		cmp		r11, rcx				;compare counter with the loop size
		jge		sToi					;jump to start over loop if greater than counter
sToiNeg:
		cmp		userStr, '-'			;
		jne		Continue				;
		mov		rax, iNum				;
		mov		rdx, -1					;
		mul		rdx						;
		mov		iNum, rax				;
Continue:
		ret								;return code to main proc
StringToInt	ENDP

END

		
