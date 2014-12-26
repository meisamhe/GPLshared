using System;

namespace ConsoleApplication2
{
	public class Cat
	{
		private static int instances = 0;
		public Cat()
		{
			instances++;
		}
		public static void HowManyCats()
		{
			Console.WriteLine("{0} cats adopted",
				instances);
		}
	}
	public class Tester
	{
		static void Main()
		{
			Cat.HowManyCats();
			Cat frisky = new Cat();
			Cat.HowManyCats();
			Cat Whiskers = new Cat();
			Cat.HowManyCats();
			Console.ReadLine();
		}
	}

            

}
