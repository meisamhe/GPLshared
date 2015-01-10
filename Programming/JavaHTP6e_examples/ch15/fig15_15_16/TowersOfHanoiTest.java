// Fig. 15.16: TowerOfHanoiTest.java
// Test the solution to the towers of Hanoi problem.

public class TowersOfHanoiTest
{
   public static void main( String args[] )
   {
      int startPeg = 1;   // value 1 used to indicate startPeg in output
      int endPeg = 3;     // value 3 used to indicate endPeg in output
      int tempPeg = 2;    // value 2 used to indicate tempPeg in output
      int totalDisks = 3; // number of disks
      TowersOfHanoi towersOfHanoi = new TowersOfHanoi( totalDisks );

      // initial nonrecursive call: move all disks.
      towersOfHanoi.solveTowers( totalDisks, startPeg, endPeg, tempPeg );
   } // end main
} // end class TowersOfHanoiTest

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