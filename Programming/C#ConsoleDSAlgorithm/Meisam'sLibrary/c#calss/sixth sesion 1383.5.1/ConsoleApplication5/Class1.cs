using System;

namespace ConsoleApplication5
{
	public class Time
	{
		//private member variables
		private int Year;
		private int Month;
		private int Date;
		private int Hour;
		private int Minute;
		private int Second;

		//public accessor methods
		public void DisplayCurrentTime()
		{
			System.Console.WriteLine("{0}/{1}/{2} {3}:{4}:{5}", Month, Date, Year, Hour, Minute, Second);
		}
		public int GetHour()
		{
			return Hour;
		}

//		public void GetTime(out int h,out int m,out int s)
//		{
//			h = Hour;
//			m = Minute;
//			s = Second;
//		}
		public void setTime(int hr, out int min, ref int sec)
		{
			//if the passed in time is >=30
			//increment the minute and set second to 9
			//otherwise leave both alone
			if ( sec >=30 )
			{
				Minute++;
				Second = 0;
			}
			Hour = hr; // set to value passed in

			//pass the minute and second back out
			min = Minute;
			sec = Second;
		}
		
		//constructor
		public Time(System.DateTime dt)
		{
			Year = dt.Year;
			Month = dt.Month;
			Date = dt.Day;
			Minute = dt.Minute;
			Second = dt.Second;
		}
	}
	public class Tester
	{
		static void Main()
		{
			System.DateTime currentTime = System.DateTime.Now;
			Time t = new Time( currentTime);
			t.DisplayCurrentTime();

			int theHour = 3;
			int theMinute ;
			int theSecond = 20;

			t.setTime( theHour,out  theMinute,ref theSecond);
		//	System.Console.WriteLine("Current time: {0}:{1}:{2}",theHour,theMinute, theSecond);
			System.Console.WriteLine("the Minute is now: {0} and {1} seconds",
				theMinute, theSecond);
			theSecond = 40;
			t.setTime( theHour, out theMinute, ref theSecond);
			System.Console.WriteLine("the Minute is now: " +
				"{0} and {1} seconds",
				theMinute,theSecond);
		System.Console.ReadLine();
		}
	}

}
