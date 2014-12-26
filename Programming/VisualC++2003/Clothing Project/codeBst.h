#include <iostream.h>
//--------------------------------------------------------
#ifndef CODEBST_H
#define CODEBST_H
//---------------------------------------------------------
class codeBst
{
        struct treenode
        {
                long int code;
                int seek;
                treenode *right, *left;
        };
        private:
                treenode *root;
//                void GlC(treenode, treenode&, treenode&); //Grand Left Data
        public:
                codeBst(){root=NULL;};
                bool insert (long int, int);
//              bool del ();
                int search (long int);
//                ~codeBst();
};
#endif