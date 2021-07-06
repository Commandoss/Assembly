.model small
.data
begstr	dd 0
curptr	dd 0
handle	dw ?
ohandle	dw ?
tfn	db 'temp.txt',0
comandLine	db 20,21 dup(0)	;принимает строку, введенную с клавиатуры
wrd	db 50,51 dup(0)
rbuff	db 8 dup(0)	;Сюда читается символ из файла
strf	db 512 dup (0)		;строка, прочитанная из файла    
msg1	db 13,10,'Enter filename: $'
msg2	db 13,10,'Enter word: $'
msg3	db 13,10,'Done!$' 
msge1	db 13,10,'Error opening file!$'
msge2	db 13,10,'Error creating file!$'
msge3	db 13,10,'Error deleting file!$'  
.stack 256
.code

start:
	mov ax,@data	;настраиваем сегментный регистр
	mov ds,ax       
	
	mov di,81h	;начало командной строки
	mov cl,es:[80h]	;длина командной строки
	mov ch,0
	test cx,cx	;Если нет командной строки
	jz enterNameFile ;то ввод имени файла  
	
	mov al,' '
	repz scasb	;пропускаем пробелы перед параметром
	test cx,cx	;если командная строка закончилась
	jz enterNameFile         ;то ввод имени файла 
	
	dec di      ;корректируем указатель на командную строку
	inc cx		;и количество обработанных символов
	
	lea si,comandLine[2]	;начало имени входного файла
;копируем имя первого файла из командной строки в сегмент данных
lp11:	
    mov al,es:[di]	;читаем символ
	cmp al,' '	;если пробел
	jz enterNameFile	;то закончить копирование 
	
	mov [si],al	;сохраняем символ в сегменте данных
	inc si		;Следующий символ
	inc di		;Следующий символ
	loop lp11	;продолжаем копирование    
	
enterNameFile:
	push ds		;es=ds
	pop es 
	
	cmp comandLine[2],0		;если имя входного файла указано
	jnz openInputFile		;то переход      
	
	mov ah,9		;функция вывода сообщения на экран
	lea dx,msg1		;выводимое сообщение
	int 21h			;выводим на экран    
	
	mov ah,0ah		;функция ввода строки с клавиатуры
	mov dx,offset comandLine       ;буфер куда вводить
	int 21h			;пользователь вводит в текстовом виде в buf  
	
	mov bh,0
	mov bl,comandLine[1]		;длина введенной строки
	mov comandLine[bx+2],byte ptr 0;добавить 0 в конец введенной строки

openInputFile:	
    mov ax,3d00h		;функция открытия файла на чтение
	lea dx, comandLine[2]		;введенное имя файла
	int 21h			;попытка открыть
	jnc createOutputFile		;если открыт - переход  
	
	mov ah,9		;функция вывода сообщения на экран
	lea dx,msge1		;выводимое сообщение
	int 21h			;выводим на экран
	jmp exit			;если ошибка - переход 
	
createOutputFile:	
    mov handle,ax		;хэндл открытого файла
	lea dx,tfn		;введенное имя файла
	
	mov ah,3ch		;ф-я создания файла
	xor cx,cx		;атрибуты
	int 21h			;создать выходной файл 
	
	jnc created		;если открыт - переход 
	
	mov ah,9		;функция вывода сообщения на экран
	lea dx,msge2		;выводимое сообщение
	int 21h			;выводим на экран
	jmp exit			;если ошибка - переход  
	
created:	
	mov ohandle,ax		;сохранить хэндл файла   
	
	mov ah,9		;функция вывода сообщения на экран
	lea dx,msg2		;выводимое сообщение
	int 21h			;выводим на экран            
	
	mov ah,0ah		;функция ввода строки с клавиатуры
	mov dx,offset wrd       ;буфер куда вводить
	int 21h			;пользователь вводит в текстовом виде в buf 
	
lp0:	
    mov bx, handle
	mov bp,0		;искомое слово в строке не встретилось
;поиск начала очередного слова
lp1:	
    mov ah,3fh		;ф-я чтения из файла
	mov cx,1		;1 байт
	lea dx,rbuff		;куда читать
	int 21h			;читаем один символ из файла в rbuff  
	
	test ax,ax		;если прочитали  0 символов, значит файл закончился
	jz fin1       
	
	mov al, rbuff
	inc curptr		;следующий символ      
	
	cmp al, 13			;если конец строки
	jz fin1				;то закончить	
	
	cmp al,' '			;если не пробел
	jz lp1                         
	
	cmp al,9			;и не табуляция
	jnz m1				;то переход       
	
	jmp lp1
;q1:                                 
;	jmp lp1				;продолжить поиск начала слова
m1:	
    lea di,strf     ;; ???
lp2:	
    stosb

	mov ah,3fh		;ф-я чтения из файла
	mov cx,1		;1 байт
	lea dx,rbuff		;куда читать
	int 21h			;читаем один символ из файла в rbuff   
	
	test ax,ax		;если прочитали 0 символов, значит файл закончился
	jz m2              
	
	mov al,rbuff		
	inc curptr		;следующий символ
	cmp al,13			;если конец строки
	jz m2			;то закончить	
	cmp al,' '			;если не пробел
	jz m2
	cmp al,9			;и не табуляция
	jz m2				;то переход
	jmp lp2				;продолжить поиск начала слова
m2:	
	mov cx,di			;длина слова
	sub cx,offset strf
	cmp cl,wrd[1]
	jnz zz1
	lea di,strf			;начало слова
	lea si,wrd[2]			;введенное слово
	repe cmpsb			;сравнить слова
	jnz zz1				;если не совпали, искать следующее
	mov bp,1			;слово найдено в строке
zz1:	
    cmp al,13
	jz fin1				
	jmp lp1				;поиск следующего слова
	
fin1:	cmp al,13
	jnz m4
	inc curptr		;следующий символ
	push ax
	mov ah,3fh		;ф-я чтения из файла
	mov cx,1		;1 байт
	lea dx,rbuff		;куда читать
	int 21h			;читаем один символ из файла в rbuff
	pop ax
	
m4:	test bp,bp
	jnz m3
	push ax
	mov esi,curptr
	sub esi,begstr
	mov ax,4200h
	mov dx,word ptr begstr
	mov cx,word ptr begstr+2
	int 21h	
lp10:	
    mov ah,3fh		;ф-я чтения из файла
	mov bx,handle
	mov cx,1		;1 байт
	lea dx,rbuff		;куда читать
	int 21h			;читаем один символ из файла в rbuff
	mov ah,40h
	mov bx,ohandle
	int 21h
	dec esi
	jnz lp10
	pop ax  
	
m3:
   	mov edx,curptr
	mov begstr,edx
	cmp al,0
	jz close
	jmp lp0

close:	
    mov ah,3eh		;ф-я закрытия файла
	mov bx,handle		;закрытие исходного
	int 21h			;файла

	mov ah,3eh		;ф-я закрытия файла
	mov bx,ohandle		;закрытие временного
	int 21h			;файла
	mov ah,41h		;ф-я удаления файла
	lea dx,comandLine[2]		;имя исходного файла
	int 21h			;удалить файл
	jnc deleted		;если нет ошибки, продолжить
	mov ah,9		;функция вывода сообщения на экран
	lea dx,msge3		;выводимое сообщение
	int 21h			;выводим на экран
	jmp exit			;если ошибка - переход 
	
deleted:	
	mov ah,56h		;ф-я переименования файла
	lea dx,tfn		;имя временного файла
	lea di,comandLine[2]		;имя исходного файла
	int 21h			;переименовать
	mov ah,9		;функция вывода сообщения на экран
	lea dx,msg3		;выводимое сообщение
	int 21h			;выводим на экран
exit:	
	mov ax,4c00h	;закончить программу
	int 21h
end start
