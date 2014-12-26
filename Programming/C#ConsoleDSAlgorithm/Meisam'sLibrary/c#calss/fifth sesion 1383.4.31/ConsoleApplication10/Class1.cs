using System;

namespace ConsoleApplication10
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
			string signal="0";	//initialize to neutral
			while ( signal != "X" )// X indicates stop
			{
				Console.Write("Enter a signal: ");
				signal=Console.ReadLine();

				// do some work here , no matter what signal you 
				// receive
				Console.WriteLine("Received: {0}",signal);

				if(signal == "A")
				{
					//faulty - abort signal processing
					//Log the problem and abort
					Console.WriteLine("Fault!Abort\n");
					break;
				}
				if( signal == "0" )
				{
					//normal traffic condition
					//log and continue on
					Console.WriteLine("All is well.\n");
					continue;
				}
				//Problem. Take action and then log the problem 
				//and then continue on 
				Console.WriteLine("{0} -- raise alarm!\n",signal);
			}
			Console.ReadLine();
			return 0;
            //
		}
	}
}
