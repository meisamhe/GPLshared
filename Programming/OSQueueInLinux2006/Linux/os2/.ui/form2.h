/****************************************************************************
** Form interface generated from reading ui file 'form2.ui'
**
** Created: Mon May 15 11:37:16 2006
**      by: The User Interface Compiler ($Id: qt/main.cpp   3.3.4   edited Nov 24 2003 $)
**
** WARNING! All changes made in this file will be lost!
****************************************************************************/

#ifndef FORM2_H
#define FORM2_H

#include <qvariant.h>
#include <qdialog.h>

class QVBoxLayout;
class QHBoxLayout;
class QGridLayout;
class QSpacerItem;
class QLabel;
class QPushButton;

class Form2 : public QDialog
{
    Q_OBJECT

public:
    Form2( QWidget* parent = 0, const char* name = 0, bool modal = FALSE, WFlags fl = 0 );
    ~Form2();

    QLabel* textLabel4;
    QPushButton* pushButton6;
    QPushButton* pushButton5;
    QPushButton* pushButton3;
    QLabel* textLabel3;

public slots:
    virtual void recievePath();
    virtual void sendResult();
    virtual void run();

protected:

protected slots:
    virtual void languageChange();

};

#endif // FORM2_H
