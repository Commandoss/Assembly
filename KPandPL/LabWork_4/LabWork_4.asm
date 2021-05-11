.model small
.stack 100h
.data      

messageWelcome db "Arkanoid",0Dh ,0Ah   
               db "Controls:",0Dh ,0Ah
               db "Left/Right arrow - move paddle",0Dh ,0Ah
               db "Up - shoot",0Dh ,0Ah
               db "Esc - exit",0Dh ,0Ah
               db "Enter - start",0Dh ,0Ah, '$'   
               
messageWin     db "*               YOU WIN                *",0Dh ,0Ah, '$'   

pointUser db "Score:$" 
failMsg db "You lose! Press enter to start over..$"
winMsg db "You Win! Press enter to start over..$"

sizeBuffer equ 4000
buffer dw sizeBuffer dup(?) 
   

level db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
      db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
      db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
	  db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
	  db 00h, 00h, 00h, 00h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
	  db 00h, 00h, 00h, 00h, 00h, 00h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
	  db 00h, 00h, 00h, 00h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
	  db 00h, 00h, 20h, 20h, 20h, 20h, 00h, 00h, 20h, 20h, 20h, 20h, 20h, 20h, 00h, 00h, 20h, 20h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
	  db 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h	  
	  db 20h, 20h, 00h, 00h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 00h, 00h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h	  
	  db 20h, 20h, 00h, 00h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 20h, 20h, 00h, 00h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h	  
	  db 00h, 00h, 00h, 00h, 00h, 00h, 20h, 20h, 20h, 20h, 00h, 00h, 20h, 20h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 20h, 20h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h	


gameOver dw 0


flagMowing dw 0

countShiftPaddle dw 0
paddlePositionY dw 0 
paddlePositionX dw 0 
paddleSize dw 16

ballPositionY dw 0
ballPositionX dw 0 
ballSize dw 2

verticalMovement dw 0
horizontalMovement dw 0

score dw 0 
winCount dw 480

.code

startMenu proc near 
    push ax
    push bx 
    push dx
    push es                                 
settingGraphicsMode:
    mov ah, 00
    mov al, 03
    int 10h 
Menu:
    xor ax, ax        
    mov ah, 9h 
    lea dx, messageWelcome
    int 21h    
hide—ursor:   
    xor ax, ax
    mov ah, 02
    mov dh, 25
    int 10h           
waitEnterWelcome: 
    mov ah, 1  
    int 16h 
    jz waitEnterWelcome 
    
    xor ah, ah
    int 16h  
    
    cmp ah, 1Ch
    je EnterWelcome   
    
    cmp ah, 01h
    je Exit 

    jmp waitEnterWelcome
    
EnterWelcome:
    pop es  
    pop dx
    pop bx
    pop ax      
    ret
endp 

clearScreen proc near 
    xor ax, ax
    mov ah, 06
    mov al, 00
    
    mov bh, 00h
    xor cx, cx
    
    mov dl, 80
    mov dh, 25
    int 10h
    ret
endp  

initBoundaries proc near
    push cx
    push ax
    push si
    push es  
    push bx
    push dx
    call clearScreen     
    lea di, buffer
    mov al, ' '
    mov ah, 40h
    mov cx, 80   
firstLine:
    stosw
    loop firstLine 
    mov cx, 23     
columns:
    stosw     
    add di, 78
    add di, 78   
    stosw 
    loop columns  
    mov cx, 80    
secondLine:
    stosw
    loop secondLine  
    mov di, 80
    add di, 80 
    add di, 2       
    mov cx, 23 
    mov ah, 70h  
glass:   
    stosw
    add di, 64
    add di, 64 
    stosw
    add di, 14
    add di, 14
    loop glass
glassEnd: 
    mov di, 160 
    add di, 2
    mov cx, 66
glassBottom:
    stosw     
    loop glassBottom
ScorePrint:
    mov ax, 07h
    mov cx, 6
    lea si, pointUser 
    mov di, 456
scoreLoop:
    movsb 
    stosb
    loop scoreLoop    
    pop dx
    pop bx
    pop es
    pop si
    pop ax
    pop cx
    ret
endp

printScore proc near
    pusha
    xor cx, cx    
    mov ax, score
    xor dx, dx 
    mov si, 10   
loadStack:   
    div si 			  		
    add dl, '0'
    push dx    
    xor dx, dx 
    inc cx        
    cmp ax, 0
    jne loadStack   
    mov bx, 468    
printStack:
    pop dx 
    push ds
    mov ax, 0b800h
    mov ds, ax
    mov [bx], dl
    inc bx
    mov [bx], 07h
    inc bx
    pop ds           
    loop printStack          
    popa 
    ret   
endp    

initPlayField proc near
    push cx
    push bx
    push ax  
    push es
    push di
    push si
      
    push 0b800h
    pop es
    mov si, offset level   
    
    xor di, di
    xor cx, cx
    xor bx, bx
     
    mov bl, 4
    add di, 324
    add cx, 64 
    mov ax, ' '
    jmp loop11
    
nextLine:
    add di, 32
    add cx, 64
    dec bx  
    
loop11:
    cld
    stosb
    movsb      
    loop loop11
    cmp bx, 0
    jne nextLine 
       
    pop si
    pop di
    pop es 
    pop ax
    pop bx
    pop cx
    ret
endp    

printLose proc near    
    push es 
    push ds
    
    push 0b800h
    pop es
    
    lea si, failMsg
    mov ax, 40h
    
    mov di, 830
    mov cx, 37
    
loopLose:
    movsb
    stosb
    loop loopLose
    
waitEnterLose: 
    mov ah, 1 ; - 01h ñ 83/84-ÍÎ‡‚Ë¯Ë; 
    int 16h 
    jz waitEnterLose 
    
    xor ah, ah
    int 16h
    
    cmp ah, 01h
    je Escape  
    
    cmp ah, 1Ch   ; ÂÒÎË enter
    je EnterLose    

    jmp waitEnterLose
       
EnterLose:   
    pop ds
    pop es
    ret
endp

outBuffer proc near
    push cx
    push es
    push ds
    call clearScreen
    push 0b800h
    pop es
    
    mov cx, sizeBuffer
    lea si, buffer
    mov di, 0
    
loopOutBuffer:
    rep movsb
    
    pop ds
    pop es
    pop cx 
    ret
endp
main:
    mov ax, @data
    mov ds, ax
    mov es, ax      
    call startMenu
    
restart:
    mov score, 0 
    mov gameOver, 0
    mov flagMowing, 0
    
    call initBoundaries
    call outBuffer
;    call printScore 
;    call initPlayField
;    call paddleStart; ----
;
;    mov verticalMovement, 1
;    mov horizontalMovement, 1
;     
;start: 
;    mov ah, 01h
;    int 16h
;    jz noKeyPressed
;    
;    xor ax, ax
;    int 16h 
;    
;    cmp ah, 4Dh
;    je Right 
;    
;    cmp ah, 4Bh
;    je Left 
;    
;    cmp ah, 01h
;    je Escape
;     
;    jmp start   
;     
;Right:
;    inc countShiftPaddle
;    mov ax, 2 
;    mov bx, paddleSize
;    mul bx
;    add ax, paddlePositionX
;    
;    cmp ax, 133 
;    jae noKeyPressed
;    
;    add paddlePositionX, 4 
;    call displayPaddle
;    
;    xor ax, ax 
;    mov ah, 86h 
;    mov dx, 02710h
;    mov cx, 0
;    int 15h  
;    
;    cmp countShiftPaddle, 3
;    jae noKeyPressed
;    
;    jmp start 
;    
;Left:
;    inc countShiftPaddle
;    cmp paddlePositionX, 5
;    jbe noKeyPressed
;    
;    sub paddlePositionX, 4
;    call displayPaddle
;    
;    xor ax, ax 
;    mov ah, 86h 
;    mov dx, 02710h
;    mov cx, 0
;    int 15h 
;    
;    cmp countShiftPaddle, 3
;    jae noKeyPressed
;     
;    jmp start 
;      
;noKeyPressed:
;    mov countShiftPaddle, 0
;
;    call deleteBall
;    call moveBall
;    
;    
;    cmp gameOver, 1
;    je LoseWait
;    
;    cmp score, 630
;    je winWait 
;    
;    call displayBall
;    
;    xor ax, ax 
;    mov ah, 86h 
;    mov dx, 086A0h
;    mov cx, 1
;    int 15h 
;    
;    jmp Start
;    
;LoseWait:
;   call printLose
;   jmp restart
; 
;winWait:
;   call printWin
;   jmp restart   
;
Escape:      
Exit:
    push 0b800h
    pop ds
    xor ax, ax
    mov al, 03
    int 10h
    mov ah, 4Ch
    int 21h
end main








