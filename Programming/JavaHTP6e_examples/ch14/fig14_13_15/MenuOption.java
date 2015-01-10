// Fig. 14.13: MenuOption.java
// Defines an enum type for the credit inquiry program's options.

public enum MenuOption
{
   // declare contents of enum type
   ZERO_BALANCE( 1 ),
   CREDIT_BALANCE( 2 ),
   DEBIT_BALANCE( 3 ),
   END( 4 );

   private final int value; // current menu option

   MenuOption( int valueOption )
   {
      value = valueOption;
   } // end MenuOptions enum constructor

   public int getValue()
   {
      return value;
   } // end method getValue
} // end enum MenuOption

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