using System;

namespace ConsoleApplication15
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	public class Time
	{
		//private variables
		private int Year;
		private int Month;
		private int Data;
		private int Hour;
		private int Minute;
		private int Second;

		//public methods
		public void DisplayCurrenTime()
		{
			Console.WriteLine("stub for DisplayCurrentTime");
		}
	}
	public class Tester
	{
		static void Main()
		{
			Time t=new Time();
			t.DisplayCurrenTime();
			Console.ReadLine();
		}
	}
}
