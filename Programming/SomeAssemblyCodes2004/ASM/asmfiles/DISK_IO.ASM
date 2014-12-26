CGROUP	GROUP	CODE_SEG, DATA_SEG
	ASSUME	CS:CGROUP, DS:CGROUP


;-----------------------------------------------------------------------;
; This file contains the procedures to handle disk I/O, such as reading	;
; and writing a disk sector.  It also contains procedures that handle	;
; reading and writing of sectors within a file.				;
;									;
; One word of caution.  As with the version in the book, Dskpatch	;
; assumes that sectors are 512 bytes.  If your machine uses longer	;
; sectors, you may want to modify Dskpatch so that it handles longer	;
; sectors.  In any case, the procedures that read and write file	;
; "sectors" are not dependent on the actual sector size.		;
;									;
; Here is a list of procedure in this file:				;
;									;
; INIT_DISK			Initializes variables, etc.		;
; TRAP_DISK_ERRORS		Handles disk errors for file functions	;
; WRITE_IO_ERROR		Writes or clears the error message	;
; WRITE_ERROR_MESSAGE		Writes an error message on screen	;
; CLEAR_ERROR_MESSAGE		Clears the last error message		;
; READ_SECTOR			Read logical or file sector		;
; READ_LOGICAL_SECTOR		Read a logical disk sector		;
; WRITE_SECTOR			Write logical or file sector		;
; WRITE_LOGICAL_SECTOR		Writes a logical sector to the disk	;
; PREVIOUS_SECTOR		Read the previous sector from disk/file	;
; NEXT_SECTOR			Read the next sector from disk/file	;
; CHANGE_DISK_DRIVE		Change to a different disk drive	;
; READ_SECTOR_NUMBER		Change to a sector, by number		;
; OPEN_NEW_FILE			Open a file for reading and writing	;
; READ_FILE_NAME		Read the name of the file to open	;
; OPEN_FILE			Actually open the file			;
; QUIT_FILE_MODE		Closes the open file			;
; READ_OFFSET_NUMBER		Ask for the sector number within a file	;
; READ_FILE_SECTOR		Actually read a sector from the file	;
; SET_FILE_POINTER		Move to the start of a sector in file	;
; WRITE_FILE_SECTOR		Writes a file's sector back to the disk	;
;-----------------------------------------------------------------------;


CODE_SEG	SEGMENT PUBLIC

	public	disk_error_flag, disk_error_code
DISK_ERROR_FLAG		DB	0	;Used to keep track of errors
DISK_ERROR_CODE		DB	0	;Error code from disk operation

DATA_SEG	SEGMENT PUBLIC
	EXTRN	ERROR_MESSAGE_LINE_NO:BYTE

ERROR_CODE_TABLE	LABEL	WORD
	DW	OFFSET CGROUP:ERROR_0
	DW	OFFSET CGROUP:ERROR_1
	DW	OFFSET CGROUP:ERROR_2
	DW	OFFSET CGROUP:ERROR_3
	DW	OFFSET CGROUP:ERROR_4
	DW	OFFSET CGROUP:ERROR_5
	DW	OFFSET CGROUP:ERROR_6
	DW	OFFSET CGROUP:ERROR_7
	DW	OFFSET CGROUP:ERROR_8
	DW	OFFSET CGROUP:ERROR_9
	DW	OFFSET CGROUP:ERROR_A
	DW	OFFSET CGROUP:ERROR_B
	DW	OFFSET CGROUP:ERROR_C
	DW	OFFSET CGROUP:ERROR_D	;Used by File I/O procedure
	DW	OFFSET CGROUP:ERROR_E	;Used by File I/O procedure
	DW	OFFSET CGROUP:ERROR_F	;Used by READ_FILE_SECTOR
	DW	OFFSET CGROUP:ERROR_10	;Used by FILE_WRITE_SECTOR

ERROR_0		DB	'Write attempt on write-protected diskette',0
ERROR_1		DB	'Unknown unit',0
ERROR_2		DB	'Drive not ready',0
ERROR_3		DB	'Unknown command',0
ERROR_4		DB	'Data error (CRC)',0
ERROR_5		DB	'Bad request structure length',0
ERROR_6		DB	'Seek error',0
ERROR_7		DB	'Unknown media type',0
ERROR_8		DB	'Sector not found',0
ERROR_9		DB	'Printer out of paper',0
ERROR_A		DB	'Write fault',0
ERROR_B		DB	'Read fault',0
ERROR_C		DB	'General failure',0
ERROR_D		DB	'Error reading file',0	;Used by File I/O procedures
ERROR_E		DB	'File not found',0	;Used by File I/O procedures
ERROR_F		DB	'Read past end of file',0	;Used by READ_FILE_S...
ERROR_10	DB	'No room on disk',0	;Used by WRITE_FILE_SECTOR

READING_MESSAGE	DB	' Reading...',0
WRITING_MESSAGE	DB	' Writing...',0
PRESS_KEY	DB	'Press any key to continue... ',0

BYTES_READ	DW	?		;Bytes read by READ_FILE_SECTOR
DATA_SEG	ENDS


	PUBLIC	INIT_DISK
DATA_SEG	SEGMENT PUBLIC
	EXTRN	DISK_DRIVE_NO:BYTE
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure initializes several things that Disk Patch needs to	;
; function properly:							;
;									;
;	1.  It sets DISK_DRIVE_NO to the number of the current drive,	;
;	    rather than simply drive A:.  This is useful if you start	;
;	    Dskpatch from a hard disk with no floppy disk in the drive.	;
;									;
;	2.  It tells DOS to call TRAP_DISK_ERRORS whenever there is a	;
;	    disk error and we're reading a file.  We use this so that	;
;	    we can report disk errors.					;
;									;
; Writes:	DISK_DRIVE_NO						;
;-----------------------------------------------------------------------;
INIT_DISK	PROC	NEAR
	MOV	AH,19h			;Ask DOS for the disk drive number
	INT	21h
	MOV	DISK_DRIVE_NO,AL	;Save this drive number

	MOV	AL,24H			;Set INT 24H (ERROR) vector
	MOV	AH,25H			;Set vector function
	LEA	DX,TRAP_DISK_ERRORS
	INT	21H

	RET
INIT_DISK	ENDP


	PUBLIC	TRAP_DISK_ERRORS
;-----------------------------------------------------------------------;
; DOS calls this procedure in case of INT 21h errors using an INT 24h	;
; call.									;
;									;
; This procedure saves the error code in DISK_ERROR_CODE, then returns	;
; to DOS with AL set to 0.  This tells DOS to "ignore" the error.	;
; Dskpatch checks the error flag for errors after making INT 21h calls.	;
;									;
; Writes:	DISK_ERROR_FLAG, DISK_ERROR_CODE			;
;-----------------------------------------------------------------------;
TRAP_DISK_ERRORS	PROC	FAR
	PUSH	AX
	MOV	AX,DI			;Get error code into AL
	MOV	CS:DISK_ERROR_FLAG,1	;Set the error flag
	MOV	CS:DISK_ERROR_CODE,AL	;Save this disk error code
	POP	AX
	MOV	AL,0			;Tell DOS to ignore this error
	IRET				;Let DOS return to Dskpatch
TRAP_DISK_ERRORS	ENDP



	PUBLIC	WRITE_IO_ERROR
;-----------------------------------------------------------------------;
; This procedure writes an error message to the error message line.	;
;									;
; Uses:		WRITE_ERROR_MESSAGE, CLEAR_ERROR_MESSAGE		;
; Reads:	DISK_ERROR_FLAG, DISK_ERROR_CODE, ERROR_CODE_TABLE	;
;-----------------------------------------------------------------------;
WRITE_IO_ERROR	PROC	NEAR
	PUSH	BX
	PUSH	DX

	CMP	DISK_ERROR_FLAG,1	;Was there an error?
	JE	WRITE_MESSAGE		;Yes, then write the message
	CALL	CLEAR_ERROR_MESSAGE	;No, then clear the message
	JMP	DONE_WRITE_IO_ERROR	;We're all done here
WRITE_MESSAGE:
	MOV	BL,DISK_ERROR_CODE	;Get the error code
	XOR	BH,BH			;Convert to a word
	SHL	BX,1			;Multiply by 2 for word look-up
	MOV	DX,ERROR_CODE_TABLE[BX]	;Get address of error message
	CALL	WRITE_ERROR_MESSAGE	;Display the error message

DONE_WRITE_IO_ERROR:
	POP	DX
	POP	BX
	RET
WRITE_IO_ERROR	ENDP


	PUBLIC	WRITE_ERROR_MESSAGE
	EXTRN	GOTO_XY:NEAR
	EXTRN	WRITE_STRING:NEAR
	EXTRN	CLEAR_TO_END_OF_LINE:NEAR
	EXTRN	WRITE_ATTRIBUTE_N_TIMES:NEAR
;-----------------------------------------------------------------------;
; This procedure writes an error message in the message area near the	;
; bottom of the screen.							;
;									;
;	DS:DX		Address of the error message			;
;									;
; Uses:		GOTO_XY, WRITE_STRING, CLEAR_TO_END_OF_LINE		;
;		WRITE_ATTRIBUTE_N_TIMES					;
; Reads:	ERROR_MESSAGE_LINE_NO					;
;-----------------------------------------------------------------------;
WRITE_ERROR_MESSAGE	PROC	NEAR
	PUSH	CX
	PUSH	DX
	MOV	CX,DX			;Put the string address into CX
	MOV	DH,ERROR_MESSAGE_LINE_NO	;Get the line number
	MOV	DL,30			;Indent message 30 spaces
	CALL	GOTO_XY			;Move cursor to start of the message
	XCHG	CX,DX			;Put the string address back into DX
	CALL	WRITE_STRING		;Write the string here
	CALL	CLEAR_TO_END_OF_LINE	;Then clear the rest of the line
	XCHG	CX,DX			;Put the coordinates back into DX
	CALL	GOTO_XY			;Move to the start of the message
	MOV	DL,0Fh			;High-intensity attribute
	MOV	CX,49			;Set the entire line to bright
	CALL	WRITE_ATTRIBUTE_N_TIMES
	POP	DX
	POP	CX
	RET
WRITE_ERROR_MESSAGE	ENDP


	PUBLIC	CLEAR_ERROR_MESSAGE
	EXTRN	GOTO_XY:NEAR
	EXTRN	CLEAR_TO_END_OF_LINE:NEAR
;-----------------------------------------------------------------------;
; This procedure clears the error message which appears after a disk	;
; error.								;
;									;
; Uses:		GOTO_XY, CLEAR_TO_END_OF_LINE				;
; Reads:	ERROR_MESSAGE_LINE_NO					;
;-----------------------------------------------------------------------;
CLEAR_ERROR_MESSAGE	PROC	NEAR
	PUSH	DX
	MOV	DH,ERROR_MESSAGE_LINE_NO ;Get the line number for the error
	XOR	DL,DL			;Start of the message line
	CALL	GOTO_XY			;Move to start of error message line
	CALL	CLEAR_TO_END_OF_LINE	;Clear the entire line
	POP	DX
	RET
CLEAR_ERROR_MESSAGE	ENDP


	PUBLIC	READ_SECTOR
DATA_SEG	SEGMENT PUBLIC
	EXTRN	DISK_DRIVE_NO:BYTE
	EXTRN	CURRENT_SECTOR_NO:WORD
	EXTRN	FILE_FLAG:BYTE
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
;  This procedure reads one sector (512 bytes) into SECTOR.		;
;									;
; Uses:		CLEAR_SECTOR, READ_LOGICAL_SECTOR, READ_FILE_SECTOR	;
;		WRITE_IO_ERROR						;
; Reads:	DISK_ERROR_FLAG, FILE_FLAG				;
; Writes:	DISK_ERROR_FLAG						;
;-----------------------------------------------------------------------;
READ_SECTOR	PROC	NEAR
	MOV	DISK_ERROR_FLAG,0	;Clear the disk error flag before read
	CALL	CLEAR_SECTOR		;Clear the sector before we start

	CMP	FILE_FLAG,1		;Are we in file mode?
	JE	FILE_READ		;Yes, then read sector from file
	CALL	READ_LOGICAL_SECTOR	;No, read a logical disk sector
	JMP	JUST_READ_SECTOR	;Now check for errors
FILE_READ:
	CALL	READ_FILE_SECTOR	;Read a sector from the file

JUST_READ_SECTOR:
	CMP	DISK_ERROR_FLAG,1	;Was there a disk error?
	JNE	DONE_READ_SECTOR	;No, then we're all done
	CALL	CLEAR_SECTOR		;Yes, then clear SECTOR
DONE_READ_SECTOR:
	CALL	WRITE_IO_ERROR		;Write or clear error message
	RET
READ_SECTOR	ENDP


	PUBLIC	CLEAR_SECTOR
DATA_SEG	SEGMENT PUBLIC
	EXTRN	SECTOR:BYTE
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure sets SECTOR to all 0s.  Call this procedure before	;
; you try a read a sector so that the sector will be all 0s if there	;
; is an error.								;
;									;
; Writes:	SECTOR							;
;-----------------------------------------------------------------------;
CLEAR_SECTOR	PROC	NEAR
	PUSH	AX			;Clear SECTOR to all 0s
	PUSH	CX
	PUSH	DI
	LEA	DI,SECTOR		;Point to the sector buffer
	MOV	CX,512			;Number of bytes in one sector
	CLD				;Set direction for increment
	MOV	AL,0			;Store zeros in SECTOR
REP	STOSB				;Clear SECTOR
	POP	DI
	POP	CX
	POP	AX
	RET
CLEAR_SECTOR	ENDP


	PUBLIC	READ_LOGICAL_SECTOR
DATA_SEG	SEGMENT PUBLIC
	EXTRN	DISK_DRIVE_NO:BYTE
	EXTRN	CURRENT_SECTOR_NO:WORD
	EXTRN	SECTOR:BYTE
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure reads a logical sector from the disk, using the DOS	;
; function 25h.								;
;									;
; Reads:	DISK_DRIVE_NO, CURRENT_SECTOR_NO			;
; Writes:	SECTOR, DISK_ERROR_FLAG, DISK_ERROR_CODE		;
;-----------------------------------------------------------------------;
READ_LOGICAL_SECTOR	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	MOV	AL,DISK_DRIVE_NO	;Drive number
	MOV	CX,1			;Read only 1 sector
	MOV	DX,CURRENT_SECTOR_NO	;Logical sector number
	LEA	BX,SECTOR		;Where to store this sector
	INT	25h			;Read the sector
	JNC	READ_LOGICAL_NO_ERROR	;There wasn't an error, continue
	MOV	DISK_ERROR_FLAG,1	;Set the error flag
	MOV	DISK_ERROR_CODE,AL	;And save the error code
READ_LOGICAL_NO_ERROR:
	POPF				;Discard flags put on stack by INT 25h
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	RET
READ_LOGICAL_SECTOR	ENDP


	PUBLIC	WRITE_SECTOR
	EXTRN	WRITE_STRING:NEAR, WRITE_PROMPT_LINE:NEAR
DATA_SEG	SEGMENT PUBLIC
	EXTRN	FILE_FLAG:BYTE
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure writes a sector back to the disk.  Note, if the last	;
; read resulted in an error (in which case the error flag will still	;
; be set) this procedure does nothing.					;
;									;
; Uses:		WRITE_IO_ERROR, WRITE_STRING, WRITE_EDITOR_PROMPT	;
;		WRITE_LOGICAL_SECTOR, WRITE_FILE_SECTOR			;
; Reads:	FILE_FLAG, WRITING_MESSAGE, DISK_ERROR_FLAG		;
;-----------------------------------------------------------------------;
WRITE_SECTOR	PROC	NEAR
	PUSH	AX
	CMP	DISK_ERROR_FLAG,0	;Was there a disk error?
	JNE	DONT_WRITE_SECTOR	;Yes, then don't write a sector

	LEA	DX,WRITING_MESSAGE	;Provide feedback while we write
	CALL	WRITE_STRING

	CMP	FILE_FLAG,1		;Are we in file mode?
	JE	FILE_WRITE		;Yes, then write sector to file
	CALL	WRITE_LOGICAL_SECTOR	;No, write a logical disk sector
	JMP	JUST_WROTE_SECTOR	;Now check for errors
FILE_WRITE:
	CALL	WRITE_FILE_SECTOR	;Write a sector to the file

JUST_WROTE_SECTOR:
	CMP	DISK_ERROR_FLAG,1	;Was there a disk error?
	JE	WRITE_SECTOR_ERROR	;Yes, then report it

DONE_WRITE_SECTOR:
	CALL	WRITE_IO_ERROR		;Write or clear error message
	CALL	WRITE_EDITOR_PROMPT
DONT_WRITE_SECTOR:
	POP	AX
	RET

WRITE_SECTOR_ERROR:
	CALL	WRITE_IO_ERROR		;Display the error message
	LEA	DX,PRESS_KEY		;Display "Press any key..." message
	CALL	WRITE_PROMPT_LINE	;Display this prompt
	CALL	READ_CHAR		;And read a character
	MOV	DISK_ERROR_FLAG,0	;Clear the error flag
	JMP	DONE_WRITE_SECTOR	;We're all done
WRITE_SECTOR	ENDP


	PUBLIC	WRITE_LOGICAL_SECTOR
	EXTRN	WRITE_EDITOR_PROMPT:NEAR
DATA_SEG	SEGMENT PUBLIC
	EXTRN	SECTOR:BYTE
	EXTRN	DISK_DRIVE_NO:BYTE
	EXTRN	CURRENT_SECTOR_NO:WORD
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure writes a logical sector to the disk drive.  Not, if	;
; the last read resulted in an error, this procedure won't write a	;
; sector to the disk.							;
;									;
; Reads:	DISK_DRIVE_NO, CURRENT_SECTOR_NO			;
; Writes:	SECTOR, DISK_ERROR_FLAG, DISK_ERROR_CODE		;
;-----------------------------------------------------------------------;
WRITE_LOGICAL_SECTOR	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	MOV	AL,DISK_DRIVE_NO	;Drive number
	MOV	CX,1			;Write 1 sector
	MOV	DX,CURRENT_SECTOR_NO	;Logical sector
	LEA	BX,SECTOR		;Get address of our sector
	INT	26H			;Write the sector to disk
	JNC	WRITE_LOGICAL_NO_ERROR	;There wasn't an error, continue
	MOV	DISK_ERROR_FLAG,1	;Set the error flag
	MOV	DISK_ERROR_CODE,AL	;Save the error code
WRITE_LOGICAL_NO_ERROR:
	POPF				;Discard the flag information
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	RET
WRITE_LOGICAL_SECTOR	ENDP


	PUBLIC	PREVIOUS_SECTOR
	EXTRN	INIT_SEC_DISP:NEAR
	EXTRN	WRITE_STRING:NEAR
	EXTRN	WRITE_EDITOR_PROMPT:NEAR
DATA_SEG	SEGMENT PUBLIC
	EXTRN	CURRENT_SECTOR_NO:WORD
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure reads the previous sector, if possible			;
;									;
; Uses:		WRITE_STRING, WRITE_EDITOR_PROMPT, INIT_SEC_DISP	;
; Reads:	CURRENT_SECTOR_NO, READING_MESSAGE			;
; Writes:	CURRENT_SECTOR_NO					;
;-----------------------------------------------------------------------;
PREVIOUS_SECTOR		PROC	NEAR
	PUSH	AX
	PUSH	DX
	MOV	AX,CURRENT_SECTOR_NO	;Get current sector number
	OR	AX,AX			;Is sector number zero?
	JZ	DONT_DECREMENT_SECTOR	;Yes, then we're all done
	DEC	AX			;No, then subtract one
	MOV	CURRENT_SECTOR_NO,AX	;Save new sector number
	LEA	DX,READING_MESSAGE	;Provide feedback while we're reading
	CALL	WRITE_STRING
	CALL	INIT_SEC_DISP		;Display the new screen
	CALL	WRITE_EDITOR_PROMPT	;Display the editor prompt
DONT_DECREMENT_SECTOR:
	POP	DX
	POP	AX
	RET
PREVIOUS_SECTOR		ENDP


	PUBLIC	NEXT_SECTOR
	EXTRN	INIT_SEC_DISP:NEAR
	EXTRN	WRITE_STRING:NEAR
	EXTRN	WRITE_EDITOR_PROMPT:NEAR
DATA_SEG	SEGMENT PUBLIC
	EXTRN	CURRENT_SECTOR_NO:WORD
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; Read the next sector.							;
;									;
; Uses:		WRITE_EDITOR_PROMPT, INIT_SEC_DISP, WRITE_STRING	;
; Reads:	CURRENT_SECTOR_NO, READING_MESSAGE			;
; Writes:	CURRENT_SECTOR_NO					;
;-----------------------------------------------------------------------;
NEXT_SECTOR	PROC	NEAR
	PUSH	AX
	PUSH	DX
	MOV	AX,CURRENT_SECTOR_NO	;Get the current sector number
	INC	AX			;Move to next sector
	MOV	CURRENT_SECTOR_NO,AX	;Save this new number
	LEA	DX,READING_MESSAGE	;Provide feedback while we read
	CALL	WRITE_STRING
	CALL	INIT_SEC_DISP		;Display the new screen
	CALL	WRITE_EDITOR_PROMPT
	POP	DX
	POP	AX
	RET
NEXT_SECTOR	ENDP


	PUBLIC	CHANGE_DISK_DRIVE
	EXTRN	READ_BYTE:NEAR
	EXTRN	WRITE_STRING:NEAR
	EXTRN	CHAR_TO_UPPER:NEAR
	EXTRN	WRITE_PROMPT_LINE:NEAR
	EXTRN	WRITE_EDITOR_PROMPT:NEAR
	EXTRN	INIT_SEC_DISP:NEAR
DATA_SEG	SEGMENT PUBLIC
	EXTRN	DISK_DRIVE_NO:BYTE, DISK_PROMPT:BYTE
	EXTRN	FILE_FLAG:BYTE, CURRENT_SECTOR_NO:WORD
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure prompts for a new disk drive letter, like A, B, ....	;
;									;
; Uses:		WRITE_PROMPT_LINE, WRITE_EDITOR_PROMPT, INIT_SEC_DISP	;
;		WRITE_STRING, CHAR_TO_UPPER, READ_BYTE, QUIT_FILE_MODE	;
; Reads:	DISK_PROMPT, FILE_FLAG, READING_MESSAGE			;
; Writes:	DISK_DRIVE_NO, CURRENT_SECTOR_NO			;
;-----------------------------------------------------------------------;
CHANGE_DISK_DRIVE	PROC	NEAR
	PUSH	AX
	PUSH	DX

READ_DRIVE_LOOP:
	LEA	DX,DISK_PROMPT		;Display prompt for drive letter
	CALL	WRITE_PROMPT_LINE
	CALL	READ_BYTE		;Get new disk-drive number
	CMP	AH,1			;Did it read a character?
	JNE	DONT_CHANGE_DRIVE	;No, don't change the drive number
	CMP	AL,25			;Yes, was it hex number <=25 decimal
	JBE	CHANGE_DRIVE		;Yes, change drive number

	CMP	AL,'0'			;No, is it a single digit number
	JB	READ_DRIVE_LOOP		;Yes, convert to drive number
	CMP	AL,'9'			;Is it a digit?
	JBE	IS_SINGLE_DIGIT		;Yes, convert to drive number

	CALL	CHAR_TO_UPPER		;Convert letter to upper-case
	CMP	AL,'A'			;Is this a legal drive letter?
	JB	READ_DRIVE_LOOP		;No, try again
	CMP	AL,'Z'			;Is this a legal drive letter?
	JA	READ_DRIVE_LOOP		;No, then try again

IS_DRIVE_LETTER:			;Yes, then convert to drive number
	SUB	AL,'A'			;Convert Upper letter to drive number
	JMP	CHANGE_DRIVE		;Change the drive number

IS_SINGLE_DIGIT:
	SUB	AL,'0'			;Convert to drive number

CHANGE_DRIVE:
	CALL	QUIT_FILE_MODE		;Turn off file mode, if on
	MOV	CURRENT_SECTOR_NO,0	;And view sector 0 of new drive
CHANGE_DRIVE_NOT_FILE:
	MOV	DISK_DRIVE_NO,AL	;Save the new drive number
	LEA	DX,READING_MESSAGE	;Provide some feedback while reading
	CALL	WRITE_STRING		;Display this string
	CALL	INIT_SEC_DISP		;And display the new sector
DONT_CHANGE_DRIVE:
	CALL	WRITE_EDITOR_PROMPT	;Display the Edit prompt
	POP	DX
	POP	AX
	RET
CHANGE_DISK_DRIVE	ENDP


	PUBLIC	READ_SECTOR_NUMBER
	EXTRN	WRITE_PROMPT_LINE:NEAR, READ_DECIMAL:NEAR
	EXTRN	WRITE_STRING:NEAR, INIT_SEC_DISP:NEAR
	EXTRN	WRITE_EDITOR_PROMPT:NEAR
DATA_SEG	SEGMENT	PUBLIC
	EXTRN	SECTOR_PROMPT:BYTE
	EXTRN	CURRENT_SECTOR_NO:WORD, FILE_FLAG:BYTE
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure prompts for the number of a new sector to read.	;
;									;
; Uses:		WRITE_PROMPT_LINE, READ_DECIMAL, WRITE_STRING		;
;		INIT_SEC_DISP, QUIT_FILE_MODE, WRITE_EDITOR_PROMPT	;
; Reads:	SECTOR_PROMPT, READING_MESSAGE				;
; Writes:	CURRENT_SECTOR_NO					;
;-----------------------------------------------------------------------;
READ_SECTOR_NUMBER	PROC	NEAR
	PUSH	AX
	PUSH	DX
	LEA	DX,SECTOR_PROMPT	;Prompt for the sector number
	CALL	WRITE_PROMPT_LINE
	CALL	READ_DECIMAL		;Read the new sector number into AX
	JC	DONT_CHANGE_SECTOR	;Error, so exit without changing
	CALL	QUIT_FILE_MODE		;Turn off file mode, if on
	MOV	CURRENT_SECTOR_NO,AX	;Save the new sector number
	LEA	DX,READING_MESSAGE	;Provide feedback while we read
	CALL	WRITE_STRING
	CALL	INIT_SEC_DISP		;Display the new sector
DONT_CHANGE_SECTOR:
	CALL	WRITE_EDITOR_PROMPT	;Display the Edit prompt
	POP	DX
	POP	AX
	RET
READ_SECTOR_NUMBER	ENDP


	PUBLIC	OPEN_NEW_FILE
	EXTRN	WRITE_STRING:NEAR, INIT_SEC_DISP:NEAR
	EXTRN	WRITE_PROMPT_LINE:NEAR, READ_CHAR:NEAR
	EXTRN	WRITE_EDITOR_PROMPT:NEAR
DATA_SEG	SEGMENT PUBLIC
	EXTRN	CURRENT_SECTOR_NO:WORD, FILE_FLAG:BYTE
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure reads a file name, opens that file, and displays the	;
; first sector.								;
;									;
; If the open failed, puts you back to editing whatever you were	;
; editing before.							;
;									;
; NOTE: This procedure needs a lot of work.  If you were in file mode	;
;	when you ask to open a new file, this procedure closes the old	;
;	file, then tries to open the new file.  If there was an error	;
;	reading the new file, or you just hit <Enter>, this procedure	;
;	doesn't return to the file you were previously editing.		;
;	instead, it returns to sector mode.  See if you can change	;
;	this procedure so that it returns to editing the last file you	;
;	were on if you were in file mode.				;
;									;
; Uses:		READ_FILE_NAME, OPEN_FILE, WRITE_STRING			;
;		INIT_SEC_DISP, WRITE_IO_ERROR, WRITE_PROMPT_LINE	;
;		READ_CHAR, WRITE_EDITOR_PROMPT, QUIT_FILE_MODE		;
; Reads:	READING_MESSAGE, DISK_ERROR_FLAG, PRESS_KEY		;
; Writes:	CURRENT_SECTOR_NO, FILE_FLAG, DISK_ERROR_FLAG		;
;-----------------------------------------------------------------------;
OPEN_NEW_FILE	PROC	NEAR
	PUSH	AX
	PUSH	DX
	CALL	QUIT_FILE_MODE		;Turn off old file mode, if on

	CALL	READ_FILE_NAME		;First, read in the file name
	OR	AX,AX			;Did we read any characters?
	JLE	DONE_OPEN_NEW_FILE	;No, then return without change

	LEA	DX,READING_MESSAGE	;Yes, Provide feedback while we read
	CALL	WRITE_STRING
	CALL	OPEN_FILE		;Try to open this file
	CMP	DISK_ERROR_FLAG,1	;Was there an I/O error?
	JE	OPEN_NEW_FILE_ERROR	;Yes, then report it.

SET_FILE_MODE:
	MOV	FILE_FLAG,1		;No, signal now in file mode
	MOV	CURRENT_SECTOR_NO,0	;Start at beginning of file

DONE_OPEN_NEW_FILE:
	CALL	INIT_SEC_DISP		;Display this new sector
	CALL	WRITE_IO_ERROR		;Display or clear error message
	CALL	WRITE_EDITOR_PROMPT	;Display the Edit prompt
	POP	DX
	POP	AX
	RET

;-----------------------------------------------;
; Here we report the error, then pause until	;
; you press a key before returning to the	;
; previous mode and sector that you were	;
; viewing.					;
;-----------------------------------------------;
OPEN_NEW_FILE_ERROR:
	CALL	WRITE_IO_ERROR		;Display the error message
	LEA	DX,PRESS_KEY		;Display prompt message
	CALL	WRITE_PROMPT_LINE	;Display this prompt
	CALL	READ_CHAR		;Read one character
	JMP	DONE_OPEN_NEW_FILE	;We're all done now
OPEN_NEW_FILE	ENDP


	PUBLIC	READ_FILE_NAME
	EXTRN	WRITE_PROMPT_LINE:NEAR, READ_STRING:NEAR
DATA_SEG	SEGMENT PUBLIC
	EXTRN	FILE_NAME_PROMPT:BYTE
	EXTRN	FILE_NAME_STRING:BYTE
	EXTRN	LENGTH_READ:BYTE
	EXTRN	FILE_NAME:BYTE
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure prompts for a file name, then reads in the file name.	;
; We've written this as a separate procedure only to make the code more	;
; readable.								;
;									;
; Returns:	AX	Number of characters read.			;
;			-1 if you pressed a special key			;
;									;
; Uses:		WRITE_PROMPT_LINE, READ_STRING				;
; Reads:	FILE_NAME_PROMPT, FILE_NAME_STRING, LENGTH_READ		;
; Writes:	FILE_NAME						;
;-----------------------------------------------------------------------;
READ_FILE_NAME	PROC	NEAR
	PUSH	BX
	PUSH	DX
	LEA	DX,FILE_NAME_PROMPT	;Display the "file name:"
	CALL	WRITE_PROMPT_LINE	; prompt
	LEA	DX,FILE_NAME_STRING	;Read in the file name
READ_NAME_AGAIN:
	CALL	READ_STRING
	MOV	BL,LENGTH_READ		;Get number of 
	OR	BL,BL			;Was this a function key?
	JL	DONE_READ_FILE_NAME	;Yes, then ignore it

	XOR	BH,BH			;Clear the upper byte
	MOV	FILE_NAME[BX],0		;Convert string into ASCIIZ
DONE_READ_FILE_NAME:
	MOV	AL,BL			;Return the length of the string
	CBW				;Extend sign into the upper byte
	POP	DX
	POP	BX
	RET
READ_FILE_NAME	ENDP


	PUBLIC	OPEN_FILE
DATA_SEG	SEGMENT PUBLIC
	EXTRN	FILE_HANDLE:WORD
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure is used by OPEN_NEW_FILE to open a file for reading	;
; and writing.								;
;									;
; Reads:	FILE_NAME						;
; Writes:	DISK_ERROR_FLAG, DISK_ERROR_CODE, FILE_HANDLE		;
;-----------------------------------------------------------------------;
OPEN_FILE	PROC	NEAR
	PUSH	AX
	PUSH	DX
	MOV	DISK_ERROR_FLAG,0	;Clear the error condition
	MOV	AX,3D02h		;Open file for read/write
	LEA	DX,FILE_NAME		;Get address of the file name
	INT	21h
	JC	FILE_OPEN_ERROR		;There was an error, report it
	MOV	FILE_HANDLE,AX		;Save this file handle
DONE_OPEN_FILE:
	POP	DX
	POP	AX
	RET

FILE_OPEN_ERROR:
	CMP	AX,2			;Is this a file-not-found message?
	JNE	CHECK_ACCESS
	MOV	AX,0Eh			;Error code for file-not-found
	JMP	DONE_FILE_ERROR
CHECK_ACCESS:
	MOV	AX,0Dh			;General Error reading file message
DONE_FILE_ERROR:
	MOV	DISK_ERROR_FLAG,1	;Set the error flag
	MOV	DISK_ERROR_CODE,AL	;Save the new error code
	JMP	DONE_OPEN_FILE		;We're all done, return.
OPEN_FILE	ENDP


	PUBLIC	QUIT_FILE_MODE
DATA_SEG	SEGMENT PUBLIC
	EXTRN	FILE_HANDLE:WORD
	EXTRN	CURRENT_SECTOR_NO:WORD
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure checks to see if we're in file mode, and if so, it	;
; closes the file, then turns off file mode.				;
;									;
; Reads:	FILE_HANDLE						;
; Writes:	FILE_FLAG, CURRENT_SECTOR_NO, DISK_ERROR_FLAG		;
;-----------------------------------------------------------------------;
QUIT_FILE_MODE	PROC	NEAR
	PUSH	AX
	PUSH	BX
	CMP	FILE_FLAG,1		;Are we in file mode?
	JNE	DONE_QUIT_FILE		;No, then we're all done
	MOV	AH,3Eh			;Ask to close this file
	MOV	BX,FILE_HANDLE		;Get the file handle
	INT	21h			;Close this file
	MOV	FILE_FLAG,0		;Turn off file mode
	MOV	CURRENT_SECTOR_NO,0	;Move to start of disk
	MOV	DISK_ERROR_FLAG,0	;Ignore any error conditions
DONE_QUIT_FILE:
	POP	BX
	POP	AX
	RET
QUIT_FILE_MODE	ENDP



	PUBLIC	READ_OFFSET_NUMBER
DATA_SEG	SEGMENT PUBLIC
	EXTRN	OFFSET_PROMPT:BYTE
	EXTRN	FILE_FLAG:BYTE, CURRENT_SECTOR_NO:WORD
DATA_SEG	ENDS
	EXTRN	WRITE_PROMPT_LINE:NEAR, READ_DECIMAL:NEAR
	EXTRN	WRITE_STRING:NEAR, INIT_SEC_DISP:NEAR
	EXTRN	WRITE_EDITOR_PROMPT:NEAR
;-----------------------------------------------------------------------;
; This procedure reads in the sector offset within a file, then		;
; displays the new sector.						;
;									;
; Uses:		WRITE_PROMPT_LINE, READ_DECIMAL, WRITE_STRING		;
;		INIT_SEC_DISP, WRITE_EDITOR_PROMPT			;
; Reads:	FILE_FLAG, OFFSET_PROMPT, READING_MESSAGE		;
; Writes:	CURRENT_SECTOR_NO					;
;-----------------------------------------------------------------------;
READ_OFFSET_NUMBER	PROC	NEAR
	PUSH	AX
	PUSH	DX
	CMP	FILE_FLAG,1		;In file mode?
	JNE	READ_OFFSET_NOT_FILE_MODE	;No, then just ignore request
	LEA	DX,OFFSET_PROMPT	;Yes, display the offset prompt
	CALL	WRITE_PROMPT_LINE
	CALL	READ_DECIMAL		;Read in the decimal number
	JC	DONT_CHANGE_OFFSET	;Error, so exit without changing
	LEA	DX,READING_MESSAGE	;Provide feedback while we read
	CALL	WRITE_STRING
	MOV	CURRENT_SECTOR_NO,AX	;Save the new number
	CALL	INIT_SEC_DISP		;Draw the new display
DONT_CHANGE_OFFSET:
READ_OFFSET_NOT_FILE_MODE:
	CALL	WRITE_EDITOR_PROMPT	;Display the Edit prompt
	POP	DX
	POP	AX
	RET
READ_OFFSET_NUMBER	ENDP


	PUBLIC	READ_FILE_SECTOR
DATA_SEG	SEGMENT PUBLIC
	EXTRN	FILE_HANDLE:WORD
	EXTRN	SECTOR:BYTE
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure reads a random sector from a file.  It also saves a	;
; count of the number of bytes actually read so that the write function	;
; won't increase the size of a file.					;
;									;
; Uses:		SET_FILE_POINTER					;
; Reads:	FILE_HANDLE, DISK_ERROR_FLAG				;
; Writes:	SECTOR, DISK_ERROR_FLAG, DISK_ERROR_CODE, BYTES_READ	;
;-----------------------------------------------------------------------;
READ_FILE_SECTOR	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	CALL	SET_FILE_POINTER	;Set to start of current sector
	CMP	DISK_ERROR_FLAG,1	;Was there an error?
	JE	DONE_READ_FILE_SECTOR	;Yes, then don't try to read sector

	MOV	AH,3Fh			;Call for a read on this file
	MOV	BX,FILE_HANDLE		;Get the file handle
	MOV	CX,512			;Read one sector of 512 bytes
	LEA	DX,SECTOR		;Address of our sector buffer
	INT	21h			;Let DOS read this sector
	MOV	BYTES_READ,AX		;Save number of bytes we read

	OR	AX,AX			;Did we read anything from file?
	JZ	READ_PAST_END		;No, we read past end of file, signal

DONE_READ_FILE_SECTOR:
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	RET

READ_PAST_END:
	MOV	DISK_ERROR_FLAG,1	;Signal that there was an error
	MOV	DISK_ERROR_CODE,0Fh	;Read-past-end error code
	JMP	DONE_READ_FILE_SECTOR
READ_FILE_SECTOR	ENDP


	PUBLIC	SET_FILE_POINTER
DATA_SEG	SEGMENT PUBLIC
	EXTRN	CURRENT_SECTOR_NO:WORD
	EXTRN	FILE_HANDLE:WORD
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure sets the file pointer to the sector number.		;
;									;
; Reads:	CURRENT_SECTOR_NO, FILE_HANDLE				;
;-----------------------------------------------------------------------;
SET_FILE_POINTER	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	MOV	AX,CURRENT_SECTOR_NO	;Get sector number for sector to read
	MOV	BX,512			;Size of the sector
	MUL	BX			;DX:AX = Offset from start of file
	MOV	CX,AX			;DX:CX = Offset in bytes
	XCHG	CX,DX			;CX:DX now contains the offset

	MOV	AX,4200h		;Move to this position in the file
	MOV	BX,FILE_HANDLE		;Get the file handle
	INT	21h			;Move the file pointer

	POP	DX
	POP	CX
	POP	BX
	POP	AX
	RET
SET_FILE_POINTER	ENDP


	PUBLIC	WRITE_FILE_SECTOR
DATA_SEG	SEGMENT PUBLIC
	EXTRN	FILE_HANDLE:WORD
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This procedure writes a single sector back to the file that you were	;
; viewing.  Note, this can change the length of the file if you write	;
; the last sector, and the file was not a multiple of 512 bytes.  In	;
; such cases, this procedure will increase the file length to a		;
; multiple of 512 bytes.						;
;									;
; Uses:		SET_FILE_POINTER
; Reads:	DISK_ERROR_FLAG, FILE_HANDLE, BYTES_READ, SECTOR
;-----------------------------------------------------------------------;
WRITE_FILE_SECTOR	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX

	CALL	SET_FILE_POINTER	;Set to start of current sector
	CMP	DISK_ERROR_FLAG,1	;Was there an error?
	JE	DONE_WRITE_FILE_SECTOR	;Yes, then don't try to write sector

	MOV	AH,40h			;Call for a write to this file
	MOV	BX,FILE_HANDLE		;Get the file handle
	MOV	CX,BYTES_READ		;Don't write more than we read
	LEA	DX,SECTOR		;Address of our sector buffer
	INT	21h			;Let DOS write this sector
	CMP	DISK_ERROR_FLAG,1	;Was there a disk error
	JE	DONE_WRITE_FILE_SECTOR	;Yes, then return

	MOV	AH,45h			;Duplicate the file handle
	INT	21h			;AX == the new file handle
	MOV	BX,AX			;Put new file handle into AX
	MOV	AH,3Eh			;Close duplicate handle to update
	INT	21h			;The changes we just made

DONE_WRITE_FILE_SECTOR:
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	RET
WRITE_FILE_SECTOR	ENDP


CODE_SEG	ENDS

	END
