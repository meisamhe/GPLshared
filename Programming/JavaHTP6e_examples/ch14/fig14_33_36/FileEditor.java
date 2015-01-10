// Fig. 14.34: FileEditor.java
// This class declares methods that manipulate bank account
// records in a random access file.
import java.io.EOFException;
import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.util.Scanner;

import com.deitel.jhtp6.ch14.RandomAccessAccountRecord;

public class FileEditor
{
   RandomAccessFile file; // reference to the file
   Scanner input = new Scanner( System.in );
   
   // open the file
   public FileEditor( String fileName ) throws IOException
   {
      file = new RandomAccessFile( fileName, "rw" );
   } // end FileEditor constructor
   
   // close the file
   public void closeFile() throws IOException
   {
      if ( file != null )
         file.close();
   } // end method closeFile
   
   // get a record from the file
   public RandomAccessAccountRecord getRecord( int accountNumber )
      throws IllegalArgumentException, NumberFormatException, IOException
   {
      RandomAccessAccountRecord record = new RandomAccessAccountRecord();

      if ( accountNumber < 1 || accountNumber > 100 )
         throw new IllegalArgumentException( "Out of range" );

      // seek appropriate record in file
      file.seek( ( accountNumber - 1 ) * RandomAccessAccountRecord.SIZE );
      
      record.read( file );

      return record;
   } // end method getRecord
   
   // update record in file
   public void updateRecord( int accountNumber, double transaction )
      throws IllegalArgumentException, IOException
   {
      RandomAccessAccountRecord record = getRecord( accountNumber );

      if ( record.getAccount() == 0 )
         throw new IllegalArgumentException( "Account does not exist" );

      // seek appropriate record in file
      file.seek( ( accountNumber - 1 ) * RandomAccessAccountRecord.SIZE );   

      record = new RandomAccessAccountRecord(
         record.getAccount(), record.getFirstName(),
         record.getLastName(), record.getBalance() + transaction );
         
      record.write( file ); // write updated record to file      
   } // end method updateRecord
   
   // add record to file
   public void newRecord( int accountNumber, String firstName, 
      String lastName, double balance )
      throws IllegalArgumentException, IOException
   {
      RandomAccessAccountRecord record = getRecord( accountNumber );
      
      if ( record.getAccount() != 0 )
         throw new IllegalArgumentException( "Account already exists" );

      // seek appropriate record in file
      file.seek( ( accountNumber - 1 ) * RandomAccessAccountRecord.SIZE );   

      record = new RandomAccessAccountRecord( accountNumber, 
         firstName, lastName, balance );
         
      record.write( file ); // write record to file      
   } // end method newRecord
   
   // delete record from file
   public void deleteRecord( int accountNumber )
      throws IllegalArgumentException, IOException
   {
      RandomAccessAccountRecord record = getRecord( accountNumber );
      
      if ( record.getAccount() == 0 )
         throw new IllegalArgumentException( "Account does not exist" );
      
      // seek appropriate record in file
      file.seek( ( accountNumber - 1 ) * RandomAccessAccountRecord.SIZE );

      // create a blank record to write to the file
      record = new RandomAccessAccountRecord();
      record.write( file );      
   } // end method deleteRecord

   // read and display records
   public void readRecords()
   {
      RandomAccessAccountRecord record = new RandomAccessAccountRecord();

      System.out.printf( "%-10s%-15s%-15s%10s\n", "Account",
         "First Name", "Last Name", "Balance" );
   
      try // read a record and display
      {
         file.seek( 0 );

         while ( true )
         {
            do
            {
               record.read( file );
            } while ( record.getAccount() == 0 );

            // display record contents
            System.out.printf( "%-10d%-15s%-15s%10.2f\n",
               record.getAccount(), record.getFirstName(),
               record.getLastName(), record.getBalance() );
         } // end while
      } // end try
      catch ( EOFException eofException ) // close file
      {
         return; // end of file was reached
      } // end catch
      catch ( IOException ioException )
      {
         System.err.println( "Error reading file." );
         System.exit( 1 );
      } // end catch
   } // end method readRecords  
} // end class FileEditor

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