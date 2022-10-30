include	mac.inc

MODEL small
stack 256

.data
string db 'Hello.',0
newString  db 200 DUP(?)
stringLen dw 6
newStringLen dw 0
symbol db ?
num2 dw 3
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
loopNV2Crypt:
    cmp br, 0
    je exit
	
	mov dl, [di]
	mov symbol,dl
	jmp changeSymbol
loopNV2CryptSecond:
	mov dl,symbol
	mov [si],dl
	;PRINT msg1
	
    inc di
	inc si
	inc newStringLen
	dec br
	mov num2,3
	jmp loopNV2Crypt
changeSymbol:;Cesar cipher
	cmp num2,0
	je loopNV2CryptSecond
	cmp symbol,0
	je symbolRotate
afterRotate:
	dec symbol
	dec num2
	jmp changeSymbol
symbolRotate:
	mov symbol,255
	jmp afterRotate
exit:
	PRINTSTR newString,newStringLen
	;PRINT newString
	mov ax,4c00h
	int 21h
end main