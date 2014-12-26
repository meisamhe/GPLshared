using System;
using System.Text;
namespace ConsoleApplication3
{
	public class Fraction
	{
		private int numerator;
		private int denominator;

		public Fraction( int numerator, int denominator )
		{
			this.numerator = numerator;
			this.denominator = denominator;
		}

		public override string ToString()
		{
			return String.Format("{0}/{1}",
				numerator, denominator);
		}

		internal class FranctionArtist
		{
			public void Draw(Fraction f)
			{
				Console.WriteLine("Drawing the numerator:{0}",
					f.numerator);
				Console.WriteLine("Drowing the denominator: {0}",
					f.denominator);
			}
		}
	}
	public class Tester
	{
		public static void Main()
		{
			Fraction f1= new Fraction(3,4);
			Console.WriteLine("f1: {0}", f1.ToString());

			Fraction.FranctionArtist fa = new Fraction.FranctionArtist();
			fa.Draw(f1);
			Console.ReadLine();
		}
	}
}
