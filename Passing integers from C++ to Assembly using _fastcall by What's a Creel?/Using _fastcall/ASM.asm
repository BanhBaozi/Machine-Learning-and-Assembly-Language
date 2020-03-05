.code
PassingParameters   PROC
      mov   ax,cx    
      add   ax,dx     
      add   ax,r8w
      add   ax,r9w
      mov   eax, edx
      ret
      
ReturnEAX:
    ret
PassingParameters ENDP
END
