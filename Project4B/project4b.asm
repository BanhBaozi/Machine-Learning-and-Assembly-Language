comment~
Author: Jenny Nguyen
Project: Project4B
Description: Fibonacci Sequence program.
~

extrn	DisplayInt:			PROTO
extrn	DisplayNewline:		PROTO
extrn	ExitProcess:		PROTO

.data
		input	qword	21
		int1	qword	0
		int2	qword	1

.data?

.code
main	PROC
			sub		rsp,32			;Reserve shadow space
			cmp		r13, input		;compare input to counter reg
			jge		Loop1			;skip loop if input is greater or equal than condition

Fibonacci:
			lea		rcx, qword ptr[int1]		;Store int1 in num1 address
			call	DisplayInt					;Print result
			call	DisplayNewLine				;Print a new line

			mov		r11, int1					;store num for sum
			add		r11, int2					;add to sum

			mov		r12, int2					;mov value into new memory
			mov		int1, r12					;mov second value into memory

			mov		int2, r11					;calc sum of last 2 n#s

			inc		r13							;next value to add
			cmp		r13, input					;compare counter and input
			jl		Fibonacci					;If counter is not fulfilled, jump to loop



Loop1:		;Loop succeeds, exit program
			add		rsp, 32						;restore shadow space
			mov		rcx, 0						;return code 0
			call	ExitProcess					;Exit code
main	ENDP
END

Output:
0
1
1
2
3
5
8
13
21
34
55
89
144
233
377
610
987
1597
2584
4181
6765


