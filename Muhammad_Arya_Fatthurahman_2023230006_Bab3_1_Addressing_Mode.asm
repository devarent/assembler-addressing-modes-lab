BITS 16
ORG 100h

DS_VALUE EQU 0200h
BX_VALUE EQU 0300h
DI_VALUE EQU 0400h

start:
    push cs
    pop ds

    mov dx, identity_text
    call print_string

    mov dx, title_text
    call print_string

    mov dx, part_a_text
    call print_string
    mov ax, DS_VALUE
    mov cl, 4
    shl ax, cl
    add ax, 1234h
    call print_hex
    mov dx, hex_suffix
    call print_string

    mov dx, part_b_text
    call print_string
    mov ax, DS_VALUE
    mov cl, 4
    shl ax, cl
    add ax, BX_VALUE
    call print_hex
    mov dx, hex_suffix
    call print_string
    mov dx, part_b_range
    call print_string

    mov dx, part_c_text
    call print_string
    mov ax, DS_VALUE
    mov cl, 4
    shl ax, cl
    add ax, DI_VALUE
    call print_hex
    mov dx, hex_suffix
    call print_string

    mov dx, exit_text
    call print_string
    mov ah, 08h
    int 21h

    mov ax, 4C00h
    int 21h

print_string:
    mov ah, 09h
    int 21h
    ret

print_hex:
    push ax
    push bx
    push cx
    push dx
    mov bx, ax
    mov cx, 4
.digit:
    rol bx, 4
    mov dl, bl
    and dl, 0Fh
    cmp dl, 9
    jbe .number
    add dl, 'A' - 10
    jmp .output
.number:
    add dl, '0'
.output:
    mov ah, 02h
    int 21h
    loop .digit
    pop dx
    pop cx
    pop bx
    pop ax
    ret

identity_text:
    db 'Nama: Muhammad Arya Fatthurahman', 13, 10
    db 'NIM: 2023230006', 13, 10
    db 'Program Studi: Teknologi Informasi', 13, 10
    db 'Hari/Tanggal: Selasa, 27 Oktober 2026', 13, 10, 13, 10, '$'
title_text:
    db 'Kuis 3.1 - Real Mode Addressing', 13, 10
    db 'DS=0200h, BX=0300h, DI=0400h', 13, 10, 13, 10, '$'
part_a_text:
    db '(a) MOV AL,[1234h]', 13, 10
    db 'DS:offset = 0200h:1234h', 13, 10
    db 'Alamat fisik = 0200h x 10h + 1234h = $'
part_b_text:
    db 13, 10, '(b) MOV EAX,[BX]', 13, 10
    db 'DS:BX = 0200h:0300h', 13, 10
    db 'Alamat awal = 0200h x 10h + 0300h = $'
part_b_range:
    db 13, 10, 'EAX membaca 4 byte: 02300h-02303h', 13, 10, 13, 10, '$'
part_c_text:
    db '(c) MOV [DI],AL', 13, 10
    db 'DS:DI = 0200h:0400h', 13, 10
    db 'Alamat fisik = 0200h x 10h + 0400h = $'
hex_suffix:
    db 'h', 13, 10, '$'
exit_text:
    db 13, 10, 'Tekan sembarang tombol untuk keluar...', '$'
