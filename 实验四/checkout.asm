Data   segment
Buffer db 1,6,0,5,0,2,0,1,0,9
port_data   equ 43aH
port_status equ 43bH
s db " Output 10 data with demand  manner. Exit...",0dh,0ah,"$"    ;
Data   ends

Code   segment
       Assume cs:code,ds:data
Go:    mov ax,data
       Mov ds,ax
       mov dx,offset s    ;��ʾ��ʾ
       mov ah,9
       int 21h
       LEA si,buffer       
       MOV CX,10
L1:   mov ah,0bh
      int 21h         ;   ������ް���������AL=0FFh(�а���)��0(�ް���)
      cmp al,0FFh
      jz Exit
       MOV DX,port_status
       IN AL,DX           ; ��״̬�˿�
       TEST AL,00000001B
       JNZ L1 
       Mov al,[si]
       MOV DX,port_data
       OUT DX,AL          ; �������
       INC  si
       LOOP L1
LA:     mov ah,0bh
        int 21h        ; ������ް���������AL=0FFh(�а���)��0(�ް���)
        cmp al,0
        jz  LA
exit:   Mov ah,4ch
       Int 21h
Code   ends
       End go
