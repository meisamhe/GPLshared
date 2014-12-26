using System;

namespace ConsoleApplication8
{
	public class Time
	{
		//private member variables
		private int year;
		private int month;
		private int date;
		private int hour;
		private int minute;
		private int second;

		//public accessor methods
		public void DisplayCurrentTime()
		{
			System.Console.WriteLine(
				"Time\t : {0}/{1}/{2} {3}:{4}:{5}",
				month, date, year, hour, minute, second);
		}

		//constructors
		public Time(System.DateTime dt)
		{
			year =	dt.Year;
			month =	dt.Month;
			date = dt.Day;
			hour =	dt.Hour;
			minute = dt.Minute;
			second = dt.Second;
		}

		//create a property
		public int Hour
		{
			get
			{
				return hour;
			}
			set 
			{
				hour =	value;
			}
		}
	}
	public class Tester
	{
		static void Main()
		{
			System.DateTime currentTime =	System.DateTime.Now;
			Time t = new Time(currentTime);
			t.DisplayCurrentTime();

			int theHour = t.Hour;
			System.Console.WriteLine("\nRetrieved the hour: {0}\n",theHour);
			theHour++;
			t.Hour =	theHour;
			System.Console.WriteLine("Updated the hour: {0}\n", theHour);
			System.Console.ReadLine();
		}
	}
}
