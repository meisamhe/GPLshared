/*
program mastermind;
 SYNOPSIS: MASTERMIND game, Player has to guess the colour and
    position of four hidden pegs arranged by the computer in row zero.
    The pegs are chosen from six colours and may be repeated.
    The computer gives hints with black and white pegs.
     Each black peg hint means, that one of the four guess is of
      right colour and at right position
     Each white peg means, that a guessed colour was right but in
      the wrong position.
    Using all the earlier hints the user tries again and again till
    she guesses all the colours and position of the pegs.

    Turbo Pascal 5.0 version for MSDOS/Windows95/WindowsNT (Console mode)
      available at http://www.cs.albany.edu/~mosh
    Turbo C 2.0 for MSDOS/Windows95/WindowsNT.
      tcc -Id:\tc\include -Ld:\tc\lib mastermind
    Curses C version for Linux/Unix, compile with:
      gcc -Wall mastermind.c -lcurses -ltermcap -o mastermind

 (C) GPL, Mohsin Ahmed and Maya Ahmed, 1992-1998.
     This is free program without any warranty, you may use/modity
     this program but keep this notice intact and must redistribute the
     original source unmodified with all distributions.
     Web:     http://www.cs.albany.edu/~mosh

     NOTES:
    +----------+-------------+--------------+
    | grid     | 0 1 2 3 4  5|6 7 8 9 10 11 |
    +----------+-------------+--------------+
        0        x solution x x x x x x
        1        x - - - -  x x _ _ _ _  \0
        2          guesses      hints
        ..        (four colors) (black/white)
                  ie. [1234]       [05]
        MAXTRY
    +----------+-------------+--------------+
    Last char is null, so we can treat each row
    as a string, for printing.
*/

#include <stdlib.h>
#include <ctype.h>
#include <time.h>
#include <string.h>
#include <assert.h>


#ifdef __TURBOC__
typedef unsigned char chtype;
enum { FALSE=0, TRUE=1 };
enum { BGCOL = 0, FGCOL = 15 };
#define endwin  clrscr
#define clear   clrscr
#define initscr clrscr
void   refresh(){ }
void   clrtoeol(){ clreol(); }
void   noecho(){ }
void   cbreak(){ }
void   move(int i,int j){ gotoxy(j+1,i+1); }
void   setcolor( chtype c){
    // Our colored peg are sequentially numbered '1'..'4'
    // we remap colors here.
    if( c == 'B' ){ textcolor( 8     ); textbackground( 0); return; }
    if( c == '3' ){ textcolor( 14    ); textbackground( 0); return; }
    if(isdigit(c)){ textcolor(c-'0'+8); textbackground( 0); return; }
    textcolor(FGCOL); textbackground(BGCOL);
}
void   addch( chtype c){ setcolor( c ); cprintf("%c",c); }
void   mvaddch(  int i, int j, chtype c ){ move(i,j); addch(c); }
void   addstr(chtype*s){ setcolor(0); cprintf("%s",s); }
void   mvaddstr( int i, int j, chtype*s ){ move(i,j); addstr(s); }
chtype mvgetch(  int i, int j   ){ move(i,j); return getche();}
#define time(X) 0 /* tcc linker can't find _setdate in module STIME? */
#else

#include <curses.h>
#endif

enum {
    NONE   = '-',  BLANK  = ' ',  BACKSPACE =  8 , CURSOR = '_',
    BLACK  = 'B',  WHITE  = 'W',
    // Overriding Turbo c colors in <conio.h>
    //  BLACK=0,BLUE=1,GREEN=2,CYAN=3,RED=4,MAGENTA=5,BROWN=6,LIGHTGRAY=7,
    //  DARKGRAY=8,LIGHTBLUE=9,LIGHTGREEN=10,LIGHTCYAN=11,LIGHTRED=12,
    //  LIGHTMAGENTA=13,YELLOW=14,WHITE=15,
    BLUE   = '1',  GREEN  = '2',  CYAN      = '3', RED    = '4',
    MAGENTA= '5',  BROWN  = '6',  LIGHTGRAY = '7', DARKGRAY='8',     
};

#define MAXTRY 19
#define until(C) while(!(C))

chtype grid[MAXTRY][12];

void drawgrid( int showsoln )
{
    int i=1, j;

    if( showsoln ){
        i = 0;
    }else{
        mvaddstr( i, 0+1, "-????-Hints" );
    }

    move(0,0); clrtoeol();
    for( ; i<=MAXTRY; i++ )
        // mvaddstr( i+1, 0+1, &grid[i][0] );
        for( j=0; j <= 10; j++ )
            mvaddch( i+1, j+1, grid[i][j] );

    refresh();
}

// Return number of black = correct entries in right locations.
//    whites = correct entries in wrong location.
// update grid[i,6..10] with black/white entries.

int checkgrid( int i )
{
    int  j, m, blacks=0, whites=0;
    char mark[5], used[5];
    int  k = 6;

    for( j=1; j<=4; j++ ){
        mark[j] = used[j] = BLANK;
        if( grid[i][j] == grid[0][j] ){
            grid[i][k++] = mark[j] = used[j] = BLACK;
            blacks++;
        }
    }

    for( j=1; j<=4; j++ )
        for( m=1; m<=4; m++ )
            if( (  m != j  )
                && (grid[i][j] == grid[0][m])
                && (mark[j] == BLANK )
                && (used[m] == BLANK )
            ){
                grid[i][k++] = mark[j] = used[m] = WHITE;
                whites++;
            }

    return blacks;
}

void help(void)
{
    mvaddstr( 2,22, "----------- Master Mind Game -----------");
    mvaddstr( 4,22, "Guess the four hidden numbered pins [");
       addch( RED ); addch( GREEN ); addch( BLUE ); addch( CYAN );
       addch( ']' ); 
    mvaddstr( 5,22, "in row 0, you will get hints, ie.");
    mvaddstr( 6,22, "Clues: " ); addch( BLACK );
              addstr(": a pin is in right place.");
    mvaddstr( 7,22, "       " ); addch( WHITE );
              addstr(": a pin color ok, but wrong position.");
    mvaddstr( 8,22, "A for Answers, Q to Quit, BACKSPACE to erase.");
    mvaddstr( 9,22, "S to see solution and play. Enter 4 numbers ");
    addch( RED ); addch( BLUE ); addch( GREEN ); addch( CYAN );
    addch('.');
    mvaddstr(11,22,
             "GPL(C) 1992-1998, by Mohsin Ahmed, mosh@cs.albany.edu");
    mvaddstr(12,22,
             "Pascal/C source code at http://www.cs.albany.edu/~mosh");
    mvaddstr(13,22,
             "Press any key to begin.");
    refresh();
    getch();
    move(11,22); clrtoeol();
    move(12,22); clrtoeol();
    move(13,22); clrtoeol();
    refresh();
}

char readuser( int s )
{
    int    i, j=1;
    chtype ch;

    do{
        do{
            if( j <= 4 )
                mvaddch(  s+1, j+1, CURSOR );

            ch = toupper( mvgetch( s+1, j+1 ) );

            mvaddch( s+1, j+1, ch );

            switch( ch ){
            case 'Q' :
            case 'A' :
                return ch;
            case 'S' :
                drawgrid( TRUE );
                break;
            case BACKSPACE :
                if( j > 1 ){
                    j--; mvaddch( s+1, j+1, ' ');
                }
                break;
            }

            assert( j <= 4 );

        }until( strchr( "1234", ch ) );

        grid[s][j] = ch;

        mvaddch( s+1, j+1, ch );

        j++;

        // Got all four colors?
        if( j == 5 )
            // Compare row s with rows 1..s-1, for dup.
            for( i=1; i<= s-1; i++ ){
                if( grid[s][1] == grid[i][1] &&
                    grid[s][2] == grid[i][2] &&
                    grid[s][3] == grid[i][3] &&
                    grid[s][4] == grid[i][4]
                ){
                    mvaddstr(22,0,"Already tried that.");
                    j = 1;   // start again.
                    break;
                }
            }

    }while( j < 5 );

    mvaddstr(22,0,"ok."); clrtoeol();

    return ch;
}


void
main(void)
{
    int  i, j, step, won, showsoln;
    chtype ch;

    srand(time(NULL));
    initscr(); cbreak(); noecho(); refresh();
    do{
        clear();
        help();

        showsoln = FALSE;

        for( i=0; i<=MAXTRY; i++ ){
            for( j=0; j<=10; j++ )
                grid[i][j] = NONE;
            grid[i][11]  = 0; // end of string.
        }

        for( j=1; j<=4; j++ )
            grid[0][j] = "1234"[ rand() % 4 ];

        step = 1;
        do{
            drawgrid( showsoln );
            ch = toupper( readuser( step ) );

            if( ch == 'A' ){
                break;
            }else if( ch == 'Q' )
                goto quit;

            won = checkgrid(step);
            step++;

            drawgrid( showsoln );

        }while( (step < MAXTRY) && (won != 4) && (ch != 'Q') );

        drawgrid( TRUE );

        if( won == 4 )
            mvaddstr( 22, 0, "Correct " );
        else if( step >= MAXTRY )
            mvaddstr( 22, 0, "Too many tries. ");

        mvaddstr( 23, 0, "Play again [y/n/q]? ");
        ch = toupper( getch() );
        addch( ch );
        refresh();

    }while( ch != 'N' && ch != 'Q' );

  quit:
    clear(); refresh();
    endwin();
}
