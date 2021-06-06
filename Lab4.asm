MyCode segment 'CODE'
	Assume cs: MyCode, ds:MyCode        
Start:
	push cs
	pop ds
	call Clearing
          call Getch 
          push ax
          call Clearing  
	mov cx, 20       
Writing:
	pop ax 
	   
	mov dl, al
 	call Putch
	
	push ax 
	
	mov dl, Defis
	call Putch
	
	pop ax
	call hexx        
          
          push ax
         mov dl, 68h       ;68h = h
         call Putch
         mov dl, 2eh       ;2eh = .
         call Putch
          
          pop ax
	inc ax    
	push ax 
	call CLRF
loop Writing    

	mov cx, 20
	mov ah, 9
	mov dx, offset   EndMessage
	int 21h 
	
       	call Getch  
       	push ax
       	call Clearing 
       	pop ax
       	push ax
       	
        	cmp al, 2ah
         	jne Writing

	mov al, 0
	mov ah, 4ch
	int 21h   
;//////////////////////////////////////////////////////////////////////////////////////	
hexx proc
	push ax
	lea bx, hex
	shr al, 4
	mov dl, 15                  ;доп задание
	sub dl, al                      ;
	mov al, dl                     ;
	xlat
	mov dx, ax
	call Putch
	pop ax
	push ax
         	and al, 0Fh 
         	mov dl, 15
	sub dl, al
	mov al, dl
	xlat
	mov dx,ax
	call Putch
	pop ax
	ret			
hexx endp
;//////////////////////////////////////////////////////////////////////////////////////	
Putch proc
	mov ah, 02
	int 21h
	ret
Putch endp
;//////////////////////////////////////////////////////////////////////////////////////	  
Getch  proc
	mov ah, 01h  
	int 021h  
	ret
Getch endp  
;//////////////////////////////////////////////////////////////////////////////////////	
Clearing proc         
	mov ax, 03
	int 10h
	ret
Clearing endp
;//////////////////////////////////////////////////////////////////////////////////////  
CLRF proc
	mov ah, 02
	mov dl, Probel
	int 21h  
	ret 
CLRF endp
;//////////////////////////////////////////////////////////////////////////////////////		
Probel db 10, 13 
Defis db '-'     
;hex db '0123456789ABCDEF'
hex db 'FEDCBA9876543210' 
EndMessage db 'Для выхода нажмите * $'
MyCode ends
End Start