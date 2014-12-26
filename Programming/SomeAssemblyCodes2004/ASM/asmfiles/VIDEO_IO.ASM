CGROUP	GROUP	CODE_SEG, DATA_SEG	;Group together two segments
	ASSUME	CS:CGROUP, DS:CGROUP

;-----------------------------------------------------------------------;
; This file contains various procedures that write to the screen:	;
;									;
; WRITE_CHAR			Writes a character on the screen	;
; WRITE_CHAR_N_TIMES		Writes N copies of one character	;
; WRITE_STRING			Writes a string to the screen		;
; WRITE_PATTERN			Writes a pattern on the screen		;
; WRITE_HEX_DIGIT		Writes a single hexadecimal digit	;
; WRITE_HEX			Writes a two-digit hex number		;
; WRITE_DECIMAL			Writes a decimal number on the screen	;
; WRITE_ATTRIBUTE_N_TIMES	Writes just the attribute to the screen	;
;									;
; WRITE_HEADER			Writes the header on the screen		;
; WRITE_PROMPT_LINE		Writes the prompt line to the screen	;
; WRITE_EDITOR_PROMPT		Displays the editor prompt		;
; WRITE_FUNCTION_KEYS		Display the function key line		;
;-----------------------------------------------------------------------;


CODE_SEG	SEGMENT PUBLIC

	PUBLIC	WRITE_CHAR
	EXTRN	CURSOR_RIGHT:NEAR
;-----------------------------------------------------------------------;
; This procedure outputs a character to the screen using the ROM BIOS	;
; routines so that characters such as backspace, etc., are treated as	;
; any other character and displayed.					;
;   This procedure must do a bit of work to update the cursor position.	;
;									;
;	DL	byte to print on screen.				;
;									;
; Uses:		CURSOR_RIGHT						;
;-----------------------------------------------------------------------;
WRITE_CHAR	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	MOV	AH,9		;Call for output of character/attribute
	MOV	BH,0		;Set to display page 0
	MOV	CX,1		;Write only one character
	MOV	AL,DL		;Character to write
	MOV	BL,7		;Normal attribute
	INT	10H		;Write character and attribute
	CALL	CURSOR_RIGHT	;Now move the cursor to the next position
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	RET
WRITE_CHAR	ENDP


	PUBLIC	WRITE_CHAR_N_TIMES
;-----------------------------------------------------------------------;
;  This procedure writes more than one copy of a character		;
;									;
;	DL	Character code						;
;	CX	Number of times to write the character			;
;									;
; Uses:		WRITE_CHAR						;
;-----------------------------------------------------------------------;
WRITE_CHAR_N_TIMES	PROC	NEAR
	PUSH	CX
N_TIMES:
	CALL	WRITE_CHAR		;Write one copy of the character
	LOOP	N_TIMES			;Keep writing for N times
	POP	CX
	RET
WRITE_CHAR_N_TIMES	ENDP


	PUBLIC	WRITE_STRING
;-----------------------------------------------------------------------;
;  This procedure writes a string of characters to the screen.  The	;
;  string must end with		DB	0				;
;									;
;	DS:DX	address of the string					;
;									;
; Uses:		WRITE_CHAR						;
;-----------------------------------------------------------------------;
WRITE_STRING	PROC	NEAR
	PUSH	AX
	PUSH	DX
	PUSH	SI
	PUSHF				;Save direction flag
	CLD				;Set direction for increment (forward)
	MOV	SI,DX			;Place address into SI for LODSB
STRING_LOOP:
	LODSB				;Get a character into the AL register
	OR	AL,AL			;Have we found the zero yet?
	JZ	END_OF_STRING		;Yes, we are done writing the string
	MOV	DL,AL			;No, write character
	CALL	WRITE_CHAR		;Write the character
	JMP	STRING_LOOP		;Read in the next character
END_OF_STRING:
	POPF				;Restore direction flag
	POP	SI
	POP	DX
	POP	AX
	RET
WRITE_STRING	ENDP


	PUBLIC	WRITE_PATTERN
;-----------------------------------------------------------------------;
;  This procedure writes a line to the screen, based on data in the	;
;  form									;
;									;
;	DB	{character, number of times to write character}, 0	;
;  Where '{x}' means that x can be repeated any number of times		;
;	DS:DX	address of above data statement				;
;									;
; Uses:		WRITE_CHAR_N_TIMES					;
;-----------------------------------------------------------------------;
WRITE_PATTERN	PROC	NEAR
	PUSH	AX
	PUSH	CX
	PUSH	DX
	PUSH	SI
	PUSHF				;Save the direction flag
	CLD				;Set direction flag for increment
	MOV	SI,DX			;Move offset into SI register for LODSB
PATTERN_LOOP:
	LODSB				;Get character data into AL
	OR	AL,AL			;Is it he end of data (0H)?
	JZ	END_PATTERN		;Yes, return
	MOV	DL,AL			;No, set up to write character N times
	LODSB				;Get the repeat count in AL
	MOV	CL,AL			;And put in CX for WRITE_CHAR_N_TIMES
	XOR	CH,CH			;Zero upper byte of CX
	CALL	WRITE_CHAR_N_TIMES	;Write N copies of this character
	JMP	PATTERN_LOOP		;Get next part of the pattern
END_PATTERN:
	POPF				;Restore direction flag
	POP	SI
	POP	DX
	POP	CX
	POP	AX
	RET
WRITE_PATTERN	ENDP


	PUBLIC	WRITE_HEX_DIGIT
;-----------------------------------------------------------------------;
; This procedure converts the lower 4 bits of DL to a hex digit and	;
; writes it to the screen.						;
;									;
;	DL	Lower 4 bits contain number to be printed in hex.	;
;									;
; Uses:		WRITE_CHAR						;
;-----------------------------------------------------------------------;
WRITE_HEX_DIGIT	PROC	NEAR
	PUSH	DX			;Save registers used
	CMP	DL,10			;Is this nibble <10?
	JAE	HEX_LETTER		;No, convert to a letter
	ADD	DL,"0"			;Yes, convert to a digit
	JMP	SHORT WRITE_DIGIT
HEX_LETTER:
	ADD	DL,"A"-10		;Convert to hex letter
WRITE_DIGIT:
	CALL	WRITE_CHAR
	POP	DX			;Restore old value of AX
	RET
WRITE_HEX_DIGIT	ENDP


	PUBLIC	WRITE_HEX
;-----------------------------------------------------------------------;
; This procedure converts the byte in the AL register to hex and writes	;
; the two hex digits at the current cursor position.			;
;									;
;	DL	byte to be converted to hex.				;
;									;
; Uses:		WRITE_HEX_DIGIT						;
;-----------------------------------------------------------------------;
WRITE_HEX	PROC	NEAR	;Entry point.
	PUSH	CX		;Save registers used in this procedure
	PUSH	DX
	MOV	DH,DL		;Make a copy of byte
	MOV	CX,4		;Get the upper nibble in DL
	SHR	DL,CL
	CALL	WRITE_HEX_DIGIT	;Convert the nibble in DL to hex and print
	MOV	DL,DH		;Get lower nibble into DL
	AND	DL,0FH
	CALL	WRITE_HEX_DIGIT
	POP	DX
	POP	CX
	RET
WRITE_HEX	ENDP


	PUBLIC	WRITE_DECIMAL
;-----------------------------------------------------------------------;
; This procedure writes a 16-bit, unsigned number in decimal notation.	;
;									;
;	DX	N : 16-bit, unsigned number				;
;									;
; Uses:		WRITE_CHAR, WRITE_HEX_DIGIT				;
;-----------------------------------------------------------------------;
WRITE_DECIMAL	PROC	NEAR
	PUSH	AX			;Save registers used here
	PUSH	CX
	PUSH	DX
	PUSH	SI
	MOV	AX,DX			;Put the number into AX
	MOV	SI,10			;Will divide by 10 using SI
	XOR	CX,CX			;Count of digits placed on stack
NON_ZERO:
	XOR	DX,DX			;Set upper word of N to 0
	DIV	SI			;Calculate N/10 and (N mod 10)
	PUSH	DX			;Push one digit onto the stack
	INC	CX			;One more digit added
	OR	AX,AX			;N = 0 yet?
	JNE	NON_ZERO		;Nope, continue
WRITE_DIGIT_LOOP:
	POP	DX			;Get the digits in reverse order
	CALL	WRITE_HEX_DIGIT		;Write a single digit
	LOOP	WRITE_DIGIT_LOOP	;Get the next digit
END_DECIMAL:
	POP	SI
	POP	DX
	POP	CX
	POP	AX
	RET
WRITE_DECIMAL	ENDP


	PUBLIC	WRITE_ATTRIBUTE_N_TIMES
	EXTRN	CURSOR_RIGHT:NEAR
;-----------------------------------------------------------------------;
; This procedure sets the attribute for N characters starting at the	;
; current cursor position.						;
;									;
;	CX	Number of characters to set attribute for		;
;	DL	New attribute for characters				;
;									;
; Uses:		CURSOR_RIGHT						;
;-----------------------------------------------------------------------;
WRITE_ATTRIBUTE_N_TIMES		PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	MOV	BL,DL			;Set attribute to new attribute
	XOR	BH,BH			;Set display page to zero
	MOV	DX,CX			;CX is used by the BIOS routines
	MOV	CX,1			;Set attribute for one character
ATTR_LOOP:
	MOV	AH,8			;Read character under cursor
	INT	10H
	MOV	AH,9			;Write attribute/character
	INT	10H
	CALL	CURSOR_RIGHT
	DEC	DX			;Set attribute for N characters?
	JNZ	ATTR_LOOP		;No, continue
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	RET
WRITE_ATTRIBUTE_N_TIMES		ENDP



	PUBLIC	WRITE_HEADER
DATA_SEG	SEGMENT PUBLIC
	EXTRN	HEADER_LINE_NO:BYTE
	EXTRN	HEADER_PART_1:BYTE
	EXTRN	HEADER_PART_2:BYTE
	EXTRN	DISK_DRIVE_NO:BYTE
	EXTRN	CURRENT_SECTOR_NO:WORD
	EXTRN	FILE_FLAG:BYTE
	EXTRN	FILE_HEADER:BYTE
	EXTRN	FILE_NAME:BYTE
DATA_SEG	ENDS
	EXTRN	GOTO_XY:NEAR, CLEAR_TO_END_OF_LINE:NEAR
;-----------------------------------------------------------------------;
;  This procedure writes the header with disk drive and sector number.	;
;									;
; Uses:		GOTO_XY, WRITE_STRING, WRITE_CHAR, WRITE_DECIMAL	;
;		CLEAR_TO_END_OF_LINE					;
; Reads:	HEADER_LINE_NO, HEADER_PART_1, HEADER_PART_2		;
;		DISK_DRIVE_NO, CURRENT_SECTOR_NO, FILE_FLAG		;
;		FILE_HEADER, FILE_NAME					;
;-----------------------------------------------------------------------;
WRITE_HEADER	PROC	NEAR
	PUSH	DX
	XOR	DL,DL			;Move cursor to header line number
	MOV	DH,HEADER_LINE_NO
	CALL	GOTO_XY

	CMP	FILE_FLAG,1		;Are we in file mode?
	JE	WRITE_OFFSET		;Yes, then don't write drive number
	LEA	DX,HEADER_PART_1	;Display "Disk "
	CALL	WRITE_STRING
	MOV	DL,DISK_DRIVE_NO	;Display the disk drive number
	ADD	DL,'A'			;Print drives A, B, ...
	CALL	WRITE_CHAR
WRITE_OFFSET:
	LEA	DX,HEADER_PART_2	;Display "     Sector "
	CALL	WRITE_STRING
	MOV	DX,CURRENT_SECTOR_NO	;Display the sector number
	CALL	WRITE_DECIMAL
	CMP	FILE_FLAG,1		;Are we in file mode?
	JNE	DONT_WRITE_FILE_HEADER	;No, then don't write the file header
	LEA	DX,FILE_HEADER		;Yes, display the file header
	CALL	WRITE_STRING
	LEA	DX,FILE_NAME		;Write the name of the file
	CALL	WRITE_STRING
DONT_WRITE_FILE_HEADER:
	CALL	CLEAR_TO_END_OF_LINE	;Clear rest of sector number
	POP	DX
	RET
WRITE_HEADER	ENDP


	PUBLIC	WRITE_PROMPT_LINE
	EXTRN	CLEAR_TO_END_OF_LINE:NEAR
	EXTRN	GOTO_XY:NEAR
DATA_SEG	SEGMENT PUBLIC
	EXTRN	PROMPT_LINE_NO:BYTE
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure writes the prompt line to the screen and clears the	;
; end of the line.							;
;									;
;	DS:DX	Address of the prompt-line message			;
;									;
; Uses:		WRITE_STRING, CLEAR_TO_END_OF_LINE, GOTO_XY		;
; Reads:	PROMPT_LINE_NO						;
;-----------------------------------------------------------------------;
WRITE_PROMPT_LINE	PROC	NEAR
	PUSH	DX
	XOR	DL,DL			;Write the prompt line and
	MOV	DH,PROMPT_LINE_NO	; the cursor there
	CALL	GOTO_XY
	POP	DX
	CALL	WRITE_STRING
	CALL	CLEAR_TO_END_OF_LINE
	RET
WRITE_PROMPT_LINE	ENDP


	PUBLIC	WRITE_EDITOR_PROMPT
DATA_SEG	SEGMENT PUBLIC
	EXTRN	EDITOR_PROMPT:BYTE
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure writes the editor prompt line.  We've defined it as	;
; a procedure since we need to switch to the Edit prompt in so many	;
; places.								;
;									;
; Uses:		WRITE_PROMPT_LINE					;
; Reads:	EDITOR_PROMPT						;
;-----------------------------------------------------------------------;
WRITE_EDITOR_PROMPT	PROC	NEAR
	PUSH	DX
	LEA	DX,EDITOR_PROMPT
	CALL	WRITE_PROMPT_LINE
	POP	DX
	RET
WRITE_EDITOR_PROMPT	ENDP


DATA_SEG	SEGMENT PUBLIC
	EXTRN	FUNCTION_KEY_LINE_NO:BYTE
	EXTRN	FUNCTION_KEY_LINE:BYTE
DATA_SEG	ENDS
	EXTRN	GOTO_XY:NEAR, CURSOR_RIGHT:NEAR
	PUBLIC	WRITE_FUNCTION_KEYS
;-----------------------------------------------------------------------;
; This procedure writes the function-key line in inverse video, with	;
; the key numbers in normal video.					;
;									;
; Uses:		GOTO_XY, WRITE_STRING, WRITE_ATTRIBUTE_N_TIMES		;
;		CURSOR_RIGHT						;
; Reads:	FUNCTION_KEY_LINE					;
;-----------------------------------------------------------------------;
WRITE_FUNCTION_KEYS	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	XOR	DL,DL			;Start a left of screen
	MOV	DH,FUNCTION_KEY_LINE_NO	;And the bottom
	CALL	GOTO_XY
	PUSH	DX			;Save start of line
	LEA	DX,FUNCTION_KEY_LINE
	CALL	WRITE_STRING
	POP	DX			;Restore start of line
	CALL	GOTO_XY			;Return to the start of this line
	MOV	AX,9			;Use as a counter
	MOV	DL,70H			;Attribute for inverse video
	MOV	CX,6			;Write 6 characters in inverse
FUNCTION_KEY_LOOP:
	CALL	CURSOR_RIGHT		;Skip over the number
	CALL	WRITE_ATTRIBUTE_N_TIMES	;Write inverse video for 6 characters
	CALL	CURSOR_RIGHT		;Skip gap
	DEC	AX			;Done yet?
	JNZ	FUNCTION_KEY_LOOP	;No, invert another word
	CALL	CURSOR_RIGHT		;Skip the last gap
	CALL	WRITE_ATTRIBUTE_N_TIMES	;Invert the 10th word
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	RET
WRITE_FUNCTION_KEYS	ENDP

CODE_SEG	ENDS

	END
