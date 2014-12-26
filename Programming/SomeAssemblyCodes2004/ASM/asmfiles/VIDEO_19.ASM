CGROUP	GROUP	CODE_SEG, DATA_SEG	;Group two segments together
	ASSUME	CS:CGROUP, DS:CGROUP

CODE_SEG	SEGMENT PUBLIC

	PUBLIC	WRITE_HEADER
DATA_SEG	SEGMENT PUBLIC
	EXTRN	HEADER_LINE_NO:BYTE
	EXTRN	HEADER_PART_1:BYTE
	EXTRN	HEADER_PART_2:BYTE
	EXTRN	DISK_DRIVE_NO:BYTE
	EXTRN	CURRENT_SECTOR_NO:WORD
DATA_SEG	ENDS
	EXTRN	GOTO_XY:NEAR, CLEAR_TO_END_OF_LINE:NEAR
;-----------------------------------------------------------------------;
; This procedure writes the header with disk-drive and sector number.	;
;									;
; Uses:		GOTO_XY, WRITE_STRING, WRITE_CHAR, WRITE_DECIMAL	;
;		CLEAR_TO_END_OF_LINE					;
; Reads:	HEADER_LINE_NO, HEADER_PART_1, HEADER_PART_2		;
;		DISK_DRIVE_NO, CURRENT_SECTOR_NO			;
;-----------------------------------------------------------------------;
WRITE_HEADER	PROC	NEAR
	PUSH	DX
	XOR	DL,DL			;Move cursor to header line number
	MOV	DH,HEADER_LINE_NO
	CALL	GOTO_XY
	LEA	DX,HEADER_PART_1
	CALL	WRITE_STRING
	MOV	DL,DISK_DRIVE_NO
	ADD	DL,'A'			;Print drives A, B, ...
	CALL	WRITE_CHAR
	LEA	DX,HEADER_PART_2
	CALL	WRITE_STRING
	MOV	DX,CURRENT_SECTOR_NO
	CALL	WRITE_DECIMAL
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
; This procedure writest he prompt line to the screen and clears the	;
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
	MOV	DH,PROMPT_LINE_NO	; move the cursor there
	CALL	GOTO_XY
	POP	DX
	CALL	WRITE_STRING
	CALL	CLEAR_TO_END_OF_LINE
	RET
WRITE_PROMPT_LINE	ENDP


	PUBLIC	WRITE_STRING
;-----------------------------------------------------------------------;
; This procedure writes a string of characters to the screen.  The	;
; string must end with		DB	0				;
;									;
;	DS:DX	Address of the string					;
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
	OR	AL,AL			;Have we found the 0 yet?
	JZ	END_OF_STRING		;Yes, we are done with the string
	MOV	DL,AL			;No, write character
	CALL	WRITE_CHAR
	JMP	STRING_LOOP
END_OF_STRING:
	POPF				;Restore direction flag
	POP	SI
	POP	DX
	POP	AX
	RET
WRITE_STRING	ENDP

	PUBLIC	WRITE_HEX
;-----------------------------------------------------------------------;
; This procedure converts the byte in the DL register to hex and writes	;
; the two hex digits at the current cursor position.			;
;									;
;	DL	Byte to be converted to hex.				;
;									;
; Uses:		WRITE_HEX_DIGIT						;
;-----------------------------------------------------------------------;
WRITE_HEX	PROC	NEAR		;Entry point
	PUSH	CX			;Save registers used in this procedure
	PUSH	DX
	MOV	DH,DL			;Make a copy of byte
	MOV	CX,4			;Get the upper nibble in DL
	SHR	DL,CL
	CALL	WRITE_HEX_DIGIT		;Display first hex digit
	MOV	DL,DH			;Get lower nibble into DL
	AND	DL,0Fh			;Remove the upper nibble
	CALL	WRITE_HEX_DIGIT		;Display second hex digit
	POP	DX
	POP	CX
	RET
WRITE_HEX	ENDP

	PUBLIC	WRITE_HEX_DIGIT
;-----------------------------------------------------------------------;
; This procedure converts the lower 4 bits of DL to a hex digit and	;
; writes it to the screen.						;
;									;
;	DL	Lower 4 bits contain number to be printed in hex.	;
;									;
; Uses:		WRITE_CHAR						;
;-----------------------------------------------------------------------;
WRITE_HEX_DIGIT		PROC	NEAR
	PUSH	DX			;Save registers used
	CMP	DL,10			;Is this nibble <10?
	JAE	HEX_LETTER		;No, convert to a letter
	ADD	DL,"0"			;Yes, convert to a digit
	JMP	Short WRITE_DIGIT	;Now write this character
HEX_LETTER:
	ADD	DL,"A"-10		;Convert to hex letter
WRITE_DIGIT:
	CALL	WRITE_CHAR		;Display the letter on the screen
	POP	DX			;Restore old value of AX
	RET
WRITE_HEX_DIGIT		ENDP

	PUBLIC	WRITE_CHAR
	EXTRN	CURSOR_RIGHT:NEAR
;-----------------------------------------------------------------------;
; This procedure outputs a character to the screen using the ROM BIOS	;
; routines, so that characters such as the backspace are treated as	;
; any other character and are displayed.				;
;   This procedure must do a bit of work to update the cursor position.	;
;									;
;	DL	Byte to print on screen					;
;									;
; Uses:		CURSOR_RIGHT						;
;-----------------------------------------------------------------------;
WRITE_CHAR	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	MOV	AH,9			;Call for output of character/attribute
	MOV	BH,0			;Set to display page 0
	MOV	CX,1			;Write only one character
	MOV	AL,DL			;Character to write
	MOV	BL,7			;Normal attribute
	INT	10h			;Write character and attribute
	CALL	CURSOR_RIGHT		;Now move to next cursor position
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	RET
WRITE_CHAR	ENDP

	PUBLIC	WRITE_DECIMAL
;-----------------------------------------------------------------------;
; This procedure writes a 16-bit, unsigned number in decimal notation.	;
;									;
;	DX	N : 16-bit, unsigned number.				;
;									;
;-----------------------------------------------------------------------;
WRITE_DECIMAL	PROC	NEAR
	PUSH	AX			;Save registers used here
	PUSH	CX
	PUSH	DX
	PUSH	SI
	MOV	AX,DX
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
	CALL	WRITE_HEX_DIGIT
	LOOP	WRITE_DIGIT_LOOP
END_DECIMAL:
	POP	SI
	POP	DX
	POP	CX
	POP	AX
	RET
WRITE_DECIMAL	ENDP

	PUBLIC	WRITE_CHAR_N_TIMES
;-----------------------------------------------------------------------;
; This procedure writes more than one copy of a character		;
;									;
;	DL	Character code						;
;	CX	Number of times to write the character			;
;									;
; Uses:		WRITE_CHAR						;
;-----------------------------------------------------------------------;
WRITE_CHAR_N_TIMES	PROC	NEAR
	PUSH	CX
N_TIMES:
	CALL	WRITE_CHAR
	LOOP	N_TIMES
	POP	CX
	RET
WRITE_CHAR_N_TIMES	ENDP

	PUBLIC	WRITE_PATTERN
;-----------------------------------------------------------------------;
; This procedure writes a line to the screen, based on data in the	;
; form									;
;									;
;	DB	{character, number of times to write character}, 0	;
; Where {x} means that x can be repeated any number of times		;
;	DS:DX	Address of above data statement				;
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
	OR	AL,AL			;Is it the end of data (0h)?
	JZ	END_PATTERN		;Yes, return
	MOV	DL,AL			;No, set up to write character N times
	LODSB				;Get repeat count into AL
	MOV	CL,AL			;And put in CX for WRITE_CHAR_N_TIMES
	XOR	CH,CH			;Zero upper byte of CX
	CALL	WRITE_CHAR_N_TIMES
	JMP	PATTERN_LOOP
END_PATTERN:
	POPF				;Restore direction flag
	POP	SI
	POP	DX
	POP	CX
	POP	AX
	RET
WRITE_PATTERN	ENDP

CODE_SEG	ENDS

	END
