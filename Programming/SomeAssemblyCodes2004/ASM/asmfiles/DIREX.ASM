
        TARGET EQU 0D8H
        SOURCE EQU 0B0H
CODE_SEG        SEGMENT
        ASSUME  CS:CODE_SEG,DS:CODE_SEG,ES:CODE_SEG
        ORG     100H
START:  JMP     DIREX
        PROMPT DB 'D=Delete P=Protect U=Unprotect C=Copy <Space>=Mark'
               DB ' N=New Dir Q=Quit$'
        COPY_PROMPT     DB      'Pathname to copy marked files to: $'
        NEW_DIR_PROMPT  DB      'New Directory: $'
        FULL_MSG        DB      '*        TARGET DISK FULL!          *$'
        DEL_MSG         DB      'Delete Marked Files (Y/N)? $'
        COPY_FLAG       DB      0       ;Set for Coping.
        DISP_FLAG       DB      0       
        FULL_FLAG       DB      0       ;Disk Full?
        SOURCE_HANDLE   DW      0       ;To keep track of the Source files.
        TARGET_HANDLE   DW      0       ;Ditto for targets.
        SOURCE_PATH_END DW      ?       ;Where we are.
        TARGET_PATH_END DW      ?       ;Where we are going to be.
        BYTES_READ      DW      ?       ;For copying.
        BYTES_ASKED     DW      ?       ;Also for copying.
        MARKED  DB      ?               ;Is this file marked?
        ATTRIB  DB      7               ;For the display.
        WILDCARDS       DB      '*.*',0
        CURSOR_X        DB      ?       ;Position of cursor.
        CURSOR_Y        DB      ?
        TEMPX           DB      ?       ;Storage for cursor positions.
        TEMPY           DB      ?

DIREX   PROC    NEAR
        CALL    DISPLAY                 ;Put filenames on screen.
        MOV     SI,SOURCE_PATH_END
        CALL    GET_FILE_NAME
TOPPER: MOV     ATTRIB,70H              ;Reverse Video.
        CALL    COLOR
TOP:    MOV     AH,0                    ;Read typed key.
        INT     16H

SPACE:  CMP     AL,20H                  ;Was typed character a space?
        JNE     RIGHT                   ;No -- check right arrow.
        MOV     AH,8                    ;Yes, get end character from screen.
        MOV     BX,0
        ADD     CURSOR_X,12
        CALL    SET_CURSOR
        INT     10H
        CMP     AL,0FFH                 ;Marked?
        JE      OPP                     ;Yes.
        MOV     AL,0FFH                 ;No, mark it now.
        JMP     PPO
OPP:    MOV     AL,0
PPO:    MOV     AH,10
        MOV     CX,1
        INT     10H
        SUB     CURSOR_X,12             ;Move to beginning of filename.
        CALL    SET_CURSOR
        JMP     TOP                     ;Get next typed key.

RIGHT:  CMP     AH,4DH                  ;Was right arrow typed?
        JNE     LEFT                    ;No, check left arrow.
        MOV     ATTRIB,7                ;Yes, set attribute for screen.
        CALL    COLOR                   ;Color out file name.
        CALL    INC_CURSOR              ;Move to next file name.
        MOV     ATTRIB,70H              ;Color in file name.
        CALL    COLOR
        JMP     TOP                     ;Read in next char.

LEFT:   CMP     AH,4BH                  ;Left arrow typed?
        JNE     UP                      ;No -- check up key.
        MOV     DL,CURSOR_X             ;Get ready to move back.
        MOV     DH,CURSOR_Y
        MOV     ATTRIB,7                ;Reset color of current file name.
        CALL    COLOR                   ;Color it out.
        SUB     DL,13                   ;Move back.
        JNC     OK                      ;Past edge of screen?
        MOV     DL,5*13                 ;Yes, wrap.
        SUB     DH,1                    ; and go up one line.
        JNC     OK
        MOV     DL,CURSOR_X
        MOV     DH,CURSOR_Y
OK:     MOV     CURSOR_X,DL
        MOV     CURSOR_Y,DH
        CALL    SET_CURSOR              ;Set current file name in rev. video.
        MOV     ATTRIB,70H
        CALL    COLOR
        JMP     TOP                     ;And wait for next command.

UP:     CMP     AH,48H                  ;Up arrow typed?
        JNE     DOWN                    ;No -- check down arrow.
        MOV     DL,CURSOR_X             ;Prepare to move down.
        MOV     DH,CURSOR_Y
        MOV     ATTRIB,7
        CALL    COLOR                   ;Color out current file name.
        SUB     DH,1
        JNC     NOTTOP                  ;Can we move down?
        ADD     DH,1                    ;Yes.
NOTTOP: MOV     CURSOR_X,DL
        MOV     CURSOR_Y,DH
        CALL    SET_CURSOR              ;Get ready to color current name in.
        MOV     ATTRIB,70H              ;Do it.
        CALL    COLOR
        JMP     TOP                     ;Get next command.

DOWN:   CMP     AH,50H                  ;Was this a down arrow typed?
        JNE     LETTERS                 ;No -- check if it was a letter.
        MOV     ATTRIB,7                ;Color out current file name.
        CALL    COLOR
        INC     CURSOR_Y
        CALL    SET_CURSOR              ;Are we pointing to a 
        MOV     SI,SOURCE_PATH_END      ; valid file name?
        CALL    GET_FILE_NAME
        CMP     BYTE PTR DS:[SI],' '
        JA      GO
NOGO:   DEC     CURSOR_Y                ;No, do not move down.
        CALL    SET_CURSOR
GO:     MOV     ATTRIB,70H              ;Yes, color in current file name.
        CALL    COLOR
        JMP     TOP                     ;Wait for next command.

LETTERS:CMP     AL,'Z'          ;Convert to lower case.
        JL      GOL
        SUB     AL,'a'-'A'
GOL:    CMP     AL,'Q'          ;Are we supposed to quit?
        JNE     DEL             ;No, check deleting.
        JMP     OUT             ;Yes, quit.
DEL:    CMP     AL,'D'          ;Delete?
        JE      OKD             ;Yes, do the delete.
        JMP     PRO             ;No, check protecting.
OKD:    MOV     ATTRIB,7        ;To delete.
        CALL    COLOR           ;Color out current file name.
        MOV     CURSOR_X,0      ;Get ready to put 
        MOV     CURSOR_Y,24     ; the deleting message at bottom
        CALL    SET_CURSOR      ; of the screen.
        MOV     AH,9
        MOV     CX,80
        MOV     AL,' '
        MOV     BX,7
        INT     10H
        MOV     CURSOR_X,0
        MOV     CURSOR_Y,24
        CALL    SET_CURSOR
        MOV     AH,9
        MOV     DX,OFFSET DEL_MSG       ;Type out deleting message.
        INT     21H
        MOV     AH,1
        INT     21H
        CMP     AL,'Z'                  ;Capitalize response.
        JL      CHECKY
        SUB     AL,'a'-'A'
CHECKY: CMP     AL,'Y'                  ;Should we delete?
        JE      GODEL                   ;Yes!
        CALL    DSPLAY2                 ;No, redisplay screen (wiping off
        MOV     ATTRIB,70H              ; delete message.
        CALL    COLOR
        JMP     TOP
GODEL:  MOV     CURSOR_X,0              ;Begin the delete.
        MOV     CURSOR_Y,0              ;Start checking file by file.
        CALL    SET_CURSOR
LOOPD:  CALL    GET_MARKED_FILE         ;Get next marked file.
        MOV     DX,SOURCE               ;Get full name.
        MOV     AH,41H                  ;Do the delete.
        INT     21H
        CALL    INC_CURSOR              ;Move on to next file name.
        CMP     DX,0FFH                 ;At end?
        JE      FIND                    ;Yes, leave.
        CMP     CX,0FFH                 ;More to delete?
        JNE     LOOPD
FIND:   CALL    DSPLAY2                 ;Move cursor to top left
        MOV     ATTRIB,70H              ; and redisplay.
        CALL    COLOR
        JMP     TOP
PRO:    CMP     AL,'P'                  ;Here we will protect a file.
        JNE     UNPRO                   ;If not, jump to unprotect.
        MOV     ATTRIB,7                ;Color out current file name if poss.
        CALL    COLOR
        MOV     CURSOR_X,0
        MOV     CURSOR_Y,0
        CALL    SET_CURSOR
LOOPP:  CALL    GET_MARKED_FILE         ;Loop over files to protect.
        MOV     DX,SOURCE               ;Set up full name.
        MOV     AH,43H                  ;Protect the file.
        MOV     AL,01
        MOV     CX,1
        INT     21H
        CALL    INC_CURSOR              ;Move on to next one.
        CMP     DX,0FFH                 ;Can we?
        JE      FINP                    ;No.
        CMP     CX,0FFH
        JNE     LOOPP                   ;Yes.
FINP:   CALL    DSPLAY2                 ;Done -- redisplay.
        MOV     ATTRIB,70H              ;Move cursor to top left.
        CALL    COLOR
        JMP     TOP                     ;Get next command.
UNPRO:  CMP     AL,'U'                  ;Are we supposed to unprotect?
        JNE     COPY                    ;No, try copy.
        MOV     ATTRIB,7                ;Color out current file name.
        CALL    COLOR
        MOV     CURSOR_X,0
        MOV     CURSOR_Y,0
        CALL    SET_CURSOR
LOOPU:  CALL    GET_MARKED_FILE         ;Loop over files to unprotect.
        MOV     DX,SOURCE
        MOV     AH,43H
        MOV     AL,01                   ;And unprotect them.
        MOV     CX,0
        INT     21H
        CALL    INC_CURSOR              ;Move on to next one.
        CMP     DX,0FFH                 ;Done?
        JE      FINU                    ;Yes.
        CMP     CX,0FFH
        JNE     LOOPU                   ;No.
FINU:   CALL    DSPLAY2                 ;All finished. Redisplay.
        MOV     ATTRIB,70H
        CALL    COLOR
        JMP     TOP                     ;Wait for next command.

COPY:   CMP     AL,'C'                  ;Are we supposed to copy?
        JE      GOC                     ;Yes.
        JMP     NEW_DIR                 ;No -- try directory change.
GOC:    MOV     FULL_FLAG,0             ;Let's copy!
        MOV     ATTRIB,7                ;Color out current file name.
        CALL    COLOR
        MOV     CURSOR_X,0
        MOV     CURSOR_Y,24
        CALL    SET_CURSOR              ;Get pathname to copy marked
        MOV     AH,9                    ; files to.
        MOV     CX,80
        MOV     AL,' '
        MOV     BX,7
        INT     10H
        MOV     CURSOR_X,0
        MOV     CURSOR_Y,24
        CALL    SET_CURSOR
        MOV     AH,9
        MOV     DX,OFFSET COPY_PROMPT   ;Put that name in TARGET.
        INT     21H
        MOV     AH,0AH
        MOV     BX,TARGET-2
        MOV     DX,TARGET-2
        MOV     BYTE PTR [BX],32        ;Add a space.
        INT     21H

        MOV     SI,TARGET
TRANS:  CMP     BYTE PTR [SI],13        ;Check for final slash on pathname.
        JE      SLASH2
        INC     SI                      ;Add it if it's missing.
        JMP     TRANS
SLASH2: CMP     BYTE PTR [SI-1],'\'
        JE      FILER2
        MOV     BYTE PTR [SI],'\'
        INC     SI
FILER2: MOV     TARGET_PATH_END,SI      ;All set to copy.
        MOV     ATTRIB,7
        CALL    COLOR                   ;Color out current file name.
        MOV     CURSOR_X,0
        MOV     CURSOR_Y,0
        CALL    SET_CURSOR
LOOPC:  MOV     COPY_FLAG,1             ;Set copy flag for GET_MARKED_FILE.
        CALL    GET_MARKED_FILE         ;Find file to copy.
        MOV     COPY_FLAG,0             ;Reset Copy flag.
        CMP     CX,0FFH                 ;Find any?
        JNE     OPEN                    ;Yes, open it.
        JMP     FINC                    ;No, finished with copy.
OPEN:   MOV     DX,SOURCE               ;Open the source file.
        MOV     AX,3D00H
        INT     21H
        JC      BOTC                    ;If error, quit.
        MOV     SOURCE_HANDLE,AX        ;Store source handle.
        MOV     DX,TARGET               ;Create Target.
        MOV     AH,3CH
        MOV     CX,0
        INT     21H
        JC      BOTC                    ;If problem, assume disk full, quit.
        MOV     TARGET_HANDLE,AX        ;Store target handle.
STUFF:  MOV     DX,OFFSET DATA
        MOV     CX,62*1024              ;Work in 62K chunks.
        MOV     AH,3FH
        MOV     BX,SOURCE_HANDLE        ;Read from source.
        INT     21H
        MOV     BYTES_READ,AX           ;How much did we get?
        MOV     CX,AX                   ;No. bytes read.
        MOV     BYTES_ASKED,CX
        MOV     AH,40H                  ;Write to target.
        MOV     BX,TARGET_HANDLE
        MOV     DX,OFFSET DATA          ;From DATA area.
        INT     21H
        CMP     AX,BYTES_ASKED          ;Did we write everything?
        JNE     FULL                    ;No, assume disk full.
        CMP     BYTES_READ,62*1024      ;More to read?
        JE      STUFF                   ;Yes.
        JMP     BOTC                    ;No.
FULL:   MOV     CURSOR_X,0              ;Disk is full.
        MOV     CURSOR_Y,24             ;Reset display and quit.
        CALL    SET_CURSOR
        LEA     DX,FULL_MSG
        MOV     AH,9                    ;Type out full message.
        INT     21H
        MOV     FULL_FLAG,1
        MOV     CURSOR_X,0
        MOV     CURSOR_Y,0
        CALL    SET_CURSOR
BOTC:   MOV     AH,3EH                  ;Done. Close all files.
        MOV     BX,SOURCE_HANDLE
        INT     21H                     ;Close Source.
        MOV     AH,3EH
        MOV     BX,TARGET_HANDLE        ;Close Target.
        INT     21H
        CMP     FULL_FLAG,1
        JNE     NOTFULL
        MOV     DX,TARGET
        MOV     AH,41H
        INT     21H
        JMP     TOPPER                  ;Go back to beginning.
NOTFULL:CALL    INC_CURSOR
        CMP     DX,0FFH
        JE      FINC
        JMP     LOOPC                   ;Copy another file.

FINC:   CALL    DSPLAY2                 ;Done with copy.
        MOV     ATTRIB,70H              ;Set cursor on.
        CALL    COLOR
        JMP     TOP                     ;Wait for next command.

NEW_DIR:CMP     AL,'N'                  ;Change directory?
        JE      GON                     ;Yes.
        JMP     TOP                     ;No -- ignore command. Wait for next.
GON:    MOV     ATTRIB,7                ;Color out current file name.
        CALL    COLOR
        MOV     CURSOR_X,0
        MOV     CURSOR_Y,24
        CALL    SET_CURSOR              ;Ask for new directory.
        MOV     AH,9
        MOV     CX,80
        MOV     AL,' '
        MOV     BX,7
        INT     10H
        MOV     CURSOR_X,0
        MOV     CURSOR_Y,24
        CALL    SET_CURSOR
        MOV     AH,9
        MOV     DX,OFFSET NEW_DIR_PROMPT
        INT     21H                     ;And now change subdirectories.
        MOV     AH,0AH
        MOV     BX,80H     
        MOV     DX,80H     
        MOV     BYTE PTR [BX],32        ;Blank out new dir message.
        INT     21H
        JMP     DIREX

OUT:    INT     20H                     ;Grand Exit.
DIREX   ENDP

GET_MARKED_FILE PROC    NEAR            ;Find marked files from screen.
                                        ;CX=FF --> no more to be found.
BEGI:   MOV     AH,8
        ADD     CURSOR_X,12
        CALL    SET_CURSOR
        MOV     BX,0                    ;Check last byte of file name on screen.
        INT     10H
        SUB     CURSOR_X,12
        CALL    SET_CURSOR
        CMP     AL,0FFH                 ;If it is FF, the file is marked.
        JE      FINI
        CALL    INC_CURSOR
        CMP     DX,0FFH
        JNE     BEGI
        MOV     CX,0FFH                 ;NO MORE to be found!
        JMP     OUTER
FINI:   MOV     CX,0
        MOV     SI,SOURCE_PATH_END
        CALL    GET_FILE_NAME
        CMP     COPY_FLAG,1             ;Set up SI?
        JNE     OUTER
        MOV     SI,TARGET_PATH_END      ;Yes for copying.
        CALL    GET_FILE_NAME
OUTER:  RET
GET_MARKED_FILE ENDP

GET_FILE_NAME   PROC    NEAR            ;Gets file name from screen.
        ;Call with DS:SI as address to put name at.
        PUSH    CX
        PUSH    SI
        PUSH    WORD PTR CURSOR_X       ;Store cursor.
        MOV     AH,8 
        MOV     BX,0
        MOV     CX,12                   ;12 Letters in name.
LOOPB:  MOV     AH,8
        INT     10H                     ;Get a letter.
        INC     CURSOR_X
        CALL    SET_CURSOR
        MOV     DS:[SI],AL              ;Move it to DS:SI.
        INC     SI                      ;Move on to next character.
        LOOP    LOOPB
        MOV     BYTE PTR DS:[SI],0      ;Make it ASCIIZ.
        POP     WORD PTR CURSOR_X
        POP     SI
        CALL    SET_CURSOR              ;Reset cursor.
        POP     CX
        RET                             ;And return.
GET_FILE_NAME   ENDP

COLOR   PROC    NEAR                    ;Set color of file name.
        PUSH    CX                      ;If marked, leave rev. video.
        PUSH    WORD PTR CURSOR_X       ;Save cursor.
        MOV     CX,12                   ;12 characters in file name.
        CMP     ATTRIB,7                ;Should we color out?
        JNE     HERE                    ;No.
        MOV     AH,8
        ADD     CURSOR_X,12             ;Yes.
        CALL    SET_CURSOR              ;Check if we should.
        MOV     BX,0
        INT     10H
        SUB     CURSOR_X,12
        CALL    SET_CURSOR
        CMP     AL,0FFH                 ;Is file marked?
        JE      FINE                    ;Yes, don't color out.
HERE:   MOV     BX,0
        MOV     AH,8            ;Change attribute character by character.
        INT     10H
        PUSH    CX
        MOV     CX,1
        MOV     BL,ATTRIB
        MOV     AH,9
        INT     10H
        POP     CX
        INC     CURSOR_X
        CALL    SET_CURSOR
        LOOP    HERE
FINE:   POP     WORD PTR CURSOR_X       ;Restore cursor.
        CALL    SET_CURSOR
        POP     CX
        RET
COLOR   ENDP

DISPLAY PROC    NEAR                    ;Puts up main display on screen.
        MOV     DI,SOURCE               ;Get source subdirectory.
        MOV     SI,82H
        MOV     SOURCE_PATH_END,SOURCE
        MOV     BX,80H
        CMP     BYTE PTR [BX],0
        JE      FILER
TRANS2: CMP     BYTE PTR [SI],13        ;Check for the slash at the end of it.
        JE      SLASH
        MOVSB
        JMP     TRANS2                  ;If it's not there, add it.
SLASH:  CMP     BYTE PTR [DI-1],'\'
        JE      FILER
        MOV     BYTE PTR [DI],'\'
        INC     DI
FILER:  MOV     SOURCE_PATH_END,DI      ;Get ready to find file name.
DSPLAY2:MOV     CX,25                   ;Short version -- don't check source.
        MOV     CURSOR_X,0
        MOV     CURSOR_Y,0              ;Set cursor to top left.
        CALL    SET_CURSOR
WIPE:   PUSH    CX                      ;Clear the screen.
        CALL    SET_CURSOR
        MOV     CX,80
        MOV     AH,9
        MOV     BX,7
        MOV     AL,0
        INT     10H
        POP     CX
        INC     CURSOR_Y
        LOOP    WIPE
        MOV     CURSOR_X,6      ;Put up command line.
        MOV     CURSOR_Y,24
        CALL    SET_CURSOR
        MOV     AH,9
        MOV     DX,OFFSET PROMPT
        INT     21H
        MOV     CURSOR_X,0
        MOV     CURSOR_Y,0
        CALL    SET_CURSOR      ;Get ready to search.
        MOV     AH,4EH
        MOV     CX,4
        MOV     DI,SOURCE_PATH_END      ;Add the *.* at the end of the path.
        MOV     SI,OFFSET WILDCARDS
REP     MOVSB
        MOV     DX,SOURCE
        INT     21H                     ;Search for first match to wildcards.
        JC      ENDER                   ;If done, exit.
        MOV     DX,0
        MOV     AH,2
        INT     10H
        CALL    PRINT                   ;Print file name on screen.
        MOV     CX,120                  ;Max of 120 files.
LOOPER: MOV     AH,4FH
        INT     21H                     ;Find next match.
        JC      ENDER                   ;If no match, exit.
        MOV     DISP_FLAG,0FFH          ;Set DISP_FLAG for INC_CURSOR.
        CALL    INC_CURSOR
        MOV     DISP_FLAG,0
        CALL    PRINT
        MOV     DX,OFFSET WILDCARDS
        LOOP    LOOPER                  ;Look for next file name.
ENDER:  MOV     CURSOR_X,0              ;Set cursor up at top left.
        MOV     CURSOR_Y,0
        CALL    SET_CURSOR
        RET                             ;And exit.
DISPLAY ENDP

INC_CURSOR      PROC    NEAR    ;Move cursor to next file.
        PUSH    CX              ;Success-->DX=0.
        MOV     DL,CURSOR_X
        MOV     DH,CURSOR_Y
        MOV     TEMPX,DL        ;Store cursor.
        MOV     TEMPY,DH
        ADD     DL,13           ;End of screen?
        CMP     DL,75
        JL      FIN
        MOV     DL,0
        INC     DH
FIN:    MOV     CURSOR_X,DL
        MOV     CURSOR_Y,DH
        MOV     DX,0                    ;Return OK signal.
        CALL    SET_CURSOR
        CMP     DISP_FLAG,0             ;Is this a DISPLAY?
        JNE     SET
        MOV     SI,SOURCE_PATH_END      ;Yes, is the next character a space?
        CALL    GET_FILE_NAME
        CMP     BYTE PTR DS:[SI],' '
        JA      SET                     ;No.
        SUB     CURSOR_X,13
        CMP     CURSOR_X,0
        JG      LEAV
        MOV     DL,TEMPX                ;If we can, update cursor.
        MOV     CURSOR_X,DL             ;If not, restore it.
        MOV     DH,TEMPY
        MOV     CURSOR_Y,DH
LEAV:   CALL    SET_CURSOR
        MOV     DX,0FFH
SET:    POP     CX                      ;Restore CX.
        RET                             ;And exit.
INC_CURSOR      ENDP

SET_CURSOR      PROC    NEAR            ;Position the cursor.
        PUSH    AX
        MOV     DL,CURSOR_X
        MOV     DH,CURSOR_Y             ;Use INT 10H.
        MOV     AH,2
        INT     10H
        POP     AX
        RET                             ;Finish.
SET_CURSOR      ENDP

PRINT   PROC    NEAR                    ;Print file names.
        PUSH    CX
        MOV     DX,80H+30               ;Check at CS:80H+30.
        MOV     BX,DX
        MOV     CX,13                   ;Search 13 chars for end of file name.
LOOPA:  CMP     BYTE PTR [BX],0         ;Find end of file name.
        JE      FOUND
        INC     BX
        LOOP    LOOPA
FOUND:  MOV     BYTE PTR DS:[BX+1],'$'  ;Use string print.
        MOV     AH,9                    ;Print out file name.
        INT     21H
        POP     CX
        RET                     ;Finish.
PRINT   ENDP
DATA:                           ;Store data for copies starting here.
CODE_SEG        ENDS
        END     START



