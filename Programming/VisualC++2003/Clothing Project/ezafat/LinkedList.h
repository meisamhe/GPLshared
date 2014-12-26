#ifndef LINKEDLIST_H
#define LINKEDLIST_H
//-----------------------------------------------
class linkedList
{
        struct node
        {
                node* next;
                int data;
        };//end node


        private:
                node* start;
        public:
                linkedList();
                int insert (int data);
                linkedList (linkedList &);
                ~linkedList();
};//end linkedlist
#endif
