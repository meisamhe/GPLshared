using System;

namespace ConsoleApplication7
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	class Tester
	{
		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		public static int Main()
		{
			//
			int i = 11;
			do
			{
				Console.WriteLine("i: {0}",i);
				i++;
			}while(i < 10);
			return 0;

			//
		}
	}
}
