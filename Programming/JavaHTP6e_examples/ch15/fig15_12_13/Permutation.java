// Fig. 15.12: Permutation.java
// Recursive method to find all permutations of a String.

public class Permutation
{
   // recursive declaration of method permuteString
   public void permuteString(
      String beginningString, String endingString )
   {
      // base case: if string to permute is length less than or equal to
      // 1, just display this string concatenated with beginningString
      if ( endingString.length() <= 1 )
         System.out.println( beginningString + endingString );
      else // recursion step: permute endingString
      {
         // for each character in endingString
         for ( int i = 0; i < endingString.length(); i++ )
         {
            try
            {
               // create new string to permute by eliminating the
               // character at index i
               String newString = endingString.substring( 0, i ) +
                  endingString.substring( i + 1 );

               // recursive call with a new string to permute
               // and a beginning string to concatenate, which
               // includes the character at index i
               permuteString( beginningString +
                  endingString.charAt( i ), newString );
            } // end try
            catch ( StringIndexOutOfBoundsException exception )
            {
               exception.printStackTrace();
            } // end catch
         } // end for
      } // end else
   } // end method permuteString
} // end class Permutation

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