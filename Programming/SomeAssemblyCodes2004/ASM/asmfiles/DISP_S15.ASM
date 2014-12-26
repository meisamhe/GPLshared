CGROUP	GROUP	CODE_SEG, DATA_SEG	;Group two segments together
	ASSUME	CS:CGROUP, DS:CGROUP

CODE_SEG	SEGMENT PUBLIC

	PUBLIC	DISP_HALF_SECTOR
	EXTRN	SEND_CRLF:NEAR
;-----------------------------------------------------------------------;
; This procedure displays half a sector (256 bytes)			;
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
	CALL	DISP_LINE
	CALL	SEND_CRLF
	ADD	DX,16
	LOOP	HALF_SECTOR
	POP	DX
	POP	CX
	RET
DISP_HALF_SECTOR	ENDP

	PUBLIC	DISP_LINE
	EXTRN	WRITE_HEX:NEAR
	EXTRN	WRITE_CHAR:NEAR
;-----------------------------------------------------------------------;
; This procedure displays one line of data, or 16 bytes, first in hex,	;
; then in ASCII.							;
;									;
;	DS:DX	Offset into sector, in bytes.				;
;									;
; Uses:		WRITE_CHAR, WRITE_HEX					;
; Reads:	SECTOR							;
;-----------------------------------------------------------------------;
DISP_LINE	PROC	NEAR
	PUSH	BX
	PUSH	CX
	PUSH	DX
	MOV	BX,DX			;Offset is more useful in BX
	MOV	CX,16			;Dump 16 bytes
	PUSH	BX			;Save the offset for ASCII_LOOP
HEX_LOOP:
	MOV	DL,SECTOR[BX]		;Get 1 byte
	CALL	WRITE_HEX		;Dump this byte in hex
	MOV	DL,' '			;Write a space between numbers
	CALL	WRITE_CHAR
	INC	BX
	LOOP	HEX_LOOP

	MOV	DL,' '			;Add another space before characters
	CALL	WRITE_CHAR
	MOV	CX,16
	POP	BX			;Get back offset into SECTOR
ASCII_LOOP:
	MOV	DL,SECTOR[BX]
	CALL	WRITE_CHAR
	INC	BX
	LOOP	ASCII_LOOP

	POP	DX
	POP	CX
	POP	BX
	RET
DISP_LINE	ENDP

CODE_SEG	ENDS


DATA_SEG	SEGMENT PUBLIC
	PUBLIC	SECTOR
SECTOR	DB	8192 DUP (0)
DATA_SEG	ENDS


	END
