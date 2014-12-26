/****************************************************************************
** Form interface generated from reading ui file 'form1.ui'
**
** Created: Fri Apr 28 16:03:20 2006
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

class Form1 : public QDialog
{
    Q_OBJECT

public:
    Form1( QWidget* parent = 0, const char* name = 0, bool modal = FALSE, WFlags fl = 0 );
    ~Form1();


public slots:
    virtual void convert();

protected:

protected slots:
    virtual void languageChange();

private:
    void init();

};

#endif // FORM1_H
