data   segment
portA  equ 400H        ; PA�ڵ�ַ
s      db "twenty four LEDs flicker crosswise. Press any key to exit ...",0dh,0ah,"$"    ;��������ʾ
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
       mov bx,5555H   
       mov cl,55H         
L0:    mov ah,0bH
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
        Call delay05      ; ��ʱ
        Xor  bx,0ffffH    ;  ��λȡ��
        xor  cl,0ffH          
        Jmp  L0         
Exit:   mov ah,4ch
        Int 21h
delay05 proc near        ; ѭ����ʱ�ӳ���
        push cx
        push bx
        mov cx,2000H
d1:     mov bx,0
d2:     dec bx
        jnz d2
        loop d1
        pop bx
        pop cx
        ret
delay05 endp
Code   ends
        End go
