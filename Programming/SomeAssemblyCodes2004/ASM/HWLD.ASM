; Hello World Sample!
; Jump to start:
.MODEL	SMALL
.CODE
	ORG	100H
BEGIN:	JMP START
; Data:
msg DB  'Hello, World!$'
; Load address of msg to DX register:
START:  LEA DX, msg

; Print using DOS interrupt:
        MOV AH, 9
        INT 21h

; Exit to operating system:
        MOV AH, 4Ch
        INT 21h
