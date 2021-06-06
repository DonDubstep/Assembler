MyCode segment 'CODE'
Assume cs: MyCode, ds:MyCode          
Start: 
    	mov ax, DTSEG
    	mov DS, ax
	push DS
	pop ES
	call CLEARING
	mov cx, NumStrgs
STARTPROGRAMM:
	push cx 
PREPINPUT:
	lea di, MyString
	mov dx, 0
	push dx  
	mov cx, NumCycle
	call Getch
	cmp al, '*'
	je EXIT                     
INPUT:                   
	cmp al, '$'                    
	je SIGNALSTOP
	STOSB                               
	pop dx
          inc dx  
          push dx
          cmp cx, 1
          je PREPPRINT
          call Getch   
loop INPUT 

SIGNALSTOP:
	cmp dx, 0
	jne PREPPRINT
	call CLRF
	jmp PREPINPUT
PREPPRINT:
        push dx
         mov dl, ' '
         call PUTCH
         mov dl, '='
         call PUTCH
         mov dl, ' '
         call PUTCH
         lea si, MyString
	pop dx
	mov cx, dx
PRINT:   
         LODSB
         call HEX
         mov dl, ' '
         call PUTCH
Loop PRINT
	call CLRF
	pop cx 
	pop cx	
Loop STARTPROGRAMM 
EXIT:  
 	mov ah, 09h
	mov dx, offset EndMessage
	int 21h 
	call CLRF  
	mov al, 0
	mov ah, 4ch
	int 21h       
	
;///////////////////////////////////////////////////////////////////////////////////
GETCH proc
	mov ah, 01
	int 21h
	ret	
 GETCH endp	
 ;///////////////////////////////////////////////////////////////////////////////////             
PUTCH proc
	mov ah, 02
	int 21h
	ret	
 PUTCH endp	
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
 
 DTSEG SEGMENT 'DATA'   
  	 EndMessage db 'End of the program$'   
 	NumCycle equ 10  
	NumStrgs equ 10
 	hexTable db '0123456789ABCDEF'     
	 MyString db  20 dup (' '), '$'
DTSEG ENDS 
MyCode ends  
End Start