comment~
Author: Jenny Nguyen
Project: Project4C
Description: Loop
~

extrn		DisplayMemory:			PROTO
extrn		DisplayInt:				PROTO
extrn		CreateThread:			PROTO
extrn		ExitThread:				PROTO
extrn		CloseHandle:			PROTO
extrn		ExitProcess:			PROTO




.data

arr1	 byte	 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
arr2	 byte	 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21
arr3	 byte	 20 dup(?)
id		 qword	 0
tHandle	 qword	 0

.code
main		 PROC
			sub		rsp, 48							 ;reserve shadow space
			push	rbp								 ;save non-volatile base pointer
			mov		rbp, rsp						 ;make frame pointer

			xor rcx, rcx							 ;parm1 Security Attributes
			xor rdx, rdx							 ;parm2 stacksize
			lea r8, myThread						 ;parm3 Pointer to thread PROC
			xor r9, r9								 ;parm4 data to pass to thread
			mov qword ptr[rbp + 40], 0				 ;parm5 run/suspend flag
			lea rbx, id								 ;&id (not used here)
			mov [rbp + 48], rbx						 ;parm6 pointer to thread ID
			call CreateThread						 ;call for thread
			add		rsp, 16							 ;repair stack after call
			cmp		rax, 0


			lea		r8, byte ptr[arr1]				;prep for arr1 by ptr
			lea		r9, byte ptr[arr2]				;prep for arr2 by ptr
			lea		r10, byte ptr[arr3]				;prep for arr3 by ptr
			mov		rcx, 10							;store counter
			lea		rbx, id							;pointer id
			push	rbx								;pointer to thread
		
			
firsthalf:	
			mov		al, byte ptr[r8]				;store initial byte by ptr
			mov		bl, byte ptr[r9]				;store initial byte by ptr
			mov		dl,	al							;saving initial byte of r8 to third array	
			add		dl, bl							;add byte of arr2 to arr1 byte and store in third array
			mov		byte ptr[r10], dl				;third array stored in memory
		
			inc		r8b								;move up to next element for arr1
			inc		r9b								;move up to next element for arr2
			inc		r10b							;move up to next element to store for arr3
			loop	firsthalf						;loop array until counter


			lea		rcx, arr3						 ;load address of arr3
			mov		rdx, 20							 ;pass 20
			call	DisplayMemory					 ;display arr3
			
			pop		rbp								;restore non-volatile register
			add		rsp, 48							;restore shadow space
			mov		rcx,1							;return code
			call	ExitProcess						;exit main

			
main	 	ENDP

myThread		PROC
			push	rbp
			lea		r8, byte ptr[arr1+10]			;prep for arr1 by ptr
			lea		r9, byte ptr[arr2+10]			;prep for arr2 by ptr
			lea		r10, byte ptr[arr3+10]			;prep for arr3 by ptr
			mov		rcx, 10							;store counter

secondhalf:
			mov		al, byte ptr[r8]				;store initial byte by ptr
			mov		bl, byte ptr[r9]				;store initial byte by ptr
			mov		dl,	al							;saving initial byte of r8 to third array	
			add		dl, bl							;add byte of arr2 to arr1 byte and store in third array
			mov		byte ptr[r10], dl				;third array stored in memory
		
			inc		r8b								 ;move up to next byte for arr1
			inc		r9b								 ;move up to next byte for arr2
			inc		r10b							 ;move up to next byte to store for arr3
			loop	secondhalf						 ;loop array until counter
	
			call	ExitThread						;exit the thread

myThread		ENDP


END


output:
03 05 07 09 0b 0d 0f 11 13 15 17 19 1b 1d 1f 21 23 25 27 29
