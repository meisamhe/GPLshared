CGROUP	GROUP	CODE_SEG, DATA_SEG
	ASSUME	CS:CGROUP, DS:CGROUP


CODE_SEG	SEGMENT PUBLIC

;-----------------------------------------------------------------------;
; These four procedures move the phantom cursors.			;
;									;
; Uses:		ERASE_PHANTOM, WRITE_PHANTOM				;
;		SCROLL_DOWN, SCROLL_UP					;
; Reads:	PHANTOM_CURSOR_X, PHANTOM_CURSOR_Y			;
; Writes:	PHANTOM_CURSOR_X, PHANTOM_CURSOR_Y			;
;-----------------------------------------------------------------------;

	PUBLIC	PHANTOM_UP
PHANTOM_UP	PROC	NEAR
	CALL	ERASE_PHANTOM		;Erase at current position
	DEC	PHANTOM_CURSOR_Y	;Move cursor up one line
	JNS	WASNT_AT_TOP		;Was not at the top, write cursor
	CALL	SCROLL_DOWN		;Was at the top, scroll
WASNT_AT_TOP:
	CALL	WRITE_PHANTOM		;Write the phantom at new position
	RET
PHANTOM_UP	ENDP

	PUBLIC	PHANTOM_DOWN
PHANTOM_DOWN	PROC	NEAR
	CALL	ERASE_PHANTOM		;Erase at current position
	INC	PHANTOM_CURSOR_Y	;Move cursor down one line
	CMP	PHANTOM_CURSOR_Y,16	;Was it at the bottom?
	JB	WASNT_AT_BOTTOM		;No, so write phantom
	CALL	SCROLL_UP		;Was at bottom, scroll
WASNT_AT_BOTTOM:
	CALL	WRITE_PHANTOM		;Write the phantom cursor
	RET
PHANTOM_DOWN	ENDP

	PUBLIC	PHANTOM_LEFT
PHANTOM_LEFT	PROC	NEAR
	CALL	ERASE_PHANTOM		;Erase at current position
	DEC	PHANTOM_CURSOR_X	;Move cursor left one column
	JNS	WASNT_AT_LEFT		;Was not at the left side, write cursor
	MOV	PHANTOM_CURSOR_X,0	;Was at left, so put back there
WASNT_AT_LEFT:
	CALL	WRITE_PHANTOM		;Write the phantom cursor
	RET
PHANTOM_LEFT	ENDP

	PUBLIC	PHANTOM_RIGHT
PHANTOM_RIGHT	PROC	NEAR
	CALL	ERASE_PHANTOM		;Erase at current position
	INC	PHANTOM_CURSOR_X	;Move cursor right one column
	CMP	PHANTOM_CURSOR_X,16	;Was it already at the right side?
	JB	WASNT_AT_RIGHT
	MOV	PHANTOM_CURSOR_X,15	;Was at right, so put back there
WASNT_AT_RIGHT:
	CALL	WRITE_PHANTOM		;Write the phantom cursor
	RET
PHANTOM_RIGHT	ENDP


	EXTRN	DISP_HALF_SECTOR:NEAR, GOTO_XY:NEAR
DATA_SEG	SEGMENT PUBLIC
	EXTRN	SECTOR_OFFSET:WORD
	EXTRN	LINES_BEFORE_SECTOR:BYTE
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; These two procedures move between the two half-sector displays.	;
;									;
; Uses:		WRITE_PHANTOM, DISP_HALF_SECTOR, ERASE_PHANTOM, GOTO_XY	;
;		SAVE_REAL_CURSOR, RESTORE_REAL_CURSOR			;
; Reads:	LINES_BEFORE_SECTOR					;
; Writes:	SECTOR_OFFSET, PHANTOM_CURSOR_Y				;
;-----------------------------------------------------------------------;
SCROLL_UP	PROC	NEAR
	PUSH	DX
	CALL	ERASE_PHANTOM		;Remove the phantom cursor
	CALL	SAVE_REAL_CURSOR	;Save the real cursor position
	XOR	DL,DL			;Set cursor for half-sector display
	MOV	DH,LINES_BEFORE_SECTOR
	ADD	DH,2
	CALL	GOTO_XY
	MOV	DX,256			;Display the second half sector
	MOV	SECTOR_OFFSET,DX
	CALL	DISP_HALF_SECTOR
	CALL	RESTORE_REAL_CURSOR	;Restore the real cursor position
	MOV	PHANTOM_CURSOR_Y,0	;Cursor at top of second half sector
	CALL	WRITE_PHANTOM		;Restore the phantom cursor
	POP	DX
	RET
SCROLL_UP	ENDP

SCROLL_DOWN	PROC	NEAR
	PUSH	DX
	CALL	ERASE_PHANTOM		;Remove the phantom cursor
	CALL	SAVE_REAL_CURSOR	;Save the real cursor position
	XOR	DL,DL			;Set cursor for half-sector display
	MOV	DH,LINES_BEFORE_SECTOR
	ADD	DH,2
	CALL	GOTO_XY
	XOR	DX,DX			;Display the first half sector
	MOV	SECTOR_OFFSET,DX
	CALL	DISP_HALF_SECTOR
	CALL	RESTORE_REAL_CURSOR	;Restore the real cursor position
	MOV	PHANTOM_CURSOR_Y,15	;Cursor at bottom of first half sector
	CALL	WRITE_PHANTOM		;Restore the phantom cursor
	POP	DX
	RET
SCROLL_DOWN	ENDP


	PUBLIC	MOV_TO_HEX_POSITION
	EXTRN	GOTO_XY:NEAR
DATA_SEG	SEGMENT PUBLIC
	EXTRN	LINES_BEFORE_SECTOR:BYTE
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure moves the real cursor to the position of the phantom	;
; cursor in the hex window.						;
;									;
; Uses:		GOTO_XY							;
; Reads:	LINES_BEFORE_SECTOR, PHANTOM_CURSOR_X, PHANTOM_CURSOR_Y	;
;-----------------------------------------------------------------------;
MOV_TO_HEX_POSITION	PROC	NEAR
	PUSH	AX
	PUSH	CX
	PUSH	DX
	MOV	DH,LINES_BEFORE_SECTOR	;Find row of phantom (0,0)
	ADD	DH,2			;Plus row of hex and horizontal bar
	ADD	DH,PHANTOM_CURSOR_Y	;DH = row of phantom cursor
	MOV	DL,8			;Indent on left side
	MOV	CL,3			;Each column uses 3 characters,so
	MOV	AL,PHANTOM_CURSOR_X	; we must multiply CURSOR_X by 3
	MUL	CL
	ADD	DL,AL			;And add to the indent, to get column
	CALL	GOTO_XY			; for phantom cursor
	POP	DX
	POP	CX
	POP	AX
	RET
MOV_TO_HEX_POSITION	ENDP

	PUBLIC	MOV_TO_ASCII_POSITION
	EXTRN	GOTO_XY:NEAR
DATA_SEG	SEGMENT PUBLIC
	EXTRN	LINES_BEFORE_SECTOR:BYTE
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure moves the real cursor to the beginning of the phantom	;
; cursor in the ASCII window.						;
;									;
; Uses:		GOTO_XY							;
; Reads:	LINES_BEFORE_SECTOR, PHANTOM_CURSOR_X, PHANTOM_CURSOR_Y	;
;-----------------------------------------------------------------------;
MOV_TO_ASCII_POSITION	PROC	NEAR
	PUSH	AX
	PUSH	DX
	MOV	DH,LINES_BEFORE_SECTOR	;Find row of phantom (0,0)
	ADD	DH,2			;Plus row of hex and horizontal bar
	ADD	DH,PHANTOM_CURSOR_Y	;DH = row of phantom cursor
	MOV	DL,59			;Indent on left side
	ADD	DL,PHANTOM_CURSOR_X	;Add CURSOR_X to get X position
	CALL	GOTO_XY			; for phantom cursor
	POP	DX
	POP	AX
	RET
MOV_TO_ASCII_POSITION	ENDP

	PUBLIC	SAVE_REAL_CURSOR
;-----------------------------------------------------------------------;
; This procedure saves the position of the real cursor in the two	;
; variables REAL_CURSOR_X and REAL_CURSOR_Y.				;
;									;
; Writes:	REAL_CURSOR_X, REAL_CURSOR_Y				;
;-----------------------------------------------------------------------;
SAVE_REAL_CURSOR	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	MOV	AH,3			;Read cursor position
	XOR	BH,BH			; on page 0
	INT	10h			;And return in DL,DH
	MOV	REAL_CURSOR_Y,DL	;Save position
	MOV	REAL_CURSOR_X,DH
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	RET
SAVE_REAL_CURSOR	ENDP

	PUBLIC	RESTORE_REAL_CURSOR
	EXTRN	GOTO_XY:NEAR
;-----------------------------------------------------------------------;
; This procedure restorest he real cursor to its old position, saved in	;
; REAL_CURSOR_X and REAL_CURSOR_Y.					;
;									;
; Uses:		GOTO_XY							;
; Reads:	REAL_CURSOR_X, REAL_CURSOR_Y				;
;-----------------------------------------------------------------------;
RESTORE_REAL_CURSOR	PROC	NEAR
	PUSH	DX
	MOV	DL,REAL_CURSOR_Y
	MOV	DH,REAL_CURSOR_X
	CALL	GOTO_XY
	POP	DX
	RET
RESTORE_REAL_CURSOR	ENDP

	PUBLIC	WRITE_PHANTOM
	EXTRN	WRITE_ATTRIBUTE_N_TIMES:NEAR
;-----------------------------------------------------------------------;
; This procedure uses CURSOR_X and CURSOR_Y, through MOV_TO_..., as the	;
; coordinates for the phantom cursor.  WRITE_PHANTOM writes this	;
; phantom cursor.							;
;									;
; Uses:		WRITE_ATTRIBUTE_N_TIMES, SAVE_REAL_CURSOR		;
;		RESTORE_REAL_CURSOR, MOV_TO_HEX_POSITION		;
;		MOV_TO_ASCII_POSITION					;
;-----------------------------------------------------------------------;
WRITE_PHANTOM	PROC	NEAR
	PUSH	CX
	PUSH	DX
	CALL	SAVE_REAL_CURSOR
	CALL	MOV_TO_HEX_POSITION	;Coord. of cursor in hex window
	MOV	CX,4			;Make phantom cursor four chars wide
	MOV	DL,70h
	CALL	WRITE_ATTRIBUTE_N_TIMES
	CALL	MOV_TO_ASCII_POSITION	;Coord. of cursor in ASCII window
	MOV	CX,1			;Cursor is one character wide here
	CALL	WRITE_ATTRIBUTE_N_TIMES
	CALL	RESTORE_REAL_CURSOR
	POP	DX
	POP	CX
	RET
WRITE_PHANTOM	ENDP

	PUBLIC	ERASE_PHANTOM
	EXTRN	WRITE_ATTRIBUTE_N_TIMES:NEAR
;-----------------------------------------------------------------------;
; This procedure erases the phantom cursor, just the opposite of	;
; WRITE_PHANTOM.							;
;									;
; Uses:		WRITE_ATTRIBUTE_N_TIMES, SAVE_REAL_CURSOR		;
;		RESTORE_REAL_CURSOR, MOV_TO_HEX_POSITION		;
;		MOV_TO_ASCII_POSITION					;
;-----------------------------------------------------------------------;
ERASE_PHANTOM	PROC	NEAR
	PUSH	CX
	PUSH	DX
	CALL	SAVE_REAL_CURSOR
	CALL	MOV_TO_HEX_POSITION	;Coord. of cursor in hex window
	MOV	CX,4			;Change back to white on black
	MOV	DL,7
	CALL	WRITE_ATTRIBUTE_N_TIMES
	CALL	MOV_TO_ASCII_POSITION
	MOV	CX,1
	CALL	WRITE_ATTRIBUTE_N_TIMES
	CALL	RESTORE_REAL_CURSOR
	POP	DX
	POP	CX
	RET
ERASE_PHANTOM	ENDP

CODE_SEG	ENDS


DATA_SEG	SEGMENT PUBLIC
REAL_CURSOR_X		DB	0
REAL_CURSOR_Y		DB	0
	PUBLIC	PHANTOM_CURSOR_X, PHANTOM_CURSOR_Y
PHANTOM_CURSOR_X	DB	0
PHANTOM_CURSOR_Y	DB	0
DATA_SEG	ENDS


	END
