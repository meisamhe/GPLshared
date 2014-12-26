CGROUP	GROUP	CODE_SEG, DATA_SEG
	ASSUME	CS:CGROUP, DS:CGROUP


CODE_SEG	SEGMENT PUBLIC

	PUBLIC	STRING_TO_UPPER
;-----------------------------------------------------------------------;
; This procedure converts the stinrg, using the DOS format for strings,	;
; to all uppercase letters.						;
;									;
;	DS:DX	Address of string buffer				;
;-----------------------------------------------------------------------;
STRING_TO_UPPER		PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	MOV	BX,DX
	INC	BX			;Point to character count
	MOV	CL,[BX]			;Character count in 2nd byte of buffer
	XOR	CH,CH			;Clear upper byte of count
UPPER_LOOP:
	INC	BX			;Point to next character in buffer
	MOV	AL,[BX]
	CMP	AL,'a'			;See if it is a lowercase letter
	JB	NOT_LOWER		;Nope
	CMP	AL,'z'
	JA	NOT_LOWER
	ADD	AL,'A'-'a'		;Convert to uppercase letter
	MOV	[BX],AL
NOT_LOWER:
	LOOP	UPPER_LOOP
	POP	CX
	POP	BX
	POP	AX
	RET
STRING_TO_UPPER		ENDP

;-----------------------------------------------------------------------;
; This procedure converts a character from ASCII (hex) to a nibble (4	;
; bits).								;
;									;
;		AL	Character to convert				;
; Returns:	AL	Nibble						;
;		DF	Set for error, cleared otherwise		;
;-----------------------------------------------------------------------;
CONVERT_HEX_DIGIT	PROC	NEAR
	CMP	AL,'0'			;Is it a legal digit?
	JB	BAD_DIGIT		;Nope
	CMP	AL,'9'			;Not sure yet
	JA	TRY_HEX			;Might be hex digit
	SUB	AL,'0'			;Is decimal digit, convert to nibble
	CLC				;Clear the carry, no error
	RET
TRY_HEX:
	CMP	AL,'A'			;Not sure yet
	JB	BAD_DIGIT		;Not hex
	CMP	AL,'F'			;Not sure yet
	JA	BAD_DIGIT		;Not hex
	SUB	AL,'A'-10		;Is hex, convert to nibble
	CLC				;Clear the carry, no error
	RET
BAD_DIGIT:
	STC				;Set the carry, error
	RET
CONVERT_HEX_DIGIT	ENDP

	PUBLIC	HEX_TO_BYTE
;-----------------------------------------------------------------------;
; This procedure converts the two characters at DS:DX from hex to one	;
; byte.									;
;									;
;	DS:DX	Address of two characters for hex number		;
; Returns:								;
;	AL	Byte							;
;	CF	Set for error, clear if no error			;
;-----------------------------------------------------------------------;
HEX_TO_BYTE	PROC	NEAR
	PUSH	BX
	PUSH	CX
	MOV	BX,DX			;Put address in BX for indirect addr
	MOV	AL,[BX]			;Get first digit
	CALL	CONVERT_HEX_DIGIT
	JC	BAD_HEX			;Bad hex digit if carry set
	MOV	CX,4			;Now multiply by 16
	SHL	AL,CL
	MOV	AH,AL			;Retain a copy
	INC	BX			;Get second digit
	MOV	AL,[BX]
	CALL	CONVERT_HEX_DIGIT
	JC	BAD_HEX			;Bad hex digit if carry set
	OR	AL,AH			;Combine two nibbles
	CLC				;Clear carry for no error
DONE_HEX:
	POP	CX
	POP	BX
	RET
BAD_HEX:
	STC				;Set carry for error
	JMP	DONE_HEX
HEX_TO_BYTE	ENDP

;-----------------------------------------------------------------------;
; This is a simple version of READ_STRING.				;
;									;
;	DS:DX	Address of string area					;
;-----------------------------------------------------------------------;
READ_STRING	PROC	NEAR
	PUSH	AX
	MOV	AH,0Ah			;Call for buffered keyboard input
	INT	21h			;Call DOS function for buffered input
	POP	AX
	RET
READ_STRING	ENDP

	PUBLIC	READ_BYTE
;-----------------------------------------------------------------------;
; This procedure reads either a single ASCII character or a two-digit	;
; hex number.  This is just a test version of READ_BYTE.		;
;									;
; Returns byte in	AL	Character code (unless AH = 0)		;
;			AH	1 if read ASCII char			;
;				0 if no characters read			;
;				-1 if read a special key		;
;									;
; Uses:		HEX_TO_BYTE, STRING_TO_UPPER, READ_STRING		;
; Reads:	KEYBOARD_INPUT, etc.					;
; Writes:	KEYBOARD_INPUT, etc.					;
;-----------------------------------------------------------------------;
READ_BYTE	PROC	NEAR
	PUSH	DX
	MOV	CHAR_NUM_LIMIT,3	;Allow only two characters (plus Enter)
	LEA	DX,KEYBOARD_INPUT
	CALL	READ_STRING
	CMP	NUM_CHARS_READ,1	;See how many characters
	JE	ASCII_INPUT		;Just one, treat as ASCII character
	JB	NO_CHARACTERS		;Only Enter key hit
	CALL	STRING_TO_UPPER		;No, convert string to uppercase
	LEA	DX,CHARS		;Address of string to convert
	CALL	HEX_TO_BYTE		;Convert string from hex to byte
	JC	NO_CHARACTERS		;Error, so return 'no characters read'
	MOV	AH,1			;Signal read one character
DONE_READ:
	POP	DX
	RET
NO_CHARACTERS:
	XOR	AH,AH			;Set to 'no characters read'
	JMP	DONE_READ
ASCII_INPUT:
	MOV	AL,CHARS		;Load character read
	MOV	AH,1			;Signal read one character
	JMP	DONE_READ
READ_BYTE	ENDP

	PUBLIC	READ_DECIMAL
;-----------------------------------------------------------------------;
; This procedure takes the output buffer of READ_STRING and converts	;
; the string of decimal digits to a word.				;
;									;
;	AX	Word converted from decimal				;
;	CF	Set if error, clear if no error				;
;									;
; Uses:		READ_STRING						;
; Reads:	KEYBOARD_INPUT, etc.					;
; Writes:	KEYBOARD_INPUT, etc.					;
;-----------------------------------------------------------------------;
READ_DECIMAL	PROC	NEAR
	PUSH	BX
	PUSH	CX
	PUSH	DX
	MOV	CHAR_NUM_LIMIT,6	;Max number is 5 digits (65535)
	LEA	DX,KEYBOARD_INPUT
	CALL	READ_STRING
	MOV	CL,NUM_CHARS_READ	;Get number of characters read
	XOR	CH,CH			;Set upper byte of count to 0
	CMP	CL,0			;Return error if no characters read
	JLE	BAD_DECIMAL_DIGIT	;No chars read, signal error
	XOR	AX,AX			;Start with number set to 0
	XOR	BX,BX			;Start at beginning of string
CONVERT_DIGIT:
	MOV	DX,10			;Multiply number by 10
	MUL	DX			;Multiply AX by 10
	JC	BAD_DECIMAL_DIGIT	;CF set if MUL overflowed one word
	MOV	DL,CHARS[BX]		;Get the next digit
	SUB	DL,'0'			;And convert to a nibble (4 bits)
	JS	BAD_DECIMAL_DIGIT	;Bad digit if < 0
	CMP	DL,9			;Is this a bad digit?
	JA	BAD_DECIMAL_DIGIT	;Yes
	ADD	AX,DX			;No, so add it to number
	INC	BX			;Point to next character
	LOOP	CONVERT_DIGIT		;Get the next digit
DONE_DECIMAL:
	POP	DX
	POP	CX
	POP	BX
	RET
BAD_DECIMAL_DIGIT:
	STC				;Set carry to signal error
	JMP	DONE_DECIMAL
READ_DECIMAL	ENDP


CODE_SEG	ENDS

DATA_SEG	SEGMENT PUBLIC
KEYBOARD_INPUT	LABEL BYTE
CHAR_NUM_LIMIT	DB	0		;Length of input buffer
NUM_CHARS_READ	DB	0		;Number of characters read
CHARS		DB	80 DUP (0)	;A buffer for keyboard input
DATA_SEG	ENDS

	END
