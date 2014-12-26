#include <iostream.h>
//--------------------------------------------------------
#ifndef CUSTOMERBST_H
#define CUSTOMERBST_H
//---------------------------------------------------------
class customerBst
{
        struct treenode
        {
                int code;
                int seek;
                treenode *right, *left;
        };
        private:
                treenode *root;
//                void GlC(treenode, treenode&, treenode&); //Grand Left Data
        public:
                customerBst(){root=NULL;};
                bool insert (int, int);
//              bool del ();
                int search (int);
                ~customerBst();
};
#endif
 