include	mac.inc

MODEL small
stack 256

.data
string db 'Ebiil+',0
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
loopNV2Decrypt:
    cmp br, 0
    je exit
	
	mov dl, [di]
	mov symbol,dl
	jmp changeSymbolAsc
loopNV2DecryptSecond:
	mov dl,symbol
	mov [si],dl
	;PRINT msg1
	
    inc di
	inc si
	inc newStringLen
	dec br
	mov num2,3
	jmp loopNV2Decrypt
changeSymbolAsc:;Cesar cipher
	cmp num2,0
	je loopNV2DecryptSecond
	cmp symbol,255
	je symbolRotateAsc
afterRotateAsc:
	inc symbol
	dec num2
	jmp changeSymbolAsc
symbolRotateAsc:
	mov symbol,0
	jmp afterRotateAsc
exit:
	PRINTSTR newString,newStringLen
	;PRINT newString
	mov ax,4c00h
	int 21h
end main