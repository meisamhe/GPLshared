#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>
#include <linux/stat.h>
#define FIFO_FILE "MYFIFO"
#define FIFO_FILE2 "MYFIFO2"

int main(void)
{
FILE *fp;
char readbuf[80];

while( readbuf == NULL)
{
fp = fopen(FIFO_FILE, "r");
fgets(readbuf, 80, fp);
printf("Received string: %s\n", readbuf);

if( readbuf !=NULL)
{
FILE *fp2;
umask(0);
mknod(FIFO_FILE2, S_IFIFO|0666, 0);
fp2 = fopen(FIFO_FILE2, "w");
strcat(readbuf , " > result.txt");
printf("%s",readbuf);
char results[800];

//filling result
fputs(results, fp2);
fclose(fp2);
}


}
return(0);
}
