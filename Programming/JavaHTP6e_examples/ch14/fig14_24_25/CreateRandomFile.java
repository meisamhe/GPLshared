// Fig. 14.24: CreateRandomFile.java
// Creates random-access file by writing 100 empty records to disk.
import java.io.IOException;
import java.io.RandomAccessFile;

import com.deitel.jhtp6.ch14.RandomAccessAccountRecord;

public class CreateRandomFile
{    
   private static final int NUMBER_RECORDS = 100;

   // enable user to select file to open
   public void createFile()
   {
      RandomAccessFile file = null;

      try // open file for reading and writing
      {           
         file = new RandomAccessFile( "clients.dat", "rw" );

         RandomAccessAccountRecord blankRecord = 
            new RandomAccessAccountRecord();

         // write 100 blank records
         for ( int count = 0; count < NUMBER_RECORDS; count++ )
            blankRecord.write( file );

         // display message that file was created
         System.out.println( "Created file clients.dat." );

         System.exit( 0 ); // terminate program
      } // end try
      catch ( IOException ioException )
      {
         System.err.println( "Error processing file." );
         System.exit( 1 );
      } // end catch
      finally
      {
         try
         {
            if ( file != null )
               file.close(); // close file
         } // end try
         catch ( IOException ioException )
         {
            System.err.println( "Error closing file." );
            System.exit( 1 );
         } // end catch
      } // end finally
   } // end method createFile
} // end class CreateRandomFile

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