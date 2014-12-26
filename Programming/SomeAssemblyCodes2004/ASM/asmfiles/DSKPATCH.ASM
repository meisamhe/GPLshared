CGROUP	GROUP	CODE_SEG, DATA_SEG
	ASSUME	CS:CGROUP, DS:CGROUP


;-----------------------------------------------------------------------;
; This file contains the main program, along with most of the variables	;
; for Dskpatch.								;
;-----------------------------------------------------------------------;


;-----------------------------------------------------------------------;
; We've declared a "dummy" copy of the code segment here to ensure that	;
; all versions of the Macro Assembler will load the CODE_SEG into	;
; memory before the DATA_SEG.  See Appendix C of Peter Norton's		;
; Assembly Language Book for more information.				;
;-----------------------------------------------------------------------;
CODE_SEG	SEGMENT PUBLIC
CODE_SEG	ENDS


DATA_SEG	SEGMENT PUBLIC

	PUBLIC	SECTOR
;-----------------------------------------------;
; The entire sector (512 bytes) is stored in	;
; this part of memory.  Since some hard disks	;
; use very large sectors, we reserve 8192 bytes	;
; here, but Dskpatch only works with 512 bytes.	;
;-----------------------------------------------;
SECTOR	DB	8192 DUP (0)

	PUBLIC	SECTOR_OFFSET
;-----------------------------------------------;
; SECTOR_OFFSET is the offset of the half-	;
; sector display into the full sector.  It must	;
; be a multiple of 16, and not greater than 256	;
;-----------------------------------------------;
SECTOR_OFFSET	DW	0

	PUBLIC	CURRENT_SECTOR_NO, DISK_DRIVE_NO
CURRENT_SECTOR_NO	DW	0		;Initially sector 0
DISK_DRIVE_NO		DB	0		;Initially Drive A:


	PUBLIC	FILE_FLAG, FILE_HANDLE, FILE_NAME
	PUBLIC	FILE_NAME_STRING
	PUBLIC	STRING_LENGTH, LENGTH_READ
;-----------------------------------------------;
; FILE_FLAG is 0 for absolute sector reads and	;
; writes.  When it's 1, reads and writes are	;
; for sectors within a file.  Then 		;
; SECTOR_OFFSET is the relative sector within	;
; the file.					;
;-----------------------------------------------;
FILE_FLAG	DB	0			;Initially absolute sectors
FILE_HANDLE	DW	0			;Handle of the opened file

FILE_NAME_STRING	LABEL	BYTE
STRING_LENGTH	DB	80			;Read up to 80 characters
LENGTH_READ	DB	?			;Number of characters read
FILE_NAME	DB	80 DUP (' ')		;Name of file being looked at


	PUBLIC	LINES_BEFORE_SECTOR, HEADER_LINE_NO
	PUBLIC	HEADER_PART_1, HEADER_PART_2, FILE_HEADER
;-----------------------------------------------;
; LINES_BEFORE_SECTOR is the number of lines	;
; at the top of the screen before the half-	;
; sector display.				;
;-----------------------------------------------;
LINES_BEFORE_SECTOR	DB	2
HEADER_LINE_NO		DB	0

HEADER_PART_1		DB	'Disk ',0
HEADER_PART_2		DB	'         Sector ',0
FILE_HEADER		DB	'      From start of: ',0

	PUBLIC	PROMPT_LINE_NO, EDITOR_PROMPT, DISK_PROMPT
	PUBLIC	SECTOR_PROMPT, FILE_NAME_PROMPT, OFFSET_PROMPT
PROMPT_LINE_NO		DB	21
EDITOR_PROMPT		DB	'Press function key, or enter'
			DB	' character or hex byte: ',0
DISK_PROMPT		DB	'Enter letter for disk drive: ',0
SECTOR_PROMPT		DB	'Enter sector dumber (decimal) to read: ',0
FILE_NAME_PROMPT	DB	'Enter file name: ',0
OFFSET_PROMPT		DB	'Enter offset from start of file: ',0

	PUBLIC	FUNCTION_KEY_LINE_NO, FUNCTION_KEY_LINE
FUNCTION_KEY_LINE_NO	DB	24
FUNCTION_KEY_LINE	DB	'1Prev.', 2 DUP(' ')
			DB	'2Next', 3 DUP(' ')
			DB	'3Drive', 2 DUP(' ')
			DB	'4Sector',' '
			DB	'5',24,'Save',2 DUP(' ')
			DB	'6File', 3 DUP(' ')
			DB	'7Offset', ' '
			DB	'8', 7 DUP(' ')
			DB	'9', 7 DUP(' ')
			DB	'0Exit', 2 DUP(' ')
			DB	0
	PUBLIC	ERROR_MESSAGE_LINE_NO
ERROR_MESSAGE_LINE_NO	DB	23
DATA_SEG	ENDS


CODE_SEG	SEGMENT PUBLIC
	ORG	100H

	EXTRN	CLEAR_SCREEN:NEAR, INIT_SEC_DISP:NEAR
	EXTRN	WRITE_PROMPT_LINE:NEAR, DISPATCHER:NEAR
	EXTRN	WRITE_FUNCTION_KEYS:NEAR
	EXTRN	GOTO_XY:NEAR, CLEAR_TO_END_OF_LINE:NEAR
	EXTRN	INIT_DISK:NEAR
	EXTRN	WRITE_EDITOR_PROMPT:NEAR
;-----------------------------------------------------------------------;
; Here is the main program for Dskpatch.  As you can see, this		;
; procedure is mostly calls to other procedures.			;
;-----------------------------------------------------------------------;
DISK_PATCH	PROC	FAR
	CALL	CLEAR_SCREEN		;Clear the entire screen
	CALL	INIT_DISK		;Setup the disk information
	CALL	WRITE_FUNCTION_KEYS	;Display the function-key line
	CALL	INIT_SEC_DISP		;Display the first part of this sector
	CALL	WRITE_EDITOR_PROMPT	;Display the Edit prompt

	CALL	DISPATCHER		;Let the dispatcher do all the work

	XOR	DL,DL			;Place cursor at bottom of screen
	MOV	DH,24
	CALL	GOTO_XY
	CALL	CLEAR_TO_END_OF_LINE	;Clear the inverse video key line
	MOV	DH,23
	CALL	GOTO_XY			;And leave cursor on line 23
	INT	20H			;Exit back to DOS
DISK_PATCH	ENDP

CODE_SEG	ENDS

	END	DISK_PATCH
