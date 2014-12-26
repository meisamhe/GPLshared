// Fig. 11.9: StringValueOf.java
// String valueOf methods.
import javax.swing.*;

public class StringValueOf {

   public static void main( String args[] )
   {
      char charArray[] = { 'a', 'b', 'c', 'd', 'e', 'f' };
      boolean booleanValue = true;
      char characterValue = 'Z';
      int integerValue = 7;
      long longValue = 10000000L;
      float floatValue = 2.5f; // f suffix indicates that 2.5 is a float
      double doubleValue = 33.333;
      Object objectRef = "hello"; // assign string to an Object reference

      String output = "char array = " + String.valueOf( charArray ) +
         "\npart of char array = " + String.valueOf( charArray, 3, 3 ) +
         "\nboolean = " + String.valueOf( booleanValue ) +
         "\nchar = " + String.valueOf( characterValue ) +
         "\nint = " + String.valueOf( integerValue ) +
         "\nlong = " + String.valueOf( longValue ) + 
         "\nfloat = " + String.valueOf( floatValue ) + 
         "\ndouble = " + String.valueOf( doubleValue ) + 
         "\nObject = " + String.valueOf( objectRef );

      JOptionPane.showMessageDialog( null, output,
         "String valueOf methods", JOptionPane.INFORMATION_MESSAGE );

      System.exit( 0 );
   }

} // end class StringValueOf

/**************************************************************************
 * (C) Copyright 1992-2003 by Deitel & Associates, Inc. and               *
 * Prentice Hall. All Rights Reserved.                                    *
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
