using System;

namespace ConsoleApplication1
{
	public class SomeClass
	{
		private int val;

		public	 SomeClass(int someVal)
		{
			val = someVal;
		}

		public override string ToString()
		{
			return val.ToString();
		}
	}

	public class Tester
	{
		static void Main()
		{
			int i = 5;
			Console.WriteLine("The value of i is: {0}", i.ToString());

			SomeClass s = new SomeClass(7);
			Console.WriteLine("The value of s is {0}", s.ToString());
			Console.ReadLine();
		}
	}

}
