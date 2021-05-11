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

screenSize equ 2000
screenBuffer db screenSize dup(0) 

;playField db 396 dup(00h)    

level db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; черный 
      db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
      db 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h ; синий
      db 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h
      db 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h ; зеленый
      db 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h
      db 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h ; голубой
      db 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h, 30h
      db 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h ; красный
      db 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h 
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

verticalMovement dw 0
horizontalMovement dw 0
                  
ballPositionY dw 0
ballPositionX dw 0 
ballSize dw 2
                   
paddlePositionY dw 0 
paddlePositionX dw 0 
paddleSize dw 12
                  
previousTime dw 0    
score dw 0                       
winCount dw 0

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
    mov al, 03 ; - 03 – 80:25 стандартный 16-цветный текстовый режим;
    int 10h  
     
    call clearScreen


startMenu:  
    mov ah, 9h
    mov dx, offset messageWelcome
    int 21h          

waitEnterWelcome: 
    mov ah, 1 ; - 01h – 83/84-клавиши; 
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
    
    mov bh, 7
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
    
    mov di, 820
    mov cx, 37
    
loopLose:
    movsb
    stosb
    loop loopLose 
    
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
    
    cmp paddlePositionX, 133
    je ShiftRight

ShiftRight:       
    sub di, 2  
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
    
    mov bx, ballPositionX
    add ax, bx
    
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
    mov ballPositionX, 63 
    
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
    cmp paddlePositionX, 6
    jb paddleLoop
    
    call deleteBall 
    sub paddlePositionX, 2
    sub ballPositionX, 2
    
    jmp displayPaddleAndBall 
    
paddleRight:
    mov ax, paddlePositionX
    add ax, 24 
    
    cmp ax, 132 
    ja paddleLoop
     
    call deleteBall  
    add paddlePositionX, 2
    add ballPositionX, 2
    
    jmp displayPaddleAndBall
    
paddleEnter:
    ret        
    
paddleEscape: 
    jmp Exit
endp
  
moveBall proc near  
    push dx 
       
    cmp verticalMovement, 0
    je moveDown 
    
    cmp ballPositionY, 0
    jne notUpCol  
    
    mov verticalMovement, 1  
    
notUpCol:              
    jmp horizontalCheck   
    
moveDown:
    cmp ballPositionY, 22
    je notDownCol
             
    mov bx, offset paddlePositionX
    mov ax, [bx]
    cmp ax, ballPositionX  
    jg paddleLose
    add ax, 3
    cmp ax, ballPositionX
    jl paddleLose
    mov verticalMovement, 0
    jmp notDownCol       
    
paddleLose:
    mov ax, 01h
    pop dx
    ret    
    
notDownCol:
   
 horizontalCheck:
    cmp horizontalMovement, 0
    je moveLeft
    
    cmp ballPositionX, 22
    jne changeBallPos
    
    mov horizontalMovement, 1
    jmp changeBallPos
    
moveLeft:   
    cmp ballPositionX, 4
    je changeBallPos   
    mov horizontalMovement, 0 
    
changeBallPos: 
    cmp horizontalMovement, 1
    jne moveRight
    
    dec ballPositionX 
    call checkCollision 
    
    cmp dx, 00h
    je verticalMove
    inc ballPositionX
    mov horizontalMovement, 0  
    jmp verticalMove  
    
moveRight:
    inc ballPositionX 
    call checkCollision 
    cmp dx, 00h
    je verticalMove
    dec ballPositionX
    mov horizontalMovement, 1
     
verticalMove:
    cmp verticalMovement, 1
    jne moveUp
    inc ballPositionY 
    call checkCollision  
    cmp dx, 00h
    je moveEnd
    dec ballPositionY 
    mov verticalMovement, 0
    jmp moveEnd           
    
moveUp:
    dec ballPositionY  
    call checkCollision
    cmp dx, 00h
    je moveEnd
    inc ballPositionY  
    mov verticalMovement, 1
    
moveEnd:   
    call checkCollision  
    xor ax, ax
    pop dx
    ret
endp

checkCollision proc near    
    push ax
    push bx
    push cx
    push es   
     
    push 0b800h
    pop es   
    
    mov di, paddlePositionY
    mov ax, 160
    mul di
    
    add ax, paddlePositionX  
    mov di, ax
    
    cmp es:[di], 00h 
    je notCollision 
    
    add score, 10
    dec winCount
    call printScore 
     
    mov es:[di], 00h
    inc di    
    je deleteInc
    
deleteInc:
    inc di
    mov es:[di], 00h
    
notCollision:  
    pop es
    pop cx
    pop bx
    pop ax
    ret
endp

   

printWin proc near   

endp

main:
    mov ax, @data
    mov ds, ax      
    call welcomeScreen
    call initScreen
    
restart:
    mov score, 0 
    mov previousTime, 0   ;????
  
    call printScore 
    call initPlayField
    call paddleStart; ----
    
    mov verticalMovement, 1
    mov horizontalMovement, 1
        
start: 
    mov ah, 1
    int 16h
    jz noKeyPressed
    
    xor ax, ax
    int 16h 
    
    cmp ah, 4Dh
    je Right 
    
    cmp ah, 4Bh
    je Left 
    
    cmp ah, 1Ch
    je Enter
    
    cmp ah, 01h
    je Escape
     
    jmp noKeyPressed   
     
Right:  
    mov ax, paddlePositionX
    add ax, 24 
    
    cmp ax, 126 
    ja noKeyPressed
    
    add paddlePositionX, 2
    call displayPaddle
    jmp noKeyPressed 
    
Left:
    cmp paddlePositionX, 8
    jb noKeyPressed
    
    sub paddlePositionX, 2
    call displayPaddle
    jmp noKeyPressed  
      
noKeyPressed: 
    call deleteBall
    call moveBall
    call displayBall 
    jmp Start
    
Enter:  
    call moveBall
    jmp start 

Escape:      
Exit:
    mov ah, 4Ch
    int 21h
end main
 