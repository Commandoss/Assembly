.model small
.stack 100h

.data 
maxStringSize equ 200
strPointer db maxStringSize
stringSize db 0
string db maxStringSize dup(?)

searchPointer db maxStringSize
searchSize db 0
searchString db maxStringSize dup(?)

changePointer db maxStringSize
changeSize db 0
changeString db maxStringSize dup(?)

msg1 db "Enter main string:$"
msg2 db "Enter search string:$" 
msg3 db "Enter change string:$"
msg4 db "Result string:$"

error1 db "The word exceeds the length of the string itself!$"
error2 db "The entered word must be single!$"
error3 db "Empty string entered!$" 
error4 db "The length exceeds the buffer!$"
.code 

cinString macro pointer
    lea dx, pointer
    
    mov bx, dx
    
    mov ah, 0Ah
    int 21h
    
    mov al, [bx + 1]
    mov ah, 0
    
    add bx, ax
    mov [bx + 2], '$'
endm

coutString macro pointer
    mov ah, 09h
    lea dx, pointer
    int 21h
endm

carriageReturn macro 
    mov ah, 02h
     
    mov dl, 0Ah  
    int 21h  
    
    mov dl, 0Dh
    int 21h  
endm 

SpacesCheck macro pointer ; если нашел пробелы то заново ввод
    lea di, pointer
    
    mov cx, 0
    mov cl, [pointer + 1]
    inc cx
    
    mov ah, 0
    mov al, ' '
    
    cld
    repnz scasb
    cmp cx, 0
endm  

endCheck macro pointer
    lea si, pointer
    cmp [si], '$'   
endm

start:
    mov ax, @data
    mov ds, ax
    mov es, ax
    
firstStringEnter:    
    coutString msg1 
    carriageReturn
    cinString strPointer
    carriageReturn
  
    endCheck string
    je ErrorStr1_2 

secondStringEnter:
    coutString msg2
    carriageReturn
    cinString searchPointer
    carriageReturn
   
    mov al, searchSize
    cmp al, stringSize
    ja ErrorStr2_1 
    endCheck searchString
    je ErrorStr2_2 
    spacesCheck searchString 
    jne ErrorStr2_3 
    
thirdStringEnter:
    coutString msg3
    carriageReturn
    cinString changePointer
    carriageReturn
    
    call checkSize
    endCheck changeString
    je ErrorStr3_2 
    spacesCheck changeString
    jne ErrorStr3_3
    lea si, string
    je compareWords 
    
checkSize:
    mov ah, stringSize;
    sub ah, searchSize
    add ah, changeSize
    cmp ah, maxStringSize
    ja ErrorStr4_3
ret

ErrorStr2_1:
    coutString error1
    carriageReturn
    jmp secondStringEnter 
    
ErrorStr1_2:
    coutString error3
    carriageReturn
    jmp firstStringEnter
    
ErrorStr2_2:
    coutString error3
    carriageReturn
    jmp secondStringEnter
    
ErrorStr3_2:
    coutString error3
    carriageReturn
    jmp thirdStringEnter
 
ErrorStr2_3:
    coutString error2
    carriageReturn
    jmp secondStringEnter 

ErrorStr3_3:
    coutString error2
    carriageReturn
    jmp thirdStringEnter 
    
ErrorStr4_3:
    coutString error4
    carriageReturn
    jmp thirdStringEnter
    
compareWords: ; сравнение слов
    lea di, searchString
    mov cx, 0
    mov cl, searchSize
    
    cld 
    repe cmpsb
    
    jne notThisWord
    jmp foundWord
    
notThisWord:
    dec si
    jmp wordSearch
    
wordSearch: ; цикл поиска пробела (сл слова)
    cmp [si], '$'
    je printString
    
    mov al, [si]
    inc si
    cmp al, ' '
    
    je compareWords
    jmp wordSearch 
    
foundWord:
    cmp [si], '$'
    je insertEnd          
    
    cmp [si], ' ' 
    jne wordSearch
    
changeWord:     
    mov al, changeSize
    mov cx, 0
    mov cl, al
     ;///
    mov al, searchSize
    cmp al, changeSize
    jb shiftMore
    ja shiftLow
    je forBackSi

    inc si 
    mov di, si
    
shiftMore:
    mov al, changeSize
    sub al, searchSize
    mov cl, al
    jmp endString
    
endString:    
    lea di, string 
    mov al, stringSize  
     
    add di, ax  ; конец строки
    add di, cx  ; от конца строки + changesize
    
    mov ax, di  
    sub ax, si  ; получили число элементов между  
    
    mov bx, si
    
    mov si, di 
    sub si, cx  ; поставили si на конец символ
    
    mov cx, ax 
    jmp shiftMoreInsert
    
shiftMoreInsert: 
    movsb 
    cmp si, bx
    jl inputProbel
    sub di, 2
    sub si, 2 
    loop shiftMoreInsert

metka: 
    mov ax, 0
    mov al, searchSize 
    ;!!! 
    mov si, bx
    sub si, ax
    jmp insertWord 
    
inputProbel:
    mov [di], ' ' 
    dec di
    loop inputProbel
    jmp metka
 
shiftLow:
    mov cx, 0
    mov cl, searchSize
    sub cl, changeSize
    mov di, si
    
    call forBackDi
    mov bx, di
    mov cl, stringSize
    sub cx, di  
    add cx, 2
    cld 
    rep movsb
     
    mov si, bx
    mov cl, changeSize
    jmp forBackSi
    
    
forBackDi:
    dec di
    loop forBackDi
    ret        
    
insertEnd:  
    mov al, searchSize
    sub si, ax
    mov cx, 0  
    mov cl, changeSize
    lea di, si 
    lea si, changeString
    cld 
    rep movsb
    mov [di + 1], '$'
    jmp printString 
    
forBackSi:
    dec si
    loop forBackSi  
    
insertWord:
    mov cl, changeSize
    lea di, si 
    lea si, changeString
    cld 
    rep movsb   
  
printString:
    coutString msg4 
    carriageReturn
    coutString string

Exit: 
    mov ax, 4c00h
    int 21h
    
end start
    