CGROUP	GROUP	CODE_SEG, DATA_SEG
	ASSUME	CS:CGROUP, DS:CGROUP


CODE_SEG	SEGMENT PUBLIC

	PUBLIC	DISPATCHER
	EXTRN	READ_BYTE:NEAR
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
; Uses:		READ_BYTE						;
;-----------------------------------------------------------------------;
DISPATCHER	PROC	NEAR
	PUSH	AX
	PUSH	BX
DISPATCH_LOOP:
	CALL	READ_BYTE		;Read character into AX
	OR	AH,AH			;AX = 0 if no character read, -1
					; for an extended code.
	JZ	DISPATCH_LOOP		;No character read, try again
	JS	SPECIAL_KEY		;Read extended code
; do nothing with the character for now
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

END_DISPATCH:
	POP	BX
	POP	AX
	RET
DISPATCHER	ENDP

CODE_SEG	ENDS


DATA_SEG	SEGMENT PUBLIC


CODE_SEG	SEGMENT PUBLIC
	EXTRN	NEXT_SECTOR:NEAR			;In DISK_IO.ASM
	EXTRN	PREVIOUS_SECTOR:NEAR			;In DISK_IO.ASM
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
	DB	0				;End of the table
DATA_SEG	ENDS

	END
