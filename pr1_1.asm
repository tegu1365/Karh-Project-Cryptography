include	mac.inc

MODEL small
stack 256

.data
string db 'Hello.',0
newString  db 200 DUP(?)
stringLen dw 6
newStringLen dw 0
symbol db ?
num dw 5
br dw 0

msg1 db 'Added symbol to str2$'
msg2 db 'added newSym to str2$'
.code
main:
	mov ax, @data
	mov ds, ax
	
	lea di, string
	lea si, newString
    mov cx, stringLen
	mov br,cx
loopNV1Crypt:
    cmp br, 0
    je exit

    mov dl, [di]
    mov [si],dl
	mov symbol,dl
	;PRINT msg1
	
    inc di
	inc si
	inc newStringLen
	dec br
	
	mov num,5
	
    jmp addSymbols
addSymbols:
    cmp num, 0
    je loopNV1Crypt
	
	inc symbol
	
	mov dl,symbol
	mov [si],dl
	;PRINT msg2
	inc si
	inc newStringLen
	dec num
	mov cx,stringLen
    jmp addSymbols 
exit:
	PRINTSTR newString,newStringLen
	;PRINT newString
	mov ax,4c00h
	int 21h
end main