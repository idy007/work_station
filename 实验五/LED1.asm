data   segment
portA  equ 400H        ; PA�ڵ�ַ
s      db "twenty four LEDs flicker circularly. Exit ...",0dh,0ah,"$"   ;
data   ends

code   segment
        assume cs:code,ds:data
go:    mov ax,data
       mov ds,ax
      mov dx,offset s    ;��ʾ��ʾ
      mov ah,9
      int 21h
       mov dx,porta+3
       mov al,80h
       Out dx,al         ; ���˿ھ���ʼ��Ϊ��ʽ0���
L0:    mov si,24
       mov bx,1         ;  ��16λ��ʼֵ��Ϊ1��һ��������
       mov cl,0          ;  ��8λ��ʼֵ��Ϊ0
L1:    mov ah,0bH
        Int 21h         ; ���ް���
        Cmp al,0ffH
        Jz  exit       
        mov dx,porta   ; ���24λ��
        mov al,bl
        Out dx,al  
        Inc  dx
        mov al,bh
        Out dx,al  
        Inc  dx
        mov al,cl
        Out dx,al  
        Call delay05    ; ��ʱ
        SHL  bx,1       ;  ��16λ����һλ
        Rcl  cl,1         ;  ��8λ����һλ
        dec si       
        jnz  L1
        Jmp  L0         ; ���¿�ʼ
Exit:   mov ah,4ch
        Int 21h
delay05 proc near        ; ѭ����ʱ�ӳ���
        push cx
        push bx
        mov cx,0000H
d1:     mov bx,1200h
d2:     dec bx
        jnz d2
        loop d1
        pop bx
        pop cx
        ret
delay05 endp
Code   ends
        End go
