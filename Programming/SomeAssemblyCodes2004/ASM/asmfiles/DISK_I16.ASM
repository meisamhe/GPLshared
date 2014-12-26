CGROUP	GROUP	CODE_SEG, DATA_SEG
	ASSUME	CS:CGROUP, DS:CGROUP


CODE_SEG	SEGMENT PUBLIC
	ORG	100h

	EXTRN	INIT_SEC_DISP:NEAR
;-----------------------------------------------------------------------;
; This procedure reads the first sector on disk A and dumps the first	;
; half of this sector.							;
;-----------------------------------------------------------------------;
READ_SECTOR	PROC	NEAR
	MOV	AL,0			;Disk drive A (number 0)
	MOV	CX,1			;Read only 1 sector
	MOV	DX,0			;Read sector number 0
	LEA	BX,SECTOR		;Where to store this sector
	INT	25h			;Read the sector
	POPF				;Discard flags put on stack by DOS
	XOR	DX,DX			;Set offset to 0 within SECTOR
	CALL	INIT_SEC_DISP		;Dump the first half
	INT	20h			;Return to DOS
READ_SECTOR	ENDP

CODE_SEG	ENDS

DATA_SEG	SEGMENT PUBLIC
	EXTRN	SECTOR:BYTE
DATA_SEG	ENDS

	END	READ_SECTOR
