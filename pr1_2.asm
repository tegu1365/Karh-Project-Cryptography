include	mac.inc

MODEL small
stack 256

.data
string db 'HhhhhhEeeeeeLlllllLlllllOooooo.12345',0
newString  db 200 DUP(?)
stringLen dw 36
newStringLen dw 0
num dw 3
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
loopNV1Decrypt:
    cmp br, 0
    je exit

    mov dl, [di]
    mov [si],dl
	;PRINT msg1
	
    inc di
	inc si
	inc newStringLen
	dec br
	
	mov num,3
	
    jmp removeSymbols
removeSymbols:
    cmp num, 0
    je loopNV1Decrypt
	
	;PRINT msg2
	inc di
	dec num
	dec br
    jmp removeSymbols 
exit:
	PRINTSTR newString,newStringLen
	;PRINT newString
	mov ax,4c00h
	int 21h
end main