
//OS LAB EXERCISE 4(GROUP1)
//CLIENT IMPLEMENTATION

#include <iostream.h>
#include <string.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>

using namespace std;

int main(   )
{
	char *command;
	cout<< endl << "Please enter a command or  "exit" to exit the program ." << endl;
	cin>> command;
	
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

	//SENDING THE COMMAND TO THE SERVER

    send( sockfd , command , strlen( command ) + 1 , 0 ); 
    
    return 0;

}