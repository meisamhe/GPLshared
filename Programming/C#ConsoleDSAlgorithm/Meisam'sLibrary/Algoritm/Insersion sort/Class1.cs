using System;
namespace ConsoleApplication2
{
	public class InsertionSort
	{
		private int[] Array;
		private int length;
		public InsertionSort(int length)
		{
			Array = new int[length];
			Console.WriteLine("Please insert the array with the form (* ,* ) please");
			for ( int i = 0; i < length-1; i++)
			{
				Array[i]=int.Parse(Console.ReadLine());
			}
			Array[length - 1 ]=int.Parse(Console.ReadLine());
			this.length = length;
		}
		public void Sort()
		{
			int key;
			int i;
			for(int j = 1 ; j < length ; j++)
			{
				key = Array[j];
				for(i=j-1; i >= 0 && key < Array[i] ; i--)
				{
					Array[i+1] = Array[i];
				}
				Array[i+1] = key;
			}
		}
		public void Show()
		{
			Console.Write("{ ");
			for( int i = 0; i < length-1; i++)
			{
				Console.Write("{0}, ", Array[i]);
			}
			Console.Write("{0} ",Array[length - 1]);
			Console.Write("}");
		}
	}
	       

	class Tester
	{
		public static void Main()
		{
			Console.WriteLine("This program is Written for Insersion sort");
			Console.WriteLine("plez insert the length of the Array");
			int length = int.Parse(Console.ReadLine());
			InsertionSort Array1 = new InsertionSort(length);
			Array1.Sort();
			Array1.Show();
			Console.ReadLine();
		}
	}
}
