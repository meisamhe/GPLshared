CGROUP	GROUP	CODE_SEG, DATA_SEG
	ASSUME	CS:CGROUP, DS:CGROUP


DATA_SEG	SEGMENT PUBLIC
	EXTRN	NEXT_SECTOR:NEAR		;In DISK_IO.ASM
	EXTRN	PREVIOUS_SECTOR:NEAR		;In DISK_IO.ASM
	EXTRN	PHANTOM_UP:NEAR, PHANTOM_DOWN:NEAR	;In PHANTOM.ASM
	EXTRN	PHANTOM_LEFT:NEAR, PHANTOM_RIGHT:NEAR
	EXTRN	PAGE_UP:NEAR, PAGE_DOWN:NEAR
	EXTRN	HOME_KEY:NEAR, END_KEY:NEAR
	EXTRN	WRITE_SECTOR:NEAR		;In DISK_IO.ASM
	EXTRN	CHANGE_DISK_DRIVE:NEAR
	EXTRN	READ_SECTOR_NUMBER:NEAR
	EXTRN	OPEN_NEW_FILE:NEAR
	EXTRN	READ_OFFSET_NUMBER:NEAR
;-----------------------------------------------------------------------;
; This table contains the legal extended ASCII keys and the addresses	;
; of the procedures which should be called when each key is pressed.	;
;	The format of the table is					;
;		DB	72		;Extended code for cursor up	;
;		DW	OFFSET CGROUP:PHANTOM_UP			;
;-----------------------------------------------------------------------;
DISPATCH_TABLE	LABEL	BYTE
	DB	59				;F1
	DW	OFFSET CGROUP:PREVIOUS_SECTOR
	DB	60				;F2
	DW	OFFSET CGROUP:NEXT_SECTOR
	DB	61				;F3
	DW	OFFSET CGROUP:CHANGE_DISK_DRIVE
	DB	62				;F4
	DW	OFFSET CGROUP:READ_SECTOR_NUMBER
	DB	64				;F6
	DW	OFFSET CGROUP:OPEN_NEW_FILE
	DB	65				;F7
	DW	OFFSET CGROUP:READ_OFFSET_NUMBER
	DB	72				;Cursor up
	DW	OFFSET CGROUP:PHANTOM_UP
	DB	80				;Cursor down
	DW	OFFSET CGROUP:PHANTOM_DOWN
	DB	75				;Cursor left
	DW	OFFSET CGROUP:PHANTOM_LEFT
	DB	77				;Cursor right
	DW	OFFSET CGROUP:PHANTOM_RIGHT
	DB	73				;Page Up
	DW	OFFSET CGROUP:PAGE_UP
	DB	81				;Page Down
	DW	OFFSET CGROUP:PAGE_DOWN
	DB	71				;Home
	DW	OFFSET CGROUP:HOME_KEY
	DB	79				;End
	DW	OFFSET CGROUP:END_KEY
	DB	88				;Shift F5
	DW	OFFSET CGROUP:WRITE_SECTOR
	DB	0				;End of the table
DATA_SEG	ENDS


CODE_SEG	SEGMENT PUBLIC

	PUBLIC	DISPATCHER
	EXTRN	READ_BYTE:NEAR, EDIT_BYTE:NEAR
	EXTRN	WRITE_EDITOR_PROMPT:NEAR
;-----------------------------------------------------------------------;
; This is the central dispatcher: during normal editing and viewing,	;
; this procedure reads characters from the keyboard and, if the character;
; is a command key (such as cursor keys), DISPATCHER calls the		;
; procedures which do the actual work.  This dispatching is done for	;
; special keys listed in the table DISPATCH_TABLE, where the procedure	;
; addresses are stored just after the key name.				;
;   If the character is not a special key, then it should be placed	;
; directly into the sector buffer -- this is the editing mode.		;
;									;
; Uses:		READ_BYTE, EDIT_BYTE, WRITE_EDITOR_PROMPT		;
; Reads:	EDITOR_PROMPT, DISPATCH_TABLE				;
;-----------------------------------------------------------------------;
DISPATCHER	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	DX
DISPATCH_LOOP:
	CALL	READ_BYTE		;Read character into AX
	OR	AH,AH			;AX = 0 if no character read, -1
					;for an extended code.
	JZ	NO_CHARS_READ		;No character read, try again
	JS	SPECIAL_KEY		;Read extended code
	MOV	DL,AL
	CALL	EDIT_BYTE		;Was normal character, edit byte
	JMP	DISPATCH_LOOP		;Read another character

SPECIAL_KEY:
	CMP	AL,68			;F10 -- exit?
	JE	END_DISPATCH		;Yes, leave
					;Use BX to look through table
	LEA	BX,DISPATCH_TABLE
SPECIAL_LOOP:
	CMP	BYTE PTR [BX],0		;End of table?
	JE	NOT_IN_TABLE		;Yes, key was not in the table
	CMP	AL,[BX]			;Is it this table entry?
	JE	DISPATCH		;Yes, then dispatch
	ADD	BX,3			;No, try next entry
	JMP	SPECIAL_LOOP		;Check next table entry

DISPATCH:
	INC	BX			;Point to address of procedure
	CALL	WORD PTR [BX]		;Call procedure
	JMP	DISPATCH_LOOP		;Wait for another key

NOT_IN_TABLE:				;Do nothing, just read next character
	JMP	DISPATCH_LOOP
	
NO_CHARS_READ:
	CALL	WRITE_EDITOR_PROMPT	;Erase any invalid characters typed
	JMP	DISPATCH_LOOP		;Try again

END_DISPATCH:
	POP	DX
	POP	BX
	POP	AX
	RET
DISPATCHER	ENDP

CODE_SEG	ENDS

	END
