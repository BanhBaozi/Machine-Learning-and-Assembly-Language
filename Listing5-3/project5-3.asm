comment~
Listings5-3
Description: Multi-Threading (parallel processing
_

extrn ExitProcess:            PROTO
extrn ExitThread:             PROTO
extrn CloseHandle:            PROTO
extrn OutputDebugStringA:     PROTO

extrn CreateThread:           PROTO
extrn WaitForSingleObjectEx:  PROTO

.data
tHandle     qword     0             ;thread handle
id          qword     0 
msgmain     byte      'main thread running', 0ah, 0dh, 0
msgsub1     byte      'sub thread running', 0ah, 0dh, 0
msgsub2     byte      'sub thread finished', 0ah, 0dh, 0
array       byte      10 dup(11h)

.code
main CRTStartup   PROC
               sub  rsp, 32                     ;reserve shadow space
               push rbp                         ;save non-volatile base pointer
               mov  rbp, rsp                    ;make frame pointer
               
               lea  rcx, msgmain                ;Display in Output
               call OutputDebugStringA          ;print Output   with an API 
               
               xor  rcx, rcx                    ;parm1 security Attributes
               xor  rdx, rdx                    ;parm2 stacksize(null-default size)
               lea  r8, myThread                ;parm3 Point to thread PROC
               xor  r9,r9                       ;parm4 data to pass to thread
               push 0                           ;parm5 run/suspect flag(null=run)
               lea  rbx, id                     ;&id pointer back to thread ID
               push rbx                         ;parm6 pointer to thread ID(
               call CreateThread                ;
               add  rsp, 16                     ;repair stack after call
               cmp  rax, 0                      ;check here for errors
               mov  tHandle, rax                ;save handle
               
               mov  rcx, 8fffffh                ;do other studd while myThread runs
stuff:
              loop  stuff                       ;don't end this thread till we know that myThread is finished
              push  rbp                         ;write base pointer to stack
              mov   rcx, tHandle                ;thread handle
              mov   rdx, 50000                  ;MAX time to wait(mSec)
              call  WaitingForSingleObjectEx    ;
              pop   rbp
              
              mov   rcx, tHandle                ;finish with thread handle
              call  CloseHandle                 ;
              
              pop   rbp                         ;restore non-volatile reg
              add   rsp, 32                     ;restore shadow space
              mov   rcx, 1                      ;return code
              call  ExitProcess                 ;Win Exit

mainCRTStartup    ENDP


myThread    PROC
          push    rbp
          lea     rcx, msgsub1                ;display in output window
          call    OutputDebugStringA          ;
          pop     rbp                         ;
          
          mov     al,1                        ;Fill a small array
          mov     rcx, 10                     ;array size
          mov     rsi, offset array           ;pointer to &array 
fill:     
          mov    [rsi], al                    ;fill byte
          inc    al                           ;increment fill byte
          inc    rsi                          ;next element
          loop   fill                         ;fill 'em all
          
          push    rbp                         ;
          lea     rcx, msgsub2                ;display in output window
          pop     rbp                         ;
          
          mov     rcx, 1234h                  ;return code
          call    ExitThread                  ;stop this thread
myThread  ENDP
END
          
