
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>
#include <linux/stat.h>
#define FIFO_FILE "MYFIFO"
#define FIFO_FILE2 "MYFIFO2"
int main(void)
{

char readbuf[800];
/* Create the FIFO if it does not exist */

FILE *fp;
umask(0);
mknod(FIFO_FILE, S_IFIFO|0666, 0);
fp = fopen(FIFO_FILE, "w");
fputs("ls", fp);
fclose(fp);

FILE *fp2;
fp2 = fopen(FIFO_FILE2 , "r");

while(readbuf == NULL)
{
fgets(readbuf, 800, fp2);
printf("Received string: %s\n", readbuf);
fclose(fp2);

}
return(0);
}
