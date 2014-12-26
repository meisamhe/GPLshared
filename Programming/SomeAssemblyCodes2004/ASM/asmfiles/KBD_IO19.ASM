CGROUP	GROUP	CODE_SEG
	ASSUME	CS:CGROUP, DS:CGROUP


CODE_SEG	SEGMENT PUBLIC
	PUBLIC	READ_BYTE
;-----------------------------------------------------------------------;
; This procedure reads a single ASCII character.  This is just		;
; a test version of READ_BYTE.						;
;									;
; Returns byte in	AL	Character code (Unless AH = 0)		;
;			AH	1 if read ASCII char			;
;				-1 if read a special key		;
;-----------------------------------------------------------------------;
READ_BYTE	PROC	NEAR
	MOV	AH,7			;Read character without echo
	INT	21h			; and place into AL
	OR	AL,AL			;Is it an extended code?
	JZ	EXTENDED_CODE		;Yes
NOT_EXTENDED:
	MOV	AH,1			;Signal normal ASCII character
DONE_READING:
	RET

EXTENDED_CODE:
	INT	21h			;Read the extended code
	MOV	AH,0FFh			;Signal extended code
	JMP	DONE_READING
READ_BYTE	ENDP

CODE_SEG	ENDS

	END
