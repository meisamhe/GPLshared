CGROUP	GROUP	CODE_SEG, DATA_SEG
	ASSUME	CS:CGROUP, DS:CGROUP


;-----------------------------------------------------------------------;
; This file contains procedures that handle the phantom cursor:		;
;									;
; WRITE_PHANTOM			Write the phantom cursor		;
; ERASE_PHANTOM			Erase the phantom cursor		;
;									;
; PHANTOM_UP			Move the phantom cursor up		;
; PHANTOM_DOWN			Move the phantom cursor down		;
; PHANTOM_LEFT			Move the phantom cursor left		;
; PHANTOM_RIGHT			Move the phantom cursor right		;
; PAGE_UP			Scroll window back by 8 lines		;
; PAGE_DOWN			Scroll window forward by 8 lines	;
; HOME_KEY			Move to the first byte in the sector	;
; END_KEY			Move to the last byte in the sector	;
;									;
; MOV_TO_HEX_POSITION		Move cursor to hex phantom cursor	;
; MOV_TO_ASCII_POSITION		Move cursor to ASCII phantom cursor	;
; MOV_TO_LEFT_NUMBERS		Move to current left number		;
; MOV_TO_TOP_HEX_NUMBERS	Move to current top hex number		;
; MOV_TO_ASCII_NUMBERS		Move to number above ASCII window	;
; SAVE_REAL_CURSOR		Remember the location of real cursor	;
; RESTORE_REAL_CURSOR		Put real cursor back where it was	;
; SCROLL_UP			Scroll the window up by N lines		;
; SCROLL_DOWN			Scroll the window down by N lines	;
; SCROLL_WINDOW			Do the actual scrolling of windows	;
; FILL_SCROLLED_LINES		Fill lines left blank by scrolling	;
;-----------------------------------------------------------------------;


DATA_SEG	SEGMENT PUBLIC
REAL_CURSOR_X		DB	0
REAL_CURSOR_Y		DB	0
	PUBLIC	PHANTOM_CURSOR_X, PHANTOM_CURSOR_Y
PHANTOM_CURSOR_X	DB	0
PHANTOM_CURSOR_Y	DB	0
DATA_SEG	ENDS


CODE_SEG	SEGMENT PUBLIC

	PUBLIC	WRITE_PHANTOM
	EXTRN	WRITE_ATTRIBUTE_N_TIMES:NEAR
;-----------------------------------------------------------------------;
; This procedure uses CURSOR_X and CURSOR_Y, through MOV_TO_..., as the	;
; coordinates for the phantom cursor.  WRITE_PHANTOM writes this	;
; phantom cursor.							;
;									;
; Uses:		WRITE_ATTRIBUTE_N_TIMES, SAVE_REAL_CURSOR		;
;		RESTORE_REAL_CURSOR, MOV_TO_HEX_POSITION		;
;		MOV_TO_ASCII_POSITION, MOV_TO_LEFT_NUMBERS		;
;		MOV_TO_TOP_HEX_NUMBERS, MOV_TO_TOP_ASCII_NUMBERS	;
;-----------------------------------------------------------------------;
WRITE_PHANTOM	PROC	NEAR
	PUSH	CX
	PUSH	DX
	CALL	SAVE_REAL_CURSOR	;Save position of the real cursor
	CALL	MOV_TO_HEX_POSITION	;Coord of cursor in hex window
	MOV	CX,4			;Make phantom cursor four chars wide
	MOV	DL,70H			;Attribute for reverse video
	CALL	WRITE_ATTRIBUTE_N_TIMES	;Write hex number in inverse video
	CALL	MOV_TO_ASCII_POSITION	;Coord. of cursor in ASCII window
	MOV	CX,1			;Cursor is one character wide here
	CALL	WRITE_ATTRIBUTE_N_TIMES	;Write ASCII character in inverse
	MOV	DL,0FH			;Attribute for high intensity
	CALL	MOV_TO_LEFT_NUMBERS	;Move to current offset on left side
	MOV	CX,5
	CALL	WRITE_ATTRIBUTE_N_TIMES	;Make current offset bright
	CALL	MOV_TO_TOP_HEX_NUMBERS	;Move to hex offset along top
	MOV	CX,4
	CALL	WRITE_ATTRIBUTE_N_TIMES	;Make current offset bright
	CALL	MOV_TO_TOP_ASCII_NUMBERS ;Move to offset above ASCII window
	MOV	CX,1
	CALL	WRITE_ATTRIBUTE_N_TIMES	;Make current offset bright
	CALL	RESTORE_REAL_CURSOR	;Put cursor back where it was
	POP	DX
	POP	CX
	RET
WRITE_PHANTOM	ENDP


	PUBLIC	ERASE_PHANTOM
	EXTRN	WRITE_ATTRIBUTE_N_TIMES:NEAR
;-----------------------------------------------------------------------;
; This procedure erases the phantom cursor, just the opposite of	;
; WRITE_PHANTOM								;
;									;
; Uses:		WRITE_ATTRIBUTE_N_TIMES, SAVE_REAL_CURSOR		;
;		RESTORE_REAL_CURSOR, MOV_TO_HEX_POSITION		;
;		MOV_TO_ASCII_POSITION, MOV_TO_LEFT_NUMBERS		;
;		MOV_TO_TOP_HEX_NUMBERS, MOV_TO_TOP_ASCII_NUMBERS	;
;-----------------------------------------------------------------------;
ERASE_PHANTOM	PROC	NEAR
	PUSH	CX
	PUSH	DX
	CALL	SAVE_REAL_CURSOR	;Remember where the cursor was
	CALL	MOV_TO_HEX_POSITION	;Coord. of cursor in hex window
	MOV	CX,4			;Make characters normal video
	MOV	DL,7			;Attribute for normal video
	CALL	WRITE_ATTRIBUTE_N_TIMES	;Make hex number normal video
	CALL	MOV_TO_ASCII_POSITION	;Move to character in ASCII window
	MOV	CX,1
	CALL	WRITE_ATTRIBUTE_N_TIMES	;Make attribute normal video
	CALL	MOV_TO_LEFT_NUMBERS	;Move to offset along left side
	MOV	CX,5
	CALL	WRITE_ATTRIBUTE_N_TIMES	;Make attribute normal video
	CALL	MOV_TO_TOP_HEX_NUMBERS	;Move to offset above hex window
	MOV	CX,4
	CALL	WRITE_ATTRIBUTE_N_TIMES	;Make attribute normal video
	CALL	MOV_TO_TOP_ASCII_NUMBERS ;Move to offset above ASCII window
	MOV	CX,1
	CALL	WRITE_ATTRIBUTE_N_TIMES	;Make attribute normal video
	CALL	RESTORE_REAL_CURSOR	;Put cursor back where it was
	POP	DX
	POP	CX
	RET
ERASE_PHANTOM	ENDP


;-----------------------------------------------------------------------;
; These four procedures move the phantom cursor.			;
;									;
; Uses:		ERASE_PHANTOM, WRITE_PHANTOM, SCROLL_DOWN, SCROLL_UP	;
; Writes:	PHANTOM_CURSOR_X, PHANTOM_CURSOR_Y			;
;-----------------------------------------------------------------------;

	PUBLIC	PHANTOM_UP
PHANTOM_UP	PROC	NEAR
	PUSH	CX
	CALL	ERASE_PHANTOM		;Erase at current position
	DEC	PHANTOM_CURSOR_Y	;Move cursor up one line
	JNS	WASNT_AT_TOP		;Was not at the top, write cursor
	MOV	PHANTOM_CURSOR_Y,0	;Was at top, so put back there
	MOV	CL,1			;Scroll by one line
	CALL	SCROLL_DOWN		;Was at the top, scroll
WASNT_AT_TOP:
	CALL	WRITE_PHANTOM		;Write the phantom at new position
	POP	CX
	RET
PHANTOM_UP	ENDP

	PUBLIC	PHANTOM_DOWN
PHANTOM_DOWN	PROC	NEAR
	PUSH	CX
	CALL	ERASE_PHANTOM		;Erase at current position
	INC	PHANTOM_CURSOR_Y	;Move cursor up one line
	CMP	PHANTOM_CURSOR_Y,16	;Was it at the bottom?
	JB	WASNT_AT_BOTTOM		;No, so write phantom
	MOV	PHANTOM_CURSOR_Y,15	;Was at bottom, so put back there
	MOV	CL,1			;Scroll by one line
	CALL	SCROLL_UP		;Was at bottom, scroll
WASNT_AT_BOTTOM:
	CALL	WRITE_PHANTOM		;Write the phantom cursor
	POP	CX
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


;-----------------------------------------------------------------------;
; These two procedures move the window 8 lines at a time.		;
;									;
; Uses:		ERASE_PHANTOM, WRITE_PHANTOM, SCROLL_DOWN (UP)		;
;-----------------------------------------------------------------------;
	PUBLIC	PAGE_UP
PAGE_UP		PROC	NEAR
	PUSH	CX
	CALL	ERASE_PHANTOM		;Remove the phantom cursor
	MOV	CL,4
	CALL	SCROLL_DOWN		;Scroll windows down by 4 lines
	CALL	WRITE_PHANTOM		;Draw the phantom cursor again
	POP	CX
	RET
PAGE_UP		ENDP


	PUBLIC	PAGE_DOWN
PAGE_DOWN	PROC	NEAR
	PUSH	CX
	CALL	ERASE_PHANTOM		;Remove the phantom cursor
	MOV	CL,4
	CALL	SCROLL_UP		;Scroll windows up by 4 lines
	CALL	WRITE_PHANTOM		;Draw the phantom cursor again
	POP	CX
	RET
PAGE_DOWN	ENDP


;-----------------------------------------------------------------------;
; These two procedures move the cursor to the end and beginning of the	;
; sector.								;
;									;
; Uses:		ERASE_PHANTOM, WRITE_PHANTOM, SCROLL_DOWN (UP)		;
; Writes:	PHANTOM_CURSOR_X, PHANTOM_CURSOR_Y			;
;-----------------------------------------------------------------------;
	PUBLIC	HOME_KEY
HOME_KEY	PROC	NEAR
	PUSH	CX
	CALL	ERASE_PHANTOM		;First remove the phantom cursor
	MOV	CL,16			;Now scroll down by 16 lines to move
	CALL	SCROLL_DOWN		;  to the beginning of the sector
	XOR	CL,CL			;Now reset the cursor to (0,0)
	MOV	PHANTOM_CURSOR_X,CL	;Save the new phantom cursor position
	MOV	PHANTOM_CURSOR_Y,CL
	CALL	WRITE_PHANTOM		;and write phantom cursor at (0,0)
	POP	CX
	RET
HOME_KEY	ENDP


	PUBLIC	END_KEY
END_KEY		PROC	NEAR
	PUSH	CX
	CALL	ERASE_PHANTOM		;First remove the phantom cursor
	MOV	CL,16			;Now scroll down by 16 lines to move
	CALL	SCROLL_UP		; to the end of the sector
	MOV	CL,15
	MOV	PHANTOM_CURSOR_X,CL	;Save the new phantom cursor position
	MOV	PHANTOM_CURSOR_Y,CL
	CALL	WRITE_PHANTOM		;And write phantom cursor at (15,15)
	POP	CX
	RET
END_KEY		ENDP


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
	CALL	GOTO_XY			;for phantom cursor.
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
	MOV	DH,LINES_BEFORE_SECTOR	;Find row for phantom (0,0)
	ADD	DH,2			;Plus row of hex and horizontal bar
	ADD	DH,PHANTOM_CURSOR_Y	;DH = row of phantom cursor
	MOV	DL,59			;Indent on left side
	ADD	DL,PHANTOM_CURSOR_X	;Add CURSOR_X to get X position
	CALL	GOTO_XY			; for phantom cursor.
	POP	DX
	POP	AX
	RET
MOV_TO_ASCII_POSITION	ENDP


	PUBLIC	MOV_TO_LEFT_NUMBERS
	EXTRN	GOTO_XY:NEAR
DATA_SEG	SEGMENT PUBLIC
	EXTRN	LINES_BEFORE_SECTOR:BYTE
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure moves the real cursor to the hex offset number to the	;
; left of the half-sector display.					;
;									;
; Uses:		GOTO_XY							;
; Reads:	LINES_BEFORE_SECTOR					;
;-----------------------------------------------------------------------;
MOV_TO_LEFT_NUMBERS	PROC	NEAR
	PUSH	AX
	PUSH	DX
	MOV	DH,LINES_BEFORE_SECTOR	;Find row of phantom (0,0)
	ADD	DH,2			;Plus row of hex and horizontal bar
	ADD	DH,PHANTOM_CURSOR_Y	;DH = row of phantom cursor
	MOV	DL,2			;Indent of left side
	CALL	GOTO_XY
	POP	DX
	POP	AX
	RET
MOV_TO_LEFT_NUMBERS	ENDP


	PUBLIC	MOV_TO_TOP_HEX_NUMBERS
	EXTRN	GOTO_XY:NEAR, READ_CURSOR_POSITION:NEAR
DATA_SEG	SEGMENT PUBLIC
	EXTRN	LINES_BEFORE_SECTOR:BYTE
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure moves the real cursor to the hex offset number above	;
; the hex window.							;
;									;
; Uses:		MOV_TO_HEX_POSITION, READ_CURSOR_POSITION, GOTO_XY	;
; Reads:	LINES_BEFORE_SECTOR					;
;-----------------------------------------------------------------------;
MOV_TO_TOP_HEX_NUMBERS	PROC	NEAR
	PUSH	DX
	CALL	MOV_TO_HEX_POSITION	;Get to proper column
	CALL	READ_CURSOR_POSITION	;Now read cursor position
	MOV	DH,LINES_BEFORE_SECTOR	;Move up to line with numbers
	CALL	GOTO_XY
	POP	DX
	RET
MOV_TO_TOP_HEX_NUMBERS	ENDP


	PUBLIC	MOV_TO_TOP_ASCII_NUMBERS
DATA_SEG	SEGMENT PUBLIC
	EXTRN	LINES_BEFORE_SECTOR:BYTE
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure moves to the hex offset number at the top of the	;
; ASCII window.								;
;									;
; Uses:		MOV_TO_ASCII_POSITION, READ_CURSOR_POSITION, GOTO_XY	;
; Reads:	LINES_BEFORE_SECTOR					;
;-----------------------------------------------------------------------;
MOV_TO_TOP_ASCII_NUMBERS	PROC	NEAR
	PUSH	DX
	CALL	MOV_TO_ASCII_POSITION	;Get to proper column
	CALL	READ_CURSOR_POSITION	;Now read cursor position
	MOV	DH,LINES_BEFORE_SECTOR	;Move up to line with numbers
	CALL	GOTO_XY
	POP	DX
	RET
MOV_TO_TOP_ASCII_NUMBERS	ENDP


	PUBLIC	SAVE_REAL_CURSOR
;-----------------------------------------------------------------------;
; This procedures saves the position of the real cursor in the two	;
; variables REAL_CURSOR_X and REAL_CURSOR_Y				;
;									;
; Uses:		READ_CURSOR_POSITION					;
; Writes:	REAL_CURSOR_X, REAL_CURSOR_Y				;
;-----------------------------------------------------------------------;
SAVE_REAL_CURSOR	PROC	NEAR
	PUSH	DX
	CALL	READ_CURSOR_POSITION	;Read cursor position
	MOV	REAL_CURSOR_Y,DL	;Save position
	MOV	REAL_CURSOR_X,DH
	POP	DX
	RET
SAVE_REAL_CURSOR	ENDP


	PUBLIC	RESTORE_REAL_CURSOR
	EXTRN	GOTO_XY:NEAR
;-----------------------------------------------------------------------;
; This procedure restores the real cursor to its old position, saved in	;
; REAL_CURSOR_X and REAL_CURSOR_Y					;
;									;
; Uses:		GOTO_XY							;
; Reads:	REAL_CURSOR_X, REAL_CURSOR_Y				;
;-----------------------------------------------------------------------;
RESTORE_REAL_CURSOR	PROC	NEAR
	PUSH	DX
	MOV	DL,REAL_CURSOR_Y	;Get the old cursor position
	MOV	DH,REAL_CURSOR_X
	CALL	GOTO_XY			;Move the cursor back there
	POP	DX
	RET
RESTORE_REAL_CURSOR	ENDP


	PUBLIC	SCROLL_UP
DATA_SEG	SEGMENT PUBLIC
	EXTRN	SECTOR_OFFSET:WORD
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure scrolls the sector display, leaving blank lines at	;
; the bottom of the display.  SCROLL_UP uses SECTOR_OFFSET to determine	;
; how many lines it can scroll without moving past the end of the half-	;
; sector display.							;
;									;
;	CL	Number of lines to scroll by.				;
;									;
; Uses:		SCROLL_WINDOW, FILL_SCROLLED_LINES			;
; Reads:	SECTOR_OFFSET						;
; Writes:	SECTOR_OFFSET						;
;-----------------------------------------------------------------------;
SCROLL_UP	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	MOV	AL,CL			;Move scroll count; we need to use CL
	MOV	BX,SECTOR_OFFSET	;See where we are in the buffer
	MOV	CL,4			;divide by 16 to get number of lines
	SHR	BX,CL			;  offset into the half-sector
	ADD	BL,AL			;See if we have enough room to scroll
	CMP	BL,16			;Enough room?
	JBE	CAN_SCROLL_UP		;Yes, scroll up by AL lines
	SUB	BL,16			;Number of extra lines we can't scroll
	SUB	AL,BL			;Total number of lines we can scroll
	JLE	DONT_SCROLL		;Don't scroll if this is zero
CAN_SCROLL_UP:
	MOV	BL,AL			;Adjust the SECTOR_OFFSET
	XOR	BH,BH			;BX contains num of lines scrolled
	MOV	CL,4
	SHL	BX,CL			;Number of bytes scrolled
	ADD	BX,SECTOR_OFFSET	;New sector offset
	MOV	SECTOR_OFFSET,BX
	MOV	CL,AL			;Mov scroll count into CL
	MOV	AL,6			;Call for scroll up
	CALL	SCROLL_WINDOW
	MOV	DL,16			;(16 - scroll count) = first blank
	SUB	DL,CL			;  blank line
	CALL	FILL_SCROLLED_LINES

DONT_SCROLL:
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	RET
SCROLL_UP	ENDP


	PUBLIC	SCROLL_DOWN
DATA_SEG	SEGMENT PUBLIC
	EXTRN	SECTOR_OFFSET:WORD
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure scrolls the sector display, leaving blank lines at	;
; the top of the display.  SCROLL_UP uses SECTOR_OFFSET to determine	;
; how many lines it can scroll without moving past the top of the half-	;
; sector display.							;
;									;
;	CL	Number of lines to scroll by.				;
;									;
; Uses:		SCROLL_WINDOW, FILL_SCROLLED_LINES			;
; Reads:	SECTOR_OFFSET						;
; Writes:	SECTOR_OFFSET						;
;-----------------------------------------------------------------------;
SCROLL_DOWN	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	MOV	AL,CL			;Move scroll count; we need to use CL
	MOV	BX,SECTOR_OFFSET	;See where we are in the buffer
	MOV	CL,4			;divide by 16 to get number of lines
	SHR	BX,CL			;  offset into the half-sector
	SUB	BL,AL			;See if we have enough room to scroll
	JNS	CAN_SCROLL_DOWN		;Yes, we can scroll down
	ADD	AL,BL			;Total number of lines we can scroll
	JZ	DONT_SCROLL		;Don't scroll if zero
CAN_SCROLL_DOWN:
	MOV	BL,AL			;Adjust the SECTOR_OFFSET
	XOR	BH,BH			;BX contains num of lines scrolled
	MOV	CL,4
	SHL	BX,CL			;Number of bytes scrolled
	SUB	BX,SECTOR_OFFSET	;New sector offset
	NEG	BX
	MOV	SECTOR_OFFSET,BX
	MOV	CL,AL			;Mov scroll count into CL
	MOV	AL,7			;Call for scroll up
	CALL	SCROLL_WINDOW
	MOV	DL,0			;First blank line
	CALL	FILL_SCROLLED_LINES
	JMP	DONT_SCROLL
SCROLL_DOWN	ENDP


	PUBLIC	SCROLL_WINDOW
DATA_SEG	SEGMENT PUBLIC
	EXTRN	LINES_BEFORE_SECTOR:BYTE
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure scrolls the half-sector display.			;
;									;
;	AL	6 for scroll up, 7 for scroll down.			;
;	CL	Number of lines to scroll				;
;									;
; Reads:	LINES_BEFORE_SECTOR					;
;-----------------------------------------------------------------------;
SCROLL_WINDOW	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	MOV	AH,AL			;Put 6 or 7 into AH register
	MOV	AL,CL			;Place scroll count into AL
	CMP	AL,15			;Should we blank entire window?
	JBE	DONT_BLANK		;No, continue.
	XOR	AL,AL			;Yes, set scroll count to 0
DONT_BLANK:
	MOV	CH,LINES_BEFORE_SECTOR	;Top row
	ADD	CH,2
	MOV	DH,CH			;Bottom row
	ADD	DH,15

	XOR	CL,CL			;Left column
	MOV	DL,6			;Right column
	MOV	BH,7			;Normal attribute for blank lines
	PUSH	AX
	INT	10h			;Scroll offset numbers on left side
	POP	AX

	MOV	CL,8			;Left side of the hex window
	MOV	DL,56			;Right side of the hex window
	PUSH	AX
	INT	10h			;Scroll the hex window
	POP	AX

	MOV	CL,58			;Left side of the ASCII window
	MOV	DL,75			;Right side of the ASCII window
	PUSH	AX
	INT	10h			;Scroll the ASCII window
	POP	AX

	POP	DX
	POP	CX
	POP	BX
	POP	AX
	RET
SCROLL_WINDOW	ENDP


	PUBLIC	FILL_SCROLLED_LINES
	EXTRN	DISP_LINE:NEAR, SEND_CRLF:NEAR
	EXTRN	GOTO_XY:NEAR
DATA_SEG	SEGMENT PUBLIC
	EXTRN	SECTOR_OFFSET:WORD
	EXTRN	LINES_BEFORE_SECTOR:BYTE
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure fills in the lines blanked by scrolling.		;
;									;
;	CL	Number of lines scrolled				;
;	DL	First line to fill in					;
;									;
; Uses:		DISP_LINE, SEND_CRLF, GOTO_XY				;
;		SAVE_REAL_CURSOR, RESTORE_REAL_CURSOR			;
; Reads:	LINES_BEFORE_SECTOR, SECTOR_OFFSET			;
;-----------------------------------------------------------------------;
FILL_SCROLLED_LINES	PROC	NEAR
	PUSH	CX
	PUSH	DX
	CALL	SAVE_REAL_CURSOR	;Remember where cursor was
	MOV	DH,LINES_BEFORE_SECTOR	;Calculate the first row
	ADD	DH,2			;Row of first line in sector display
	ADD	DH,DL			;Row of first line to fill
	XOR	DL,DL
	CALL	GOTO_XY			;Move cursor to start of row
	POP	DX			;Restore DX
	PUSH	DX
	XOR	DH,DH			;DX -- first line to fill in (0..15)
	PUSH	CX
	MOV	CL,4
	SHL	DX,CL			;Number of bytes from start of display
	POP	CX
	ADD	DX,SECTOR_OFFSET	;Starting byte.
FILL_LINE_LOOP:
	CALL	DISP_LINE		;Display one line
	CALL	SEND_CRLF		;Move to start of next line
	ADD	DX,16			;Move to next line in SECTOR
	LOOP	FILL_LINE_LOOP		;Keep filling empty lines
	CALL	RESTORE_REAL_CURSOR	;Put cursor back where it was
	POP	DX
	POP	CX
	RET
FILL_SCROLLED_LINES	ENDP

CODE_SEG	ENDS

	END
