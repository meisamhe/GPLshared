/****************************************************************************
** Form interface generated from reading ui file 'form1.ui'
**
** Created: Sun Jul 2 15:36:55 2006
**      by: The User Interface Compiler ($Id: qt/main.cpp   3.3.4   edited Nov 24 2003 $)
**
** WARNING! All changes made in this file will be lost!
****************************************************************************/

#ifndef FORM1_H
#define FORM1_H

#include <qvariant.h>
#include <qdialog.h>

class QVBoxLayout;
class QHBoxLayout;
class QGridLayout;
class QSpacerItem;
class QLineEdit;

class Form1 : public QDialog
{
    Q_OBJECT

public:
    Form1( QWidget* parent = 0, const char* name = 0, bool modal = FALSE, WFlags fl = 0 );
    ~Form1();

    QLineEdit* LN1;

public slots:
    virtual void showText( char * command );

protected:

protected slots:
    virtual void languageChange();

};

#endif // FORM1_H
