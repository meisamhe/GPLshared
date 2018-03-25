#ifndef MYSERVER_H
#define MYSERVER_H

#include <qserversocket.h>
#include <qsocket.h>
class ServerForm;
class MyServerSocket : public QServerSocket{
Q_OBJECT
public :
	MyServerSocket(ServerForm * _serverForm);
	
	void newConnection ( int socket );
	
	QSocket * clientHost;
private:
	ServerForm * serverForm;

};

#endif
