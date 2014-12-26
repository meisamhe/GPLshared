#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <linux/stat.h>
#define FIFO_FILE "/tmp/fifo-file"

//second process

int main(void)
{
FILE *fp;
char readbuf[8000];


fp = fopen(FIFO_FILE, "w");
fputs("ls -l", fp);
fclose(fp);

fp = fopen (FIFO_FILE, "r");

char line[100];

fgets(line, 100, fp);
while (!feof(fp))
	{
	strcat(readbuf, line);
	fgets(line, 100, fp);
	}//while
printf ("The result is\n%s\n", readbuf);

return(0);
}
