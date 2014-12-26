using System;

namespace ConsoleApplication11
{
	public class Window
	{
		//these members are protected and thus visible
		//to derived class methods.We'll examine this
		//later in the chapter
		protected int top;
		protected int left;

		//constructor takes two integers to
		//fix location on the console
		public Window(int top, int left)
		{
			this.top = top;
			this.left = left;
		}

		//simulates drawing the window
		public virtual void DrawWindow()
		{
			Console.WriteLine("Window: drawing window at {0}, {1}",
				top, left);
		}
	}

	//ListBox derives from Window
	public class ListBox : Window
	{
		private string listBoxContents;	// new member variable

		//constructor adds a parameter
		public ListBox(
			int top,
			int left,
			string contents):
			base( top, left )	//call base constructor
		{
			listBoxContents = contents;
		}

		//an overridden version (note keyword) because in the
		//derived method ve change the behavior
		public override void DrawWindow()
		{
			base.DrawWindow();	// invoke the base method
			Console.WriteLine("Writing string to the listbox: {0}",
				listBoxContents);
		}
	}
	public class Button : Window
	{
		public Button(
			int top, 
			int left):
			base( top, left)
		{
		}

		//an overridden version (mote keywor) because in the
		//derived method we change the behavior
		public override void DrawWindow()
		{
			Console.WriteLine("Darawing a button at {0}, {1}\n",
				top, left);
		}
	}
	public class Tester
	{
		static void Main()
		{
			Window win = new Window(1,2);
			ListBox lb = new ListBox(3,4,"stand alone list bow");
			Button b = new Button(5,6);
			win.DrawWindow();
			lb.DrawWindow();
			b.DrawWindow();

			Window[] winArray = new Window[3];
			winArray[0] = new Window(1,2);
			winArray[1] = new ListBox(3,4,"List box in array");
			winArray[2] = new Button(5,6);

			for(int i=0; i < 3 ; i++)
			{
				winArray[i].DrawWindow();
			}
		Console.ReadLine();
		}
	}
}
