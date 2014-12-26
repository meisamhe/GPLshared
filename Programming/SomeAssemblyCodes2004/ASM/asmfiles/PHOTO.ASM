
INTERRUPTS      SEGMENT AT 0H   ;This is where the keyboard interrupt
        ORG     9H*4            ;holds the address of its service routine
KEYBOARD_INT    LABEL   WORD  
INTERRUPTS      ENDS

SCREEN  SEGMENT AT 0B000H       ;A dummy segment to use as the
SCREEN  ENDS                    ;Extra Segment 

ROM_BIOS_DATA   SEGMENT AT 40H  ;BIOS statuses held here, also keyboard buffer

        ORG     1AH
        HEAD DW      ?                  ;Unread chars go from Head to Tail
        TAIL DW      ?
        BUFFER       DW      16 DUP (?)         ;The buffer itself
        BUFFER_END   LABEL   WORD

ROM_BIOS_DATA   ENDS

CODE_SEG        SEGMENT
        ASSUME  CS:CODE_SEG
        ORG     100H            ;ORG = 100H to make this into a .COM file
FIRST:  JMP     LOAD_SNAPSHOT   ;First time through jump to initialize routine
 
        COPY_RIGHT DB  '(C) S. HOLZNER 1985'  ;An Ascii signature
        KEYS   DW   310EH,2106H,1E01H,3002H,2E03H ;A Sample: ^N,^F,^A,^B,^C
;       KEYS   DW   5 DUP(0)
        FLASHED    DB      0               ;Have we flashed a screenful? 1=yes
        SNAPSHOT_OFFSET      DW      0          ;Chooses 1st 250 bytes or 2nd
        SCREEN_SEG_OFFSET       DW      0       ;0 for mono, 8000H for graphics
        IO_CHAR         DW      ?               ;Holds addr of Put or Get_Char
        FILE_SIZE       DW      0               ;Read in this many bytes
        OLD_KEY_INT     LABEL   WORD
        OLD_KEYBOARD_INT        DD      ?       ;Location of old kbd interrupt
        FILE            DB  'A.DAT',0           ;Asciiz. Changed to B.Dat, etc.
        WS_FLAG         DB      0               ;<-- Set to 1 to strip WordStar 
        SNAPSHOT             DB      10000 DUP (32) ;Storage for screens

SNAP    PROC    NEAR            ;The keyboard interrupt will now come here.
        ASSUME  CS:CODE_SEG
        PUSH    AX              ;Save the used registers for good form
        PUSH    BX
        PUSH    CX
        PUSH    DX
        PUSH    DI
        PUSH    SI
        PUSH    DS
        PUSH    ES
        PUSHF                   ;First, call old keyboard interrupt
        CALL    OLD_KEYBOARD_INT

        ASSUME  DS:ROM_BIOS_DATA        ;Examine the char just put in
        MOV     BX,ROM_BIOS_DATA
        MOV     DS,BX
        MOV     BX,TAIL                 ;Point to current tail
        CMP     BX,HEAD                 ;If at head, kbd int has deleted char
        JE      IN                      ;So leave 
        SUB     BX,2                    ;Point to just read in character
        CMP     BX,OFFSET BUFFER        ;Did we undershoot buffer?
        JAE     NO_WRAP                 ;Nope
        MOV     BX,OFFSET BUFFER_END    ;Yes -- move to buffer top
        SUB     BX,2                    ;Point to just read in character
NO_WRAP:MOV     DX,[BX]                 ;** Typed character in DX now **
        LEA     SI,KEYS                 ;Point to Keys for search
        CMP     FLASHED,1               ;Should we restore screen?
        JE      RESTORE                 ;Yes, jump there
        CMP     DX,CS:[SI]              ;Compare to first key (Store screen)
        JE      STORE                   ;So Store
        ADD     SI,2                    ;Point to next key
        CMP     DX,CS:[SI]              ;Second key -- should we flash screen?
        JE      FLASH                   ;Yes     
        MOV     CX,3                    ;No -- check for .Dat keys (A.Dat,etc)
        MOV     SNAPSHOT_OFFSET,4000    ;Point to beginning of .Dats in memory
TEST:   ADD     SI,2                    ;Increment to next key
        CMP     DX,CS:[SI]              ;Is it right?
        JE      DATS                    ;Yes, flash a .Dat file on screen
        ADD     SNAPSHOT_OFFSET,2000    ;Point to next .Dat
        LOOP    TEST                    ;And go back until all three are done
        JMP     OUT                     ;No keys matched. Jump Out.
STORE:  MOV     TAIL,BX                 ;Delete character from buffer
        MOV     FLASHED,0               ;Switch Modes on Flashed
        MOV     SNAPSHOT_OFFSET,0       ;Point to screen storage part of pad
        LEA     AX,GET_CHAR             ;Make IO use Get_char so current screen
        MOV     IO_CHAR,AX              ;is stored
        CALL    IO                      ;Store Screen
IN:     JMP     OUT                     ;Done here, let's go.
FLASH:  MOV     TAIL,BX
        MOV     FLASHED,1           ;Switch Modes, next key will restore screen
        MOV     SNAPSHOT_OFFSET,2000    ;Point to screen storage part 
        LEA     AX,GET_CHAR             ;Make IO use Get_char so current screen
        MOV     IO_CHAR,AX              ;is stored
        CALL    IO                      ;Store Screen
        MOV     SNAPSHOT_OFFSET,0       ;Use 1st 250 bytes of Snapshot memory
        LEA     AX,PUT_CHAR             ;Make IO use Put-Char so it does
        MOV     IO_CHAR,AX              
        CALL    IO                      ;Put result on screen
        JMP     OUT                     ;Done here.
RESTORE:
        MOV     FLASHED,0               ;Restore screen from memory
        MOV     TAIL,BX                 ;Delete character from buffer
        MOV     SNAPSHOT_OFFSET,2000    ;Point to storage part of memory
        LEA     AX,PUT_CHAR             ;Make IO call Put_Char as it scans
        MOV     IO_CHAR,AX              ;over all locations in screen
        CALL    IO                      ;Restore screen
        JMP     OUT                     ;And leave
      
DATS:   MOV     TAIL,BX
        MOV     FLASHED,1           ;Switch Modes, next key will restore screen
        PUSH    SNAPSHOT_OFFSET         ;Save this while Offset set for storing
        MOV     SNAPSHOT_OFFSET,2000    ;Point to screen storage part 
        LEA     AX,GET_CHAR             ;Make IO use Get_char so current screen
        MOV     IO_CHAR,AX              ;is stored
        CALL    IO                      ;Store Screen
        POP     SNAPSHOT_OFFSET         ;Restore pointer to stored .Dat
        LEA     AX,PUT_CHAR             ;Make IO use Put-Char so it does
        MOV     IO_CHAR,AX              
        CALL    IO                      ;Put result on screen

OUT:    POP     ES                      ;Do the Pops of all registers.
        POP     DS
        POP     SI
        POP     DI
        POP     DX
        POP     CX
        POP     BX
        POP     AX     
        IRET                    ;An interrupt needs an IRET
SNAP    ENDP

GET_CHAR        PROC    NEAR    ;Gets a char from screen and advances position
        PUSH    DX
        MOV     SI,2            ;Loop twice, once for char, once for attribute
G_WAIT_LOW:
        MOV     AH,ES:[DI]      ;Do the move from the screen, one byte at a time
        INC     DI              ;Move to next screen location                   
        DEC     SI              ;Decrement loop counter
        CMP     SI,0            ;Are we done?
        JE      LEAVE           ;Yes
        MOV     SNAPSHOT[BX],AH      ;No -- put char we got into snapshot
        JMP     G_WAIT_LOW      ;Do it again
LEAVE:  INC     BX              ;Update location
        POP     DX
        RET
GET_CHAR        ENDP

PUT_CHAR        PROC    NEAR    ;Puts one char on screen and advances position
        PUSH    DX
        MOV     AH,SNAPSHOT[BX]      ;Get the char to be put onto the screen
        MOV     SI,2            ;Loop twice, once for char, once for attribute
        MOV     ES:[DI],AH      ;Move to screen, one byte at a time
        ADD     DI,2
        SUB     SI,2
        INC     BX              ;Point to next char 
        POP     DX
        RET                     ;Exeunt
PUT_CHAR        ENDP

IO      PROC    NEAR           ;This scans over all screen positions 
        ASSUME  ES:SCREEN               ;Use screen as extra segment
        MOV     BX,SCREEN
        MOV     ES,BX
        
        MOV     DI,SCREEN_SEG_OFFSET    ;DI will be pointer to screen postion
        MOV     BX,SNAPSHOT_OFFSET           ;BX will be location pointer
        MOV     CX,25                   ;There will be 10 lines
LINE_LOOP:      
        MOV     DX,80                   ;And 25 spaces across
CHAR_LOOP:
        CALL    IO_CHAR                 ;Call Put-Char or Get-Char
        DEC     DX                      ;Decrement character loop counter
        JNZ     CHAR_LOOP               ;If not zero, scan over next character
        LOOP    LINE_LOOP               ;And now go back to do next line
        RET                             ;Finished
IO      ENDP
                         
READ_FILE       PROC    NEAR            ;Reads .Dats and formats in memory.
        PUSH    CX                      ;Save used registers
        PUSH    DX
        PUSH    DI
        ASSUME  DS:CODE_SEG,ES:CODE_SEG
        MOV     BX,AX                   ;Put passed file handle in BX
        MOV     CX,2000                 ;Ask for 2000 bytes (Tops)
        LEA     DX,DATA                 ;Point DS:DX at Data area at end
        MOV     AH,3FH                  ;Ask for reading service
        INT     21H                     ;And go get 'em
        MOV     CX,AX                   ;Store number of bytes read
        MOV     AH,3EH                  ;Now close file
        INT     21H                     
        CALL    WS                      ;Strip high bit if necessary
        LEA     SI,DATA                 ;Transfer from CS:[SI] to DS:[BX] now
        CMP     CX,2000                 ;Make sure on number of bytes read in.
        JBE     THE_LOOP
        MOV     CX,2000                 ;Format file into Snapshot area now
THE_LOOP:                               ;Loop over character by character
        CMP     BYTE PTR [SI],9         ;Is it a tab?
        JNE     NOTAB                   ;Add 8 spaces for tabs
        ADD     DI,8
        INC     SI                      ;And point to next character
        JMP     CONT
NOTAB:  CMP     BYTE PTR [SI],13        ;Is it a carriage return?
        JNE     OK                      ;No, store the character
FILL:   INC     SI                      ;Found a <CR>. Fill to end of line 
        DEC     CX                      ;Get rid of line feeds
        CMP     BYTE PTR [SI],13        ;Treat additional <CR>s as new lines
        JE      CR
        CMP     BYTE PTR [SI],' '       ;Bona Fide character?
        JB      FILL                    ;No, keep going past all linefeeds
CR:     CMP     CX,0                    ;Yes, start to fill to end of line here
        JLE     FIN                     ;Check on loop index
        INC     CX                      ;And readjust it from skipping lf.s
        MOV     AX,DI                   ;AH will check if we're at end of line
        SUB     AX,OFFSET SNAPSHOT+4000 ;Get distance into screen
        MOV     DL,80                   ;Divide by 80 to find columns
        DIV     DL                      
CHECK:  CMP     AH,79                   ;Remainder of 79?
        JA      CONT                    ;If more, have begun a new line.
ADD:    INC     DI                      ;Add a space by incrementing DI
        INC     AH                      ;And keep track by incrementing AH too.
        JMP     CHECK                   ;At edge of screen?
OK:     CMP     DI,OFFSET SNAP    ;Past end of storage area? (Many tabs and CRs)
        JAE     FIN                     ;Yes, don't move byte into it
        MOVSB                           ;No, safe to move byte from [SI] to [DI]
CONT:   LOOP    THE_LOOP                ;And keep going for all bytes in file
FIN:    POP     DI
        POP     DX
        POP     CX
        RET                             ;Exit here.
READ_FILE       ENDP
                                    
WS      PROC    NEAR                    ;This will strip high bits from the
        CMP     WS_FLAG,1               ;  read-in file if WS_Flag = 1
        JNE     RETWS                   ;IF WS_Flag is not 1, exit
        PUSH    SI                      ;Store used registers
        PUSH    CX
        LEA     SI,DATA                 ;Point to read-in file
        MOV     CX,2000                 ;Do 2000 bytes
ALOOP:  AND     BYTE PTR CS:[SI],127    ;Strip top bit
        INC     SI                      ;Point to next one.
        LOOP    ALOOP                   ;And keep going
        POP     CX                      ;Pops
        POP     SI
RETWS:  RET                             ;And Exit.
WS      ENDP

LOAD_SNAPSHOT        PROC    NEAR    ;This procedure intializes everything
        ASSUME  DS:INTERRUPTS   ;The data segment will be the Interrupt area
        MOV     AX,INTERRUPTS
        MOV     DS,AX
        
        MOV     AX,KEYBOARD_INT         ;Get the old interrupt service routine
        MOV     OLD_KEY_INT,AX          ;address and put it into our location
        MOV     AX,KEYBOARD_INT[2]      ;OLD_KEYBOARD_INT so we can call it.
        MOV     OLD_KEY_INT[2],AX
        
        MOV     KEYBOARD_INT,OFFSET SNAP  ;Now load the address of our program
        MOV     KEYBOARD_INT[2],CS         ;routine into the keyboard interrupt
                                        
        MOV     AH,15                   ;Ask for service 15 of INT 10H 
        INT     10H                     ;This tells us how display is set up
        TEST    AL,4                    ;Is it?
        JNZ     READ                    ;Yes - jump out
        MOV     SCREEN_SEG_OFFSET,8000H ;No - set up for graphics display
READ:   PUSH    CS                      ;Now read in A.Dat, B.Dat etc.
        POP     DS                      ;Set DS correctly
        MOV     CX,3                    ;Loop over three files
        LEA     DI,SNAPSHOT+4000        ;Store starting in this area
LOOP:   ASSUME  DS:CODE_SEG             ;Loop over files
        LEA     DX,FILE                 ;Point to file name
        MOV     AX,3D00H                ;Service 3DH, attribute 0 for file
        INT     21H                     ;Open file
        JC      EXIT                    ;If not found, exit
        CALL    READ_FILE               ;Pass file handle in AX to Read_File
        ADD     DI,2000                 ;Point to next storage area
        MOV     BX,DX                   ;Change A.Dat into B.Dat etc.
        INC     BYTE PTR CS:[BX]        ;A.DAT-->B.DAT etc.
        LOOP    LOOP                    ;Keep going over all files.
EXIT:   MOV     DX,OFFSET LOAD_SNAPSHOT ;Set up everything but LOAD_SNAPSHOT to
        INT     27H                     ;stay and attach itself to DOS
LOAD_SNAPSHOT        ENDP
DATA:
        CODE_SEG        ENDS
        
        END     FIRST   ;END "FIRST" so 8088 will go to FIRST first.

