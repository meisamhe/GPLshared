#include "bst.h"

template <class data, class position>
bool bst<data, position> :: insert (data d, position* p)
{
        if (search (data)==true) return false;
        treenode* temp;
        temp = new treenode;
        temp->data=d;
        temp->left=NULL;
        temp->right=NULL;
        temp->position=p;
        if(root==NULL)
        {
             start=temp;
             return true;
        }
        treenode *cur,*pre;
        cur=root;
        pre=NULL;
        while(cur==NULL)
        {
                pre=cur;
                if(d>cur->data) cur=cur->right;
                else cur=cur->left;
        }
        if(d>pre->data)
        {
                pre->right=temp;
        }
        else pre->left=temp;
}//end insert
//----------------------------------------------------------------
template <class data, class position>
position bst <data, position> :: search (data)
{
    treenode *cur,*pre;
        cur=root;
        pre=NULL;
        while(cur==NULL)
        {
                pre=cur;
                if(d>cur->data) cur=cur->right;
                else if (d<cur->data) cur=cur->left;
                else return (cur->position);

        }
        return (NULL);
}//end search
//----------------------------------------------------------------
template <class data, class position>
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
//----------------------------------------------------------------

