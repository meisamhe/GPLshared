using System;

namespace ConsoleApplication5
{
	public struct Location
	{
		private int xVal;
		private int yVal;

	/*	public Location(int xCoordinate, int yCoordinate)
		{
			xVal = xCoordinate;
			yVal = yCoordinate;
		}	*/
		public int x
		{
			get 
			{
				return xVal;
			}
			set 
			{
				xVal = value;
			}
		}
		public int y 
		{
			get
			{
				return yVal;
			}
			set
			{
				yVal= value;
			}
		}

		public override string ToString()
		{
			return ( String.Format("{0}, {1}", xVal, yVal));
		}
	}
	public class	Tester
	{
		public void myFunc(Location loc)
		{
			loc.x = 50;
			loc.y = 100;
			Console.WriteLine("In MyFunc loc: {0}", loc);
		}
		static void Main()
		{
			//Location loc1 = new Location(200, 300);
			Location loc1 = new Location();
			Console.WriteLine("In MyFunc loc: {0}", loc1);
			Tester t = new Tester();
			t.myFunc(loc1);
			Console.WriteLine("Loc1 location: {0}", loc1);
			Console.ReadLine();
		}
	}
}
