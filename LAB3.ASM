MyCode segment 'CODE'
	Assume cs: MyCode, ds:MyCode
Start:
push cs
pop ds

;������� ������
mov ax, 03
int 10h

mov dl, WriteA
call PUTCH
call CLRFF 

call GETCH

mov al, 0
mov ah, 4ch
int 21h

;����� ��������
PUTCH  proc
	mov ah, 02
	int 21h 
	ret
PUTCH endp

;������� �� ��������� ������
CLRFF proc
	mov ah, 02
	mov dl, CLRF
	int 21h   
	ret
CLRFF endp

;���� �������
GETCH proc
	mov ah, 01h
	int 021h
ret
GETCH endp 

WriteA db 'Vasyunin$'
CLRF db 10, 13
MyCode ends
End Start

