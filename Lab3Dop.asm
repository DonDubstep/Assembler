MyCode segment 'CODE'
Assume cs: MyCode, ds:MyCode
Start:
push cs
pop ds

;Очистка экрана
mov ax, 03
int 10h

mov dl, WriteName    
mov ah, 02
int 21h
call CLRFF
call GETCH

mov al, 0
mov ah, 4ch
int 21h

;Переход на следующую строку
CLRFF proc
	mov ah, 02
	mov dl, CLRF
	int 21h   
	ret
CLRFF endp

;Ввод символа
GETCH proc
	mov ah, 01h
	int 021h
ret
GETCH endp 

WriteName db 'Yo$'
CLRF db 10, 13
MyCode ends
End Start

