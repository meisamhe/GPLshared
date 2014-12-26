CR		EQU	13		;Carriage return
LF		EQU	10		;Line feed

CGROUP	GROUP	CODE_SEG
	ASSUME	CS:CGROUP

CODE_SEG	SEGMENT PUBLIC

	PUBLIC	SEND_CRLF
;-----------------------------------------------------------------------;
; This routine just sends a carriage return-line feed pair to the	;
; display, using the DOS routines so that scrolling will be handled	;
; correctly.								;
;-----------------------------------------------------------------------;
SEND_CRLF	PROC	NEAR
	PUSH	AX
	PUSH	DX
	MOV	AH,2
	MOV	DL,CR
	INT	21h
	MOV	DL,LF
	INT	21h
	POP	DX
	POP	AX
	RET
SEND_CRLF	ENDP

CODE_SEG	ENDS

	END
