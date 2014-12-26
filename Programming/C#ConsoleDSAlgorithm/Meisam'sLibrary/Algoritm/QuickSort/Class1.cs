using System;

namespace ConsoleApplication1
{
	class QuickSort
	{
		public QuickSort(){}
		public void Sort(int[] tempArray, int first, int end)
		{
			if( first < end )
			{
				int middel = Partition(tempArray, first, end);
				Sort(tempArray, first, middel-1);
				Sort(tempArray, middel+1, end);
			}
		}
		private int Partition(int[] tempArray, int first, int end)
		{
			int x = tempArray[end];
			int i = first - 1;
			int temp = 0;
			for( int j = first; j <= end - 1; j++)
			{
				if ( tempArray[ j ] <= x)
				{
					i++;
					temp = tempArray[ i ];
					tempArray [ i ] = tempArray [ j ];
					tempArray [ j ] = temp;
				}
			}
			temp = tempArray[ i + 1 ];
			tempArray[ i + 1 ] = tempArray[ end ];
			tempArray[ end ] = temp;
			return i + 1;
		}
	}
	class tester
	{
		public static void Main()
		{
			Console.WriteLine("This program is for testing QuickSort");
			Console.WriteLine("please Insert the length of Array");
			int length = int.Parse(Console.ReadLine());
			int[] tempArray = new int[length];
			for( int j = 0; j < length ; j++ )
			{
				tempArray[ j ] = int.Parse(Console.ReadLine());
			}
			QuickSort temp = new QuickSort();
			temp.Sort(tempArray,0,length - 1);
			for( int j = 0; j < length; j++)
			{
				Console.Write("{0} ,", tempArray[j]);
			}
			Console.ReadLine();
		}
	}
}
