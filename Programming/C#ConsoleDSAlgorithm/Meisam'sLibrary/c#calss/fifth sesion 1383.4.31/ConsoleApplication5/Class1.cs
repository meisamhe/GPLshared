using System;

namespace ConsoleApplication5
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
			repeat:      //the label
			Console.WriteLine("i: {0}",i);
			i++;
			if ( i < 10 )
				goto repeat; //the dastardly deed
			Console.ReadLine();
			return 0;
			//
		}
	}
}
