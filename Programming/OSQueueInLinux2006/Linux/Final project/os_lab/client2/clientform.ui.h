/****************************************************************************
** ui.h extension file, included from the uic-generated form implementation.
**
** If you want to add, delete, or rename functions or slots, use
** Qt Designer to update this file, preserving your code.
**
** You should not define a constructor or destructor in this file.
** Instead, write your code in functions called init() and destroy().
** These will automatically be called by the form's constructor and
** destructor.
*****************************************************************************/
#include <qspinbox.h>
#include <qsocket.h>
#include <../common/structures.h>
#include <iostream>
#include <list>
#include <qpainter.h>
#include <sstream>

using namespace std;

list<Message> responses;
list<Message> guesses;


void ClientForm::startButton_clicked()
{
   
    mySocket->connectToHost(hostEdit->text() , 1025);
     logText->append("connecting...");
}


void ClientForm::sendButton_clicked()
{
	Message msg;
	msg.Cmd = CLIENT_GUESS;
	msg.data[0] = (unsigned char)d1->value();
	msg.data[1] = (unsigned char)d2->value();
	msg.data[2] = (unsigned char)d3->value();
	msg.data[3] = (unsigned char)d4->value();
	mySocket->writeBlock((char*)&msg , sizeof(Message));
	guesses.push_back(msg);
}


void ClientForm::socket_connected()
{
    logText->append("connected to Host.");
    responses.clear();
}


void ClientForm::socket_readyRead() 
{
	if ( mySocket->size() >= sizeof(Message) )
	{
		Message msg;
		mySocket->readBlock((char*)&msg,sizeof(Message));
		switch(msg.Cmd)
		{
			case SERVER_NUMBER_CHOSEN:
				logText->append("Guess the number :p !!!");
				d1->setEnabled(true);
				d2->setEnabled(true);
				d3->setEnabled(true);
				d4->setEnabled(true);
				sendButton->setEnabled(true);
				break;
			    case SERVER_GAMEOVER_WIN:
					logText->append("<font color=#ff0000><b> You Won !!! <i>Your IQ is over 50.");
				break;
			    case SERVER_GAMEOVER_LOSE:
					logText->append("<font color=#999999><b> You Lost !!! <i>Your IQ is under 50.");
				break;
			    case SERVER_GAMERUNNING:
			    	responses.push_back(msg);
			    	this->repaint();
				break;
		}	
	}    
}


void ClientForm::init()
{
   mySocket = new QSocket;
   connect(mySocket  , SIGNAL( connected() ) , this , SLOT( socket_connected() ) );
    connect(mySocket  , SIGNAL(readyRead()) , this , SLOT(socket_readyRead() ) );
}


void ClientForm::paintEvent( QPaintEvent * paintev)
{
	QPainter paint(this);
	int j = 0;
	for ( list<Message>::iterator iter = responses.begin() ; iter != responses.end() ; ++iter)
	{
		Message msg;
		msg = *iter;
		for ( int i = 0 ; i < 4 ; ++i )
		{
			switch ( msg.data[i] )
			{
				case GREEN:
					paint.setBrush(Qt::green);
					break;
				case YELLOW:
					paint.setBrush(Qt::yellow);
					break;
				case RED:
					paint.setBrush(Qt::red);
					break;
			}
			int x,y;
			y = d1->y() + d1->height() + 50 + j *35;
			switch ( i )
			{
				case 0 : 
					x = d1->x() + d1->width()/2 - 10;
					break;
				case 1 : 
					x = d2->x() + d2->width()/2 - 10;
					break;
				case 2 : 
					x = d3->x() + d3->width()/2 - 10;
					break;
				case 3 : 
					x = d4->x() + d4->width()/2 - 10;
					break;
			}
			paint.drawEllipse(x,y , 20 , 20);
		}
		j++;
	}
	j = 0;
	for ( list<Message>::iterator iter = guesses.begin() ; iter != guesses.end() ; ++iter)
	{
		Message msg;
		msg = *iter;
		for ( int i = 0 ; i < 4 ; ++i )
		{
			paint.setBrush(Qt::black);
			stringstream ss;
			ss << (int)msg.data[i];
			int x,y;
			y = d1->y() + d1->height() + 50 + j * 35;
			switch ( i )
			{
				case 0 : 
					x = d1->x() + d1->width()/2 - 10;
					break;
				case 1 : 
					x = d2->x() + d2->width()/2 - 10;
					break;
				case 2 : 
					x = d3->x() + d3->width()/2 - 10;
					break;
				case 3 : 
					x = d4->x() + d4->width()/2 - 10;
					break;
			}
			paint.drawText(x,y , ss.str().c_str());
		}
		j++;
	}
	
}