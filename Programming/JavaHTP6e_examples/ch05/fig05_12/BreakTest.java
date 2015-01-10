// Fig. 5.12: BreakTest.java
// break statement exiting a for statement.
public class BreakTest 
{
   public static void main( String args[] )
   {
      int count; // control variable also used after loop terminates
      
      for ( count = 1; count <= 10; count++ ) // loop 10 times
      {  
         if ( count == 5 ) // if count is 5, 
            break;         // terminate loop

         System.out.printf( "%d ", count );
      } // end for

      System.out.printf( "\nBroke out of loop at count = %d\n", count );
   } // end main
} // end class BreakTest


/**************************************************************************
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
