CGROUP	GROUP	CODE_SEG, DATA_SEG
	ASSUME	CS:CGROUP, DS:CGROUP


CODE_SEG	SEGMENT PUBLIC
	ORG	100h

	EXTRN	CLEAR_SCREEN:NEAR, READ_SECTOR:NEAR
	EXTRN	INIT_SEC_DISP:NEAR, WRITE_HEADER:NEAR
DISK_PATCH	PROC	NEAR
	CALL	CLEAR_SCREEN
	CALL	WRITE_HEADER
	CALL	READ_SECTOR
	CALL	INIT_SEC_DISP
	INT	20h
DISK_PATCH	ENDP

CODE_SEG	ENDS

DATA_SEG	SEGMENT PUBLIC

	PUBLIC	SECTOR_OFFSET
;-----------------------------------------------;
; SECTOR_OFFSET is the offset of the half	;
; sector display into the full sector.  It must	;
; be a multiple of 16, and not greater than 256	;
;-----------------------------------------------;
SECTOR_OFFSET	DW	0

	PUBLIC	CURRENT_SECTOR_NO, DISK_DRIVE_NO
CURRENT_SECTOR_NO	DW	0		;Initially sector 0
DISK_DRIVE_NO		DB	0		;Initially Drive A:

	PUBLIC	LINES_BEFORE_SECTOR, HEADER_LINE_NO
	PUBLIC	HEADER_PART_1, HEADER_PART_2
;-----------------------------------------------;
; LINES_BEFORE_SECTOR is the number of lines	;
; at the top of the screen before the half-	;
; sector display.				;
;-----------------------------------------------;
LINES_BEFORE_SECTOR	DB	2
HEADER_LINE_NO		DB	0
HEADER_PART_1		DB	'Disk ',0
HEADER_PART_2		DB	'         Sector ',0

	PUBLIC	SECTOR
;-----------------------------------------------;
; The entire sector (up to 8192 bytes) is	;
; stored in this part of memory.		;
;-----------------------------------------------;
SECTOR	DB	8192 DUP (0)

DATA_SEG	ENDS

	END	DISK_PATCH
