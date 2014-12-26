using System;

namespace ConsoleApplication1
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	class Functions
	{
		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main(string[] args)
		{
			//
			Console.WriteLine("In Main! Calling SomeMethod()...");
			SomeMethod();
			Console.WriteLine("Back in Main().");
			Console.ReadLine();
			//
		}
		static void SomeMethod()
		{
			Console.WriteLine("Greetings frome SomeMethod!");
		}
	}
}
