using System;

namespace ConsoleApplication2
{
	//a simple dlass to store in the array
	public class Employee
	{
		//a simple class to store in the array
		public Employee( int empID)
		{
			this.empID = empID;
		}
		public override string ToString()
		{
			return empID.ToString();
		}
		private int empID;
	}
	public class Tester
	{
		static void Main()
		{
			int[] intArray;
			Employee[] empArray;
			intArray = new int[5];
			empArray = new Employee[3];
			
			//populate the array
			for(int i= 0; i<empArray.Length ; i++)
			{
				empArray[i] = new Employee(i+5);
			}
			for( int i = 0;i< intArray.Length;i++)
			{
				Console.WriteLine(intArray[i].ToString());
			}
			for( int i = 0; i < empArray.Length ; i++)
			{
				Console.WriteLine( empArray[i].ToString());
			}
			Console.ReadLine();
		}
	}

}
