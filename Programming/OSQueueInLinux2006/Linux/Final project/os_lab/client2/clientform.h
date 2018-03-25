/****************************************************************************
** Form interface generated from reading ui file 'clientform.ui'
**
** Created: Fri Jun 30 17:34:12 2006
**      by: The User Interface Compiler ($Id: qt/main.cpp   3.3.5   edited Aug 31 12:13 $)
**
** WARNING! All changes made in this file will be lost!
****************************************************************************/

#ifndef CLIENTFORM_H
#define CLIENTFORM_H

#include <qvariant.h>
#include <qdialog.h>

class QVBoxLayout;
class QHBoxLayout;
class QGridLayout;
class QSpacerItem;
class QLineEdit;
class QPushButton;
class QTextEdit;
class QSpinBox;
class QSocket;

class ClientForm : public QDialog
{
    Q_OBJECT

public:
    ClientForm( QWidget* parent = 0, const char* name = 0, bool modal = FALSE, WFlags fl = 0 );
    ~ClientForm();

    QLineEdit* hostEdit;
    QPushButton* startButton;
    QTextEdit* logText;
    QSpinBox* d1;
    QSpinBox* d2;
    QSpinBox* d3;
    QSpinBox* d4;
    QPushButton* sendButton;

public slots:
    virtual void startButton_clicked();
    virtual void sendButton_clicked();
    virtual void socket_connected();
    virtual void socket_readyRead();

protected:
    QSocket * mySocket;

    virtual void init();
    virtual void paintEvent( QPaintEvent * paintev );

    QHBoxLayout* ClientFormLayout;
    QVBoxLayout* layout13;
    QSpacerItem* spacer9;
    QHBoxLayout* layout11;
    QHBoxLayout* layout12;

protected slots:
    virtual void languageChange();

};

#endif // CLIENTFORM_H
