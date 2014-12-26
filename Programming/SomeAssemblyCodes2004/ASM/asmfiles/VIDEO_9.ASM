CODE_SEG	SEGMENT
	ASSUME	CS:CODE_SEG
	ORG	100h

TEST_WRITE_HEX	PROC	NEAR
	MOV	DL,3Fh			;Test with 3Fh
	CALL	WRITE_HEX
	INT	20h
TEST_WRITE_HEX	ENDP

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
;-----------------------------------------------------------------------;
; This procedure prints a character on the screen using the DOS		;
; function call.							;
;									;
;	DL	Byte to print on screen.				;
;-----------------------------------------------------------------------;
WRITE_CHAR	PROC	NEAR
	PUSH	AX
	MOV	AH,2			;Call for character output
	INT	21h			;Output character in DL register
	POP	AX			;Restore old value in AX
	RET				;And return
WRITE_CHAR	ENDP

CODE_SEG	ENDS

	END	TEST_WRITE_HEX
