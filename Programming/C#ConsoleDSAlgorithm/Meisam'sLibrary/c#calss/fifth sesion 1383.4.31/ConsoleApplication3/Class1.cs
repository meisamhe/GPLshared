using System;

namespace ConsoleApplication3
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	class Values
	{
		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main(string[] args)
		{
			//
			int temp=32;

			if ( temp <= 32)
			{
				Console.WriteLine("Warning Ice on road!");
				if ( temp == 32 )
				{
					Console.WriteLine("Temp exactly freezing, beware of water.");
				}// end secound if
				else
				{
					Console.WriteLine("Watch for black ice! Temp: {0}", temp);
				}// end else
			}//end first if
			Console.ReadLine();
			//
					
		}
	}
}
