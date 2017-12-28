data   segment
portA  equ 400H        ; PA口地址
s      db "twenty four LEDs flicker crosswise. Press any key to exit ...",0dh,0ah,"$"    ;程序功能提示
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
       mov bx,5555H   
       mov cl,55H         
L0:    mov ah,0bH
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
        Call delay05      ; 延时
        Xor  bx,0ffffH    ;  各位取反
        xor  cl,0ffH          
        Jmp  L0         
Exit:   mov ah,4ch
        Int 21h
delay05 proc near        ; 循环延时子程序
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
