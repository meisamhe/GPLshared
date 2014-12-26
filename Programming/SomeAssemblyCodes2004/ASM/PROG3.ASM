;-----------------------------------------------
	.MODEL	SMALL
	.CODE
	ORG	100H
BEGIN	PROC	NEAR
	MOV	AX, 01	;Initialize	AX,
	MOV	BX, 01	;	BX, and
	MOV	DX, 01	;DX	to 01
	MOV	CX, 10	;Initialize
A20:
	INC	AX	;Add 01 to AX
	ADD 	BX, AX	;Add AX to BX
	SHL	DX, 1	;Double DX
	LOOP	A20	;Decrement CX,
			;	loop if nonzero
	MOV 	AX, 4C00H	;Exit to DOS
	INT	21H
BEGIN	ENDP
	END	BEGIN