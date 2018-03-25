/****************************************************************************
** Form interface generated from reading ui file 'serverform.ui'
**
** Created: Fri Jun 30 17:34:17 2006
**      by: The User Interface Compiler ($Id: qt/main.cpp   3.3.5   edited Aug 31 12:13 $)
**
** WARNING! All changes made in this file will be lost!
****************************************************************************/

#ifndef SERVERFORM_H
#define SERVERFORM_H

#include <qvariant.h>
#include <qdialog.h>

class QVBoxLayout;
class QHBoxLayout;
class QGridLayout;
class QSpacerItem;
class QTextEdit;
class QGroupBox;
class QSpinBox;
class QPushButton;
class MyServerSocket;

class ServerForm : public QDialog
{
    Q_OBJECT

public:
    ServerForm( QWidget* parent = 0, const char* name = 0, bool modal = FALSE, WFlags fl = 0 );
    ~ServerForm();

    QTextEdit* logEdit;
    QGroupBox* groupBox1;
    QSpinBox* d1;
    QSpinBox* d2;
    QSpinBox* d3;
    QSpinBox* d4;
    QPushButton* pushButton1;

public slots:
    virtual void pushButton1_clicked();
    virtual void socket_readyBytes();

protected:
    MyServerSocket * mysocket;

    virtual void showEvent( QShowEvent * );
    virtual void init();

    QGridLayout* ServerFormLayout;
    QVBoxLayout* layout9;
    QGridLayout* layout8;
    QSpacerItem* spacer9;
    QSpacerItem* spacer7;
    QGridLayout* groupBox1Layout;
    QVBoxLayout* layout3;
    QSpacerItem* spacer1;
    QHBoxLayout* layout1;
    QHBoxLayout* layout2;
    QSpacerItem* spacer2;

protected slots:
    virtual void languageChange();

};

#endif // SERVERFORM_H
