.model small
.data
begstr	dd 0
curptr	dd 0
handle	dw ?
ohandle	dw ?
tfn	db 'temp.txt',0
comandLine	db 20,21 dup(0)	;��������� ������, ��������� � ����������
wrd	db 50,51 dup(0)
rbuff	db 8 dup(0)	;���� �������� ������ �� �����
strf	db 512 dup (0)		;������, ����������� �� �����    
msg1	db 13,10,'Enter filename: $'
msg2	db 13,10,'Enter word: $'
msg3	db 13,10,'Done!$' 
msge1	db 13,10,'Error opening file!$'
msge2	db 13,10,'Error creating file!$'
msge3	db 13,10,'Error deleting file!$'  
.stack 256
.code

start:
	mov ax,@data	;����������� ���������� �������
	mov ds,ax       
	
	mov di,81h	;������ ��������� ������
	mov cl,es:[80h]	;����� ��������� ������
	mov ch,0
	test cx,cx	;���� ��� ��������� ������
	jz enterNameFile ;�� ���� ����� �����  
	
	mov al,' '
	repz scasb	;���������� ������� ����� ����������
	test cx,cx	;���� ��������� ������ �����������
	jz enterNameFile         ;�� ���� ����� ����� 
	
	dec di      ;������������ ��������� �� ��������� ������
	inc cx		;� ���������� ������������ ��������
	
	lea si,comandLine[2]	;������ ����� �������� �����
;�������� ��� ������� ����� �� ��������� ������ � ������� ������
lp11:	
    mov al,es:[di]	;������ ������
	cmp al,' '	;���� ������
	jz enterNameFile	;�� ��������� ����������� 
	
	mov [si],al	;��������� ������ � �������� ������
	inc si		;��������� ������
	inc di		;��������� ������
	loop lp11	;���������� �����������    
	
enterNameFile:
	push ds		;es=ds
	pop es 
	
	cmp comandLine[2],0		;���� ��� �������� ����� �������
	jnz openInputFile		;�� �������      
	
	mov ah,9		;������� ������ ��������� �� �����
	lea dx,msg1		;��������� ���������
	int 21h			;������� �� �����    
	
	mov ah,0ah		;������� ����� ������ � ����������
	mov dx,offset comandLine       ;����� ���� �������
	int 21h			;������������ ������ � ��������� ���� � buf  
	
	mov bh,0
	mov bl,comandLine[1]		;����� ��������� ������
	mov comandLine[bx+2],byte ptr 0;�������� 0 � ����� ��������� ������

openInputFile:	
    mov ax,3d00h		;������� �������� ����� �� ������
	lea dx, comandLine[2]		;��������� ��� �����
	int 21h			;������� �������
	jnc createOutputFile		;���� ������ - �������  
	
	mov ah,9		;������� ������ ��������� �� �����
	lea dx,msge1		;��������� ���������
	int 21h			;������� �� �����
	jmp exit			;���� ������ - ������� 
	
createOutputFile:	
    mov handle,ax		;����� ��������� �����
	lea dx,tfn		;��������� ��� �����
	
	mov ah,3ch		;�-� �������� �����
	xor cx,cx		;��������
	int 21h			;������� �������� ���� 
	
	jnc created		;���� ������ - ������� 
	
	mov ah,9		;������� ������ ��������� �� �����
	lea dx,msge2		;��������� ���������
	int 21h			;������� �� �����
	jmp exit			;���� ������ - �������  
	
created:	
	mov ohandle,ax		;��������� ����� �����   
	
	mov ah,9		;������� ������ ��������� �� �����
	lea dx,msg2		;��������� ���������
	int 21h			;������� �� �����            
	
	mov ah,0ah		;������� ����� ������ � ����������
	mov dx,offset wrd       ;����� ���� �������
	int 21h			;������������ ������ � ��������� ���� � buf 
	
lp0:	
    mov bx, handle
	mov bp,0		;������� ����� � ������ �� �����������
;����� ������ ���������� �����
lp1:	
    mov ah,3fh		;�-� ������ �� �����
	mov cx,1		;1 ����
	lea dx,rbuff		;���� ������
	int 21h			;������ ���� ������ �� ����� � rbuff  
	
	test ax,ax		;���� ���������  0 ��������, ������ ���� ����������
	jz fin1       
	
	mov al, rbuff
	inc curptr		;��������� ������      
	
	cmp al, 13			;���� ����� ������
	jz fin1				;�� ���������	
	
	cmp al,' '			;���� �� ������
	jz lp1                         
	
	cmp al,9			;� �� ���������
	jnz m1				;�� �������       
	
	jmp lp1
;q1:                                 
;	jmp lp1				;���������� ����� ������ �����
m1:	
    lea di,strf     ;; ???
lp2:	
    stosb

	mov ah,3fh		;�-� ������ �� �����
	mov cx,1		;1 ����
	lea dx,rbuff		;���� ������
	int 21h			;������ ���� ������ �� ����� � rbuff   
	
	test ax,ax		;���� ��������� 0 ��������, ������ ���� ����������
	jz m2              
	
	mov al,rbuff		
	inc curptr		;��������� ������
	cmp al,13			;���� ����� ������
	jz m2			;�� ���������	
	cmp al,' '			;���� �� ������
	jz m2
	cmp al,9			;� �� ���������
	jz m2				;�� �������
	jmp lp2				;���������� ����� ������ �����
m2:	
	mov cx,di			;����� �����
	sub cx,offset strf
	cmp cl,wrd[1]
	jnz zz1
	lea di,strf			;������ �����
	lea si,wrd[2]			;��������� �����
	repe cmpsb			;�������� �����
	jnz zz1				;���� �� �������, ������ ���������
	mov bp,1			;����� ������� � ������
zz1:	
    cmp al,13
	jz fin1				
	jmp lp1				;����� ���������� �����
	
fin1:	cmp al,13
	jnz m4
	inc curptr		;��������� ������
	push ax
	mov ah,3fh		;�-� ������ �� �����
	mov cx,1		;1 ����
	lea dx,rbuff		;���� ������
	int 21h			;������ ���� ������ �� ����� � rbuff
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
    mov ah,3fh		;�-� ������ �� �����
	mov bx,handle
	mov cx,1		;1 ����
	lea dx,rbuff		;���� ������
	int 21h			;������ ���� ������ �� ����� � rbuff
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
    mov ah,3eh		;�-� �������� �����
	mov bx,handle		;�������� ���������
	int 21h			;�����

	mov ah,3eh		;�-� �������� �����
	mov bx,ohandle		;�������� ����������
	int 21h			;�����
	mov ah,41h		;�-� �������� �����
	lea dx,comandLine[2]		;��� ��������� �����
	int 21h			;������� ����
	jnc deleted		;���� ��� ������, ����������
	mov ah,9		;������� ������ ��������� �� �����
	lea dx,msge3		;��������� ���������
	int 21h			;������� �� �����
	jmp exit			;���� ������ - ������� 
	
deleted:	
	mov ah,56h		;�-� �������������� �����
	lea dx,tfn		;��� ���������� �����
	lea di,comandLine[2]		;��� ��������� �����
	int 21h			;�������������
	mov ah,9		;������� ������ ��������� �� �����
	lea dx,msg3		;��������� ���������
	int 21h			;������� �� �����
exit:	
	mov ax,4c00h	;��������� ���������
	int 21h
end start
