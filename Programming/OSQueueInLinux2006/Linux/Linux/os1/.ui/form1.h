/****************************************************************************
** Form interface generated from reading ui file 'form1.ui'
**
** Created: Mon May 15 11:37:37 2006
**      by: The User Interface Compiler ($Id: qt/main.cpp   3.3.4   edited Nov 24 2003 $)
**
** WARNING! All changes made in this file will be lost!
****************************************************************************/

#ifndef OS1FRM_H
#define OS1FRM_H

#include <qvariant.h>
#include <qdialog.h>

class QVBoxLayout;
class QHBoxLayout;
class QGridLayout;
class QSpacerItem;
class QPushButton;
class QTextEdit;
class QLabel;

class os1frm : public QDialog
{
    Q_OBJECT

public:
    os1frm( QWidget* parent = 0, const char* name = 0, bool modal = FALSE, WFlags fl = 0 );
    ~os1frm();

    QPushButton* pushButton2;
    QTextEdit* textEdit3;
    QLabel* textLabel2;
    QLabel* textLabel1;
    QPushButton* pushButton1;

public slots:
    virtual void send();
    virtual void recieveResult();

protected:

protected slots:
    virtual void languageChange();

};

#endif // OS1FRM_H
