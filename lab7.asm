MyCode segment 'CODE'
Assume cs: MyCode, ds:MyCode
Start:
    mov ax, DTSEG
    mov ds, ax
	push ds
	pop es
	call CLEARING
	mov dx, offset HiString
	mov ah, 9h
	int 21h              
	call CLRF
STARTPROGRAMM:
	lea si, HexString		
	mov cx, 4
INPUT:
	call GETCH
	CHECKNUMBER:
	cmp al, '*'
	je FAREXIT
	cmp al, '0'
	jl INPUT
	cmp al, '9'
	jg CHECKHILETTER
	mov dl, al
	call PUTCH
	sub al, 48
	jmp CORRECT
	
	CHECKHILETTER:
	cmp al, 'A'
	jl INPUT
	cmp al, 'F'
	jg CHECKLOLETTER
	mov dl, al
	call PUTCH
	sub al, 55
	jmp CORRECT
	
	CHECKLOLETTER:
	cmp al, 'a'
	jl INPUT
	cmp al, 'f'
	jg INPUT
	mov dl, al
	call PUTCH
	sub al, 87
	
	CORRECT:
	mov [si], al
	inc si
Loop INPUT
	lea si, HexString
	mov bx, 0
	xor ax, ax
	mov cx, 4
WRITETOAX:
	mov dx, 10h
	mov bl, [si]
	mul dx
	add ax, bx
	inc si
Loop WRITETOAX
push ax
PREPRINTHEX:
	mov dl, ' '
	call PUTCH
	mov dl, ' '
	call PUTCH
	mov dl, ' '
	call PUTCH
	lea si, HexString
	mov cx, 4
	pop ax
	jmp PRINTHEX
FAREXIT:
	jmp EXIT
	
PRINTHEX:
	push ax
	mov al, ah
	call HEX
	pop ax
	push ax
	call HEX
	mov dl, 'h'
	call PUTCH
	mov dl, ' '
	call PUTCH
	mov dl, '='
	call PUTCH
	mov dl, ' '
	call PUTCH
	pop ax 
	push ax
	mov cx, 0
CONVERTING:
	mov dx, 0
	mov bx, 8
	div bx
	push dx
	inc cx
	cmp ax, 0
	jne CONVERTING
OUTPUTDECIMAL:
	pop dx
	add dx, '0'
	call PUTCH
Loop OUTPUTDECIMAL
	mov dl, 'd'
	call PUTCH
WRITECODEFROMES:
	mov dl, ' '
	call PUTCH
	mov dl, ' '
	call PUTCH
	pop ax
	mov di, ax
	mov dx, es:[di]
	push dx
	mov al, dl
	call HEX
	mov dl, ' '
	call PUTCH
	pop dx
	push dx
	mov al, dh
	call HEX
	mov dl, ' '
	call PUTCH
	pop dx
	push dx
	call PUTCH
	mov dl, ' '
	call PUTCH
	pop dx 
	mov dl, dh
	call PUTCH
	
	call CLRF
	jmp STARTPROGRAMM
EXIT:   
	call CLRF        
	mov al, 0
	mov ah, 4ch
	int 21h 

;///////////////////////////////////////////////////////////////////////////////////           
HEX proc
	push ax
	lea bx, hexTable
	shr al, 4                  
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
	mov ah, 8
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
	HexString db '????$'
	hexTable db '0123456789ABCDEF' 
	HiString db 'Перевод из шестнадцатеричной cистемы cчисления в десятичную$'
DTSEG ENDS 	
 	Sixteen dw 16
MyCode ends
End Start
