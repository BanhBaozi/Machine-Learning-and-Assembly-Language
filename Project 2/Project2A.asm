comment~
Author: Jenny Nguyen
Project: Project2A
Description: print hexadecimal values to console. 
Intro to data declaration
~

CONSOLE         equ     -11

extern  GetStdHandle:   PROTO
extern  WriteFile:      PROTO
extern  ExitProcess:    PROTO

.data
num1        byte    ?
num2        word    ?
num3        dword   ?
num4        qword   ?



.data? 
stdout      qword   ?
numWrite    qword   ?

.code
mainCRTStartup      PROC
    sub rsp, 40     ;reserve shadow space

    ;Storing information into memory
    mov num1, 6dh                 ;assign hex 
    mov num2, 7361h               ;assign hex
    mov num3, 7369206dh           ;assign hex
    mov rax, 216e754620h          ;assign hex to register
    mov num4, rax                 ;assign num4 now to register for hex

    mov rcx, CONSOLE             ;windows handle
    call GetStdHandle            ;handle in rax
    mov stdout, rax              ;save out handle

    ;Display message
    mov rcx, stdout              ;parm1 = console. handle to standard output device
    mov rdx, offset num2         ;parm2 = string
    mov r8, 15                   ;parm3 = total # bytes to display
    lea r9, numWrite             ;parm4 # bytes written
    mov qword ptr [rsp+32], 0    ;parm5 = 0 (unused)
    call WriteFile               ;display output_input

    ;Finalizing program and exit
    add rsp, 40                 ;restore shadow space
    mov rcx, 0                  ;return code
    call ExitProcess            ;Windows exit/end of program

mainCRTStartup      ENDP
END

asm is Fun!
