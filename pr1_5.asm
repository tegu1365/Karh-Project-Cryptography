include	mac.inc

MODEL small
stack 256

.data
string db 'Hello.8',0
newString  db 200 DUP(?)
stringLen dw 7
newStringLen dw 0
symbol db ' '
s2 db ' '
br dw 0

.code
main:
	mov ax, @data
	mov ds, ax
	
	lea di, string
	lea si, newString
    mov cx, stringLen
	mov br,cx
loopNV3Crypt:
    cmp br, 0
    je exit
	
	mov dl, [di]
	mov symbol,dl
	dec br
	
	cmp br,0
	je secondHalfOfLoop3
	
	inc di
	mov dl, [di]
	
	mov s2,dl
	mov dl,s2
	
	mov [si],dl
	
	inc si
	inc newStringLen
	dec br
	
secondHalfOfLoop3:
	mov dl,symbol
	mov [si],dl
	;PRINT msg1
	
    inc di
	inc si
	inc newStringLen
	jmp loopNV3Crypt	
exit:
	PRINTSTR newString,newStringLen
	;PRINT newString
	mov ax,4c00h
	int 21h
end main