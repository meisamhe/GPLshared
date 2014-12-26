using System;

namespace ConsoleApplication17
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	public class Time
	{
		//private member variables
		int Year;
		int Month;
		int Date;
		int Hour;
		int Minute;
		int Second = 30;//initializer
		private static string Name = "Time";
		//public accessor methods
		//static constructor
//		static Time()
//		{
//			Name="Time";
//		}
		public void DisplayCurrentTime()
		{
			System.DateTime now=System.DateTime.Now;
			System.Console.WriteLine("\nDebug\t:{0}/{1}/{2} {3}:{4}:{5}",
				now.Month, now.Day, now.Year, now.Hour, 
				now.Minute, now.Second);
			System.Console.WriteLine("Name: {0}", Name);
			System.Console.WriteLine("Time\t: {0}/{1}/{2} {3}:{4}:{5}",
				Month, Date, Year, Hour, Minute, Second);
		}
		//constructor
		public Time(System.DateTime dt)
		{
			Year= dt.Year;
			Month= dt.Month;
			Date= dt.Day;
			Hour= dt.Hour;
			Minute= dt.Minute;
			Second= dt.Second;//explicit assignment
		}
		public Time(int Year, int Month, int Date,
			int Hour, int Minute)
		{
			this.Year= Year;
			this.Month= Month;
			this.Date= Date;
			this.Hour= Hour;
			this.Minute= Minute;
		}
	}

	
	public class Tester
	{
		static void Main()
		{
			System.DateTime currentTime=System.DateTime.Now;
			Time t=new Time(currentTime);
			t.DisplayCurrentTime();

			Time t2= new Time(2005,11,18,11,45);
			t2.DisplayCurrentTime();
			System.Console.ReadLine();
		}
	}
}
