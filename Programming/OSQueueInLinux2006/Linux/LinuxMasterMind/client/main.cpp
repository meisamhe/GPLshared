#include <qapplication.h>
#include "form1.h"
#include <iostream.h>
#include <string.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>

void sendtoserver(clientfrm * ,int );
int main( int argc, char ** argv )
{
    QApplication a( argc, argv );
    a.connect( &a, SIGNAL( lastWindowClosed() ), &a, SLOT( quit() ) );
    clientfrm w; 
    w.show();
    //new code
        int sockfd;
    struct sockaddr_in pin;
    hostent *server_host_name;
    server_host_name = gethostbyname( "127.0.0.1" );
    //SERVER PARAMETERS
    bzero( & pin, sizeof( pin ) );
    pin.sin_family = AF_INET;
    pin.sin_port = htons( 8000 );
    pin.sin_addr.s_addr = htonl( INADDR_ANY ); 
    pin.sin_addr.s_addr = ( ( in_addr * )( server_host_name->h_addr ) )->s_addr;
     //CREATING CLIENT END POINT
    sockfd = socket( AF_INET , SOCK_STREAM , 0 );
    //CONNECT REQUEST TO THE SERVER
    int con = connect( sockfd, ( sockaddr * )& pin , sizeof( pin ) );
    //own code
    char * command= "bigbang";
    // darj
    send(sockfd,command, strlen(command)+1,1);
    printf("%s\n",command);
     return a.exec();
}
void sendtoserver(clientfrm* w,int sockfd)
{
     //SENDING THE COMMAND TO THE SERVER
    const char *  command =w->sendCommand();
    send( sockfd , command , strlen( command ) + 1 , 0 );   
}
//    cout<< endl <ain.cpp:39: error: invalid conversion from `clientfrm*' to `int'
//< "Please enter a command or  "exit" to exit the program ." << endl;
    //  cin>> command;
    
//    while (1)
//    {
//	if (w.check ==true)
//	{
//	    w.check = false;
//	    sendtoserver(&w ,sockfd);
//	}
//    }
