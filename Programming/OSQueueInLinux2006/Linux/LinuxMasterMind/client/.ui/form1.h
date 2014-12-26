/****************************************************************************
** Form interface generated from reading ui file 'form1.ui'
**
** Created: Sun Jul 2 12:58:31 2006
**      by: The User Interface Compiler ($Id: qt/main.cpp   3.3.4   edited Nov 24 2003 $)
**
** WARNING! All changes made in this file will be lost!
****************************************************************************/

#ifndef CLIENTFRM_H
#define CLIENTFRM_H

#include <qvariant.h>
#include <qdialog.h>

class QVBoxLayout;
class QHBoxLayout;
class QGridLayout;
class QSpacerItem;
class QPushButton;
class QLineEdit;
class QTextEdit;

class clientfrm : public QDialog
{
    Q_OBJECT

public:
    clientfrm( QWidget* parent = 0, const char* name = 0, bool modal = FALSE, WFlags fl = 0 );
    ~clientfrm();

    QPushButton* recievebtn;
    QLineEdit* T3_2;
    QLineEdit* T1_2;
    QLineEdit* T2_2;
    QLineEdit* T4_2;
    QLineEdit* T4_3;
    QLineEdit* T1_3;
    QLineEdit* T2_3;
    QLineEdit* T3_3;
    QLineEdit* T4_4;
    QLineEdit* T3_4;
    QLineEdit* T2_4;
    QLineEdit* T1_4;
    QLineEdit* T3_5;
    QLineEdit* T4_5;
    QLineEdit* T2_5;
    QLineEdit* T1_5;
    QLineEdit* T1_6;
    QLineEdit* T2_6;
    QLineEdit* T3_6;
    QLineEdit* T4_6;
    QLineEdit* T3_7;
    QLineEdit* T4_7;
    QLineEdit* T1_7;
    QLineEdit* T2_7;
    QLineEdit* T4_8;
    QLineEdit* T3_8;
    QLineEdit* T2_8;
    QLineEdit* T1_8;
    QLineEdit* T4_9;
    QLineEdit* T3_9;
    QLineEdit* T2_9;
    QLineEdit* T1_9;
    QLineEdit* T1_10;
    QLineEdit* T4_10;
    QLineEdit* T2_10;
    QLineEdit* T3_10;
    QLineEdit* T1_1;
    QLineEdit* T2_1;
    QLineEdit* T3_1;
    QLineEdit* T4_1;
    QTextEdit* number;
    QPushButton* sendbtn;

    bool check;

public slots:
    virtual QString sendCommand() const;
    virtual void send();

protected:

protected slots:
    virtual void languageChange();

};

#endif // CLIENTFRM_H
