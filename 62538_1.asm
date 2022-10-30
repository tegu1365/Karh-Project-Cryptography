include	mac.inc

MODEL small
stack 256

.data
nvk db '0'
;file data
handle dw 0 
string db 1201 DUP ('$')
stringLen dw 0
filename db 'test.txt',0

;Input
comand db ?
UI db 'Enter comand(1-to crypt; 2-to decrypt; 3-to exit): $'
errorMessComand db '- The comand is not valid.$'
errorMessMxCrypt db '- The massegeis crypted on max level.$'
errorMess db '- The massege is not crypted. You cannot decrypt.$'
levelMess db '--- Crypted at level: $'

;Strings handling
newString  db 1200 DUP(?)
newStringLen dw 0
symbol db ?
br dw 0
k db ' '

;NVK 1-crypt
num dw 6; first i wanted to do it with 5 so i can make it like pencile

;NVK 2-crypt
num2 dw 3

;NVK 3-crypt
s2 db ?

.code
.386
main:
	mov ax, @data
	mov ds, ax
	
	;open
	mov ah,3Dh   
	mov al,0   
	mov dx,offset filename 
	int 21h
	mov handle,ax 
	
	;read
	mov ah,3Fh
	mov cx,200
	mov dx,offset string  
	mov bx,handle
	int 21h
	
	;string len
	mov dx,offset string
	add stringLen,ax
	
	jmp printMessage
	
EnterComand:
	PRINT UI
	mov ah,01h
	int 21h
	mov comand,al
	
	mov ah,02h
	mov dl,10
	int 21h
	
	cmp comand,'3'
	je endProgram
	
	cmp comand,'1'
	je NVKCrypt
	
	cmp comand,'2'
	je NVKDecrypt
	
	cmp comand,'3'
	jg printErrorMessComand
	
	cmp comand,'1'
	jl printErrorMessComand
NVKCrypt:
	cmp nvk,'0'
	je N1Crypt
	
	cmp nvk,'1'
	je N2Crypt
	
	cmp nvk,'2'
	je N3Crypt
	
	cmp nvk,'3'
	jge printErrorMessMaxCrypt
NVKDecrypt:
	cmp nvk,'0'
	je printErrorMess
	
	cmp nvk,'1'
	je N1Decrypt
	
	cmp nvk,'2'
	je N2Decrypt
	
	cmp nvk,'3'
	je N3Decrypt
	
N1Crypt:;Skitala
	lea di, string
	lea si, newString
    mov cx, stringLen
	mov br,cx
loopNV1Crypt:
    cmp br, 0
    je endOfCrypt

    mov dl, [di]
    mov [si],dl
	mov symbol,dl
	
    inc di
	inc si
	inc newStringLen
	dec br
	
	mov num,6
	
    jmp addSymbols
addSymbols:
    cmp num, 0
    je loopNV1Crypt
	
	inc symbol
	cmp symbol,255
	je maxSymbolNK1	
returnToAddSymbols:
	mov dl,symbol
	mov [si],dl
	inc si
	inc newStringLen
	dec num
	mov cx,stringLen
    jmp addSymbols
maxSymbolNK1:
	mov symbol,0
	jmp returnToAddSymbols
	
N2Crypt:;Cesar cipher
	lea di, string
	lea si, newString
    mov cx, stringLen
	mov br,cx
loopNV2Crypt:
    cmp br, 0
    je endOfCrypt
	
	mov dl, [di]
	mov symbol,dl
	jmp changeSymbol
loopNV2CryptSecond:
	mov dl,symbol
	mov [si],dl
	
    inc di
	inc si
	inc newStringLen
	dec br
	mov num2,3
	jmp loopNV2Crypt
changeSymbol:
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
	
N3Crypt:;Swap symbols
	lea di, string
	lea si, newString
    mov cx, stringLen
	mov br,cx
loopNV3Crypt:
    cmp br, 0
    je endOfCrypt
	
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

N1Decrypt:
	lea di, string
	lea si, newString
    mov cx, stringLen
	mov br,cx
loopNV1Decrypt:
    cmp br, 0
    je endOfDecrypt

    mov dl, [di]
    mov [si],dl
	;PRINT msg1
	
    inc di
	inc si
	inc newStringLen
	dec br
	
	mov num,6
	
    jmp removeSymbols
removeSymbols:
    cmp num, 0
    je loopNV1Decrypt
	
	;PRINT msg2
	inc di
	dec num
	dec br
    jmp removeSymbols

N2Decrypt:
	lea di, string
	lea si, newString
    mov cx, stringLen
	mov br,cx
loopNV2Decrypt:
    cmp br, 0
    je endOfDecrypt
	
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
changeSymbolAsc:
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
	
N3Decrypt:
	lea di, string
	lea si, newString
    mov cx, stringLen
	mov br,cx
loopNV3Decrypt:
    cmp br, 0
    je endOfDecrypt
	
	mov dl, [di]
	mov symbol,dl
	dec br
	
	cmp br,0
	je secondHalfOfLoop3Decrypt
	
	inc di
	mov dl, [di]
	
	mov s2,dl
	mov dl,s2
	
	mov [si],dl
	
	inc si
	inc newStringLen
	dec br
	
secondHalfOfLoop3Decrypt:
	mov dl,symbol
	mov [si],dl
	;PRINT msg1
	
    inc di
	inc si
	inc newStringLen
	jmp loopNV3Decrypt

;for every crypt and decrypt
endOfCrypt:
	add nvk,1
	jmp StrCorrection
endOfDecrypt:
	sub nvk,1
	jmp StrCorrection
	
;swaps and clears the strings
StrCorrection:
clearSTR:
	lea di, string
    mov cx, stringLen
loopCLRnewSTR1:
	cmp cx,0
	je MoveSTR1
	mov dl, k
    mov [di], dl

    inc di
    dec cx
    jg loopCLRnewSTR1
	
MoveSTR1:
	lea di,newString
	lea si,string
	mov cx,newStringLen
loopMoveSTR:
	cmp cx,0
	je sizeMove
	mov dl,[di]
	mov [si],dl
	
	inc di
	inc si
	dec cx
	jg loopMoveSTR
sizeMove:	
	mov ax,newStringLen
	mov stringLen,ax
clearSTR2:
	lea di, newString
    mov cx, newStringLen
loopCLRnewSTR:
	cmp cx,0
	je endOfStrCorection
	mov dl, k
    mov [di], dl

    inc di
    dec cx
    jg loopCLRnewSTR
	
endOfStrCorection:	
	mov newStringLen,0
	jmp printMessage
	
;message print
printMessage:
    PRINT levelMess
	mov ah,02h
	mov dl,nvk
	int 21h
    mov ah,02h
	mov dl,10
	int 21h
	PRINTSTR string,stringLen
	mov ah,02h
	mov dl,10
	int 21h
	jmp EnterComand
printErrorMessComand:
	PRINT errorMessComand
	
	mov ah,02h
	mov dl,10
	int 21h
	jmp EnterComand
printErrorMess:
    PRINT errorMess
	
	mov ah,02h
	mov dl,10
	int 21h
	jmp EnterComand
	
printErrorMessMaxCrypt:
	PRINT errorMessMxCrypt
	
	mov ah,02h
	mov dl,10
	int 21h
	jmp EnterComand
endProgram:
	;close
	mov ah,3eh
	mov bx,handle
	int 21h
	jc	exit 
	nop 
exit:
	mov ax,4c00h
	int 21h
end main