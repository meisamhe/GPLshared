CR		EQU	13		;Carriage return
LF		EQU	10		;Line feed

CGROUP	GROUP	CODE_SEG, DATA_SEG
	ASSUME	CS:CGROUP, DS:CGROUP


;-----------------------------------------------------------------------;
; This file contains procedures that work with the cursor:		;
;									;
; GOTO_XY			Move the cursor to a new position	;
; SEND_CRLF			Move cursor to start of the next line	;
; CURSOR_RIGHT			Move the cursor right one column	;
; READ_CURSOR_POSITION		Get the current cursor position		;
; CLEAR_TO_END_OF_LINE		Clear all the line after the cursor	;
; CLEAR_SCREEN			Clear the entire screen			;
;-----------------------------------------------------------------------;


DATA_SEG	SEGMENT PUBLIC
DATA_SEG	ENDS


CODE_SEG	SEGMENT PUBLIC

	PUBLIC	GOTO_XY
;-----------------------------------------------------------------------;
;  This procedure moves the cursor					;
;									;
;	DH	Row (Y)							;
;	DL	Column (X)						;
;-----------------------------------------------------------------------;
GOTO_XY		PROC	NEAR
	PUSH	AX
	PUSH	BX
	MOV	BH,0			;Display page 0
	MOV	AH,2			;Call for SET CURSOR POSITION
	INT	10h			;Let the ROM BIOS do the work
	POP	BX
	POP	AX
	RET
GOTO_XY		ENDP


	PUBLIC	SEND_CRLF
;-----------------------------------------------------------------------;
; This procedure just sends a carriage return, line feed pair to the	;
; display, using the DOS routines so that scrolling will be handled	;
; correctly.								;
;-----------------------------------------------------------------------;
SEND_CRLF	PROC	NEAR
	PUSH	AX
	PUSH	DX
	MOV	AH,2			;Ask for character output function
	MOV	DL,CR			;Send a carriage-return character
	INT	21h
	MOV	DL,LF			;Send a line-feed character
	INT	21h
	POP	DX
	POP	AX
	RET
SEND_CRLF	ENDP


	PUBLIC	CURSOR_RIGHT
;-----------------------------------------------------------------------;
; This procedure moves the cursor one position to the right, or to the	;
; next line if it was at the end of a line.				;
;									;
; Uses:		SEND_CRLF						;
;-----------------------------------------------------------------------;
CURSOR_RIGHT	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	MOV	AH,3		;Read the current cursor position
	MOV	BH,0		;On page zero
	INT	10h		;Read cursor position
	MOV	AH,2		;Set new cursor position
	INC	DL		;Set column to next position
	CMP	DL,79		;Did we pass column 79?
	JBE	MOVE_CURSOR	;No, then move the cursor
	CALL	SEND_CRLF	;Yes, go to next line
	JMP	DONE_CURSOR_RIGHT
MOVE_CURSOR:
	INT	10h		;Move the cursor
DONE_CURSOR_RIGHT:
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	RET
CURSOR_RIGHT	ENDP


	PUBLIC	READ_CURSOR_POSITION
;-----------------------------------------------------------------------;
; This procedure doesn't follow the conventions for returning		;
; information in the AX register so that it can be used easily with	;
; GOTO_XY.								;
;									;
; Returns:	DH,DL	Row, column of cursor				;
;-----------------------------------------------------------------------;
READ_CURSOR_POSITION	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	MOV	AH,3			;Ask for current cursor position
	MOV	BH,0			;On page 0
	INT	10h			;Return information in DX
	POP	CX
	POP	BX
	POP	AX
	RET
READ_CURSOR_POSITION	ENDP


	PUBLIC	CLEAR_TO_END_OF_LINE
;-----------------------------------------------------------------------;
; This procedure clears the line from the current cursor position to	;
; the end of that line.							;
;-----------------------------------------------------------------------;
CLEAR_TO_END_OF_LINE	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	MOV	AH,3			;Read current cursor position
	XOR	BH,BH			;  on page zero
	INT	10h			;Now have (X,Y) in DL, DH
	MOV	AH,6			;Set up to clear to end of line
	XOR	AL,AL			;Clear window
	MOV	CH,DH			;All on same line
	MOV	CL,DL			;Start at the cursor position
	MOV	DL,79			;And stop at the end of the line
	MOV	BH,7			;Use normal attribute
	INT	10h
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	RET
CLEAR_TO_END_OF_LINE	ENDP


	PUBLIC	CLEAR_SCREEN
;-----------------------------------------------------------------------;
;  This procedure clears the entire screen.				;
;-----------------------------------------------------------------------;
CLEAR_SCREEN	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	XOR	AL,AL			;Blank entire window
	XOR	CX,CX			;Set upper left to (0,0)
	MOV	DH,24			;Set lower right to (24,79)
	MOV	DL,79
	MOV	BH,7			;Use normal attribute for blanks
	MOV	AH,6			;Call for scroll function
	INT	10h			;Let the ROM BIOS do the work
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	RET
CLEAR_SCREEN	ENDP


CODE_SEG	ENDS

	END
