using System;

namespace ConsoleApplication1
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	public class MyClass
	{
		public void SomeMethod(int firstParam, float secondParam)
		{
			Console.WriteLine(
				"Here are the parameters received : {0}, {1}",
				firstParam,secondParam);
		}
	}
	public class Tester
	{
		static void Main()
		{
			int howManyPeople = 5;
			float pi = 3.14f;
			MyClass mc= new MyClass();
			mc.SomeMethod(howManyPeople, pi);
		}
	}

}
