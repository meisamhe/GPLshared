using System;

namespace ConsoleApplication16
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	public class MyClass
	{
		public void SomeMethod(int firstParam, float secondParam)
		{
			Console.WriteLine(
				"here are the parameters recieved: {0}, {1}",firstParam, secondParam);
		}
	}
	public class Tester
	{
		static void Main()
		{
			int howManyPeople=5;
			float pi=3.14f;
			MyClass mc=new MyClass();
			mc.SomeMethod(howManyPeople, pi);
			Console.ReadLine();		
		}
	}
}
