// Fig. I.2: PrintBits.java
// Printing an unsigned integer in bits.
import java.util.Scanner;

public class PrintBits
{
   public static void main( String args[] )
   {
      // get input integer
      Scanner scanner = new Scanner( System.in );
      System.out.println( "Please enter an integer:" );
      int input = scanner.nextInt();

      // display bit representation of an integer
      System.out.println( "\nThe integer in bits is:" );

      // create int value with 1 in leftmost bit and 0s elsewhere
      int displayMask = 1 << 31;

      // for each bit display 0 or 1 
      for ( int bit = 1; bit <= 32; bit++ ) 
      {
         // use displayMask to isolate bit
         System.out.print( ( input & displayMask ) == 0 ? '0' : '1' );

         input <<= 1; // shift value one position to left 

         if ( bit % 8 == 0 )
            System.out.print( ' ' ); // display space every 8 bits
      } // end for
   } // end main
} // end class PrintBits


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
