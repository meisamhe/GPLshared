using System;

namespace BST
{
	class treenode
	{
		private int data;
		private treenode right;
		private treenode left;
		private treenode parent;

	//	public treenode() : this(null){}
		public treenode( int data) : this ( data, null, null , null){}
		public treenode( int data, treenode right, treenode left, treenode parent) 
		{
			this.right = right;
			this.left = left;
			this.data = data;
			this.parent = parent;
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
		public int Data
		{
			set
			{
				data = value;
			}
			get 
			{
				return data;
			}
		}

		public treenode Left
		{
			set
			{
				left = value;
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
				right = value;
			}
			get
			{
				return right;
			}
		}
	}

	class BST
	{
		private treenode root;

		public BST()
		{
			root = null;
		}

		public void InOrder(treenode cur)
		{
			if ( cur != null )
			{
				InOrder(cur.Left);
				Console.WriteLine(cur.Data);
				InOrder(cur.Right);
			}
		}

		public treenode Search( treenode cur, int data)
		{
			if ( cur == null || data == cur.Data )
				return cur;
			if ( data < cur.Data )
				return Search(cur.Left , data);
			else return Search( cur.Right, data);
		}

		public treenode ItrativeSearch( treenode cur, int data)
		{
			while ( cur != null && data != cur.Data )
				if ( data < cur.Data )
					cur = cur.Left;
				else
					cur = cur.Right;
			return cur;
		}

		public treenode Minimum(treenode cur )
		{
			while ( cur.Left != null )
				cur = cur.Left;
			return cur;
		}

		public treenode Maximum( treenode cur)
		{
			while ( cur.Right != null )
				cur = cur.Right;
			return cur;
		}

		public treenode Successor( treenode cur )
		{
			if ( cur.Right != null )
				return Minimum( cur.Right );
			treenode prev = cur.Parent;
			while ( prev != null && cur == prev.Right )
			{
				cur = prev;
				prev = prev.Parent;
			}
			return prev;
		} 

		public void Insert ( int data )
		{
			treenode temp = new treenode(data);
			treenode prev = null;
			treenode cur = root;
			while ( cur != null )
			{
				prev = cur ;
				if ( temp.Data < cur.Data )
					cur = cur.Left;
				else
					cur = cur.Right;
			}
			temp.Parent = prev;
			if ( prev == null )
				root = temp;
			else if ( temp.Data < prev.Data )
				prev.Left = temp;
			else prev.Right = temp;
		}

		public void Delete ( int data )
		{
			treenode temp = ItrativeSearch(root , data);
			treenode prev, cur;
			if ( temp.Left == null || temp.Right ==null )
				prev = temp;
			else  
				prev = Successor(temp );
			if (prev.Left != null )
				cur = prev.Left;
			else
				cur = prev.Right;
			if ( cur.Parent != null )
				cur.Parent = prev.Parent;
			if (prev.Parent == null )
				root = cur;
			else if ( prev == prev.Parent.Left )
				prev.Parent.Left = cur;
			else
				prev.Parent.Right = cur;
			if ( prev != temp )
				temp.Data = prev.Data;
		}
	}
}



