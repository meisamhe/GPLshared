#include <qapplication.h>
#include "form1.h"
#include <arpa/inet.h>
#include <netdb.h>
#include <netinet/in.h>
#include <unistd.h>
#include <iostream>
#define MAX_MSG 100
#define LINE_ARRAY_SIZE (MAX_MSG+1)
#include <stdlib.h>
#include <sys/socket.h>
#include   <stdio.h>
#include   <sys/un.h>
//int server (int client_socket,Form1 *w)
//{
//  while (1) {
//     int length;
//     char* text;
//     /* First, read the length of the text message from the socket. If
//        read returns zero, the client closed the connection. */
//     if (read (client_socket, &length, sizeof (length)) == 0)
//       return 0;
//     /* Allocate a buffer to hold the text. */
//     text = (char*) malloc (length);
//     /* Read the text itself, and print it. */
//     read (client_socket, text, length);
//     w->showText(text);
//    printf ("%s\n", text);
//    printf("%d\n",length);
//     /* Free the buffer. */
//     free (text);
//     /* If the client sent the message “quit,” we’re all done.  */
//     if (!strcmp (text, "quit"))
//       return 1;
//  }
//}
int main( int argc, char ** argv )
{
    QApplication a( argc, argv );
    Form1 w;
    w.show();
         int sockfd;
    struct sockaddr_in sin;
    struct sockaddr_in pin;
    int temp;
    socklen_t addr_size;
     //PREPARING FOR AN ORIENTED CONNECTION (MAKING A SOCKET)
     sockfd = socket( AF_INET , SOCK_STREAM , 0 );
    //PORT ALLOCATION TO THE DEFINED SERVER SOCKET
    bzero( & sin , sizeof( sin ) );
    sin.sin_family = AF_INET;
    sin.sin_port = htons( 8000 );
   sin.sin_addr.s_addr = INADDR_ANY;
    bind( sockfd , ( sockaddr * )& sin , sizeof( sin ) );
      //DETERMINING THE LENGTH OF SERVER QUEUE 
     listen( sockfd , 100);
    bool flag = true;
    char * command;
    char * exit = "exit";
//    while( flag )
//    {                
//            //HANDSHAKING WITH THE CLIENT SIDE
//              temp = accept( sockfd , ( sockaddr * )& pin , & addr_size );
//            //RECEIVING THE COMMAND AND EXECUTING IT
//              recv( temp , command , 16384 , 0 );
//               w.showText(command);
//               printf ("%s\n", command);
//	printf("%d\n",sizeof(command));
//         /*     if( strcmp( command , exit ) != 0 )
//                        system( command );
//                else
//                        flag = false;*/
//     }
   while(1)
    {
       temp = accept( sockfd, (sockaddr *)&pin, & addr_size);
       recv(temp,command,1024,0);
       printf("%s\n",command);
       printf("%d\n",sizeof(command));
     }
  //  close (sockfd);
    return a.exec();
}
/*  
//     const char* const socket_name  = "meisam";    
//    //argv[1]
//    int socket_fd;
//    struct sockaddr_un name;
//    int client_sent_quit_message;
//    /* Create the socket. */
//    socket_fd = socket (PF_LOCAL, SOCK_STREAM, 0);
//    /* Indicate that this is a server. */
//    name.sun_family = AF_LOCAL;
//    strcpy (name.sun_path, socket_name);
//    bind (socket_fd, ( sockaddr * )& name, SUN_LEN (&name));
//    /* Listen for connections. */
//    listen (socket_fd, 5);
//    /* Repeatedly accept connections, spinning off one server() to deal
//   with each client. Continue until a client sends a “quit” message.   */
//    do {
//	struct sockaddr_un client_name;
//	socklen_t client_name_len;
//	int client_socket_fd;
//	/* Accept a connection. */
//	client_socket_fd = accept (socket_fd, ( sockaddr * )& client_name, &client_name_len);
//	/* Handle the connection. */
//	client_sent_quit_message = server (client_socket_fd,&w);
//	/* Close our end of the connection. */
//	close (client_socket_fd);
//    }   while (!client_sent_quit_message);   /* Remove the socket file.  */
//    close (socket_fd);
//    unlink (socket_name);
