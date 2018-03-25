#ifndef STRUCTURES_H
#define STRUCTURES_H

#define SERVER_GAMEOVER_WIN 0
#define SERVER_GAMEOVER_LOSE 1
#define SERVER_GAMERUNNING 2
#define SERVER_NUMBER_CHOSEN 3
#define CLIENT_START 4
#define CLIENT_GUESS 5

#define RED 1
#define GREEN 2
#define YELLOW 3


struct Message
{
	int Cmd;
	unsigned char data[4];
};

#endif