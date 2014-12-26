/****************************************************************************
** Form implementation generated from reading ui file 'serverform.ui'
**
** Created: Fri Jun 30 17:34:19 2006
**      by: The User Interface Compiler ($Id: qt/main.cpp   3.3.5   edited Aug 31 12:13 $)
**
** WARNING! All changes made in this file will be lost!
****************************************************************************/

#include "serverform.h"

#include <qvariant.h>
#include <qpushbutton.h>
#include <qtextedit.h>
#include <qgroupbox.h>
#include <qspinbox.h>
#include <qlayout.h>
#include <qtooltip.h>
#include <qwhatsthis.h>
#include "myserversocket.h"
#include "serverform.ui.h"

/*
 *  Constructs a ServerForm as a child of 'parent', with the
 *  name 'name' and widget flags set to 'f'.
 *
 *  The dialog will by default be modeless, unless you set 'modal' to
 *  TRUE to construct a modal dialog.
 */
ServerForm::ServerForm( QWidget* parent, const char* name, bool modal, WFlags fl )
    : QDialog( parent, name, modal, fl )
{
    if ( !name )
	setName( "ServerForm" );
    ServerFormLayout = new QGridLayout( this, 1, 1, 11, 6, "ServerFormLayout"); 

    layout9 = new QVBoxLayout( 0, 0, 6, "layout9"); 

    layout8 = new QGridLayout( 0, 1, 1, 0, 6, "layout8"); 
    spacer9 = new QSpacerItem( 120, 20, QSizePolicy::Expanding, QSizePolicy::Minimum );
    layout8->addItem( spacer9, 0, 0 );

    logEdit = new QTextEdit( this, "logEdit" );
    logEdit->setSizePolicy( QSizePolicy( (QSizePolicy::SizeType)7, (QSizePolicy::SizeType)7, 0, 0, logEdit->sizePolicy().hasHeightForWidth() ) );
    logEdit->setMinimumSize( QSize( 400, 0 ) );
    logEdit->setTextFormat( QTextEdit::LogText );
    logEdit->setWrapPolicy( QTextEdit::AtWordBoundary );

    layout8->addWidget( logEdit, 0, 1 );
    spacer7 = new QSpacerItem( 119, 20, QSizePolicy::Expanding, QSizePolicy::Minimum );
    layout8->addItem( spacer7, 0, 2 );
    layout9->addLayout( layout8 );

    groupBox1 = new QGroupBox( this, "groupBox1" );
    groupBox1->setEnabled( FALSE );
    groupBox1->setColumnLayout(0, Qt::Vertical );
    groupBox1->layout()->setSpacing( 6 );
    groupBox1->layout()->setMargin( 11 );
    groupBox1Layout = new QGridLayout( groupBox1->layout() );
    groupBox1Layout->setAlignment( Qt::AlignTop );

    layout3 = new QVBoxLayout( 0, 0, 6, "layout3"); 
    spacer1 = new QSpacerItem( 20, 31, QSizePolicy::Minimum, QSizePolicy::Expanding );
    layout3->addItem( spacer1 );

    layout1 = new QHBoxLayout( 0, 0, 6, "layout1"); 

    d1 = new QSpinBox( groupBox1, "d1" );
    d1->setMaxValue( 9 );
    layout1->addWidget( d1 );

    d2 = new QSpinBox( groupBox1, "d2" );
    d2->setMaxValue( 9 );
    layout1->addWidget( d2 );

    d3 = new QSpinBox( groupBox1, "d3" );
    d3->setMaxValue( 9 );
    layout1->addWidget( d3 );

    d4 = new QSpinBox( groupBox1, "d4" );
    d4->setMaxValue( 9 );
    layout1->addWidget( d4 );
    layout3->addLayout( layout1 );

    layout2 = new QHBoxLayout( 0, 0, 6, "layout2"); 

    pushButton1 = new QPushButton( groupBox1, "pushButton1" );
    layout2->addWidget( pushButton1 );
    spacer2 = new QSpacerItem( 91, 20, QSizePolicy::Expanding, QSizePolicy::Minimum );
    layout2->addItem( spacer2 );
    layout3->addLayout( layout2 );

    groupBox1Layout->addLayout( layout3, 0, 0 );
    layout9->addWidget( groupBox1 );

    ServerFormLayout->addLayout( layout9, 0, 0 );
    languageChange();
    resize( QSize(744, 457).expandedTo(minimumSizeHint()) );
    clearWState( WState_Polished );

    // signals and slots connections
    connect( pushButton1, SIGNAL( clicked() ), this, SLOT( pushButton1_clicked() ) );
    init();
}

/*
 *  Destroys the object and frees any allocated resources
 */
ServerForm::~ServerForm()
{
    // no need to delete child widgets, Qt does it all for us
}

/*
 *  Sets the strings of the subwidgets using the current
 *  language.
 */
void ServerForm::languageChange()
{
    setCaption( tr( "Happy fekrobekr! :D " ) );
    groupBox1->setTitle( tr( "choose 4 digits" ) );
    pushButton1->setText( tr( "start the game" ) );
}

