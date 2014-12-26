using System;

namespace ConsoleApplication1
{
	class StackDepthQuickSort
	{
		public StackDepthQuickSort(){}
		public void Sort(int[] tempArray, int first, int end)
		{
			int middel ;
			while( first < end )
			{
				middel = Partition(tempArray, first, end );
				Sort(tempArray, first, middel - 1);
				first = middel + 1;
			}
		}
		private int Partition(int[] tempArray, int first, int end)
		{
			int x = tempArray[ end ];
			int i = first - 1;
			int temp;
			for( int j = first; j < end ;j++)
			{
				if( tempArray[j] <= x)
				{
					i++;
					temp = tempArray[i];
					tempArray[i] = tempArray[j];
					tempArray[j] = temp;
				}
			}
			temp = tempArray[i + 1];
			tempArray[i + 1] = tempArray[ end ];
			tempArray[ end ] = temp;
			return i + 1;
		}
	}
	class Tester
	{
		public static void Main()
		{
			Console.WriteLine("This Program is for Testing StackDepthQuickSort");
			Console.WriteLine("Please insert length of Array that you want to be Sort");
			int length  = int.Parse(Console.ReadLine());
			int[] tempArray = new int[length];
			for( int i = 0; i < length ; i++)
			{
				tempArray[i] = int.Parse(Console.ReadLine());
			}
			StackDepthQuickSort temp = new StackDepthQuickSort();
			temp.Sort(tempArray, 0, length - 1);
			for(int i = 0; i < length ; i++)
			{
				Console.Write("{0} ",tempArray[i]);
			}
			Console.ReadLine();
		}
	}
}
