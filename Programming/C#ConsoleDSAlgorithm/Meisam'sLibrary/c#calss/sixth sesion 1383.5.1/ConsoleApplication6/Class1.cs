using System;

namespace ConsoleApplication6
{
	public class Time
	{
		//private member vaiables
		private int Year;
		private int Month;
		private int Date;
		private int Hour;
		private int Minute;
		private int Second;

		//public addessor methods
		public void DisplayCurrentTime()
		{
			System.Console.WriteLine(
				"{0}/{1}/{2} {3}:{4}:{5}",
				Month, Date, Year, Hour, Minute, Second);
		}
	
		//constructors
		public Time( System.DateTime dt)
		{
			Year =	dt.Year;
			Month =	dt.Month;
			Date =	dt.Day;
			Hour =	dt.Hour;
			Minute =	dt.Minute;
			Second =	dt.Second;
		}

		public Time(int Year, int Month, int Date,
			int Hour, int Minute, int Second)
		{
			this.Year =	Year;
			this.Month = Month;
			this.Date = Date;
			this.Hour = Hour;
			this.Minute = Minute;
			this.Second = Second;
		}
	}
	public class Tester
	{
		static void Main()
		{
			System.DateTime currentTime = System.DateTime.Now;

			Time t = new Time(currentTime);
			t.DisplayCurrentTime();

			Time t2 = new Time(2005,18,11,18,03,30);
			t2.DisplayCurrentTime();
			System.Console.ReadLine();
		}
	}
}
