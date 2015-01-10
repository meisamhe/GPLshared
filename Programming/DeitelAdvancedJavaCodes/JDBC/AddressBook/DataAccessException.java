package AddressBook;

/**
 * DataAccessException.java
 * Trata das exceptions
 */

public class DataAccessException extends Exception {

   private Exception exception;
 
   // constructor with String argument
   public DataAccessException( String message )
   {
     super( message );
   }

   // constructor with Exception argument
   public DataAccessException( Exception exception )
   {
      exception = this.exception;
   }

   // printStackTrace of exception from constructor
   public void printStackTrace()
   {
      exception.printStackTrace();
   }
}