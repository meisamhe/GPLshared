using System;

namespace ConsoleApplication9
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
			for(int i=0; i < 100 ; i++)
			{
				Console.Write("{0}", i);

				if( i%10 == 0 )
				{
					Console.WriteLine("\t{0}", i);
				}
			}
			Console.WriteLine("\n Final value of i: {0}", i);
			Console.ReadLine();
			return 0;
					//
				}
	}
}
