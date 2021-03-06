data   segment
portA  equ 400H        ; PA口地址
s      db "twenty four LEDs flicker circularly. Exit ...",0dh,0ah,"$"   ;
data   ends

code   segment
        assume cs:code,ds:data
go:    mov ax,data
       mov ds,ax
      mov dx,offset s    ;显示提示
      mov ah,9
      int 21h
       mov dx,porta+3
       mov al,80h
       Out dx,al         ; 三端口均初始化为方式0输出
L0:    mov si,24
       mov bx,1         ;  低16位初始值设为1（一个灯亮）
       mov cl,0          ;  高8位初始值设为0
L1:    mov ah,0bH
        Int 21h         ; 有无按键
        Cmp al,0ffH
        Jz  exit       
        mov dx,porta   ; 输出24位数
        mov al,bl
        Out dx,al  
        Inc  dx
        mov al,bh
        Out dx,al  
        Inc  dx
        mov al,cl
        Out dx,al  
        Call delay05    ; 延时
        SHL  bx,1       ;  低16位左移一位
        Rcl  cl,1         ;  高8位左移一位
        dec si       
        jnz  L1
        Jmp  L0         ; 重新开始
Exit:   mov ah,4ch
        Int 21h
delay05 proc near        ; 循环延时子程序
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
