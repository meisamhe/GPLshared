;-----------------------------------------------
STACKSG SEGMENT PARA STACK	'Stack'
		DW	32 DUP(0)
STACKSG	ENDS
;------------------------------------------------
DATASG	SEGMENT	PARA	'Data'
FLDA	DW	250
FLDB	DW	125
FLDC	DW	?
DATASG	ENDS
;-----------------------------------------------
CODESG	SEGMENT PARA	'Code'
BEGIN	PROC	FAR
		ASSUME	SS:STACKSG,DS : DATASG, CS : CODESG
		MOV		AX,DATASG	;Set address of DATASG
		MOV		DS,AX		;in DS register
		
		MOV		AX, FLDA	;MOVE 0250		to AX
		ADD		AX, FLDB	;Add 0125		to AX
		MOV		FLDC, AX	;Store sum		in	FLDC
		MOV		AX, 4C00H	;Exit to Dos
		INT		21H
BEGIN	ENDP
CODESG	ENDS	;End of segment
		END		BEGIN
		