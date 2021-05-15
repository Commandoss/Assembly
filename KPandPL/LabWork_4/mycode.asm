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

sizeBuffer equ 2000
buffer dw sizeBuffer dup(?) 

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

gameOver dw 0

flagMowing dw 0 

countShiftPaddle dw 0     

verticalMovement dw 0
horizontalMovement dw 0
                  
ballPositionY dw 0
ballPositionX dw 0 
ballSize dw 2
                   
paddlePositionY dw 0 
paddlePositionX dw 0 
paddleSize dw 16
paddleStart db 0
                    
score dw 0                       
winCount dw 630  

.code
welcomeScreen proc near 
    push ax
    push bx 
    push dx                                
settingGraphicsMode:
    mov ah, 00
    mov al, 03 ; - 03 Ц 80:25 стандартный 16-цветный текстовый режим;
    int 10h    
startMenu:
    xor ax, ax        
    mov ah, 9h 
    lea dx, messageWelcome
    int 21h    
    xor ax, ax
    mov ah, 02
    mov dh, 25
    int 10h           
waitEnterWelcome: 
    mov ah, 1 ; - 01h Ц 83/84-клавиши; 
    int 16h 
    jz waitEnterWelcome   
    xor ah, ah
    int 16h    
    cmp ah, 1Ch   ; если enter
    je EnterWelcome       
    cmp ah, 01h   ; если строка не пуста
    je Exit
    jmp waitEnterWelcome  
EnterWelcome:  
    pop dx
    pop bx
    pop ax      
    ret
endp 

clearScreen proc near 
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
    push ds  
    push bx
    push dx      
    call clearScreen
    lea di, buffer
    mov al, ' '
    mov ah, 40h           
    mov cx, 80    
firstLineRed:
    rep stosw   
    mov cx, 23     
columnsRed:
    stosw           
    add di, 156     
    stosw 
    loop columnsRed    
    mov cx, 80    
secondLineRed:
    rep stosw 
    lea di, buffer    
    add di, 162     
    mov cx, 23
    mov ah, 70h    
columnsGlass:   
    stosw 
    add di, 128    
    stosw       
    add di, 28
    loop columnsGlass  
    lea di, buffer 
    add di, 162 
    mov cx, 66  
topLineGlass:      
    rep stosw        
ScorePrint:
    mov ax, 07h
    mov cx, 6
    lea si, pointUser
    lea di, buffer 
    add di, 456   
scoreLoop:
    movsb 
    stosb 
    loop scoreLoop
    pop dx
    pop bx
    pop ds
    pop si
    pop ax
    pop cx
    ret
endp 

printBuffer proc near 
    push es
    push ds
    push si
    push di
    call clearScreen
    push 0b800h
    pop es
initPrintBuffer:
    mov di, 0
    mov si, offset buffer
    mov cx, sizeBuffer
loopBuffer:
    rep movsw  
    pop di
    pop si
    pop ds
    pop es
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

initLevel proc near
    push cx
    push bx
    push ax  
    push es
    push di
    push si 
    lea di, buffer
    lea si, level   
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
    pop ds
    pop es
    ret
endp 

printWin proc near   
    push es 
    push ds
    push 0b800h
    pop es
    lea si, winMsg
    mov ax, 20h
    lea di, buffer
    mov di, 830
    mov cx, 36   
loopWin:
    movsb
    stosb
    loop loopWin     
    pop ds
    pop es
    ret
endp

waitEnter proc near
  waitEnterLose: 
    mov ah, 1 ; - 01h Ц 83/84-клавиши; 
    int 16h 
    jz waitEnterLose    
    xor ah, ah
    int 16h   
    cmp ah, 01h
    je Escape     
    cmp ah, 1Ch   ; если enter
    je EnterPressed   
    jmp waitEnterLose
EnterPressed:   
  ret  
endp

displayPaddle proc near       
    push es
    push ds    
clearPaddle:
    mov di, paddlePositionY
    mov ax, 160
    mul di  
    add ax, paddlePositionX 
    lea di, buffer 
    add di, ax
    mov cx, paddleSize
    cmp paddlePositionX, 5
    je notShiftLeft   
    mov ax, 2
    mul cx 
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
    lea di, buffer 
    add di, ax
    mov cx, paddleSize  
loop21:    
    mov es:[di], 60h
    add di, 2
    loop loop21
endPaddlePrint:
    pop ds        
    pop es    
    ret
endp 

displayBall proc near           
    push ax
    push bx
    push cx
    push es
    mov ax, ballPositionY 
    mov bx, 160 
    mul bx
    mov bx, ballPositionX
    add ax, bx
    lea di, buffer
    add di, ax
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
    mov ax, ballPositionY 
    mov bx, 160 
    mul bx 
    add ax, ballPositionX
    lea di, buffer
    add di, ax 
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

moveBall proc near  
    push dx
    push es        
verticalCheck:
    mov flagMowing, 0
    cmp verticalMovement, 1
    je moveUp
    jne moveDown   
deleteHorizontal:
    push horizontalMovement
    push ballPositionX
    call horizontalMove 
    pop ballPositionX
    pop horizontalMovement
    call changeHorizontalMovement
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

cornerCube:
    call horizontalCheck
    cmp flagMowing, 1
    je startCornerCubeDelete
ret
startCornerCubeDelete:
    push horizontalMovement
    push ballPositionX
    call horizontalMove 
    pop ballPositionX    
    cmp verticalMovement, 1
    je cornerCubeUp
    jne cornerCubeDown 
cornerCubeUp:
    inc ballPositionY
    jmp cornerExit    
cornerCubeDown:
    dec ballPositionY
cornerExit:
    call changeVerticalMovement
    pop horizontalMovement
    call changeHorizontalMovement 
ret
    
notMoveUp:
    call changeVerticalMovement 
    inc ballPositionY 
    jmp verticalCheck   
moveUp:
    call horizontalCheck
    cmp flagMowing, 0
    je checkUp
    call deleteHorizontal     
checkUp:  
    dec ballPositionY
    call checkCollision    
    cmp flagMowing, 1
    je notMoveUp 
    push verticalMovement
    call cornerCube 
    pop ax
    cmp ax, verticalMovement 
    jne moveDown
    call horizontalMove           
    jmp moveEnd
notMoveDown:
    call changeVerticalMovement 
    dec ballPositionY 
    jmp verticalCheck    
moveDown:
    call horizontalCheck
    cmp flagMowing, 0
    je checkDown
    call deleteHorizontal    
checkDown:   
    inc ballPositionY
    call checkCollision    
    cmp flagMowing, 1
    je notMoveDown
    push verticalMovement   
    call cornerCube 
    pop ax
    cmp ax, verticalMovement 
    jne moveUp 
    call horizontalMove   
    jmp moveEnd    
horizontalCheck:
    push ballPositionX
    cmp horizontalMovement, 0
    je checkLeft
    jne checkRight
checkLeft:
    sub ballPositionX, 4
    jmp check
checkRight: 
    add ballPositionX, 4
check: 
    call checkCollision 
    pop ballPositionX
ret 

horizontalMove: 
    mov flagMowing, 0
    cmp horizontalMovement, 0
    je moveLeft
    jne moveRight    
notMoveLeft:
    call changeHorizontalMovement
    add ballPositionX, 4
    jmp horizontalMove
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
    jmp horizontalMove 
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
    mov ax, ballPositionY 
    mov bx, 160 
    mul bx 
    add ax, ballPositionX
    lea di, buffer
    add di, ax
    
    cmp ballPositionY, 23
    je checkPaddle
    
    cmp ballPositionY, 1
    je collisionGalss
    
    cmp ballPositionX, 129
    ja collisionGalss
    
    cmp ballPositionX, 5
    jb collisionGalss
    
    cmp [di], 00h 
    je notCollision
               
    mov flagMowing, 1
    
    add score, 10
    dec winCount
    call printScore  
    
    mov cx, 2

loopCollision:    
    mov [di], 00h
    add di, 2
    loop loopCollision
    jmp notCollision  
    
checkPaddle: 
    mov ax, paddlePositionX   
    
    cmp ax, ballPositionX 
    ja endGame
    
    mov ax, 2
    mov bx, paddleSize
    mul bx
    sub ax, 2 
    add ax, paddlePositionX
    
    cmp ax, ballPositionX 
    jb endGame 
    
    inc flagMowing
    jmp notCollision    
endGame:
    mov gameOver, 1
    jmp notCollision   
collisionGalss: 
    mov flagMowing, 1     
notCollision:  
    pop cx
    pop bx
    pop ax
    ret
endp 

clearBuffer proc near
    push es
    push ds
    lea di, buffer
    
    mov al, ' '
    mov ah, 00h 
    mov cx, sizeBuffer
clearLoop:
    stosw
loop clearLoop
     
    
    pop ds
    pop es
    
ret 
endp

main:
    mov ax, @data
    mov ds, ax
    mov es, ax      
    call welcomeScreen   
restart:
    mov score, 0 
    mov gameOver, 0
    mov flagMowing, 0
    mov paddleStart, 0
    
    mov verticalMovement, 0
    mov horizontalMovement, 0 
    
    mov ballPositionY, 22
    mov ballPositionX, 69 
    
    mov paddlePositionX, 53
    mov paddlePositionY, 23
    
initGame:
    call initScreen
    call initLevel
    call displayBall
    call displayPaddle
      
    call printBuffer
     
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
    
    cmp ah, 1Ch
    je Enter
    
    cmp ah, 01h
    je Escape
     
    jmp noKeyPressed   
     
Right:
    mov ax, 2 
    mov bx, paddleSize
    mul bx
    add ax, paddlePositionX 
    cmp ax, 133 
    jae start
    
    cmp paddleStart, 0
    jne shiftPaddleRight    
    call deleteBall 
    add paddlePositionX, 4
    add ballPositionX, 4   
    jmp paddleNotStart  
    
shiftPaddleRight:   
    add paddlePositionX, 4 
    call displayPaddle  
    jmp start 
    
Left:
    cmp paddlePositionX, 5
    jbe Start 
    
    cmp paddleStart, 0
    jne shiftPaddleLeft    
    call deleteBall  
    sub paddlePositionX, 4
    sub ballPositionX, 4   
    jmp paddleNotStart
    
shiftPaddleLeft:    
    sub paddlePositionX, 4
    call displayPaddle   
    jmp start
    
paddleNotStart: 
    call displayBall  
    call displayPaddle 
    call printBuffer
    jmp start
      
noKeyPressed:
    cmp paddleStart, 0
    je start 
    
    call deleteBall
    call moveBall
    call displayBall
    cmp gameOver, 1
    je LoseWait
    
    cmp score, 630
    je winWait 
    
    call printBuffer
    
    xor ax, ax 
    mov ah, 86h 
    mov dx, 086A0h
    mov cx, 1
    int 15h 
    
    jmp Start
    
LoseWait:
   call printLose
   call waitEnter
   call clearBuffer
   jmp restart
 
winWait:
   call printWin
   call waitEnter
   call clearBuffer  
   jmp restart 
   
Enter:
    cmp paddleStart, 0
    jne noEnter   
    mov paddleStart, 1
    
    mov verticalMovement, 1
    mov horizontalMovement, 1   
noEnter:    
    jmp Start
    
Escape:      
Exit:
    xor ax, ax
    mov al, 03
    int 10h
    mov ah, 4Ch
    int 21h
end main