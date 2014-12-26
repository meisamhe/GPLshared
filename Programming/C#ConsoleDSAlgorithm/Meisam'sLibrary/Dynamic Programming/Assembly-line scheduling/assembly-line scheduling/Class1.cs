using System;
namespace AssemblyLineScheduling
{
	class Tester
	{
		public void FasterWay(int[][] a, int[][] t, int[] e, int[] x, int n)
		{
			int[] f1 = new int[ n ];
			int[] f2 = new int[ n ];
			int[] l1 = new int[ n ];
			int[] l2 = new int[ n ];
			f1[1] = e[0] + a[0][0];
			f2[1] = e[1] + a[1][0];
			for( int j = 1 ; j < n ; j++)
			{
				if ( f1[ j-1 ] + a[0][j] <= f2[ j-1 ] +  t[1][j - 1] + a[0][j] )
				{
					f1[j] = f1[j-1] + a[1][j];
					l1[ j ] = 1;
				}
				else
				{
					f1[j] =  f2[ j - 1] + t[1][j - 1] + a[ 0 ][ j ];
					l1[j] = 2;
				}
				if ( f2[ j - 1 ] + a[2][j] <= f1[j - 1] + t[0][j - 1] + a[1][j])
				{
					f2[j] = f2[j - 1] + a[1][j];
					l2[j] = 2;
				}
				else
				{
					f2[j] = f1[ j-1 ] + t[0][j - 1] + a[2][j];
					l2[j] = 1;
				}
			}
			int fe, le ;
			if (f1[n] + x[0] <= f2[n] + x[1])
			{
				fe = f1[n] + x[0];
				le = 1;
			}
			else
			{
				fe = f2[n] + x[1];
				le = 2;
			}
		}
	}
}


			