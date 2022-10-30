PRINT macro message
    mov ah,09h
	mov dx, offset message
	int 21h
endm


PRINTSTR macro str,strLen
    lea di, str
    mov cx, strLen
loop1:
    mov dl, [di]
    mov ah, 02h
    int 21h 

    inc di
    dec cx
    jg loop1
endm

CLRSTR macro str, strLen,symbol
    lea di, str
    mov cx, strLen
loop3:
	mov dl, symbol
    mov [di], dl

    inc di
    dec cx
    jg loop3
endm

MOVESTR macro dest,str,strLen
	lea di,str
	lea si,dest
	mov cx,strLen
loop2:
	mov dl,[di]
	mov [si],dl
	
	inc di
	inc si
	dec cx
	jg loop2
endm