name "String"
.model small
.stack 100h 
.code
  
start: 
    mov ax, @data
    mov ds, ax
              
    mov ah, 9h
    mov dx, offset message1
    int 21h  
    
    call nextline
    
    mov ah, 9h
    mov dx, offset message2
    int 21h  
    
    call nextline
    
    mov ah, 9h
    mov dx, offset message3
    int 21h   
    
    call nextline
    
    mov ah, 9h
    mov dx, offset message4
    int 21h  
    
    call nextline  
    
    
    mov ax, 4c00h
    int 21h 
    
nextline: 
    mov ah, 02h
    mov dl, 0ah  
    int 21h 
 
    mov dl, 0dh  
    int 21h
ret 
   
.data 

message1 db "Hello Stas$"   
message2 db "I LOVE $" 
message3 db "ASSEMBLY$" 
message4 db "NO)))))$" 


