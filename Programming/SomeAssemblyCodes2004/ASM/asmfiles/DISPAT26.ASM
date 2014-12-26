CGROUP	GROUP	CODE_SEG, DATA_SEG
	ASSUME	CS:CGROUP, DS:CGROUP


CODE_SEG	SEGMENT PUBLIC

	PUBLIC	DISPATCHER
	EXTRN	READ_BYTE:NEAR, EDIT_BYTE:NEAR
	EXTRN	WRITE_PROMPT_LINE:NEAR
DATA_SEG	SEGMENT PUBLIC
	EXTRN	EDITOR_PROMPT:BYTE
DATA_SEG	ENDS
;-----------------------------------------------------------------------;
; This is the central dispatcher. During normal editing and viewing,	;
; this procedure reads characters from the keybaord and, if the char	;
; is a command key (such as a cursor key), DISPATCHER calls the		;
; procedures that do the actual work.  This dispatching is done for	;
; special keys listed in the table DISPATCH_TABLE, where the procedure	;
; addresses are stored just after the key names.			;
;   If the character is not a special key, then it should be placed	;
; directly into the sector buffer--this is the editing mode.		;
;									;
; Uses:		READ_BYTE, EDIT_BYTE, WRITE_PROMPT_LINE			;
; Reads:	EDITOR_PROMPT						;
;-----------------------------------------------------------------------;
DISPATCHER	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	DX
DISPATCH_LOOP:
	CALL	READ_BYTE		;Read character into AX
	OR	AH,AH			;AX = 0 if no character read, -1
					; for an extended code.
	JZ	NO_CHARS_READ		;No character read, try again
	JS	SPECIAL_KEY		;Read extended code
	MOV	DL,AL
	CALL	EDIT_BYTE		;Was normal character, edit byte
	JMP	DISPATCH_LOOP		;Read another character
SPECIAL_KEY:
	CMP	AL,68			;F10--exit?
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
	LEA	DX,EDITOR_PROMPT
	CALL	WRITE_PROMPT_LINE	;Erase any invalid characters typed
	JMP	DISPATCH_LOOP		;Try again

END_DISPATCH:
	POP	DX
	POP	BX
	POP	AX
	RET
DISPATCHER	ENDP

CODE_SEG	ENDS


DATA_SEG	SEGMENT PUBLIC


CODE_SEG	SEGMENT PUBLIC
	EXTRN	NEXT_SECTOR:NEAR			;In DISK_IO.ASM
	EXTRN	PREVIOUS_SECTOR:NEAR			;In DISK_IO.ASM
	EXTRN	PHANTOM_UP:NEAR, PHANTOM_DOWN:NEAR	;In PHANTOM.ASM
	EXTRN	PHANTOM_LEFT:NEAR, PHANTOM_RIGHT:NEAR
	EXTRN	WRITE_SECTOR:NEAR			;In DISK_IO.ASM
CODE_SEG	ENDS
;-----------------------------------------------------------------------;
; This table contains the legal extended ASCII keys and the addresses	;
; of the procedures that should be called when each key is pressed.	;
;	The format of the table is					;
;		DB	72		;Extended code for cursor up	;
;		DW	OFFSET CGROUP:PHANTOM_UP			;
;-----------------------------------------------------------------------;
DISPATCH_TABLE	LABEL	BYTE
	DB	59				;F1
	DW	OFFSET CGROUP:PREVIOUS_SECTOR
	DB	60				;F2
	DW	OFFSET CGROUP:NEXT_SECTOR
	DB	72				;Cursor up
	DW	OFFSET CGROUP:PHANTOM_UP
	DB	80				;Cursor down
	DW	OFFSET CGROUP:PHANTOM_DOWN
	DB	75				;Cursor left
	DW	OFFSET CGROUP:PHANTOM_LEFT
	DB	77				;Cursor right
	DW	OFFSET CGROUP:PHANTOM_RIGHT
	DB	88				;Shift F5
	DW	OFFSET CGROUP:WRITE_SECTOR
	DB	0				;End of the table
DATA_SEG	ENDS

	END
