using System;

namespace ConsoleApplication13
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
			int valueOne=10;
			int valueTwo=20;

			int maxValue=valueOne > valueTwo ? valueOne : valueTwo;

			Console.WriteLine("ValueOne :{0}, ValueTwo : {1} ,maxValue : {2}",
				valueOne,valueTwo,maxValue);
			Console.ReadLine();
			//
		}
	}
}
