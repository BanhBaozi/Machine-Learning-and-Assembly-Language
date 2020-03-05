.code
PassingParameters   PROC
      mov   eax, ecx      ;Assume ecx is smaller
      cmp   edx, eax      ;compared eax to edx
      jg    ReturnEAX
      
      mov   eax, edx
      ret
      
ReturnEAX:
    ret
PassingParameters ENDP
END
