#include <iostream.h>
//--------------------------------------------------------
#ifndef CLOTHDATEBST_H
#define CLOTHDATEBST_H
//---------------------------------------------------------
class clothDateBst
{
        struct treenode
        {
                char date[10];
                int count;
                treenode *right, *left;
        };
        private:
                treenode *root;
//                void GlC(treenode, treenode&, treenode&); //Grand Left Data
        public:
                clothDateBst(){root=NULL;};
                clothDateBst (clothDateBst &);
                bool insert (char [], int);
//              bool del ();
                int search (char[]);
                ~clothDateBst();
};
#endif
