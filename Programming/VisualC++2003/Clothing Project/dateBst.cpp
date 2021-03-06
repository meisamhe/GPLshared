#include <string.h>
#include "dateBst.h"

bool dateBst :: insert(char d[], int s)
{
        if (search (d)==true) return false;
        treenode* temp;
        temp = new treenode;
        strcpy (temp->date, d);
        temp->left=NULL;
        temp->right=NULL;
        temp->seek=s;
//if empty
        if(root==NULL)
        {
             root=temp;
             return true;
        }
//else
        treenode *cur,*pre;
        cur=root;
        pre=NULL;
        while(cur!=NULL)
        {
                pre=cur;
                if(strcmp (d, cur->date)==1) cur=cur->right;
                else cur=cur->left;
        }
        if(strcmp (d, pre->date)==1)
        {
                pre->right=temp;
        }
        else pre->left=temp;
        return (true);
}//end insert
//----------------------------------------------------------------
int  dateBst :: search (char d[])
{
    treenode *cur;
        cur=root;
        while(cur!=NULL)
        {
                if(strcmp (d,cur->date)==1) cur=cur->right;
                else if (strcmp (d,cur->date)==-1) cur=cur->left;
                else return (cur->seek);

        }
        return (-1);
}//end search
//----------------------------------------------------------------
/*template <class data, class position>
bool bst <data, position> :: del (data d)
{
        treenode *search=root,*prev=NULL;
        while(search->data!=d && search!=NULL)
        {
                if(search->data>d) search=search->left;
                else if(search->data<d) search=search->right;
        }
        if(search==NULL) return(false);
        if(search->left==NULL && search->right==NULL)
        {
                if(prev)
                {
                        if(search->data<prev->data) prev->left=NULL;
                        else prev->right=NULL;
                }
                else{
                root=NULL;
//              niaz be bahs darad
        }
        if((search->left && !search->right) && (!search->left && search->right)
        {
                if(prev)
                {
                        if (search->right) prev->left=search->left;
                        else prev->left=search->left;
                }else{
                        if(search->left)    prev->right=search->right;
                        else    prev->right=search->left;
                        }
                }else if(search->right)  root=search->right;
                else root=search->left;
//              niaz be bahs darad
        }
         if((search->left && search->right)
         {
                treenode *rep,*reppop;
                GlC(search,rep,reppop);
                if(prev){
                        if( search->data<prev->data ) prev->left=rep;
                        else  prev->right=rep;
                        }else root=rep;
                 if(search==reppop)
                 {
                        if(rep->data>reppop->data)
                        {
                                prev->right=rep;
                                rep->right=search->right;
                        }
                 }
                 else
                 {
                        repop->right=search->right;
                        rep->right=search->right;
                        rep->left=search->left;
//               niaz be bahs darad
                 }
         }

}//end delete
//----------------------------------------------------------------
template <class data, class position>
void bst <data, position> :: GlC(treenode search, treenode& rep, treenode& repPop)
{
        repPop=search;
        search=search->left;
        rep=search;
        while (search->right!=NULL)
        {
                repPop=search;
                search=search->right;
        }
        rep=search;
}//end GLC
*/

//----------------------------------------------------------------

