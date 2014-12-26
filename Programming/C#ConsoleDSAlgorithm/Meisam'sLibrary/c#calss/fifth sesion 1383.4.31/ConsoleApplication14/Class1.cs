using System;

namespace Programming_C_Sharp
{
	namespace Programming_C_Sharp_Test
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
						
				for(int i=0; i<10 ;i++)
				{
					Console.WriteLine("i : {0} ", i);
				}
				Console.ReadLine();
				return 0;
				
				//
			}
		}
	}
}
