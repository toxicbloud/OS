[BITS 16]  ; indique a Nasm que l'on travaille en 16 bits
[ORG 0x0]

; initialisation des segments en 0x07C00
    mov ax, 0x07C0
    mov ds, ax
    mov es, ax
    mov ax, 0x8000
    mov ss, ax
    mov sp, 0xf000    ; pile de 0x8F000 -> 0x80000

; affiche un msg
    mov si, msgDebut
    call afficher


end:
    jmp end


;--- Variables ---
    msgDebut db "Hello World !", 13, 10, 0
;-----------------

;---------------------------------------------------------
; Synopsis: Affiche une chaîne de caractères se terminant par 0x0
; Entrée:   DS:SI -> pointe sur la chaîne à afficher
;---------------------------------------------------------
afficher:
    push ax
    push bx
.debut:
    lodsb         ; ds:si -> al
    cmp al, 0     ; fin chaîne ?
    jz .fin
    mov ah, 0x0E  ; appel au service 0x0e, int 0x10 du bios
    mov bx, 0x07  ; bx -> attribut, al -> caractère ASCII
    int 0x10
    jmp .debut

.fin:
    pop bx
    pop ax
    ret

;--- NOP jusqu'à 510 ---
    times 510-($-$$) db 144
    dw 0xAA55
