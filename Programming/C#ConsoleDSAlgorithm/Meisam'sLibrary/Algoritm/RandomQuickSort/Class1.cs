using System;

namespace ConsoleApplication1
{
	class QuickSort
	{
		#region constructor
		public QuickSort(){}
		#endregion
		#region private functions
		private int RandomPartition(int[] tempArray, int first, int end)
		{
			Random temp = new Random(end);
			int i = temp.Next(first, end);
			int change;
			change = i;
			i = end;
			end = change;
			return Partition(tempArray, first, end);
		}
		private int Partition(int[] tempArray, int first, int end)
		{
			int x = tempArray[end];
			int i = first - 1;
			int temp;
			for( int j = first; j < end ;j++)
			{
				if( tempArray[j] <= x )
				{
					i++;
					temp = tempArray[i];
					tempArray[i] = tempArray[j];
					tempArray[j] = temp;
				}
			}
			temp = tempArray[i + 1];
			tempArray[i + 1] = tempArray[end];
			tempArray[end] = temp;
			return( i + 1 );
		}
		#endregion
		#region public functions
		public void RandomizedQuickSort(int[] tempArray, int first, int end)
		{
			if( first < end )
			{
				int middel = RandomPartition(tempArray, first, end);
				RandomizedQuickSort(tempArray, first, middel-1);
				RandomizedQuickSort(tempArray, middel+1, end);
			}
		}
		#endregion
	}
	class Tester
	{
		public static void Main()
		{
		}
	}
}
