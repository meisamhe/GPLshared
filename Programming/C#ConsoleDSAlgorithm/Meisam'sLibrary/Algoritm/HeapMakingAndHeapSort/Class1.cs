using System;

namespace ConsoleApplication1
{
	public  class  HeapNode
	{
		private int Value ;
		private HeapNode right;
		private HeapNode left ;

		#region Constructors
		public HeapNode(int Value) : this(Value, null, null){}
		public HeapNode(int Value,HeapNode left, HeapNode right)
		{
			this.Value = Value;
			this.left = left;
			this.right = right;
		}
		#endregion

		#region Public Properties
		public HeapNode Right
		{
			get
			{
				return right;
			}
			set 
			{
				right = value;
			}
		}
		public HeapNode Left
		{
			get
			{
				return left;
			}
			set
			{
				left = value;
			}
		}
		#endregion
	}
	public class Heap
	{
		private HeapNode root;

		public Heap()
		{
			root = null;
		}

		#region Public Methods
		public virtual void Clear()
		{
			root = null;
		}
		#endregion

		#region Public Properties
		public HeapNode Root
		{
			get
			{
				return root;
			}
			set
			{
				root = value;
			}
		}
		#endregion
	}
}
