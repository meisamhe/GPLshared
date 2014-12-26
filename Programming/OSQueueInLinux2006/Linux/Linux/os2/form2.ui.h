#include<sys/types.h>
#include<sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include<qstring.h>
#include<qfile.h>
void Form2::recievePath()
{
    char* path = "/mnt/sda1_removable/Linux/queue.txt";
    char buffer[100];
    FILE* fifo = fopen(path,"r");
   // if ( fifo == NULL)
//	textLabel3->setText("False");
  //  else
	//textLabel3->setText("True");
textLabel3->setText("");
while (!feof(fifo))
        {
              fgets(buffer, 100, fifo);
              textLabel3->setText(buffer+textLabel3->text());
        }
}
void Form2::sendResult()
{
    char* path = "/mnt/sda1_removable/Linux/queue1.txt";    
    FILE *fp;
   umask(0);
   mkfifo(path, 0777);
   fp = fopen(path, "w");
   if ( fp == NULL)
	this->textLabel3->setText("Unsuccessful opening ");
    else {
	QString input = textLabel3->text();
	fputs(input,fp);
	this->textLabel3->setText(input);
	fclose(fp);
              }
}
void Form2::run()
{
    FILE *fp = popen(textLabel3->text(),"r");
    char buffer[100];
    while(!feof(fp))
    {
	fgets(buffer,100,fp);
	this->textLabel3->setText(textLabel3->text()+buffer);
    }
    fclose(fp);
}
