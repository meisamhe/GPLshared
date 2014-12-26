using System;

namespace ConsoleApplication1
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	class Class1
	{
		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main(string[] args)
		{
			//
			const int FreezingPoint=32;	//degrees Farenheit
			const int BoilingPoint=212;
//			int myInt;
//			myInt=5;
//			System.Console.WriteLine("Assign,myInt:{0}",myInt);
//			myInt=7;
//			System.Console.WriteLine("Reassigned,myInt:{0}",myInt);
			System.Console.WriteLine("Freezing point of water:{0}",FreezingPoint);
			System.Console.WriteLine("Boiling point of water:{0}",BoilingPoint);
			System.Console.Read();
			//
		}
	}
}
