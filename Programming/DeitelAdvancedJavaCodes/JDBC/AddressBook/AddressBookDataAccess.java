/**
 * Interface que especifica os metodos para inserir, atualizar, apagar e 
 * encontrar registros
 * */

package AddressBook;

import java.sql.*;


public interface AddressBookDataAccess {
      
   /**
    *  Localiza uma pessoa pelo ultimo nome (last name)
    * @return AddressBookEntry contendo a informação
    */
   public AddressBookEntry findPerson( String lastName );
   
   /**
    * Atualiza a informação para uma pessoa especifica
    * @return boolean indicando sucesso ou falha
    */
   public boolean savePerson( AddressBookEntry person ) throws DataAccessException;

   /**
    * Insere uma nova pessoa
    * @return boolean indicando sucesso ou falha
    */
   public boolean newPerson( AddressBookEntry person )
      throws DataAccessException;
      
   /**
    * Apaga o registro de uma pessoa específica
    * @return boolean indicando sucesso ou falha
    */
   public boolean deletePerson( AddressBookEntry person ) throws DataAccessException;
      
   /** fecha a conexão com a fonte de dados */
   public void close(); 
}  // end interface AddressBookDataAccess


/**************************************************************************
 * (C) Copyright 2001 by Deitel & Associates, Inc. and Prentice Hall.     *
 * All Rights Reserved.                                                   *
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
