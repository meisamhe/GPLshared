#include <iostream.h>
#include "linkedList.h"
//--------------------------------------------------------
#ifndef CLOTHSEARCHBYDATEBST_H
#define CLOTHSEARCHBYDATEBST_H
//---------------------------------------------------------
class clothSearchByDateBst
{
        struct treenode
        {
                long int code;
                linkedList seek;
                treenode *right, *left;
        };
        private:
                treenode *root;
//                void GlC(treenode, treenode&, treenode&); //Grand Left Data
        public:
                clothSearchByDateBst(){root=NULL;};
                void insert (long int c, int s);
//              bool del ();
                treenode search (long int c);
                ~clothSearchByDateBst();
};
#endif
