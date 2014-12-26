using System;

namespace ConsoleApplication6
{
	public struct Location
	{
		public int xVal;
		public int yVal;

		public Location( int xCoordinate, int yCoordinate)
		{
			xVal = xCoordinate;
			yVal = yCoordinate;
		}
		
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
				yVal = value;
			}
		}

		public override string ToString()
		{
			return ( String.Format("{0}, {1}", xVal, yVal));
		}
	}
	public class Tester
	{
		static void Main()
		{

			Location loc1;	//no call to the constructor

			loc1.xVal = 75;
			loc1.yVal = 225;
			loc1.x = 300;
			loc1.y = 400;
			Console.WriteLine(loc1);
			Console.ReadLine();
		}
	}
	}
