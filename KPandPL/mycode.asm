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

level db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
	  db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
	  db 00h, 00h, 00h, 00h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
	  db 00h, 00h, 00h, 00h, 00h, 00h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
	  db 00h, 00h, 00h, 00h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
	  db 00h, 00h, 20h, 20h, 20h, 20h, 00h, 00h, 20h, 20h, 20h, 20h, 20h, 20h, 00h, 00h, 20h, 20h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
	  db 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h	  
	  db 20h, 20h, 00h, 00h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 00h, 00h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h	  
	  db 20h, 20h, 00h, 00h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 20h, 20h, 00h, 00h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h	  
	  db 00h, 00h, 00h, 00h, 00h, 00h, 20h, 20h, 20h, 20h, 00h, 00h, 20h, 20h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 20h, 20h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h	

      ;db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; черный 
;      db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
;      db 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h ; синий
;      db 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h
;      db 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h ; зеленый
;      db 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h
;      db 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h ; голубой
;      db 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h
;      db 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h ; красный
;      db 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h 
;      db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
;      db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
;      db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h 
;      db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
;      db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
;      db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h 
;      db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
;      db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h  
;
;     
;      db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
;	  db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
;	  db 00h, 00h, 00h, 00h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
;	  db 00h, 00h, 00h, 00h, 00h, 00h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
;	  db 00h, 00h, 00h, 00h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
;	  db 00h, 00h, 20h, 20h, 20h, 20h, 00h, 00h, 20h, 20h, 20h, 20h, 20h, 20h, 00h, 00h, 20h, 20h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
;	  db 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h	  
;	  db 20h, 20h, 00h, 00h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 00h, 00h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h	  
;	  db 20h, 20h, 00h, 00h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 20h, 20h, 00h, 00h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h	  
;	  db 00h, 00h, 00h, 00h, 00h, 00h, 20h, 20h, 20h, 20h, 00h, 00h, 20h, 20h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h, 20h, 20h, 20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h	  
;	  db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
;	  db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
;	  db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
;	  db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
;	  db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
;	  db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
;	  db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	  
;	  db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h	;32
	    

;levelCount dw 88
;           dw 46

      
;currentLevel dw 0

gameOver dw 0

flagMowing dw 0
flagGlass dw 0

flagColor dw 0

countShiftPaddle dw 0     

verticalMovement dw 0
horizontalMovement dw 0
                  
ballPositionY dw 0
ballPositionX dw 0 
ballSize dw 2
                   
paddlePositionY dw 0 
paddlePositionX dw 0 
paddleSize dw 30
                  
previousTime dw 0    
score dw 0                       
winCount dw 630

.code

welcomeScreen proc near 
    push ax
    push bx 
    push dx
    push es  
      
    push 0b800h
    pop es                               

settingGraphicsMode:
    mov ah, 00
    mov al, 03 ; - 03 Ц 80:25 стандартный 16-цветный текстовый режим;
    int 10h  
    
startMenu:
    xor ax, ax        
    mov ah, 9h 
    lea dx, messageWelcome
    int 21h 
            
waitEnterWelcome: 
    mov ah, 1 ; - 01h Ц 83/84-клавиши; 
    int 16h 
    jz waitEnterWelcome 
    
    xor ah, ah
    int 16h  
    
    cmp ah, 1Ch   ; если enter
    je EnterWelcome   
    
    cmp ah, 01h   ; если строка не пуста
    jne waitEnterWelcome 

    jmp Exit
    
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

initScreen proc near
    push cx
    push ax
    push si
    push es  
    push bx
    push dx   
      
    call clearScreen  
      
    push 0b800h
    pop es 
    
    xor di, di
    mov cx, 80   
        
firstLine:
    mov es:[di], ' '
    inc di
    mov es:[di], 40h
    inc di
    loop firstLine 
    
    mov cx, 23     
columns:
    mov es:[di], ' '
    inc di
    mov es:[di], 40h
    inc di         
    
    add di, 78
    add di, 78   
    
    mov es:[di], ' '
    inc di
    mov es:[di], 40h
    inc di  

    loop columns  
    
    mov cx, 80    
secondLine:
    mov es:[di], ' '
    inc di
    mov es:[di], 40h
    inc di
    
    loop secondLine  
    

    mov di, 80
    add di, 80 
    add di, 2       
    mov cx, 23    
glass:   
    mov es:[di], ' '
    inc di
    mov es:[di], 70h
    inc di
    
    add di, 64
    add di, 64 
    
    mov es:[di], ' '
    inc di
    mov es:[di], 70h 
    inc di   
    
    add di, 14
    add di, 14
  
    loop glass
    
glassEnd: 
    mov di, 160 
    add di, 2
    mov cx, 66
    
glassBottom:
    mov es:[di], ' '
    inc di
    mov es:[di], 70h
    inc di     
    
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
    mov ah, 1 ; - 01h Ц 83/84-клавиши; 
    int 16h 
    jz waitEnterLose 
    
    xor ah, ah
    int 16h
    
    cmp ah, 01h
    je Escape  
    
    cmp ah, 1Ch   ; если enter
    je EnterLose    

    jmp waitEnterLose
       
EnterLose:   
    pop ds
    pop es
    ret
endp

displayPaddle proc near       
    push es
    
    push 0b800h
    pop es 
    
clearPaddle:
    mov di, paddlePositionY
    mov ax, 160
    mul di
    
    add ax, paddlePositionX  
    mov di, ax
    mov cx, paddleSize

    cmp paddlePositionX, 5
    je notShiftLeft
    
    mov ax, 2
    mul cx 
;    sub ax, 2
    add ax, paddlePositionX
    cmp ax, 133
    je ShiftRight
 
    sub di, 4              
    add cx, 4
    jmp loopClearPaddle
ShiftRight:       
    sub di, 4
    jmp loopClearPaddle 
    
notShiftLeft:    
    add cx, 2
    
loopClearPaddle:    
    mov es:[di], 00h
    add di, 2
    loop loopClearPaddle   
  
newPaddle:   
    mov di, paddlePositionY
    mov ax, 160
    mul di
    
    add ax, paddlePositionX  
    mov di, ax
    mov cx, paddleSize
    
loop21:    
    mov es:[di], 60h
    add di, 2
    loop loop21

endPaddlePrint:        
    pop es    
    ret
endp 

displayBall proc near           
    push ax
    push bx
    push cx
    push es
    
    push 0b800h
    pop es
    
    mov ax, ballPositionY 
    mov bx, 160 
    mul bx
    
    mov bx, ballPositionX
    add ax, bx
    
    mov di, ax
    mov cx, 2 
    
loopBall:   
    mov es:[di], 50h
    add di, 2
    loop loopBall    
    
    pop es
    pop cx
    pop bx
    pop ax
    ret
endp

deleteBall proc near           
    push ax
    push bx
    push cx
    push es
    
    push 0b800h
    pop es
    
    mov ax, ballPositionY 
    mov bx, 160 
    mul bx
    
    add ax, ballPositionX
    mov di, ax
    
    mov cx, 2 
    
loopDeleteBall:   
    mov es:[di], 00h
    add di, 2
    loop loopDeleteBall    
    
    pop es
    pop cx
    pop bx
    pop ax
    ret
endp  

paddleStart proc near
    mov ballPositionY, 22
    mov ballPositionX, 69 
    
    mov paddlePositionX, 53
    mov paddlePositionY, 23
    
displayPaddleAndBall:
    call displayBall  
    call displayPaddle
    
paddleLoop:
    mov ah, 1
    int 16h
    jz paddleLoop
    
    xor ax, ax
    int 16h 
    
    cmp ah, 4Dh
    je paddleRight 
    
    cmp ah, 4Bh
    je paddleLeft 
    
    cmp ah, 1Ch
    je paddleEnter
    
    cmp ah, 01h
    je paddleEscape
     
    jmp paddleLoop   
    
paddleLeft:  
    cmp paddlePositionX, 5
    jbe paddleLoop
    
    call deleteBall 
    sub paddlePositionX, 4
    sub ballPositionX, 4
    
    jmp displayPaddleAndBall 
    
paddleRight:
    mov ax, paddleSize
    mov bx, 2
    mul bx
    add ax, paddlePositionX
    
    cmp ax, 133 
    jae paddleLoop
     
    call deleteBall  
    add paddlePositionX, 4
    add ballPositionX, 4
    
    jmp displayPaddleAndBall
    
paddleEnter:
    ret        
    
paddleEscape: 
    jmp Exit
endp
  
moveBall proc near  
    push dx
    push es
    
verticalCheck:
    mov flagMowing, 0
    cmp verticalMovement, 1
    je moveUp
    jne moveDown 
    
badCheck:
    push horizontalMovement
    push ballPositionX
    call horizontalMove
    pop ballPositionX
    pop horizontalMovement
    call changeHorizontalMovement
;    call changeVerticalMovement 
ret
    
changeVerticalMovement:
    cmp verticalMovement, 0
    je verticalMovementUp
    mov verticalMovement, 0
    ret
verticalMovementUp:
    mov verticalMovement, 1
    ret


changeHorizontalMovement:
    cmp horizontalMovement, 0
    je horizontalMovementLeft
    mov horizontalMovement, 0
    ret
horizontalMovementLeft:
    mov horizontalMovement, 1
    ret

cornerCubeUp: 
    push horizontalMovement
    push ballPositionX

    call horizontalMove  
    pop ballPositionX
    call changeVerticalMovement 
    mov flagMowing, 0 
    inc ballPositionY
    pop horizontalMovement
    call changeHorizontalMovement 
    jmp moveDown
    
notMoveUp:
    call changeVerticalMovement 
    inc ballPositionY
    mov flagMowing, 0 
    jmp moveDown
    
moveUp:
    call horizontalCheck
    cmp flagMowing, 0
    je checkUp
    call badCheck
    
checkUp:  
    dec ballPositionY
    call checkCollision 
    
    cmp flagMowing, 1
    je notMoveUp
    
    call horizontalCheck
    cmp flagMowing, 1
    je cornerCubeUp
    
    call horizontalMove    
    jmp moveEnd
    
cornerCubeDown:
    push horizontalMovement 
    push ballPositionX 
    call horizontalMove 
    pop ballPositionX
    call changeVerticalMovement 
    mov flagMowing, 0
    sub ballPositionY, 1  
    pop  horizontalMovement
    call changeHorizontalMovement
    jmp moveUp

notMoveDown:
    call changeVerticalMovement 
    dec ballPositionY 
    mov flagMowing, 0
    jmp moveUp
    
moveDown:
    call horizontalCheck
    cmp flagMowing, 0
    je checkDown
    call badCheck

checkDown:   
    inc ballPositionY
    call checkCollision
    
    cmp flagMowing, 1
    je notMoveDown    
    
    call horizontalCheck
    cmp flagMowing, 1
    je cornerCubeDown
    
    call horizontalMove
    jmp moveEnd
    
horizontalCheck:
    cmp horizontalMovement, 0
    je checkLeft
    jne checkRight
    
checkLeft:
    sub ballPositionX, 4 
    
    push flagColor
    mov flagColor, 1 
    call checkCollision
    pop flagColor
     
    add ballPositionX, 4
      
;    cmp flagGlass, 0
;    je endCheck 
;    mov flagGlass, 0
;    mov flagMowing, 0
ret
    
checkRight:
    add ballPositionX, 4
    push flagColor
    mov flagColor, 1  
    call checkCollision 
    pop flagColor
    sub ballPositionX, 4
;    cmp flagGlass, 0
;    je endCheck
;    mov flagGlass, 0
;    mov flagMowing, 0
ret 

endCheck:
ret
    
horizontalMove:
    mov flagMowing, 0 
    call checkAll 
    
    cmp ax, 2
    je endCheckAll
    
    cmp horizontalMovement, 0
    je moveLeft
    jne moveRight
    
checkAll:
   mov ax, 0
   mov flagMowing, 0
   push ballPositionX
   add ballPositionX, 4
   call checkCollision
   cmp flagMowing, 0
   je endCheckAll
   mov flagMowing, 0 
   inc ax
   pop ballPositionX  
   push ballPositionX
   sub ballPositionX, 4
   call checkCollision
   cmp flagMowing, 0
   je endCheckAll
   inc ax 
endCheckAll:
    mov flagMowing, 0 
    
ret

notMoveLeft:
    call changeHorizontalMovement
    add ballPositionX, 4
    mov flagMowing, 0
    jmp moveRight
ret   
moveLeft:
    sub ballPositionX, 4  
    call checkCollision 
    
    cmp flagMowing, 1
    je notMoveLeft
ret
    
notMoveRight: 
    call changeHorizontalMovement 
    sub ballPositionX, 4 
    mov flagMowing, 0
    jmp moveLeft
ret   
moveRight:
    add ballPositionX, 4 
    call checkCollision
    
    cmp flagMowing, 1
    je notMoveRight 
    
    ret
    
moveEnd:    
    xor ax, ax
    pop es
    pop dx
    ret
endp

checkCollision proc near    
    push ax
    push bx
    push cx  
     
    push 0b800h
    pop es   
    
    mov ax, ballPositionY 
    mov bx, 160 
    mul bx
    
    add ax, ballPositionX
    mov di, ax
    
    cmp ballPositionY, 23
    je checkPaddle
    
    cmp ballPositionY, 1
    je collisionGalss
    
    cmp ballPositionX, 129
    ja collisionGalss
    
    cmp ballPositionX, 5
    jb collisionGalss
    
    cmp es:[di], 00h 
    je notCollision
               
    mov flagMowing, 1
;    mov flagGlass, 0
    
    cmp flagColor, 1
    je notCollision
    
    mov flagColor, 1
    
    add score, 10
    dec winCount
    call printScore  
    
    mov cx, 2

loopCollision:    
    mov es:[di], 00h
    add di, 2
    loop loopCollision
    jmp notCollision  
    
checkPaddle: 
;    mov ax, paddlePositionX   
;    
;    cmp ax, ballPositionX 
;    ja endGame
;    
;    mov ax, 2
;    mov bx, paddleSize
;    mul bx
;    sub ax, 2 
;    add ax, paddlePositionX
;    
;    cmp ax, ballPositionX 
;    jb endGame 
    
    inc flagMowing
    mov flagColor, 0
    jmp notCollision    

endGame:
    mov gameOver, 1
    jmp notCollision
    
collisionGalss: 
    mov flagMowing, 1
    mov flagGlass, 1
       
notCollision:  
    pop cx
    pop bx
    pop ax
    ret
endp

printWin proc near   
    push es 
    push ds
    
    push 0b800h
    pop es
    
    lea si, winMsg
    mov ax, 20h
    
    mov di, 830
    mov cx, 36
    
loopWin:
    movsb
    stosb
    loop loopWin
    
waitEnterWin: 
    mov ah, 1 ; - 01h Ц 83/84-клавиши; 
    int 16h 
    jz waitEnterWin 
    
    xor ah, ah
    int 16h
    
    cmp ah, 01h
    je Escape  
    
    cmp ah, 1Ch   ; если enter
    je EnterWin    

    jmp waitEnterWin
       
EnterWin:   
    pop ds
    pop es
    ret
endp

main:
    mov ax, @data
    mov ds, ax      
    call welcomeScreen
    
restart:
    mov score, 0 
    mov gameOver, 0
    mov flagColor, 0
    mov flagMowing, 0
    
    call initScreen
    call printScore 
    call initPlayField
    call paddleStart; ----

    mov verticalMovement, 1
    mov horizontalMovement, 1
     
start: 
    mov ah, 01h
    int 16h
    jz noKeyPressed
    
    xor ax, ax
    int 16h 
    
    cmp ah, 4Dh
    je Right 
    
    cmp ah, 4Bh
    je Left 
    
    cmp ah, 01h
    je Escape
     
    jmp start   
     
Right:
    inc countShiftPaddle
    mov ax, 2 
    mov bx, paddleSize
    mul bx
    add ax, paddlePositionX
    
    cmp ax, 133 
    jae noKeyPressed
    
    add paddlePositionX, 4 
    call displayPaddle
    
    xor ax, ax 
    mov ah, 86h 
    mov dx, 02710h
    mov cx, 0
    int 15h  
    
    cmp countShiftPaddle, 3
    jae noKeyPressed
    
    jmp start 
    
Left:
    inc countShiftPaddle
    cmp paddlePositionX, 5
    jbe noKeyPressed
    
    sub paddlePositionX, 4
    call displayPaddle
    
    xor ax, ax 
    mov ah, 86h 
    mov dx, 02710h
    mov cx, 0
    int 15h 
    
    cmp countShiftPaddle, 3
    jae noKeyPressed
     
    jmp start 
      
noKeyPressed:
    mov countShiftPaddle, 0

    call deleteBall
    call moveBall
    call displayBall
    
    cmp gameOver, 1
    je LoseWait
    
    cmp score, 630
    je winWait
    
    xor ax, ax 
    mov ah, 86h 
    mov dx, 086A0h
    mov cx, 1
    int 15h 
    
    jmp Start
    
LoseWait:
   call printLose
   jmp restart
 
winWait:
   call printWin
   jmp restart   

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
 