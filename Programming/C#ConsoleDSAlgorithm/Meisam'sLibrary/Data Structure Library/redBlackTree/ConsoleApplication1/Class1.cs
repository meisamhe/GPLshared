using System;

namespace RedBlackTree
{
	class treenode
	{
		private bool color;
		private int date;
		private treenode left;
		private treenode right;
		private treenode parent;

		//public treenode() : this (null){}
		public treenode(int data ) : this (false,data, null, null, null){}
		public treenode(bool color, int data, treenode left, treenode right,
			treenode parent)
		{
			this.color = color;
			this.date = data;
			this.left = left;
			this.right = right;
			this.parent = parent;
		}

		public bool Color
		{
			set
			{
				this.color = value;
			}
			get
			{
				return color;
			}
		}

		public int Data 
		{
			set
			{
				this.date = value;
			}
			get
			{
				return date;
			}
		}

		public treenode Left
		{
			set
			{
				this.left = value;
			}
			get
			{
				return left;
			}
		}

		public treenode Right
		{
			set
			{
				this.right = value;
			}
			get
			{
				return right;
			}
		}

		public treenode Parent
		{
			set
			{
				this.parent = value;
			}
			get
			{
				return parent;
			}
		}
	}
	class RedBlackTree
	{
		private treenode root;
		private treenode nil;

		public RedBlackTree()
		{
			root = null;
			nil = null;
		}

		public void LeftRotate(treenode temp)
		{
			treenode prev = temp.Right;
			temp.Right = prev.Left;
			prev.Left.Parent = temp;
			prev.Parent = temp.Parent;
			if ( temp.Parent == nil )
				root = prev;
			else if ( temp == temp.Parent.Left )
				temp.Parent.Left = prev;
			else temp.Parent.Right = temp;
			prev.Left = temp;
			temp.Parent = prev;
		}
		public void RightRotate(treenode temp)
		{
			treenode prev =temp.Right;
			temp.Left = prev.Right;
			prev.Right.Parent = temp;
			prev.Parent = temp.Parent;
			if ( temp.Parent == nil )
				root = prev;
			else if ( temp == temp.Parent.Right )
				temp.Parent.Right = prev;
			else temp.Parent.Left = temp;
			prev.Right = temp;
			temp.Parent = prev;
		}
		public void RBInsert( int data )
		{
			treenode temp = new treenode(data);
			treenode  prev = nil;
			treenode cur = root;
			while ( cur != nil )
				prev = cur;
			if (temp.Data <  cur.Data)
				cur = cur.Left;
			else cur = cur.Right;
			temp.Parent = prev;
			if ( prev == nil )
				root = temp;
			else if ( temp.Data < prev.Data )
				prev.Left = temp;
			else prev.Right =temp;
			temp.Left = nil;
			temp.Right = nil;
			temp.Color = true;
			RBInsertFixup( temp );
		}

		private void RBInsertFixup( treenode temp )
		{
			treenode  prev = null;
			while ( temp.Parent.Color == true )
			{
				if ( temp.Parent == temp.Parent.Parent.Left )
					prev = temp.Parent.Parent.Right;
				if (prev.Color == true )
				{
					temp.Parent.Color = false;
					prev.Color = false;
					temp.Parent.Parent.Color = true;
					temp = temp.Parent.Parent;
				}
				else if ( temp == temp.Parent.Right )
				{
					temp = temp.Parent;
					LeftRotate(temp );
					temp.Parent.Color = false;
					temp.Parent.Parent.Color = true;
					RightRotate(temp.Parent.Parent);
				}
				else
				{
					temp = temp.Parent;
					RightRotate(temp );
					temp.Parent.Color = false;
					temp.Parent.Parent.Color = true;
					LeftRotate ( temp.Parent.Parent);
				}
			}

			root.Color = false;
		}
		public treenode Successor(treenode temp )
		{
			if ( temp.Right != nil )
				return  Minimum( temp.Right );
			treenode prev = temp.Parent;
			while ( prev != nil && temp == prev.Right )
			{
				temp = prev;
				prev = prev.Parent;
			}
			return prev;
		}

		public treenode Minimum( treenode temp )
		{
			while ( temp.Left != nil )
				temp = temp.Left;
			return temp;
		}

		public treenode Maximum ( treenode temp )
		{
			while ( temp.Right != nil )
				temp = temp.Right ;
			return temp;
		}
		public treenode RBDelete( int data )
		{
			treenode temp = new treenode(data );
			treenode prev;
			treenode cur;
			if (temp.Left == nil ||  temp.Right == nil )
				prev = temp;
			else prev = Successor(temp );
			if ( prev.Left != nil )
				cur = prev.Left;
			else cur = prev.Right;
			cur.Parent = prev.Parent;
			if ( prev.Parent == nil )
				root = cur;
			else if ( prev == prev.Parent.Left )
				prev.Parent.Left =  cur;
			else prev.Parent.Right = cur;
			if ( prev != temp )
				temp.Data = prev.Data;
			if ( prev.Color == false )
				RBDeleteFixup (temp );
			return prev;
		}

		private void RBDeleteFixup( treenode temp )
		{
			treenode cur;
			while ( temp != root  && temp.Color == false )
				if ( temp == temp.Parent.Left )
				{
					cur = temp.Parent.Right;
					if ( cur.Color == true )
					{
						cur.Color = false;
						temp.Parent.Color = true;
						LeftRotate(temp.Parent);
						cur = temp.Parent.Right;
					}
					if ( cur.Left.Color  == false && cur.Right.Color == false )
					{
						cur.Color = true;
						temp = temp.Parent;
					}
					else if ( cur.Right.Color == false )
					{
						cur.Left.Color = false;
						cur.Color = true;
						RightRotate(cur);
						cur = temp.Parent.Right;
					}
					cur.Color = temp.Parent.Color;
					temp.Parent.Color = false;
					cur.Right.Color = false;
					LeftRotate(temp.Parent);
					temp = root;
				}
				else
				{
					cur = temp.Parent.Left;
					if ( cur.Color == true )
					{
						cur.Color = false;
						temp.Parent.Color = true;
						RightRotate(temp.Parent);
						cur = temp.Parent.Left;
					}
					if ( cur.Right.Color  == false && cur.Left.Color == false )
					{
						cur.Color = true;
						temp = temp.Parent;
					}
					else if ( cur.Left.Color == false )
					{
						cur.Right.Color = false;
						cur.Color = true;
						LeftRotate(cur);
						cur = temp.Parent.Left;
					}
					cur.Color = temp.Parent.Color;
					temp.Parent.Color = false;
					cur.Left.Color = false;
					RightRotate(temp.Parent);
					temp = root;
				}
			temp.Color = false;
		}
	}
}



					



