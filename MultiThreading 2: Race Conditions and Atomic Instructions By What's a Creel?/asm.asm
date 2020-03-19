.data
extrn   CreateThread:   PROC

.code

ThreadStartProc   PROC
            inc   dword ptr [rcx]
            ret
ThreadStartProc   ENDP

CreateThreadInASM  PROC
            push   rbp                  ;save the caller's RBP
            mov    rbp, rsp             ;save rsp of stack frame to rbp
            
            push   0                    ;ThreadID
            push   0                    ;Creation flags, start immediately
            
            sub    rsp, 20h             ;Reserve 4 quads of shadow space
            mov    r9,  rcx             ;mov *i to r9
            mov    rcx, 0               ;Security attributes
            mov    rdx, 0               ;Stack size, use the same stack size as the calling thread
            mov    r8, ThreatStartProc  ;
            call   CreateThread         ;call our second thread
            mov    rsp, rbp             ;
            pop    rbp                  ;restore the caller's rebp
            ret
CreateThreadInASM  ENDP           
