namespace LinkedList
{
	class Node
	{
		int key;
		Node next,prev;

	//	public Node() : this(null) {}
		public Node(int key) : this( key , null, null) {}
		public Node(int key, Node next , Node prev)
		{
			this.key = key;
			this.next = next;
			this.prev = prev;
		}

		public int Key
		{
			set
			{
				key = value;
			}
			get
			{
				return key;
			}
		}

		public Node Prev
		{
			set
			{
				prev = value;
			}
			get
			{
				return prev;
			}
		}

		public Node Next
		{
			set
			{
				next = value;
			}
			get
			{
				return next;
			}
		}

	}
	class LinkedListSentinel
	{
		private Node Null;

		public LinkedListSentinel()
		{
			Null = null;
		}

		public Node Search(int key)
		{
			Node temp = Null.Next;
			while( temp != Null && temp.Key != key )
			{
				temp = temp.Next;
			}
			return temp;
		}

		public void Insert(int key)
		{
			Node temp = new Node(key);
			temp.Next = Null.Next;
			Null.Next.Prev = temp;
			Null.Next = temp;
			temp.Prev = Null;
		}

		public void Delete(Node x)
		{
			x.Prev.Next = x.Next;
			x.Next.Prev = x.Prev;
		}
	}
}