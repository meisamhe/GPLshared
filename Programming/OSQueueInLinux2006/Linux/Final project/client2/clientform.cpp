/****************************************************************************
** Form implementation generated from reading ui file 'clientform.ui'
**
** Created: Fri Jun 30 17:36:45 2006
**      by: The User Interface Compiler ($Id: qt/main.cpp   3.3.5   edited Aug 31 12:13 $)
**
** WARNING! All changes made in this file will be lost!
****************************************************************************/

#include "clientform.h"

#include <qvariant.h>
#include <qpushbutton.h>
#include <qlineedit.h>
#include <qtextedit.h>
#include <qspinbox.h>
#include <qlayout.h>
#include <qtooltip.h>
#include <qwhatsthis.h>
#include "clientform.ui.h"

/*
 *  Constructs a ClientForm as a child of 'parent', with the
 *  name 'name' and widget flags set to 'f'.
 *
 *  The dialog will by default be modeless, unless you set 'modal' to
 *  TRUE to construct a modal dialog.
 */
ClientForm::ClientForm( QWidget* parent, const char* name, bool modal, WFlags fl )
    : QDialog( parent, name, modal, fl )
{
    if ( !name )
	setName( "ClientForm" );
    ClientFormLayout = new QHBoxLayout( this, 11, 6, "ClientFormLayout"); 

    layout13 = new QVBoxLayout( 0, 0, 6, "layout13"); 

    layout11 = new QHBoxLayout( 0, 0, 6, "layout11"); 

    hostEdit = new QLineEdit( this, "hostEdit" );
    layout11->addWidget( hostEdit );

    startButton = new QPushButton( this, "startButton" );
    layout11->addWidget( startButton );
    layout13->addLayout( layout11 );

    logText = new QTextEdit( this, "logText" );
    logText->setSizePolicy( QSizePolicy( (QSizePolicy::SizeType)7, (QSizePolicy::SizeType)0, 0, 0, logText->sizePolicy().hasHeightForWidth() ) );
    logText->setTextFormat( QTextEdit::LogText );
    layout13->addWidget( logText );

    layout12 = new QHBoxLayout( 0, 0, 6, "layout12"); 

    d1 = new QSpinBox( this, "d1" );
    layout12->addWidget( d1 );

    d2 = new QSpinBox( this, "d2" );
    layout12->addWidget( d2 );

    d3 = new QSpinBox( this, "d3" );
    layout12->addWidget( d3 );

    d4 = new QSpinBox( this, "d4" );
    layout12->addWidget( d4 );

    sendButton = new QPushButton( this, "sendButton" );
    layout12->addWidget( sendButton );
    layout13->addLayout( layout12 );
    spacer9 = new QSpacerItem( 20, 101, QSizePolicy::Minimum, QSizePolicy::Expanding );
    layout13->addItem( spacer9 );
    ClientFormLayout->addLayout( layout13 );
    languageChange();
    resize( QSize(556, 398).expandedTo(minimumSizeHint()) );
    clearWState( WState_Polished );

    // signals and slots connections
    connect( startButton, SIGNAL( clicked() ), this, SLOT( startButton_clicked() ) );
    connect( sendButton, SIGNAL( clicked() ), this, SLOT( sendButton_clicked() ) );
    init();
}

/*
 *  Destroys the object and frees any allocated resources
 */
ClientForm::~ClientForm()
{
    // no need to delete child widgets, Qt does it all for us
}

/*
 *  Sets the strings of the subwidgets using the current
 *  language.
 */
void ClientForm::languageChange()
{
    setCaption( tr( "Client" ) );
    hostEdit->setText( tr( "127.0.0.1" ) );
    startButton->setText( tr( "Start" ) );
    sendButton->setText( tr( "Send" ) );
}

