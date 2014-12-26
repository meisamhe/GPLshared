CR		EQU	13		;Carriage return
LF		EQU	10		;Line feed

CGROUP	GROUP	CODE_SEG
	ASSUME	CS:CGROUP

CODE_SEG	SEGMENT PUBLIC

	PUBLIC	CLEAR_SCREEN
;-----------------------------------------------------------------------;
; This procedure clears the entire screen.				;
;-----------------------------------------------------------------------;
CLEAR_SCREEN	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	XOR	AL,AL			;Blank entire window
	XOR	CX,CX			;Upper left corner is at (0,0)
	MOV	DH,24			;Bottom line of screen is line 24
	MOV	DL,79			;Right side is at column 79
	MOV	BH,7			;Use normal attribute for blanks
	MOV	AH,6			;Call for SCROLL-UP function
	INT	10h			;Clear the window
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	RET
CLEAR_SCREEN	ENDP


	PUBLIC	GOTO_XY
;-----------------------------------------------------------------------;
; This procedure moves the cursor					;
;									;
;	DH	Row (Y)							;
;	DL	Column (X)						;
;-----------------------------------------------------------------------;
GOTO_XY		PROC	NEAR
	PUSH	AX
	PUSH	BX
	MOV	BH,0			;Display page 0
	MOV	AH,2			;Call for SET CURSOR POSITION
	INT	10h
	POP	BX
	POP	AX
	RET
GOTO_XY		ENDP

	PUBLIC	SEND_CRLF
;-----------------------------------------------------------------------;
; This routine just sends a carriage return-line feed pair to the	;
; display, using the DOS routines so that scrolling will be handled	;
; correctly.								;
;-----------------------------------------------------------------------;
SEND_CRLF	PROC	NEAR
	PUSH	AX
	PUSH	DX
	MOV	AH,2
	MOV	DL,CR
	INT	21h
	MOV	DL,LF
	INT	21h
	POP	DX
	POP	AX
	RET
SEND_CRLF	ENDP

CODE_SEG	ENDS

	END
