.model small
.stack 100h
.data      

messageWelcome db "Program 3",0Dh ,0Ah, '$'
.code
  
start:    
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    mov ah, 09h
    mov dx, offset messageWelcome
    int 21h   
    
    mov ah, 4Ch
    int 21h
end start
 