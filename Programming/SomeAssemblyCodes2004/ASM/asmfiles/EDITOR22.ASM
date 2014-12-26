CGROUP	GROUP	CODE_SEG, DATA_SEG
	ASSUME	CS:CGROUP, DS:CGROUP

CODE_SEG	SEGMENT PUBLIC

DATA_SEG	SEGMENT PUBLIC
	EXTRN	SECTOR:BYTE
	EXTRN	SECTOR_OFFSET:WORD
	EXTRN	PHANTOM_CURSOR_X:BYTE
	EXTRN	PHANTOM_CURSOR_Y:BYTE
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure write one byte to SECTOR, at the memory location	;
; pointed to by the phantom cursor.					;
;									;
;	DL	Byte to write to SECTOR					;
;									;
; The offset is calculated by						;
;   OFFSET = SECTOR_OFFSET + (16 * PHANTOM_CURSOR_Y) + PHANTOM_CURSOR_X	;
;									;
; Reads:	PHANTOM_CURSOR_X, PHANTOM_CURSOR_Y, SECTOR_OFFSET	;
; Writes:	SECTOR							;
;-----------------------------------------------------------------------;
WRITE_TO_MEMORY	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	MOV	BX,SECTOR_OFFSET
	MOV	AL,PHANTOM_CURSOR_Y
	XOR	AH,AH
	MOV	CL,4			;Multiply PHANTOM_CURSOR_Y by 16
	SHL	AX,CL
	ADD	BX,AX			;BX = SECTOR_OFFSET + (16 * Y)
	MOV	AL,PHANTOM_CURSOR_X
	XOR	AH,AH
	ADD	BX,AX			;That's the address!
	MOV	SECTOR[BX],DL		;Now, store the byte
	POP	CX
	POP	BX
	POP	AX
	RET
WRITE_TO_MEMORY		ENDP

	PUBLIC	EDIT_BYTE
	EXTRN	SAVE_REAL_CURSOR:NEAR, RESTORE_REAL_CURSOR:NEAR
	EXTRN	MOV_TO_HEX_POSITION:NEAR, MOV_TO_ASCII_POSITION:NEAR
	EXTRN	WRITE_PHANTOM:NEAR, WRITE_PROMPT_LINE:NEAR
	EXTRN	CURSOR_RIGHT:NEAR, WRITE_HEX:NEAR, WRITE_CHAR:NEAR
DATA_SEG	SEGMENT PUBLIC
	EXTRN	EDITOR_PROMPT:BYTE
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure changes a byte in memory and on the screen.		;
;									;
;	DL	Byte to write into SECTOR, and change on screen		;
;									;
; Uses:		SAVE_REAL_CURSOR, RESTORE_REAL_CURSOR			;
;		MOV_TO_HEX_POSITION, MOV_TO_ASCII_POSITION		;
;		WRITE_PHANTOM, WRITE_PROMPT_LINE, CURSOR_RIGHT		;
;		WRITE_HEX, WRITE_CHAR, WRITE_TO_MEMORY			;
; Reads:	EDITOR_PROMPT						;
;-----------------------------------------------------------------------;
EDIT_BYTE	PROC	NEAR
	PUSH	DX
	CALL	SAVE_REAL_CURSOR
	CALL	MOV_TO_HEX_POSITION	;Move to the hex number in the
	CALL	CURSOR_RIGHT		; hex window
	CALL	WRITE_HEX		;Write the new number
	CALL	MOV_TO_ASCII_POSITION	;Move to the char. in the ASCII window
	CALL	WRITE_CHAR		;Write the new character
	CALL	RESTORE_REAL_CURSOR	;Move cursor back where it belongs
	CALL	WRITE_PHANTOM		;Rewrite the phantom cursor
	CALL	WRITE_TO_MEMORY		;Save this new byte in SECTOR
	LEA	DX,EDITOR_PROMPT
	CALL	WRITE_PROMPT_LINE
	POP	DX
	RET
EDIT_BYTE	ENDP

CODE_SEG	ENDS

	END
