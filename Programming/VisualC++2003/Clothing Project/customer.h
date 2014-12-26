#ifndef CUSTOMER_H
#define CUSTOMER_H
#include <string.h>
//------------------------------------------------------
class customer
{
        private:
                static int customerCount;
                int code;
                char name [30];
                char address [100];
                char tel [12];
        public:
                customer(char[] n, char[] a, char[] t)
                {
                        customer::customerCount++;
                        code= customerCount;
                        strcpy (name, n);
                        strcpy (address, a);
                        strcpy (tel, t);
                }//
};//end class customer
int customer::customerCount=0;
#endif
//------------------------------------------------------
