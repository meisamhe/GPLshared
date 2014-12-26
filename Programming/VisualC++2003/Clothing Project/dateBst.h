#include <iostream.h>
//--------------------------------------------------------
#ifndef DATEBST_H
#define DATEBST_H
//---------------------------------------------------------
class dateBst
{
        struct treenode
        {
                char date[10];
                int seek;
                treenode *right, *left;
        };
        private:
                treenode *root;
//                void GlC(treenode, treenode&, treenode&); //Grand Left Data
        public:
                dateBst(){root=NULL;};
                bool insert (char [], int);
//              bool del ();
                int search (char[]);
//                ~dateBst();
};
#endif
