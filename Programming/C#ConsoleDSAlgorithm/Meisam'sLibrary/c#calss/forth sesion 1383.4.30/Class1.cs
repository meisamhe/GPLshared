using System;

namespace ConsoleApplication1
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>

	class Class1
	{
		/// <summary>
		/// The main entry point for the application.
		/// </summary>

		enum Temperatures:uint
		{
			FreezingPoint=32,
			BoilingPoint,
			LightJadketWeather=60,
			SwimmingWeather,
			WickedCold,
		}
		static void Main(string[] args)
		{
			//
	//		Temperatures temp=Temperatures.BoilingPoint;
	//		System.Console.WriteLine("the FreezingPoint,BoilingPoint,LightJadketWether,SwimmingWeather,WickedCold:{0},{1},{2},{3},{4}",(int)Temperatures.WickedCold,(int)Temperatures.FreezingPoint,(int)Temperatures.LightJadketWeather,(int)Temperatures.SwimmingWeather,(int)Temperatures.BoilingPoint);
	//		System.Console.WriteLine("the temp is : {0}",(int)temp);
			string temp="hello meisam how r u";
			System.Console.WriteLine("the temp string is : {0}",temp);
			System.Console.Read();
			//
		}
	}
}
