// Fig. 15.15: TowersOfHanoi.java
// Program solves the towers of Hanoi problem, and
// demonstrates recursion.

public class TowersOfHanoi
{
   private int numDisks; // number of disks to move

   public TowersOfHanoi( int disks )
   {
      numDisks = disks;
   } // end constructor TowersOfHanoi 

   // recusively move disks through towers
   public void solveTowers( int disks, int sourcePeg, int destinationPeg,
      int tempPeg )
   {
      // base case -- only one disk to move
      if ( disks == 1 )
      {
         System.out.printf( "\n%d --> %d", sourcePeg, destinationPeg );
         return;
      } // end if

      // recursion step -- move disk to tempPeg, then to destinationPeg
      // move ( disks - 1 ) disks from sourcePeg to tempPeg recursively
      solveTowers( disks - 1, sourcePeg, tempPeg, destinationPeg );

      // move last disk from sourcePeg to destinationPeg
      System.out.printf( "\n%d --> %d", sourcePeg, destinationPeg );

      // move ( disks - 1 ) disks from tempPeg to destinationPeg
      solveTowers( disks - 1, tempPeg, destinationPeg, sourcePeg );
   } // end method solveTowers
} // end class TowersOfHanoi

/*************************************************************************
* (C) Copyright 1992-2005 by Deitel & Associates, Inc. and               *
* Pearson Education, Inc. All Rights Reserved.                           *
*                                                                        *
* DISCLAIMER: The authors and publisher of this book have used their     *
* best efforts in preparing the book. These efforts include the          *
* development, research, and testing of the theories and programs        *
* to determine their effectiveness. The authors and publisher make       *
* no warranty of any kind, expressed or implied, with regard to these    *
* programs or to the documentation contained in these books. The authors *
* and publisher shall not be liable in any event for incidental or       *
* consequential damages in connection with, or arising out of, the       *
* furnishing, performance, or use of these programs.                     *
*************************************************************************/