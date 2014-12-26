using System;

namespace ConsoleApplication1
{
	class HeapNode
	{
		private int Value;
		private HeapNode right;
		private HeapNode left;

		#region Constructor
		public HeapNode(int Value) : this(Value,null, null){}
		public HeapNode(int Value,HeapNode right,HeapNode left) 
		{
			this.Value = Value;
			this.left = left;
			this.right = right;
		}
		#endregion
		#region Public Properties
		public int Data
		{
			get
			{
				return Value;
			}
			set
			{
				Value = value;
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
		#endregion
	}
	class Heap
	{
		private HeapNode root;
		private int size;

		#region constructor
		public Heap()
		{
			root = null;
			size = 0;
		}
		#endregion
		#region Public Methods
		public virtual void Clear()
		{
			root = null;
		}
		#endregion
		#region Public properties
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
		public int Size
		{
			get
			{
				return size;
			}
			set
			{
				size = value;
			}
		}
		#endregion
		#region Private function
		
		//this function takes the index of array and returns 
		//the node that the index is in
		private HeapNode Search(int Value)
		{
			if ( Value == 1 ) return root;
			HeapNode prev = root;
			int temp = Value;
			int i = 0;
			while ( temp != 0 )
			{
				temp /= 2;
				i++;
			}
			i--;
			int Root = 1;	//the node that u suppose to reach in any round
			int pre = 0;

			for( int j = 0; j < i; j++)
			{
				temp = Value;
				while ( Root != temp )
				{
					pre = temp;
					temp /= 2;
				}
				if ( pre % 2 == 0 )
				{
					prev = prev.Left;
					Root = pre;
				}
				else
				{
					prev = prev.Right;
					Root = pre;
				}
				if ( pre == Value )
					return prev;
			}
			return prev;
		}

		
		//this funcion defines the best position for each element
		private void MaxHeapify(int i)
		{
			HeapNode cur = Search(i);
			HeapNode Right = cur.Right;
			HeapNode Left = cur.Left;
			int largest;
			if ( Left!= null && Left.Data> cur.Data)
				largest = Left.Data;
			else
				largest = cur.Data;
			if ( Right != null && Right.Data > largest)
				largest = Right.Data;

			if( largest != cur.Data)
			{
				int temp;
				if (Right != null && largest == Right.Data)
				{
					largest = 2*i + 1;
					temp = cur.Data;
					cur.Data = Right.Data;
					Right.Data = temp;
				}
				else
				{
					largest = 2*i ;
					temp = cur.Data;
					cur.Data = Left.Data;
					Left.Data = temp;
				}
				MaxHeapify(largest);
			}
		}

		
		//this function sorts all the heap
		private void BuildMaxHeap()
		{
			for (int i= size/2; i >= 0 ; i--)
				MaxHeapify(i);
		}
		#endregion
		#region Public function
		public void Make(int[] TempArray)
		{
			if ( TempArray.Length != 0)
			{
				root = new HeapNode(TempArray[0]);
			}
			else
				return;
			HeapNode Temp;
			for( int i = 2; i <= TempArray.Length ; i++)
			{
				Temp = Search( i / 2 );
				HeapNode newNode = new HeapNode(TempArray[i - 1]);
				if ( i % 2 == 1)
					Temp.Right = newNode;
				else
					Temp.Left = newNode;
					
			}
			size = TempArray.Length;
		}

		public void HeapSort(int[] TempArray)
		{
			Make(TempArray);
			BuildMaxHeap();
			HeapNode temp;
			for(int i = size - 1;i >=0;i--)
			{
				temp = Search(size);
				TempArray[TempArray.Length - i - 1] = root.Data;
				root.Data = temp.Data;
				temp = Search(size/2);
				if(size % 2 == 1)
					temp.Right = null;
				else
					temp.Left = null;
				size--;
				MaxHeapify(1);
			}
		}

		public int HeapMaximum()
		{
			if( size < 1) return 0;
			return (root.Data);
		}
		
		public int HeapExtract()
		{
			if( size < 1 )
				return 0;
			int max;
			max = root.Data;
			HeapNode temp;
			temp = Search(size);
			root.Data = temp.Data;
			temp = Search(size /2);
			if( size % 2 ==1)
				temp.Right = null;
			else
				temp.Left = null;
			size--;
			MaxHeapify(1);
			return max;
		}
		
		public bool HeapIncreaseKey(int i,int key)
		{
			HeapNode cur = Search(i);
			if(key < cur.Data)
				return false;
			cur.Data = key;
			HeapNode temp = Search(i/2);
			int Temp;
			while ( i != 0 && temp.Data < key)
			{
				Temp = cur.Data;
				temp.Data = Temp;
				cur.Data = temp.Data;
				cur = temp;
				i/=2;
				temp = Search(i/2);
			}
			return true;
		}
		public bool Insert(int Value)
		{
			HeapNode par;
			size++;
			par = Search(size/2);
			HeapNode newNode = new HeapNode(Value);
			if ( newNode == null ) return false;
			if ( size % 2 == 1 )
			{
				par.Right = newNode;
			}
			else
			{
				par.Left = newNode;
			}
			return true;
		}
		#endregion
					
	}

	class Tester
	{
		public static void Main()
		{
			Console.WriteLine("This program is for Testin HeapSort");
			int length= int.Parse(Console.ReadLine());
			int[] TempArray;
			TempArray = new int[length];
			for( int i = 0; i < length; i++)
			{
				TempArray[i] = int.Parse(Console.ReadLine());
			}
			Heap Temp = new Heap();
			Temp.HeapSort(TempArray);
			Console.WriteLine("The Sorted Array is:");
			for ( int j = 0 ; j < TempArray.Length ; j++)
					Console.WriteLine("{0}",TempArray[j]);
			Console.ReadLine();
		}
	}
}
