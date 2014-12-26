
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <linux/stat.h>

#define FIFO_FILE "/tmp/fifo-file"

// first process

int main(void)
{
FILE *fp;
char readbuf[800];

/* Create the FIFO if it does not exist */

umask(0);
mkfifo(FIFO_FILE, 0777);
fp = fopen(FIFO_FILE, "r");
//fputs("ls", fp);

char line[80];

//while (!EOF)
	{
	fgets (line, 80, fp);
	strcat(readbuf, line);
	}//while
printf("The command is:\n%s\n\n", readbuf);

fclose(fp);

strcat (readbuf, "> ");
strcat (readbuf, FIFO_FILE);
system (readbuf);
}
