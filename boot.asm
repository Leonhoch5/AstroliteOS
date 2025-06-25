[org 0x7c00]

mov si, message           ; String source
mov ax, 0xB800            ; Load VGA text segment
mov es, ax                ; ES now points to VGA memory segment
xor di, di                ; DI = 0, start at offset 0

mov ah, 0x0F              ; Attribute (white on black)

.next_char:
    lodsb                 ; Load byte from [SI] into AL, SI++
    cmp al, 0
    je .done              ; End of string (null terminator)
    mov [es:di], al       ; Write character to video memory
    inc di
    mov [es:di], ah       ; Write attribute byte
    inc di
    jmp .next_char

.done:
    jmp $                 ; Infinite loop

message db "Hello, OS World!", 0

times 510-($-$$) db 0
dw 0xaa55
