using System;

namespace ConsoleApplication10
{
	public class Window
	{
		//these members are private and thus invisible
		//to derived class methods; we'll examine this
		//later in the chapter
		private int top;
		private int left;

		//constructor takes two integers to
		//fix location on the console
		public Window( int top, int left )
		{
			this.top = top;
			this.left = left;
		}
		//simulate drawinwf the window
		public void DrawWindow()
		{
			Console.WriteLine("Draw Window at {0}, {1}",
				top, left);
		}
	}
	
	//ListBox derives from Window
	public class ListBox : Window
	{
		private string mListBoxContents;	// new member variables

		//constructor adds a parameter
		public ListBox(
			int top,
			int left,
			string theContents):
			base( top, left)	// call base constructor
		{
			mListBoxContents = theContents;
		}

		// a new versoin(note keyword) because in the
		// derived method we change the behavior
		public new void DrawWindow()
		{
			base.DrawWindow();	// invoke the base method
			Console.WriteLine("Writing string to the listbox:	{0}",
				mListBoxContents);
		}
	}
	public class Tester
	{
		public static void Main()
		{
			//create a base instance
			Window w = new Window(5,10);
			w.DrawWindow();

			//create a derived instance
			ListBox lb = new ListBox(20,30,"Hello word");
			lb.DrawWindow();
			Console.ReadLine();		
		}
	}
}
