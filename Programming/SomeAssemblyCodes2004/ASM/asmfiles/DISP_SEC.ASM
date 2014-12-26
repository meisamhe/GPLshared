CGROUP	GROUP	CODE_SEG, DATA_SEG	;Group together two segments
	ASSUME	CS:CGROUP, DS:CGROUP

;-----------------------------------------------------------------------;
; This file contains procedures for displaying sectors on the screen:	;
;									;
; INIT_SEC_DISP			Reads a sector and redraws the screen	;
; WRITE_TOP_HEX_NUMBERS		Writes numbers along top of the box	;
; DISP_HALF_SECTOR		Displays half of the sector		;
; DISP_LINE			Displays one line of the sector		;
;-----------------------------------------------------------------------;


;-----------------------------------------------------------------------;
; Graphics characters for border of sector.				;
;-----------------------------------------------------------------------;
VERTICAL_BAR	EQU	0BAH
HORIZONTAL_BAR	EQU	0CDH
UPPER_LEFT	EQU	0C9H
UPPER_RIGHT	EQU	0BBH
LOWER_LEFT	EQU	0C8H
LOWER_RIGHT	EQU	0BCH
TOP_T_BAR	EQU	0CBH
BOTTOM_T_BAR	EQU	0CAH
TOP_TICK	EQU	0D1H
BOTTOM_TICK	EQU	0CFH


DATA_SEG	SEGMENT PUBLIC
	EXTRN	SECTOR:BYTE
TOP_LINE_PATTERN	LABEL	BYTE
	DB	' ',7
	DB	UPPER_LEFT,1
	DB	HORIZONTAL_BAR,12
	DB	TOP_TICK,1
	DB	HORIZONTAL_BAR,11
	DB	TOP_TICK,1
	DB	HORIZONTAL_BAR,11
	DB	TOP_TICK,1
	DB	HORIZONTAL_BAR,12
	DB	TOP_T_BAR,1
	DB	HORIZONTAL_BAR,18
	DB	UPPER_RIGHT,1
	DB	0
BOTTOM_LINE_PATTERN	LABEL	BYTE
	DB	' ',7
	DB	LOWER_LEFT,1
	DB	HORIZONTAL_BAR,12
	DB	BOTTOM_TICK,1
	DB	HORIZONTAL_BAR,11
	DB	BOTTOM_TICK,1
	DB	HORIZONTAL_BAR,11
	DB	BOTTOM_TICK,1
	DB	HORIZONTAL_BAR,12
	DB	BOTTOM_T_BAR,1
	DB	HORIZONTAL_BAR,18
	DB	LOWER_RIGHT,1
	DB	0
DATA_SEG	ENDS


CODE_SEG	SEGMENT	PUBLIC

	PUBLIC	INIT_SEC_DISP
	EXTRN	WRITE_HEADER:NEAR, READ_SECTOR:NEAR
	EXTRN	WRITE_PATTERN:NEAR, SEND_CRLF:NEAR
	EXTRN	GOTO_XY:NEAR, WRITE_PHANTOM:NEAR
DATA_SEG	SEGMENT PUBLIC
	EXTRN	LINES_BEFORE_SECTOR:BYTE
	EXTRN	SECTOR_OFFSET:WORD
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
;  This procedure initializes the half-sector display.			;
;									;
; Uses:		WRITE_HEADER, READ_SECTOR, WRITE_TOP_HEX_NUMBERS	;
;		WRITE_PATTERN, SEND_CRLF, GOTO_XY, DISP_HALF_LINE	;
;		WRITE_PHANTOM						;
; Reads:	TOP_LINE_PATTERN, BOTTOM_LINE_PATTERN			;
;		LINES_BEFORE_SECTOR					;
; Writes:	SECTOR_OFFSET						;
;-----------------------------------------------------------------------;
INIT_SEC_DISP	PROC	NEAR
	PUSH	DX
	CALL	WRITE_HEADER		;Write the new header
	CALL	READ_SECTOR		;Read in the disk sector

	XOR	DL,DL			;Move cursor into position to beginning
	MOV	DH,LINES_BEFORE_SECTOR
	MOV	DH,2			;of 3rd line.
	CALL	GOTO_XY			;Move the cursor
	CALL	WRITE_TOP_HEX_NUMBERS	;Write lines along the top of window
	LEA	DX,TOP_LINE_PATTERN	;Write top of the box
	CALL	WRITE_PATTERN
	CALL	SEND_CRLF		;Move to the next line

	XOR	DX,DX			;Start at the beginning of the sector
	MOV	SECTOR_OFFSET,DX	;Set sector offset to zero
	CALL	DISP_HALF_SECTOR	;Display the first half sector
	LEA	DX,BOTTOM_LINE_PATTERN	;Display the bottom of the box
	CALL	WRITE_PATTERN
	CALL	WRITE_PHANTOM		;Write phantom cursor
	POP	DX
	RET
INIT_SEC_DISP	ENDP


	PUBLIC	WRITE_TOP_HEX_NUMBERS
	EXTRN	WRITE_CHAR_N_TIMES:NEAR, WRITE_HEX:NEAR, WRITE_CHAR:NEAR
	EXTRN	WRITE_HEX_DIGIT:NEAR, SEND_CRLF:NEAR
;-----------------------------------------------------------------------;
;  This procedure writes the index numbers (0 through F) at the top of	;
;  the half-sector display.						;
;									;
; Uses:		WRITE_CHAR_N_TIMES, WRITE_HEX, WRITE_CHAR		;
;		WRITE_HEX_DIGIT, SEND_CRLF				;
;-----------------------------------------------------------------------;
WRITE_TOP_HEX_NUMBERS	PROC	NEAR
	PUSH	CX
	PUSH	DX
	MOV	DL,' '			;Write 9 spaces for left side
	MOV	CX,9
	CALL	WRITE_CHAR_N_TIMES
	XOR	DH,DH			;Start with 0
HEX_NUMBER_LOOP:
	MOV	DL,DH
	CALL	WRITE_HEX		;Write a two-digit hex number
	MOV	DL,' '
	CALL	WRITE_CHAR		;Write a space between numbers
	INC	DH			;Increment the number
	CMP	DH,10H			;Have we written 16 numbers?
	JB	HEX_NUMBER_LOOP		;No, then keep writing

	MOV	DL,' '			;Write hex numbers over ASCII window
	MOV	CX,2
	CALL	WRITE_CHAR_N_TIMES
	XOR	DL,DL			;Start over at zero again
HEX_DIGIT_LOOP:
	CALL	WRITE_HEX_DIGIT		;Write a single-digit hex number
	INC	DL			;Increment the number
	CMP	DL,10H			;Have we written 16 numbers?
	JB	HEX_DIGIT_LOOP		;No, then keep writing

	CALL	SEND_CRLF		;Move to the start of the next line
	POP	DX
	POP	CX
	RET
WRITE_TOP_HEX_NUMBERS	ENDP


	PUBLIC	DISP_HALF_SECTOR
	EXTRN	SEND_CRLF:NEAR
;-----------------------------------------------------------------------;
;  This procedure displays half a sector (256 bytes)			;
;									;
;	DS:DX	Offset into sector, in bytes -- should be multiple of 16;
;									;
; Uses:		DISP_LINE, SEND_CRLF					;
;-----------------------------------------------------------------------;
DISP_HALF_SECTOR	PROC	NEAR
	PUSH	CX
	PUSH	DX
	MOV	CX,16			;Display 16 lines
HALF_SECTOR:
	CALL	DISP_LINE		;Display a single line
	CALL	SEND_CRLF		;Move to the start of the next line
	ADD	DX,16			;Increase our offset by 16 bytes
	LOOP	HALF_SECTOR		;Keep writing for 16 lines
	POP	DX
	POP	CX
	RET
DISP_HALF_SECTOR	ENDP


	PUBLIC	DISP_LINE
	EXTRN	WRITE_HEX:NEAR
	EXTRN	WRITE_CHAR:NEAR
	EXTRN	WRITE_CHAR_N_TIMES:NEAR
;-----------------------------------------------------------------------;
;  This procedure displays one line of data, or 16 bytes; first in hex,	;
;  then in ASCII.							;
;									;
;	DS:DX	Offset into sector, in bytes.				;
;									;
; Uses:		WRITE_CHAR, WRITE_HEX, WRITE_CHAR_N_TIMES		;
; Reads:	SECTOR							;
;-----------------------------------------------------------------------;
DISP_LINE	PROC	NEAR
	PUSH	BX
	PUSH	CX
	PUSH	DX
	MOV	BX,DX			;Offset is more useful in BX
	MOV	DL,' '
	MOV	CX,3			;Write 3 spaces before line
	CALL	WRITE_CHAR_N_TIMES
					;Write offset in hex
	CMP	BX,100H			;Is the first digit a 1?
	JB	WRITE_ONE		;No, white space already in DL
	MOV	DL,'1'			;Yes, then place '1' into DL for output
WRITE_ONE:
	CALL	WRITE_CHAR		;Write either space or '1'
	MOV	DL,BL			;Copy lower byte into DL for hex output
	CALL	WRITE_HEX		;Display the lower byte of offset

	MOV	DL,' '			;Write separator
	CALL	WRITE_CHAR
	MOV	DL,VERTICAL_BAR		;Draw left side of box
	CALL	WRITE_CHAR
	MOV	DL,' '			;Indent by one space from border
	CALL	WRITE_CHAR
					;Now write out 16 bytes
	MOV	CX,16			;Dump 16 bytes
	PUSH	BX			;Save the offset for ASCII_LOOP
HEX_LOOP:
	MOV	DL,SECTOR[BX]		;Get one byte
	CALL	WRITE_HEX		;Dump this byte in hex
	MOV	DL,' '			;Write a space between numbers
	CALL	WRITE_CHAR
	INC	BX			;Move to the next byte
	LOOP	HEX_LOOP		;Write 16 bytes of data

	MOV	DL,VERTICAL_BAR		;Write separator
	CALL	WRITE_CHAR
	MOV	DL,' '			;Add another space before characters
	CALL	WRITE_CHAR

	MOV	CX,16			;Now write 16 bytes of characters
	POP	BX
ASCII_LOOP:
	MOV	DL,SECTOR[BX]		;Get one byte
	CALL	WRITE_CHAR		;Display this as a character
	INC	BX			;Move to the next byte
	LOOP	ASCII_LOOP		;Display a total of 16 characters

	MOV	DL,' '			;Write a space before the box border
	CALL	WRITE_CHAR
	MOV	DL,VERTICAL_BAR		;Write the box border
	CALL	WRITE_CHAR
	
	POP	DX
	POP	CX
	POP	BX
	RET
DISP_LINE	ENDP

CODE_SEG	ENDS

	END
