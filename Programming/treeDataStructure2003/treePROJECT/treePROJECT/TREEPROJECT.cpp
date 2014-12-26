// TREEPROJECT.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include<string>
#include <fstream>
using namespace std;
class treeNode
{
private:
	int data;
	treeNode *left;
	treeNode *right;
	int leftSize;
	int rightSize;
public:
	treeNode(int data)
	{
		this->data = data;
        this->left = 0;
		this->right = 0;
		this->leftSize = 0;
		this->rightSize = 0;
	}
	treeNode(int data,treeNode *left, treeNode *right)
	{
		this->data = data;
		this->left = left;
		this->right = right;
		if ( left)
			this->leftSize = left->getLeftSize() +left->getRightSize()+ 1;
		else 
			this->leftSize = 0;
		if ( right )
			this->rightSize = right->getLeftSize()+ right->getRightSize() + 1 ;
		else
			this->rightSize = 0;
	}
	int getData()
	{
		return data;
	}
	void setData(int data)
	{
		this->data = data;
	}
	void setLeft(treeNode *left)
	{
		this->left = left;
	}
	void setRight(treeNode *right)
	{
		this->right = right;
	}
	treeNode * getLeft()
	{
		return (this->left);
	}
	treeNode *getRight()
	{
		return (this->right);
	}
	void addRight()
	{
		this->rightSize++;
	}
	void addLeft()
	{
		this->leftSize++;
	}
	void minRight()
	{
		this->rightSize--;
	}
	void minLeft()
	{
		this->leftSize--;
	}
	int getLeftSize()
	{
		return this->leftSize;
	}
	int getRightSize()
	{
		return this->rightSize;
	}
	//check if two treeNode are equal or not
	bool operator==(treeNode *temp)
	{
		if (!temp )
			 return false;
		if (temp->getData() == data)
		{
			if( left== NULL && temp->getLeft()== NULL)
				if (right == NULL && temp->getRight() == NULL)
					return true;
				else
				{
					if (right == NULL || temp->getRight() == NULL)
						return false;
					if ((*right) == temp->getRight())
						return true;
					else return false;
				}
			else
			{
				if( left == NULL || temp->getLeft() == NULL)
					return false;
				if(right == NULL && temp->getRight() == NULL)
						if ( (*left) == temp->getLeft())
							return true;
						else	return false;
				else
					if( (*left) == temp->getLeft())
						if ( (*right) == temp->getRight())
							return true;
			}
		}
	return false;
	}
				
	~treeNode()
	{
	}
};
//----------------------------------------------------------------------------
class BST
{
private:
	treeNode *root;
	string name;
	//this function constructs the tree that its value are between start and end
	//in the array
	treeNode *construct(int preOrder[], int start, int end)
	{
		if ( start > end ) return NULL;
		treeNode *temp;
		if ( start == end) 
		{
			temp = new treeNode(preOrder[start],NULL,NULL);
			return temp;
		}
		int i = start+1;
		while(i <= end && preOrder[i] < preOrder[start])
			i++;
		treeNode *p = construct(preOrder,start+1,i-1);
		treeNode *q =construct(preOrder,i,end);
		if ( p )
			temp = new treeNode(preOrder[start],p,q);
		else
			if (q->getData() < preOrder[start])
					temp = new treeNode(preOrder[start],q,p);
			else
				temp = new treeNode(preOrder[start],p,q);
		return temp;
	}
	//delet one element of the tree that its' data is choosen
	bool delOne(int choosen,bool stage )
	{
		if (!search(choosen))
			return false;
		treeNode *cur = root;
		treeNode *prev = 0;
		int temp = 0;
		while ( cur )
		{
			if (choosen == cur->getData())
			{
				if ( !cur->getLeft() && !cur->getRight())
				{
					if (cur == root )
					{
						root = NULL;
						return true;
					}
					if ( prev ->getLeft() == cur)
					{
						if (stage)
							prev->minLeft();
						prev->setLeft(NULL);
					}
					else
					{	
						if (stage)
							prev->minRight();
						prev ->setRight(NULL);
					}
					
					cur->~treeNode();
					return true;
				}
				else 
					if ( !cur->getLeft() || !cur->getRight())
					{
						if ( cur == root )
						{
							if ( cur ->getLeft())
								root = cur->getLeft();
							else
								root = cur->getRight();
							cur->~treeNode();
							return true;
						}
						if (prev ->getLeft()== cur)
						{
							if ( cur->getLeft())
								prev->setLeft(cur->getLeft());
							else 
								prev->setLeft(cur->getRight());
							cur->~treeNode();
						}
						else
						{
							if ( cur ->getLeft())
								prev->setRight(cur->getLeft());
							else
								prev->setRight(cur->getRight());
							cur->~treeNode();
						}
						return true;
					}
					else 
					{
						treeNode *successor,*psuccess;
						psuccess = cur;
						successor = cur->getRight();
						if ( successor ->getLeft() )
						{
							while (successor->getLeft())
							{
								psuccess = successor;
								successor = successor->getLeft();
							}
						}
						temp = successor->getData();
						delOne(temp,false);
						cur->setData(temp);
						successor->~treeNode();
						return true;
					}

			}
			else
				if(choosen < cur->getData())
				{
					if (stage)
						cur->minLeft();
					prev = cur;
					cur = cur ->getLeft();
				}
				else	
					if (choosen > cur->getData())
					{
						if (stage)
							cur->minRight();
						prev = cur;
						cur = cur ->getRight();
					}
		}
		return false;
	}
	bool search ( int temp )
	{
		treeNode *cur = root;
		while( cur )
		{
			if ( cur ->getData() == temp )
				return true;
			if ( cur ->getData() > temp )
			{
				cur = cur->getLeft();
			}
			else
				cur = cur->getRight();
		}
		return false;
	}
	//adding one element to BST that its key is temp
	bool addOne(int temp)
	{
		if (search(temp))
			return false;
		treeNode *cur,*prev;
		cur = root;
		prev = NULL;
		while( cur )
		{
			if ( cur->getData()== temp )
				return false;
			if ( cur ->getData() > temp )
			{
				cur->addLeft();
				prev = cur;
				cur = cur->getLeft() ;
			}
			else
			{
				cur->addRight();
				prev = cur;
				cur = cur->getRight();
			}
		}
		treeNode *New = new treeNode(temp,NULL, NULL);
		if ( temp < prev->getData() )
			prev->setLeft(New);
		else 
			prev->setRight(New);
		return true;
	}
	void preOrder( treeNode *cur,ofstream &out)
	{
		if (cur == NULL ) return ;
		out<< cur->getData()<<' ';
		preOrder(cur->getLeft(),out);
		preOrder(cur->getRight(),out);
	}
	void DelSubBST(treeNode *root)
	{	
		if ( root == NULL ) return;
		DelSubBST(root->getLeft());
		DelSubBST(root->getRight());
		root->~treeNode();
	}


public:
	// constructor for empty tree
	BST(string name,ofstream &out)
	{
		root = NULL;
		this->name = name;
		out << "successful"<< "#"<<endl;
	}
	//constructor for full tree
	BST(string name,int preOrder[], int Length,ofstream &out)
	{
		this->name = name;
		 this->root = construct(preOrder, 0, Length -1);
		 out <<"successful"<<"#"<< endl;
	}
	//delet the keys in tha tree that are in the choosen array		
	void del(int choosen[], int length,ofstream &out)
	{
		for (int i = 0; i < length ; i++)
		{
			if (!delOne(choosen[i],true))
				out << "U ";//write the operation is unsuccessful
			else
				out << "S ";
		}
		out << "#"<<endl;
	}
	// addding the keys in the treee that are in the coosen array
	void add(int choosen[], int length,ofstream &out)
	{
		for (int i = 0; i < length; i++)
		{
			if (!addOne(choosen[i]))
				out << "U ";//write the operation is unsuccessful
			else
				out << "S ";
		}
		out <<"#"<< endl;
	}
	//writing the preorder traversal
	void preOrder(ofstream &out)
	{
		preOrder(root,out);
		out << "#"<<'\n';
	}
	//taking the key of the tree that are between min and max in that

	void between(const int &min,const int &max,treeNode *p, int &stage,ofstream &out)
	{
		if ( p == NULL ) return ;
		int LR='N';
		if( stage == 0 )
		{
			if( min < p -> getData())
			{
				if ( !p->getLeft() )
				{
					stage = 1;
					return;
				}
				else
				{
					between(min, max, p->getLeft(),stage,out);
					LR = 'L';
				}
			}
			else
			{
				if ( min > p -> getData())
				{
					stage = 1;
					between (min,max,p->getRight(),stage,out);
					LR ='R';
				}
				else
					if ( min == p->getData())
					{
						out << min << " ";
						stage = 1;
						return;
					}
			}
		}
		if (stage == 1)
		{
			if (LR == 'R')
				return;
			if ( p->getData() < max )
			{	
				if( LR != 'L')
							between(min,max,p->getLeft(),stage,out);
				out << p->getData() << " ";
				if( p->getRight())
					between(min,max,p->getRight(),stage,out);
			}
			else
			{
				if ( LR != 'L')
						between(min,max,p->getLeft(),stage,out);
				if ( p->getData() == max)
					out << max << " ";
				stage = 3;
				return;
			}
		}
			if ( stage == 3)
				return;
	}
	//taking the nth max in the tree
	int find(int k)
	{
		treeNode *p = root;;
		while( p )
		{
			if ( k == (p->getLeftSize()+1))
				return p->getData();
			if ( k < (p->getLeftSize()+1)) p= p->getLeft();
			else
			{
				k-= (p->getLeftSize()+ 1);
				p = p->getRight();
			}
		}
		return 0;
	}
	//check if two BST are equal
	bool operator==(BST temp)
	{
		if (!temp.getRoot())
			if (!root)
				return true;
			else 
				return false;
		if ( (*(temp.getRoot()))== root )
			return true;
		return false;
	}
	//returning the name of BST
	string getName()
	{
		return name;
	}
	//returning the root of BST
	treeNode *getRoot()
	{
		return root;
	}
	//deleting BST
	~BST()
	{
		DelSubBST(root);
	}
};
//-----------------------------------------------------------------------
class node
{
private:
	BST *data;
	node *next;
public:
	node(BST *data)
	{
		this->data = data;
		next = NULL;
	}
	BST *getData()
	{
		return data;
	}
	node *getNext()
	{
		return next;
	}
	void setNext(node* next)
	{
		this->next = next;
	}

	~node()
	{
		data.~BST();
	}
};
//------------------------------------------------------------------------

class linkedList
{
private:
	node *first;
public:
	linkedList()
	{
		first = NULL;
	}
	void add(BST *data)
	{
		node *temp = new node(data);
		temp->setNext(first);
		first = temp;
	}
	node *search(string name)
	{
		node *p = first;
		while( p )
		{
			if ( name == p->getData()->getName()   )
				return p;
			p = p->getNext();
		}
		return NULL;
	}
	void del(node *temp)
	{
		node *p = first;
		while( p->getNext() != temp)
			p = p->getNext();
		p->setNext(temp->getNext());
		temp->~node();
	}
	~linkedList()
	{
		node *p= first,*q;
		while( p != NULL)
		{
			q=p;
			p = p->getNext();
			q->~node();
		}
	}
};

int main(int argc, char* argv[])
{
	ifstream  infile("IN.TXT");
	ofstream  outfile("OUT.TXT");
	char buffer[300];
	string s("");
	string name("");
	string name1("");
	int j = 0,l = 0;
	int i1;
	int k = 0;
	int array[200];
	int stage = 0;
	BST *temp;
	node *cur,*checked;
	int max,min;
	linkedList *list= new linkedList();
	while( !infile.eof())
	{
		infile.getline(buffer,300,'#');
		s.erase();
		s.insert(0,buffer);
		if (s == "") break;
		l = s.length()- 1;
		int i = 3;
		while( buffer[i] != '>')
			i++;
		name.erase();
		name.append(buffer,3, i-3);
		switch (buffer[0])
		{
		case '1':
			outfile << "1 " << "<"<<name <<">"<< " ";
			cur = list->search(name);
			if ( cur != NULL )
			{
				outfile << "UNsuccessful because we have reserved this name for another tree #" << endl;
				break;
			}
			if ( name == "")
			{
				outfile << "UNsuccessful qauz undecleared name!!#"<< endl;
				break;
			}
			temp = new BST(name,outfile);
			list->add(temp);
			break;
		case '2':
			outfile << "2 " << "<"<<name <<">"<< " ";
			if ( name == "")
			{
				outfile << "UNsuccessful because undecleared name!!#"<< endl;
				break;
			}
			cur = list->search(name);
			if ( cur != NULL )
			{
				outfile << "UNsuccessful because we have reserved this name for another tree#" << endl;
				break;
			}
			k = 0;
			i+=2;
			while ( i < l )
			{
				j = 0;
				while ( buffer[i] <= '9' && buffer[i] >= '0')
				{
					j = (j*10)+ (buffer[i] -'0');
					i++;
				}
				array[k] = j;
				k++;
				if ( i <l && buffer[i] > '9' || buffer[i] < '0')
					i++;
			}
			temp = new BST(name, array, k,outfile);
			list->add(temp);

			break;
		case '3':
			outfile << "3 " << "<"<<name <<">"<< " ";
			cur = list->search(name);
			if ( cur == NULL )
			{
				outfile << "UNsuccessful#" << endl;
				break;
			}
			temp =cur->getData();
			k = 0;
			i+=2;
			while ( i < l )
			{
				j = 0;
				while ( buffer[i] <= '9' && buffer[i] >= '0')
				{
					j = (j*10)+ (buffer[i] -'0');
					i++;
				}
				array[k] = j;
				k++;
				if ( i <l && buffer[i] > '9' || buffer[i] < '0')
					i++;
			}
			temp->add(array,k,outfile);
			break;
		case '4':
			outfile << "4 " << "<"<<name <<">"<< " ";
			cur = list->search(name);
			if ( cur == NULL )
			{
				outfile << "UNsuccessful#" << endl;
				break;
			}
			temp =cur->getData();
			k = 0;
			i+=2;
			while ( i < l )
			{
				j = 0;
				while ( buffer[i] <= '9' && buffer[i] >= '0')
				{
					j = (j*10)+ (buffer[i] -'0');
					i++;
				}
				array[k] = j;
				k++;
				if ( i <l && buffer[i] > '9' || buffer[i] < '0')
					i++;
			}
			temp->del(array,k,outfile);
			break;
		case '5':
			outfile << "5 " << "<"<<name <<">"<< " ";
			cur = list->search(name);
			if ( cur == NULL )
			{
				outfile << "UNsuccessful#" << endl;
				break;
			}
			temp =cur->getData();
			temp->preOrder(outfile);
			break;
		case '6':
			outfile << "6 " << "<"<<name <<">"<< " ";
			cur = list->search(name);
			if ( cur == NULL )
			{
				outfile << "UNsuccessful#" << endl;
				break;
			}
			temp = cur ->getData();
			k = 0;
			i+=2;
			while ( i < l )
			{
				j = 0;
				while ( buffer[i] <= '9' && buffer[i] >= '0')
				{
					j = (j*10)+ (buffer[i] -'0');
					i++;
				}
				if ( k == 0 )
					min = j;
				else
					max = j;
				k++;
				if ( i <l && buffer[i] > '9' || buffer[i] < '0')
					i++;
			}
			stage = 0;
			temp->between(min,max,temp->getRoot(),stage,outfile);
			outfile<< "#"<<endl;

			break;
		case '7':
			outfile << "7 " << "<"<<name <<">"<< " ";
			cur = list->search(name);
			if ( cur == NULL )
			{
				outfile << "UNsuccessful#" << endl;
				break;
			}
			temp =cur->getData();
			i+=2;
			j = 0;
			while ( buffer[i] <= '9' && buffer[i] >= '0')
			{
				j = (j*10)+ (buffer[i] -'0');
				i++;
			}
			outfile<< temp->find(j) <<"#"<< endl;
			break;
		case '8':
			i+=2;
			i1=i;
			while( buffer[i] != '>')
				i++;
			name1.erase();
			name1.append(buffer,i1+1, i-i1-1);
			cur = list->search(name);
			checked = list->search(name1);
			outfile << "8 " << "<"<<name <<">"<< " "<< "<" << name1<<">";
			if ( cur == NULL || checked == NULL )
			{
				outfile << "UNsuccessful#" << endl;
				break;
			}
			temp =cur->getData();
			if( (*temp)== (*(checked->getData())))
				outfile <<"are equal"<<"#"<<endl;
			else
				outfile << "are not equal"<<"#"<<endl;
			break;
		case '9':
			outfile << "9 " << "<"<<name <<">"<< " ";
			cur = list->search(name);
			if ( cur == NULL )
			{
				outfile << "UNsuccessful#" << endl;
				break;
			}
			temp =cur->getData();
 			cur = list->search(name);
			temp = cur->getData();
			temp->~BST();
			outfile<<"deleted successfully"<<"#"<<endl;
			break;
		}
		infile.getline(buffer,100,'\n');
	}
	outfile<<"#"<<endl;
		list->~linkedList();
		infile.close();
		outfile.close();
	return 0;
}
