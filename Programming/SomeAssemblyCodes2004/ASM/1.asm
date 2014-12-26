TITLE   8086 Code Template (for EXE file)

;       AUTHOR          emu8086
;       DATE            ?
;       VERSION         1.00
;       FILE            ?.ASM

; 8086 Code Template

; Directive to make EXE output:
       #MAKE_EXE#

DSEG    SEGMENT 'DATA'

; TODO: add your data here!!!!

DSEG    ENDS

SSEG    SEGMENT STACK   'STACK'
        DW      100h    DUP(?)
SSEG    ENDS

CSEG    SEGMENT 'CODE'

;*******************************************

START   PROC    FAR

; Store return address to OS:
    PUSH    DS
    MOV     AX, 0
    PUSH    AX

; set segment registers:
    MOV     AX, DSEG
    MOV     DS, AX
    MOV     ES, AX


; TODO: add your code here!!!!
Message 	DB	'This is CS 141$'
;
;	move the cursor to the row/column
;	where the string should begin
	MOV AH,02h	;code to set cursor 
	MOV BH, 00	;page number 00
	MOV DH,12	;ROW 12
	MOV DL,33	;column 33
	INT 10h		;BIOS call
	
;
;	now print the string to the screen
;
	MOV AH, 09H	;code for display
	LEA	DX,Message	;addr of text
	INT	21h	;DOS call

; return to operating system:
    RET
START   ENDP

;*******************************************

CSEG    ENDS 

        END    START    ; set entry point.

