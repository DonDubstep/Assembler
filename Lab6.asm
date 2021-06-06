.286
MyCode segment 'CODE'
	Assume cs: MyCode, ds:MyCode        
Start:
	push cs
	pop ds   
	call CLEARING
  	  mov cl, es:80h  
    	dec cl
    	mov ch, 0
	lea bx, es:82h	
	mov di, 82h		
	lea si, String1	
	;mov dx, 0
CHECKFIRSTARG:
	mov al, es:[di]  
	cmp al, ' '
	je ENDFIRSTARG
	cmp al,BYTE PTR[si]
	jne DOESNOTMATCH
	inc si
         	inc di
	inc ah  
Loop CHECKFIRSTARG
ENDFIRSTARG:         
	push ax
	cmp ah,8      
	je COMPLIANCE
	jne DOESNOTMATCH
COMPLIANCE:
	mov dx, offset RightFirstArg
	call PUTSTRING 
	mov di, 82h
	pop ax  
	push cx
	push ax
	mov cl, ah
	WriteLastNameLoop:
        		mov dl, es:[di]
       		call PUTCH
		inc di
	Loop WriteLastNameLoop    
	mov dl, ' '
	call PUTCH
	pop ax 
	mov cl, ah
	mov di, 82h  
	mov ah, 0
 WriteCodeLastName:    
	mov al, es:[di]     
	mov ah, 0
	push cx
	mov cx, 0
CONVERTOCT:		     
	mov dx, 0
	mov bx, 8
	div bx
	push dx
	inc cx
	cmp ax, 0
	jne CONVERTOCT
OUTPUTDECIMAL:
	pop dx
	add dx, '0'
	call PUTCH
Loop OUTPUTDECIMAL  
	inc di 
	mov dl, ' '
	call PUTCH 
	pop cx
Loop WriteCodeLastName

	
	pop cx                
	mov al, es:[di]
	jmp SECONDCHECK
DOESNOTMATCH:
	mov dx, offset NoRightFirstArg
	call PUTSTRING     
 	push cx
	jmp SECONDCHECK
	     
SECONDCHECK: 
	cmp cx, 0
	je SECONDNOSUCCESS
	cmp al, ' '
	jne SKIPFORSECONDARG
	cmp cx, 4
	jge SECONDSUCCESS
	SECONDNOSUCCESS:  
	call CLRF
	mov dx, offset NOTSecondArg 
	call PUTSTRING 
	jmp EXIT    
	SECONDSUCCESS: 
	call CLRF          
	mov dx, offset ISSecondArg 
	call PUTSTRING 
	jmp EXIT
SKIPFORSECONDARG:
	dec cx                         
	inc di  
	mov al, es:[di]              
	jmp SECONDCHECK
EXIT:   
	call CLRF        
	mov al, 0
	mov ah, 4ch
	int 21h   	          
;///////////////////////////////////////////////////////////////////////////////////       
 HEX proc
	push ax
	lea bx, hexTable
	shr al, 4                  ;
	xlat
	mov dx, ax
	call PUTCH
	pop ax
	push ax
         	and al, 0Fh 
	xlat
	mov dx,ax
	call PUTCH
	pop ax
	ret			
 HEX endp	
 ;///////////////////////////////////////////////////////////////////////////////////             
GETCH proc
	mov ah, 08
	int 21h
	ret	
 GETCH endp	
 ;///////////////////////////////////////////////////////////////////////////////////             
PUTCH proc
	mov ah, 02
	int 21h
	ret	
 PUTCH endp	 	    
  ;//////////////////////////////////////////////////////////////////////////////////
  PUTSTRING proc  
  	mov ah, 9
  	int 21h  
  	ret
  PUTSTRING endp
 ;///////////////////////////////////////////////////////////////////////////////////
CLRF proc
	mov ah, 02
	mov dl, 10
	int 21h         
	mov dl, 13
	int 21h  
	ret 
CLRF endp 
 ;///////////////////////////////////////////////////////////////////////////////////
CLEARING proc         
	mov ax, 03
	int 10h
	ret
CLEARING endp
;//////////////////////////////////////////////////////////////////////////////////////  	

String1 db 'Vasyunin$'
RightFirstArg db 'Первый параметр задан правильно = $'
NoRightFirstArg db 'Первый параметр неправильный$'      
ISSecondArg db 'Второй параметр есть$'
NOTSecondArg db 'Второй параметр отсутствует$'         
hexTable db '01234567'     
MyCode ends
End Start