#include "linkedList.h"
//--------------------------------------------
linkedList::linkedList
{
        start=NULL;
}//end Constructor
//--------------------------------------------
void linkedList::insert (int data)
{
        if (start==NULL)
        {
                node *temp=new node;
                temp->date=data;
                temp->next=NULL;
                start=temp;
                return;
        }//end if
        node *temp=new node;
        temp->data=data;
        node *cur;
        cur=start;
        while (cur->next!=NULL)
                cur=cur->next;
        cur->next=temp;
        temp->next=NULL;
}//end insert
//----------------------------------------
linkedList::linkedList (linkedList &l)
{
        node *start=new node;
        start->next=NULL;
        start->data=l.start->data;
        node *temp, *cur=l.start, *prev=start;
        while (cur->next!=NULL)
        {
                cur=cur->next;
                temp = new node;
                temp->data=cur->data;
                temp->next=NULL;
                prev->next=temp;
                prev=cur;
        }//end while
}//end copy constructor

