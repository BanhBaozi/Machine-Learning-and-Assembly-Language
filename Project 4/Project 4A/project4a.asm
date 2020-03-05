comment~
Author: Jenny Nguyen
Project: Project4A
Description: Loop
~
extrn		DisplayMemory:		PROC
extrn		DisplayNewline:		PROC
extrn		DisplayString:		PROC
extrn		ExitProcess:    PROC




.data
.radix	 16
array	 byte	 11,12,13,14,15,16,17,18,19,20  
.radix	 10 

.code
main   PROC
					sub		rsp, 32						;reserve shadow space
					push	rbp							;save non-volatile
					mov		rbp, rsp					;make frame pointer for stack
					lea		rcx, array					;point to array
					mov		rdx, lengthof array			;store length of array to rdx
					call	DisplayMemory				;print first array
					call	DisplayNewLine				;print new line

					lea		r12, array					;start of array

					;counter register will = half of # of elements
					mov	rcx, lengthof array/2			;counter 					
		
swap:				mov		r8b, [r12]						;store array in lower 8-bits
					mov		r9b, [r12+1]					;store next element in lower 8-bits
					mov		byte ptr [r12], r9b			    ;store first element in memory byte
					mov		byte ptr [r12+1], r8b			;store second element in memory byte
					add		r12, 2							;add or technically increment two bytes	
					
					loop swap								;loop at swap and move to next pair

					lea		 rcx, array						;&array
					mov	 	 rdx, lengthof array			;put back lengthof array in rdx
					call	 DisplayMemory					;show array on console
					

					;Preparing to exit code
					pop		 rbp							;restore stack
					add		 rsp, 32						;restore shadow space
					mov		 rcx, 0							;return code 0 
					call	 ExitProcess                    ;Exit windows
main	ENDP
END

output:
11 12 13 14 15 16 17 18 19 20
12 11 14 13 16 15 18 17 20 19
