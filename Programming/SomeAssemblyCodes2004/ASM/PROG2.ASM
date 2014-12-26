;------------------------------------------------
.MODEL SMALL
.DATA
	NAME1	DB	'ABCDEFGHI'
	NAME2	DB	'JKLMNOPQR'
;--------------------------------------------------
.CODE
BEGIN	PROC	FAR
	MOV	AX,@DATA	;Initialize	segment
	MOV	DS,Ax		;registers
	MOV	ES,AX
	
	MOV	CX,09	;Init.	to move 9 chars
	LEA	SI,NAME1;Init. address of NAME1
	LEA	DI,NAME2;	and NAME2
B20:
	MOV	AL, [SI]	;Get character form NAME1,
	MOV	[DI], AL	;move it to NAME2
	INC	SI		;incr. next char in NAME1
	INC	DI		;Incr. next pos'n in NAME2
	DEC 	CX		;Decrement loop count
	JNZ	B20		;Count not zero? Yes, loop
	
	MOV	AX,4C00H	;Exit to Dos
	INT	21H
BEGIN	ENDP
	END BEGIN
	
	
	
