comment~
Author: Jenny Nguyen
Project: Project1B
Description: Listing 1-1. hello, world using Win10 API WriteConsoleA
~

includelib kernel32.lib       ;Note: Optional if VS IDE Build is used

CONSOLE           equ -11

extrn GetStdHandle:         PROTO
extrn WriteConsoleA:        PROTO
extrn ExitProcess:           PROTO

.data
hello             byte 'hello, world!'

.data?
stdout            qword ?   ;handle to console standard out
numWrite          qword ?   ;number bytes actually written


.code
mainCRTStartup    PROC
                  ;Initialize the program
                  sub rsp, 40               ;reserve shadow space
                  
                  ;Get handle id to console window
                  mov rcx, CONSOLE          ;/subsystem:console
                  call GetStdHandle         ;handle in rax
                  mov stdout, rax           ;save out handle
                  
                  ;Display message on console window
                  mov rcx, stdout           ;parm1 = console handle
                  lea rdx, hello            ;parm2 = ascii message
                  mov r8, lengthof hello    ;#bytes to display(write)
                  lea r9, numWrite          ;& to store # bytes written
                  call WriteConsoleA        ;display message
                  
                  ;Finalize program and exit
                  add rsp, 40               ;restore shadow space
                  mov rcx, 0                ;return code %error level%
                  call ExitProcess          ;exit
                  
                  
mainCRTStartup    ENDP
END


hello, world!
