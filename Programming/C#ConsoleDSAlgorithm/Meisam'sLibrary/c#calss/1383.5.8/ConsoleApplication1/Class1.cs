using System;

namespace ConsoleApplication1
{
	//declare the interface

	interface IStorable
	{
		//no access modifiers, methods are public
		//no implementation
		void Read();
		void Write(object obj);
		int Status { get; set; }
	}

	//create a class which implements the IStorable interface
	public class Document : IStorable
	{

		//store the value for the property
		private int status = 0;

		public Document( string s)
		{
			Console.WriteLine("Creating document with : {0}", s);
		}

		//implement the Read method
		public void Read()
		{
			Console.WriteLine(
				"Implementing the Read Method for IStorable");
		}
		//implement the Write method
		public void Write(object o)
		{
			Console.WriteLine(
				"Implementing the Write Method for IStorable");
		}

		//implement the property
		public int Status
		{
			get 
			{
				return Status;
			}
			set
			{
				status  = value;
			}
		}
	}

	//Take our interface out for a spin
	public class Tester
	{

		static void Main()
		{
			//access the methods in the Document object
			Document doc = new Document("Test Document");
			doc.Status = -1;
			doc.Read();
			Console.WriteLine("Document Status: {0}", doc.Status);
		}
	}
}
