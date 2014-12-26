using System;

namespace ConsoleApplication9
{
	public class RightNow
	{
		//public member variables
		public static readonly int Year;
		public static readonly int Month;
		public static readonly int Date;
		public static readonly int Hour;
		public static readonly int Minute;
		public static readonly int Second;

		static RightNow()
		{
			System.DateTime dt = System.DateTime.Now;
			Year =	dt.Year;
			Month =  dt.Month;
			Date =	dt.Day;
			Hour =	dt.Hour;
			Minute =	dt.Minute;
			Second	=	dt.Second;
		}
	}
	public class Tester
	{
		static void Main()
		{
			System.Console.WriteLine ("This year: {0}",
				RightNow.Year.ToString());
		//	RightNow.Year =	2006;	//error!
			System.Console.WriteLine("This year: {0}",RightNow.Year.ToString());
			System.Console.ReadLine();
		}
	}
}
