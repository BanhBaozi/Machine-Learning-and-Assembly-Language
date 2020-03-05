extrn   MyProc:     PROC          ;Tell MASM there's an external procedure that will be linked


.code
CallACPPProcedure   PROC
          sub    rsp, 30h                   ;Allocate shadow space
          mov    ecx, 1                     ;move first param into ECX
          mov    edx, 2                     ;move second param into EDX
          mov    r8d, 3                     ;move third param into r8d
          mov    r9d, 4                     ;move fourth param into r9d
          mov    dword ptr [rsp+20h],5      ;move fifth param into rsp+20h
          mov    dword ptr [rsp+28h],6      ;move sixth param into rsp+28h
          call   MyProc                     ;call procedure in C++
          add    rsp, 30h                   ;restore the stack
          ret
CallACPPProcedure   ENDP
END
