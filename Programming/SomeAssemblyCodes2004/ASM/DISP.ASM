.MODEL SMALL
.CODE
ORG	100H
BEGIN:	JMP	SHORT MAIN
CHAR	DB	00,'$'

;	Main procedure:
;	----------------
MAIN	PROC 	NEAR
	CALL	B10CLR	;Clear screen
	CALL	B10SET	;Set cursor
	CALL	D10DISP	;Display	characters
	MOV	AX,4C00H 	;Exit to Dos
	INT	21h
MAIN	ENDP
;	Clear screen;
;	--------------
B10CLR	PROC	NEAR
	MOV	AX,0600H		;Scroll full screen
	MOV	BH,07		;Attrib : wh on blk
	MOV	CX, 0000		;Upper left loc
	MOV	DX, 184FH	;Lower right loc
	INT	10H
	RET
B10CLR	ENDP
;	Set cursor to 00,00:
;	--------------------
C10SET	PROC	NEAR
	MOV	AH,02H	;Request set cursor
	MOV	BH,00	;Page number 0
	MOV	DX,0000	;ROW 0, Column 0
	INT	10H
	RET
C10SET	ENDP
;	-------------------------
D10DISP	PROC
	MOV	 CX,256	;Do 256 iterations
	LEA 	DX, CHAR	;Init addr of char
D20:
	MOV	AH, 09H	;Display ASCII  char
	INT 	21H
	INC	CHAR	;Incr for next char
	LOOP	D20	;Do 256	times
	RET		;Return
D10DISP	ENDP
	END BEGIN