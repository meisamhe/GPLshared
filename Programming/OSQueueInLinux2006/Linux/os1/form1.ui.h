#include<sys/types.h>
#include<sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include<qstring.h>
#include<qfile.h>
void os1frm::send()
{
    char* path = "/mnt/sda1_removable/Linux/queue.txt";
    char readbuf[800];
   FILE *fp;
   umask(0);
   mkfifo(path, 0777);
   fp = fopen(path, "w");
   if ( fp == NULL)
	this->textLabel1->setText("Fuck ");
    else {
	this->textLabel1->setText("OK");
	QString input = textEdit3->text();
	fputs(input,fp);
	this->textLabel1->setText(input);
	fclose(fp);
              }
}
void os1frm::recieveResult()
{
    char* path = "/mnt/sda1_removable/Linux/queue1.txt";
    char buffer[100];
    FILE* fifo = fopen(path,"r");
    if ( fifo == NULL)
	textLabel1->setText("False");
    else
	textLabel1->setText("True");
     while (!feof(fifo))
        {
              fgets(buffer, 100, fifo);
              textLabel1->setText(buffer+textLabel1->text());
        }
}
