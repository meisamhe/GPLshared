/****************************************************************************
** Form implementation generated from reading ui file 'form1.ui'
**
** Created: Mon May 15 11:38:21 2006
**      by: The User Interface Compiler ($Id: qt/main.cpp   3.3.4   edited Nov 24 2003 $)
**
** WARNING! All changes made in this file will be lost!
****************************************************************************/

#include "form1.h"

#include <qvariant.h>
#include <qpushbutton.h>
#include <qtextedit.h>
#include <qlabel.h>
#include <qlayout.h>
#include <qtooltip.h>
#include <qwhatsthis.h>
#include <qimage.h>
#include <qpixmap.h>

#include "../form1.ui.h"
/*
 *  Constructs a os1frm as a child of 'parent', with the
 *  name 'name' and widget flags set to 'f'.
 *
 *  The dialog will by default be modeless, unless you set 'modal' to
 *  TRUE to construct a modal dialog.
 */
os1frm::os1frm( QWidget* parent, const char* name, bool modal, WFlags fl )
    : QDialog( parent, name, modal, fl )
{
    if ( !name )
	setName( "os1frm" );
    setIcon( QPixmap::fromMimeSource( "1.png" ) );

    pushButton2 = new QPushButton( this, "pushButton2" );
    pushButton2->setGeometry( QRect( 150, 350, 111, 31 ) );

    textEdit3 = new QTextEdit( this, "textEdit3" );
    textEdit3->setGeometry( QRect( 10, 310, 220, 30 ) );

    textLabel2 = new QLabel( this, "textLabel2" );
    textLabel2->setGeometry( QRect( 10, 0, 71, 21 ) );

    textLabel1 = new QLabel( this, "textLabel1" );
    textLabel1->setGeometry( QRect( 0, 30, 271, 271 ) );
    textLabel1->setAlignment( int( QLabel::AlignCenter ) );

    pushButton1 = new QPushButton( this, "pushButton1" );
    pushButton1->setGeometry( QRect( 10, 350, 111, 31 ) );
    languageChange();
    resize( QSize(289, 385).expandedTo(minimumSizeHint()) );
    clearWState( WState_Polished );

    // signals and slots connections
    connect( pushButton1, SIGNAL( clicked() ), this, SLOT( send() ) );
    connect( pushButton2, SIGNAL( clicked() ), this, SLOT( recieveResult() ) );

    // tab order
    setTabOrder( textEdit3, pushButton1 );
    setTabOrder( pushButton1, pushButton2 );
}

/*
 *  Destroys the object and frees any allocated resources
 */
os1frm::~os1frm()
{
    // no need to delete child widgets, Qt does it all for us
}

/*
 *  Sets the strings of the subwidgets using the current
 *  language.
 */
void os1frm::languageChange()
{
    setCaption( tr( "os1" ) );
    pushButton2->setText( tr( "recieve" ) );
    textLabel2->setText( tr( "OUTPUT : " ) );
    textLabel1->setText( tr( "outpu" ) );
    pushButton1->setText( tr( "send" ) );
}

