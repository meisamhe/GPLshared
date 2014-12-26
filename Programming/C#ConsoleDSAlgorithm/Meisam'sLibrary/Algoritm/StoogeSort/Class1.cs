using System;

namespace ConsoleApplication1
{
	class StoogeSort
	{
		public StoogeSort(){}
		public void Sort(int[] tempArray, int first, int end)
		{
			int temp ;
			if( tempArray[first] > tempArray[end] )
			{
				temp = tempArray[first];
				tempArray[first] = tempArray[end];
				tempArray[end] = temp;
			}
			if( first + 1 >= end )
				return;
			int k = ( ( end - first + 1)/3 );
			Sort(tempArray, first, end - k);
			Sort(tempArray, first + k, end);
			Sort(tempArray, first, end - k );
		}
	}
	class Tester
	{
		public static void Main()
		{
			Console.WriteLine( " This program is written to test stoogeSort");
			Console.WriteLine("Please insert the length of array");
			int length = int.Parse(Console.ReadLine());
			int[] tempArray = new int[length];
			for( int i = 0; i < length; i++)
			{
				tempArray[i] = int.Parse(Console.ReadLine());
			}
			StoogeSort temp = new StoogeSort();
			temp.Sort(tempArray,0,length - 1);
			for( int i = 0; i < length ; i++)
			{
				Console.Write("{0} ", tempArray[i]);
			}
			Console.ReadLine();
		}
	}
				
	}
