.model small 
.stack 130h

.data     
maxNumOfElem equ 30
numberOfInput db 0

stringPointer db 7
stringSize db 0
string db 7 dup(?)

negativeFlag db ?

inputType db ?

rangePosOne dd 0
rangePosTwo dd 0

counterRange db 0   

tempDoubleWord dd 0

msgEnterInfo db "Enter number [-32768, 32767], enter 'S' to stop.", 0Dh, 0Ah, '$'
msgEnterNumString db "Enter number: ", '$'
msgCounterNumber db "Found numbers in a given range: ", "$"

msgOutOfRangeString db "Out of range!", 0Dh, 0Ah, '$'
msgNotDigitString db "Incorrect symbol detected!", 0Dh, 0Ah, '$'
msgIncorRange db "Range specified incorrectly!", 0Dh, 0Ah, '$'


msgInputRangeOne db "Enter range one: ", '$'
msgInputRangeTwo db "Enter range two: ", '$'

macro cinString str
    lea dx, str
    mov bx, dx
    
    mov ah, 0Ah
    int 21h
    
    mov al, [bx + 1]
    mov ah, 0
    
    add bx, ax
    mov [bx + 2], '$'
endm

macro coutString str
    mov ah, 9h
    lea dx, str
    int 21h
endm

macro coutSymbol symbol
    mov dl, symbol
    mov ah, 02h
    int 21h
endm 

.code  

atoi proc uses ax, si  
    sub si, cx
    mov ax, 0
    mov bh, 0
    
    atoiLoop:
        mov dx, 10
        mul dx
        jc outOfRangeAtoi
        sub [si], '0'
        mov bl, [si]
        add ax, bx
        jc outOfRangeAtoi   
        inc si
    loop atoiLoop 
    ret           
    outOfRangeAtoi:
        coutString msgOutOfRangeString 
        pop si
    jmp goOver
endp 

stoi proc uses ax, si
    
endp 

outAX proc 

	push ax
	push bx
	push cx
	push dx
	mov bx, 10
	mov cx, 0
	flagdiv:
	mov dx, 0
	
	div bx
	add dx, '0'
	push dx
	
	inc cx
	
	test ax, ax 
	jnz flagdiv
	
	outsymbol:
		mov ah, 02h     
        pop dx      
        int 21h
        loop outsymbol     
	
	pop dx
	pop cx
	pop bx
	pop ax
	ret
outAX endp

digits proc uses cx, si
    mov cx, 0
    checkDigit:    
        cmp [si], '$'
        je exitDigit
        
        cmp [si], '0'
        jl notDigit
        
        cmp [si], '9'
        ja notDigit
        
        inc cx
        inc si
    jmp checkDigit
    
    notDigit:
        coutString msgNotDigitString
        pop si 
    jmp goOver
    
    exitDigit:
    ret
endp

carriageReturn proc uses ah, dl
    mov ah, 02h 
    
    mov dl, 0Ah
    int 21h
    
    mov dl, 0Dh
    int 21h  
    
    ret
endp


start:
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    coutString msgEnterInfo
    mov inputType, 0
    
enterNumber:
    mov cx, 0
    
    cmp numberOfInput, maxNumOfElem
    je changeInput 
     
    coutString msgEnterNumString
    cinString stringPointer 
    call carriageReturn
    jmp checkExitSymbol
    
enterRangeOne:
    coutString msgInputRangeOne
    cinString stringPointer 
    call carriageReturn 
    jmp checkNumber
    
enterRangeTwo:  
    coutString msgInputRangeTwo
    cinString stringPointer 
    call carriageReturn
    jmp checkNumber   

checkExitSymbol:
    cmp string, 'S'
    je changeInput
    
    cmp string, 's'
    je changeInput   
    
checkNumber: 
    cmp string, '-'
    je negativeNumber
    
    cmp stringSize, 6
    je outOfRange
    
    positiveNumber:
        lea si, string
        mov negativeFlag, 0
        jmp metkaAtoi1
    
    negativeNumber:
        lea si, string + 1
        mov negativeFlag, 1 
        
metkaAtoi1: 
    call digits
    call atoi
    checkRange:
        cmp negativeFlag, 1
        je checkNegative
    
        checkPositive:
            cmp ax, 32767
            ja outOfRange
            jmp addToStack
        
        checkNegative:
            cmp ax, 32768
            ja outOfRange
            neg ax
        
        addToStack:
            inc numberOFInput
            push ax
             
        nextInput:
            cmp inputType, 1
            je changeInput 
            
            cmp inputType, 2
            je changeInput
        jmp goOver
    
        outOfRange:
            coutString msgOutOfRangeString
        jmp goOver

changeInput:
    inc inputType 
    
goOver:
    cmp inputType, 0
    je enterNumber 
      
    
    cmp inputType, 1
    je enterRangeOne 
    
    dec numberOfInput
    
    cmp inputType, 2
    je enterRangeTwo 
        
checkSizeMas:
    cmp numberOfInput, 0
    je printZeroEnd  
    
checkRangeMas: 
    secondRange:
        pop word ptr rangePosTwo       
    firstRange:
        pop word ptr rangePosOne 
    
    movRangeRegister:
        mov bx, word ptr [rangePosTwo]
     ;   cmp bx, 127
;        jl printZeroEnd
    
        mov ax, word ptr [rangePosOne]
;        cmp ax, 128
;        ja negativeBX
        
        cmp ax, bx
        jg outRange
    jmp findNumber 
        
errorFind:
    outRange:
        coutString msgIncorRange 
        mov inputType, 1
        jmp enterRangeOne
    
findNumber:
    mov counterRange, 0
    mov cx, 0  
    mov cl, numberOfInput
    findNumberLoop:
        cmp numberOfInput, 0
        je printCounter  
        
        pop word ptr tempDoubleWord
        mov cx, word ptr [tempDoubleWord]
        ;jns 
        dec numberOfInput  
        
        cmp word ptr [tempDoubleWord], ax
        jl findNumberLoop
        
        cmp word ptr [tempDoubleWord], bx
        jg findNumberLoop 
        inc counterRange
        jmp findNumberLoop

printCounter: 
    coutString msgCounterNumber
    mov ax, 0
    mov al, counterRange
    call outAX
    call carriageReturn 
    jmp Exit         
 
printZeroEnd:
    coutSymbol '0'     
    
Exit:
    mov ax, 4c00h
    int 21h 

end start
