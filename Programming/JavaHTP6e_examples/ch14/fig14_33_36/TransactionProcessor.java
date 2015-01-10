// Fig. 14.35: TransactionProcessor.java
// A transaction processing program using random-access files.
import java.io.IOException;
import java.util.NoSuchElementException;
import java.util.Scanner;

import com.deitel.jhtp6.ch14.RandomAccessAccountRecord;

public class TransactionProcessor
{
   private FileEditor dataFile;
   private RandomAccessAccountRecord record;
   private MenuOption choices[] = { MenuOption.PRINT,
      MenuOption.UPDATE, MenuOption.NEW,
      MenuOption.DELETE, MenuOption.END };

   private Scanner input = new Scanner( System.in );

   // get the file name and open the file
   private boolean openFile()
   {
      try // attempt to open file
      {
         // call the helper method to open the file
         dataFile = new FileEditor( "clients.dat" ); 
      } // end try
      catch ( IOException ioException )
      {
         System.err.println( "Error opening file." );
         return false;
      } // end catch
       
      return true;
   } // end method openFile

   // close file and terminate application 
   private void closeFile() 
   {
      try // close file
      {
         dataFile.closeFile();
      } // end try
      catch ( IOException ioException )
      {
         System.err.println( "Error closing file." );
         System.exit( 1 );
      } // end catch
   } // end method closeFile

   // create, update or delete the record
   private void performAction( MenuOption action )
   {
      int accountNumber = 0; // account number of record
      String firstName; // first name for account
      String lastName; // last name for account
      double balance; // account balance
      double transaction; // amount to change in balance

      try // attempt to manipulate files based on option selected
      {
         switch ( action ) // switch based on option selected
         {
            case PRINT:
               System.out.println();
               dataFile.readRecords();
               break;
            case NEW:
               System.out.printf( "\n%s%s\n%s\n%s",
                  "Enter account number,",
                  " first name, last name and balance.",
                  "(Account number must be 1 - 100)", "? " );

               accountNumber = input.nextInt(); // read account number
               firstName = input.next(); // read first name
               lastName = input.next(); // read last name
               balance = input.nextDouble(); // read balance

               dataFile.newRecord( accountNumber, firstName,
                  lastName, balance ); // create new record   
               break;
            case UPDATE:
               System.out.print(
                  "\nEnter account to update ( 1 - 100 ): " );
               accountNumber = input.nextInt();
               record = dataFile.getRecord( accountNumber );

               if ( record.getAccount() == 0 )
                  System.out.println( "Account does not exist." );
               else
               {
                  // display record contents
                  System.out.printf( "%-10d%-12s%-12s%10.2f\n\n",
                     record.getAccount(), record.getFirstName(),
                     record.getLastName(), record.getBalance() );

                  System.out.print(
                     "Enter charge ( + ) or payment ( - ): " );
                  transaction = input.nextDouble();
                  dataFile.updateRecord( accountNumber, // update record
                     transaction );

                  // retrieve updated record
                  record = dataFile.getRecord( accountNumber );

                  // display updated record
                  System.out.printf( "%-10d%-12s%-12s%10.2f\n",
                     record.getAccount(), record.getFirstName(),
                     record.getLastName(), record.getBalance() );
               } // end else
               break;
            case DELETE:
               System.out.print(
                  "\nEnter an account to delete (1 - 100): " );
               accountNumber = input.nextInt();
         
               dataFile.deleteRecord( accountNumber ); // delete record
               break;
            default:
               System.out.println( "Invalid action." );
               break;
         } // end switch
      } // end try
      catch ( NumberFormatException format )
      {
         System.err.println( "Bad input." );
      } // end catch
      catch ( IllegalArgumentException badAccount )
      {
         System.err.println( badAccount.getMessage() );
      } // end catch
      catch ( IOException ioException )
      {
         System.err.println( "Error writing to the file." );
      } // end catch
      catch ( NoSuchElementException elementException )
      {
         System.err.println( "Invalid input. Please try again." );
         input.nextLine(); // discard input so user can try again
      } // end catch
   } // end method performAction

   // enable user to input menu choice
   private MenuOption enterChoice()
   {
      int menuChoice = 1;

      // display available options
      System.out.printf( "\n%s\n%s\n%s\n%s\n%s\n%s",
         "Enter your choice", "1 - List accounts",
         "2 - Update an account", "3 - Add a new account",
         "4 - Delete an account", "5 - End program\n? " );

      try // attempt to input menu choice
      {
         menuChoice = input.nextInt();
      } // end try
      catch ( NoSuchElementException elementException )
      {
         System.err.println( "Invalid input." );
         System.exit( 1 );
      } // end catch

      return choices[ menuChoice - 1 ]; // return choice from user
   } // end enterChoice

   public void processRequests()
   {
      openFile();

      // get user's request
      MenuOption choice = enterChoice();

      while ( choice != MenuOption.END )
      {
         performAction( choice );
         choice = enterChoice();
      } // end while
 
      closeFile();
   } // end method processRequests
} // end class TransactionProcessor

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