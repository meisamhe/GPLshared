/****************************************************************************
** Form implementation generated from reading ui file 'form2.ui'
**
** Created: Mon May 15 11:39:42 2006
**      by: The User Interface Compiler ($Id: qt/main.cpp   3.3.4   edited Nov 24 2003 $)
**
** WARNING! All changes made in this file will be lost!
****************************************************************************/

#include "form2.h"

#include <qvariant.h>
#include <qlabel.h>
#include <qpushbutton.h>
#include <qlayout.h>
#include <qtooltip.h>
#include <qwhatsthis.h>
#include <qimage.h>
#include <qpixmap.h>

#include "../form2.ui.h"
/*
 *  Constructs a Form2 as a child of 'parent', with the
 *  name 'name' and widget flags set to 'f'.
 *
 *  The dialog will by default be modeless, unless you set 'modal' to
 *  TRUE to construct a modal dialog.
 */
Form2::Form2( QWidget* parent, const char* name, bool modal, WFlags fl )
    : QDialog( parent, name, modal, fl )
{
    if ( !name )
	setName( "Form2" );

    textLabel4 = new QLabel( this, "textLabel4" );
    textLabel4->setGeometry( QRect( 10, 10, 81, 31 ) );

    pushButton6 = new QPushButton( this, "pushButton6" );
    pushButton6->setGeometry( QRect( 10, 331, 240, 40 ) );

    pushButton5 = new QPushButton( this, "pushButton5" );
    pushButton5->setGeometry( QRect( 10, 290, 240, 40 ) );

    pushButton3 = new QPushButton( this, "pushButton3" );
    pushButton3->setGeometry( QRect( 10, 250, 240, 40 ) );

    textLabel3 = new QLabel( this, "textLabel3" );
    textLabel3->setGeometry( QRect( 21, 50, 230, 190 ) );
    textLabel3->setFrameShape( QLabel::NoFrame );
    textLabel3->setFrameShadow( QLabel::Plain );
    textLabel3->setAlignment( int( QLabel::AlignCenter ) );
    languageChange();
    resize( QSize(280, 392).expandedTo(minimumSizeHint()) );
    clearWState( WState_Polished );

    // signals and slots connections
    connect( pushButton5, SIGNAL( clicked() ), this, SLOT( recievePath() ) );
    connect( pushButton3, SIGNAL( clicked() ), this, SLOT( sendResult() ) );
    connect( pushButton6, SIGNAL( clicked() ), this, SLOT( run() ) );
}

/*
 *  Destroys the object and frees any allocated resources
 */
Form2::~Form2()
{
    // no need to delete child widgets, Qt does it all for us
}

/*
 *  Sets the strings of the subwidgets using the current
 *  language.
 */
void Form2::languageChange()
{
    setCaption( tr( "Form2" ) );
    textLabel4->setText( tr( "message:" ) );
    pushButton6->setText( tr( "run" ) );
    pushButton5->setText( tr( "recive" ) );
    pushButton3->setText( tr( "send" ) );
    textLabel3->setText( tr( "message" ) );
}

