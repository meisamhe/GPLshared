/****************************************************************************
** Form implementation generated from reading ui file 'form1.ui'
**
** Created: Sun Jul 2 13:47:25 2006
**      by: The User Interface Compiler ($Id: qt/main.cpp   3.3.4   edited Nov 24 2003 $)
**
** WARNING! All changes made in this file will be lost!
****************************************************************************/

#include "form1.h"

#include <qvariant.h>
#include <qpushbutton.h>
#include <qlineedit.h>
#include <qtextedit.h>
#include <qlayout.h>
#include <qtooltip.h>
#include <qwhatsthis.h>
#include <qimage.h>
#include <qpixmap.h>

#include "../form1.ui.h"
/*
 *  Constructs a clientfrm as a child of 'parent', with the
 *  name 'name' and widget flags set to 'f'.
 *
 *  The dialog will by default be modeless, unless you set 'modal' to
 *  TRUE to construct a modal dialog.
 */
clientfrm::clientfrm( QWidget* parent, const char* name, bool modal, WFlags fl )
    : QDialog( parent, name, modal, fl )
{
    if ( !name )
	setName( "clientfrm" );
    setFocusPolicy( QDialog::ClickFocus );

    recievebtn = new QPushButton( this, "recievebtn" );
    recievebtn->setGeometry( QRect( 110, 50, 80, 31 ) );

    T3_2 = new QLineEdit( this, "T3_2" );
    T3_2->setGeometry( QRect( 110, 130, 31, 21 ) );
    T3_2->setReadOnly( TRUE );

    T1_2 = new QLineEdit( this, "T1_2" );
    T1_2->setGeometry( QRect( 30, 130, 31, 21 ) );
    T1_2->setReadOnly( TRUE );

    T2_2 = new QLineEdit( this, "T2_2" );
    T2_2->setGeometry( QRect( 70, 130, 31, 21 ) );
    T2_2->setReadOnly( TRUE );

    T4_2 = new QLineEdit( this, "T4_2" );
    T4_2->setGeometry( QRect( 150, 130, 31, 21 ) );
    T4_2->setReadOnly( TRUE );

    T4_3 = new QLineEdit( this, "T4_3" );
    T4_3->setGeometry( QRect( 150, 160, 31, 21 ) );
    T4_3->setReadOnly( TRUE );

    T1_3 = new QLineEdit( this, "T1_3" );
    T1_3->setGeometry( QRect( 30, 160, 31, 21 ) );
    T1_3->setReadOnly( TRUE );

    T2_3 = new QLineEdit( this, "T2_3" );
    T2_3->setGeometry( QRect( 70, 160, 31, 21 ) );
    T2_3->setReadOnly( TRUE );

    T3_3 = new QLineEdit( this, "T3_3" );
    T3_3->setGeometry( QRect( 110, 160, 31, 21 ) );
    T3_3->setReadOnly( TRUE );

    T4_4 = new QLineEdit( this, "T4_4" );
    T4_4->setGeometry( QRect( 150, 190, 31, 21 ) );
    T4_4->setReadOnly( TRUE );

    T3_4 = new QLineEdit( this, "T3_4" );
    T3_4->setGeometry( QRect( 110, 190, 31, 21 ) );
    T3_4->setReadOnly( TRUE );

    T2_4 = new QLineEdit( this, "T2_4" );
    T2_4->setGeometry( QRect( 70, 190, 31, 21 ) );
    T2_4->setReadOnly( TRUE );

    T1_4 = new QLineEdit( this, "T1_4" );
    T1_4->setGeometry( QRect( 30, 190, 31, 21 ) );
    T1_4->setReadOnly( TRUE );

    T3_5 = new QLineEdit( this, "T3_5" );
    T3_5->setGeometry( QRect( 110, 220, 31, 21 ) );
    T3_5->setReadOnly( TRUE );

    T4_5 = new QLineEdit( this, "T4_5" );
    T4_5->setGeometry( QRect( 150, 220, 31, 21 ) );
    T4_5->setReadOnly( TRUE );

    T2_5 = new QLineEdit( this, "T2_5" );
    T2_5->setGeometry( QRect( 70, 220, 31, 21 ) );
    T2_5->setReadOnly( TRUE );

    T1_5 = new QLineEdit( this, "T1_5" );
    T1_5->setGeometry( QRect( 30, 220, 31, 21 ) );
    T1_5->setReadOnly( TRUE );

    T1_6 = new QLineEdit( this, "T1_6" );
    T1_6->setGeometry( QRect( 30, 250, 31, 21 ) );
    T1_6->setReadOnly( TRUE );

    T2_6 = new QLineEdit( this, "T2_6" );
    T2_6->setGeometry( QRect( 70, 250, 31, 21 ) );
    T2_6->setReadOnly( TRUE );

    T3_6 = new QLineEdit( this, "T3_6" );
    T3_6->setGeometry( QRect( 110, 250, 31, 21 ) );
    T3_6->setReadOnly( TRUE );

    T4_6 = new QLineEdit( this, "T4_6" );
    T4_6->setGeometry( QRect( 150, 250, 31, 21 ) );
    T4_6->setReadOnly( TRUE );

    T3_7 = new QLineEdit( this, "T3_7" );
    T3_7->setGeometry( QRect( 110, 280, 31, 21 ) );
    T3_7->setReadOnly( TRUE );

    T4_7 = new QLineEdit( this, "T4_7" );
    T4_7->setGeometry( QRect( 150, 280, 31, 21 ) );
    T4_7->setReadOnly( TRUE );

    T1_7 = new QLineEdit( this, "T1_7" );
    T1_7->setGeometry( QRect( 30, 280, 31, 21 ) );
    T1_7->setReadOnly( TRUE );

    T2_7 = new QLineEdit( this, "T2_7" );
    T2_7->setGeometry( QRect( 70, 280, 31, 21 ) );
    T2_7->setReadOnly( TRUE );

    T4_8 = new QLineEdit( this, "T4_8" );
    T4_8->setGeometry( QRect( 150, 310, 31, 21 ) );
    T4_8->setReadOnly( TRUE );

    T3_8 = new QLineEdit( this, "T3_8" );
    T3_8->setGeometry( QRect( 110, 310, 31, 21 ) );
    T3_8->setReadOnly( TRUE );

    T2_8 = new QLineEdit( this, "T2_8" );
    T2_8->setGeometry( QRect( 70, 310, 31, 21 ) );
    T2_8->setReadOnly( TRUE );

    T1_8 = new QLineEdit( this, "T1_8" );
    T1_8->setGeometry( QRect( 30, 310, 31, 21 ) );
    T1_8->setReadOnly( TRUE );

    T4_9 = new QLineEdit( this, "T4_9" );
    T4_9->setGeometry( QRect( 150, 340, 31, 21 ) );
    T4_9->setReadOnly( TRUE );

    T3_9 = new QLineEdit( this, "T3_9" );
    T3_9->setGeometry( QRect( 110, 340, 31, 21 ) );
    T3_9->setReadOnly( TRUE );

    T2_9 = new QLineEdit( this, "T2_9" );
    T2_9->setGeometry( QRect( 70, 340, 31, 21 ) );
    T2_9->setReadOnly( TRUE );

    T1_9 = new QLineEdit( this, "T1_9" );
    T1_9->setGeometry( QRect( 30, 340, 31, 21 ) );
    T1_9->setReadOnly( TRUE );

    T1_10 = new QLineEdit( this, "T1_10" );
    T1_10->setGeometry( QRect( 30, 370, 31, 21 ) );
    T1_10->setReadOnly( TRUE );

    T4_10 = new QLineEdit( this, "T4_10" );
    T4_10->setGeometry( QRect( 150, 370, 31, 21 ) );
    T4_10->setReadOnly( TRUE );

    T2_10 = new QLineEdit( this, "T2_10" );
    T2_10->setGeometry( QRect( 70, 370, 31, 21 ) );
    T2_10->setReadOnly( TRUE );

    T3_10 = new QLineEdit( this, "T3_10" );
    T3_10->setGeometry( QRect( 110, 370, 31, 21 ) );
    T3_10->setReadOnly( TRUE );

    T1_1 = new QLineEdit( this, "T1_1" );
    T1_1->setGeometry( QRect( 30, 100, 31, 21 ) );
    T1_1->setReadOnly( TRUE );

    T2_1 = new QLineEdit( this, "T2_1" );
    T2_1->setGeometry( QRect( 70, 100, 31, 21 ) );
    T2_1->setReadOnly( TRUE );

    T3_1 = new QLineEdit( this, "T3_1" );
    T3_1->setGeometry( QRect( 110, 100, 31, 21 ) );
    T3_1->setReadOnly( TRUE );

    T4_1 = new QLineEdit( this, "T4_1" );
    T4_1->setGeometry( QRect( 150, 100, 31, 21 ) );
    T4_1->setReadOnly( TRUE );

    number = new QTextEdit( this, "number" );
    number->setGeometry( QRect( 20, 10, 170, 25 ) );
    number->setMaximumSize( QSize( 32767, 32767 ) );
    number->setLineWidth( 0 );
    number->setMargin( 3 );
    number->setTextFormat( QTextEdit::AutoText );

    sendbtn = new QPushButton( this, "sendbtn" );
    sendbtn->setGeometry( QRect( 20, 50, 81, 31 ) );
    languageChange();
    resize( QSize(217, 408).expandedTo(minimumSizeHint()) );
    clearWState( WState_Polished );

    // signals and slots connections
}

/*
 *  Destroys the object and frees any allocated resources
 */
clientfrm::~clientfrm()
{
    // no need to delete child widgets, Qt does it all for us
}

/*
 *  Sets the strings of the subwidgets using the current
 *  language.
 */
void clientfrm::languageChange()
{
    setCaption( tr( "client" ) );
    recievebtn->setText( tr( "recieve" ) );
    sendbtn->setText( tr( "send" ) );
}

