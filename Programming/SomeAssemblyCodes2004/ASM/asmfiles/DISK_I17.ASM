CGROUP	GROUP	CODE_SEG, DATA_SEG
	ASSUME	CS:CGROUP, DS:CGROUP


CODE_SEG	SEGMENT PUBLIC

	PUBLIC	READ_SECTOR
DATA_SEG	SEGMENT PUBLIC
	EXTRN	SECTOR:BYTE
	EXTRN	DISK_DRIVE_NO:BYTE
	EXTRN	CURRENT_SECTOR_NO:WORD
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure reads one sector (512 bytes) into SECTOR.		;
;									;
; Reads:	CURRENT_SECTOR_NO, DISK_DRIVE_NO			;
; Writes:	SECTOR							;
;-----------------------------------------------------------------------;
READ_SECTOR	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	MOV	AL,DISK_DRIVE_NO	;Drive number
	MOV	CX,1			;Read only 1 sector
	MOV	DX,CURRENT_SECTOR_NO	;Logical sector number
	LEA	BX,SECTOR		;Where to store this sector
	INT	25h			;Read the sector
	POPF				;Discard flags put on stack by DOS
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	RET
READ_SECTOR	ENDP

CODE_SEG	ENDS

	END
