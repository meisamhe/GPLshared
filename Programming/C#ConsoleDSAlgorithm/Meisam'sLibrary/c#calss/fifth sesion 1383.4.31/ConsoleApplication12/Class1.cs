using System;

namespace ConsoleApplication12
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	class Value
	{
		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main(string[] args)
		{
			//
			int valueOne = 10;
			int valueTwo;
			valueTwo = valueOne++;
			Console.WriteLine("After postfix: {0}, {1}", valueOne,valueTwo);
			valueOne = 20;
			valueTwo = ++ valueOne;
			Console.WriteLine("After prefix:{0},{1}",valueOne,valueTwo);
			Console.ReadLine();
			//
		}
	}
}
