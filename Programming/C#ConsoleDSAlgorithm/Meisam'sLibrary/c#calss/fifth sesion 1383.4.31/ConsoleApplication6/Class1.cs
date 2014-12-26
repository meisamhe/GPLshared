using System;

namespace ConsoleApplication6
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	public class Tester
	{
		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		public static int Main()
		{
			//
			int i=0;
			while ( i < 10 )
			{
				Console.WriteLine("i: {0}",i);
				i++;
			}
			Console.ReadLine();
			return 0;
			//
		}
	}
}
