; Calling will use AX and BX as parameters

; AX is delay in microseconds
delay:
	pusha
	
	; CX:DX combined is 32 bit specifier of delay in microseconds
	; 000030d4 is 0.0125
 	mov cx, bx
	mov dx, ax
	mov ah, 86H ; timer mode, may not be portable.
	int 15H
	
	popa
	ret
	
; Uses BX as string pointer and AX as color.
print:
	pusha
	mov cx, ax ; Store color since it's going to be messed with a lot
	
.loop:
	
	; Delay each char by a bit to read
	push ax
	push bx
	mov ax, 30d4h ; 0.0125 sec 
	mov bx, 0h
	call delay
	pop bx
	pop ax
	
	; AL is current character in VGA
	; Now for actually printing
	mov al, [bx] ; AL is char to print.
	cmp	al, 0 ; Null termed, return
	je .exit
	
	push bx
	mov ah, 0x0e ; TTY mode
	mov bx, cx ; Color 
	int 0x10 ; PRINT!
	pop bx
	 
	inc bx ; Next char
	jnz .loop

.exit:
	popa
	ret

; No params
print_nl:
	pusha

	mov	ax, 0x0e0a ; \n
	int	0x10
	mov	al, 0x0d ; \r
	int	0x10

	popa
	ret

; BX is address
; That's it
print_hex:
	pusha

	mov	cx, 0

.loop:
	cmp	cx, 4
	je	.end

	mov	ax, dx
	and	ax, 0x000f
	add	al, 0x30
	cmp	al, 0x39
	jle	.numeric
	add	al, 7

.numeric:
	mov	bx, HEX_OUT + 5
	sub	bx, cx
	mov	[bx], al
	ror	dx, 4

	add	cx, 1
	jmp	.loop

.end:
	mov	bx, HEX_OUT
	call	print

	popa
	ret

HEX_OUT:
	db '0x0000',0
