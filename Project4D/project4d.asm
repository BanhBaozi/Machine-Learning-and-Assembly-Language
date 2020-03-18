comment~
Author: Jenny Nguyen
Project: Project4D
Description: Max and Min 
~
extrn DisplayString: PROTO
extrn DisplayNewline:       PROTO
extrn ReadInt: PROTO
extrn DisplayInt: PROTO
extrn ExitProcess: PROTO

.data
msg1			byte   'Enter a series of numbers: ', 0
largestMsg		byte   'Largest: '
smallestMsg     byte   'Smallest: '
input		    dword   ?
smallest		dword   0
largest			dword   0


.code

main       PROC
		mov		rcx, offset msg1				;prep prompt to print
		call	DisplayString				;print prompt
		call	DisplayNewline				;print new line
		mov		rcx, offset input			;prep for user input
		call	ReadInt						;read user input
		mov		largest, ecx				;store largest tent int
		mov		smallest, ecx				;store smallest tent int


		cmp		ecx, 0						;compare input with sentinel
		je		Zero						;exit if equal
		cmp		ecx, largest				;compare input with largest tent int
		jg		larger						;jump if greater than tent
		cmp		ecx, smallest				;compare input with smallest tent int
		jl		smaller						;jump if less than tent
		loop	inputLoop					;loop for more entries until sentinel
Zero:	
		jmp		Exit						;jump to exit since sentinel was entered
inputLoop:
		mov		rcx, offset input			;prep for input
		call	ReadInt						;read user input
		cmp		ecx, 0						;
		je		DisplayResults				;
		cmp		ecx, largest				;
		jg		larger						;
		cmp		ecx, smallest				;
		jl		smaller						;
		loop	inputLoop					;

larger:
		mov		largest, ecx				;store biggest recent input to largest
		jmp		inputLoop					;return to input loop until sentinel
smaller:
		mov		smallest, ecx				;store smallest recent input to smallest
		jmp		inputLoop					;return to input loop until sentinel

DisplayResults:	
		mov		rcx, offset largestMsg		;
		call	DisplayString				;
		mov		rcx, offset largest			;
		call	DisplayInt					;
		call	DisplayNewLine				;
		mov		rcx, offset smallestMsg		;
		call	DisplayString				;
		mov		rcx, offset smallest		;
		call	DisplayInt					;
Exit:
		xor		rcx, rcx					;
		call	ExitProcess					;

main	ENDP
END
