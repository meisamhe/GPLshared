using System;

namespace ConsoleApplication3
{
	class Testing : IDisposable
	{
		bool is_disposed = false;
		protected virtual void Dispose( bool disposing)
		{
			if ( !is_disposed ) //onlu dispose once!
			{
				if ( disposing )
				{
					Console.WriteLine("Not in destructor , OK to refrerence other objects");
				}
				//perform cleanup for this object
				Console.WriteLine("Disposing...");
			}
			this.is_disposed = true;
		}
		public void Dispose()
		{
			Dispose( true );
			//tell the GC not ot finalize
			GC.SuppressFinalize(this);
		}
		~Testing()
		{
			Dispose( false);
			Console.WriteLine("In destructor.");
		}
	}

}
