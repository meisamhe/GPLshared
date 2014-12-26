using System;

namespace ConsoleApplication1
{
	class HoarPartitionQuickSort
	{
		public HoarPartitionQuickSort(){}
		private int HoarPartition(int[] tempArray, int first, int end)
		{
			int x = tempArray[first];
			int i = first - 1;
			int j = end + 1;
			int temp = 0;
			while ( true )
			{
				do
					j--;
				while(tempArray[j] > x );
				do
					i++;
				while( tempArray[i] < x );
				if( i < j )
				{
					temp = tempArray[i];
					tempArray[i] = tempArray[j];
					tempArray[j] = temp;
				}
				else
					return j;
			}
		}
		public void Sort(int[] tempArray, int first, int end)
		{
			if( first < end )
			{
				int middel = HoarPartition(tempArray, first, end);
				Sort(tempArray, first, middel - 1);
				Sort(tempArray, middel + 1, end );
			}
		}
	}
	class Tester
	{
		public static void Main()
		{
			Console.WriteLine("This program is Written to Test HoarPartition for QuickSort");
			Console.WriteLine("Please insert the length of Array");
			int length = int.Parse(Console.ReadLine());
			int[] tempArray = new int[length];
			for( int i = 0; i < length ; i++ )
			{
				tempArray[i] = int.Parse(Console.ReadLine());
			}
			HoarPartitionQuickSort temp = new HoarPartitionQuickSort();
			temp.Sort(tempArray, 0, length - 1);
			for( int j = 0; j < length ; j++)
			{
				Console.Write("{0} ", tempArray[j]);
			}
			Console.ReadLine();
		}
	}

				
}
