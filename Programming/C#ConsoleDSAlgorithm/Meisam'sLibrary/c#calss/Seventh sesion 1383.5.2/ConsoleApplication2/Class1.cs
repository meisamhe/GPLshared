using System;

namespace ConsoleApplication2
{
	public class UnBoxingTesting
	{
		public static void Main()
		{
			int i=123;

			//Boxing
			object o = i;

			//unBoxing( must be explict )
			int j = (int) o;
			Console.WriteLine("j: {0}", j);
			Console.ReadLine();
		}
	}
}
