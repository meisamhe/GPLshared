/**
 * Implementação da interface AddressBookDataAccess que executa as operações no 
 * banco de dados com PreparedStatements
 */

package AddressBook;

import java.sql.*;

public class FirebirdDataAccess implements AddressBookDataAccess {
      
   /* referencia para conexao com o BD */
   private Connection connection;
      
   /* referencia para prepared statement para localizar entrada */
   private PreparedStatement sqlFind;

   /* referencia para prepared statement para determinar personID */
   private PreparedStatement sqlPersonID;

   /* referencia para prepared statements para inserir entrada */
   private PreparedStatement sqlInsertName;
   private PreparedStatement sqlInsertAddress;
   private PreparedStatement sqlInsertPhone;
   private PreparedStatement sqlInsertEmail;
   
   /* referencia para prepared statements para atualizar entrada */
   private PreparedStatement sqlUpdateName;
   private PreparedStatement sqlUpdateAddress;
   private PreparedStatement sqlUpdatePhone;
   private PreparedStatement sqlUpdateEmail;
   
   /* referencia para prepared statements para apagar entrada */
   private PreparedStatement sqlDeleteName;
   private PreparedStatement sqlDeleteAddress;
   private PreparedStatement sqlDeletePhone;
   private PreparedStatement sqlDeleteEmail;

   /** congiura os PreparedStatements para acessar o BD */
   public FirebirdDataAccess() throws Exception
   {
      /* conecta ao BD AddressBook */
      connect();

      /* localiza pessoa */
      sqlFind = connection.prepareStatement(
         "SELECT persons.personID, firstName, lastName, " +
            "addressID, address1, address2, city, state, " +
            "zipcode, phoneID, phoneNumber, emailID, " +
            "emailAddress " +
         "FROM persons, addresses, phoneNumbers, emailAddresses " +
         "WHERE lastName = ? AND " +
            "persons.personID = addresses.personID AND " +
            "persons.personID = phoneNumbers.personID AND " +
            "persons.personID = emailAddresses.personID" );
      
      /* obtem personID da ultima pessoa inserida no BD */ 
      sqlPersonID = connection.prepareStatement(
         "SELECT count(*) FROM persons" );

      /* insere primeiro e ultimo nome  
         deve ser executado antes sqlInsertAddress, sqlInsertPhone e
         sqlInsertEmail */
      sqlInsertName = connection.prepareStatement(
         "INSERT INTO persons ( personID, firstName, lastName ) " +
         "VALUES ( ?, ? , ? )" );

      /* insere endereco */
      sqlInsertAddress = connection.prepareStatement(
         "INSERT INTO addresses ( personID, addressID, address1, " +
            "address2, city, state, zipcode ) " +
         "VALUES ( ?, ? , ? , ? , ? , ? , ? )" );

      /* insere numero telefone */
      sqlInsertPhone = connection.prepareStatement(
         "INSERT INTO phoneNumbers " +
            "( personID, phoneID, phoneNumber) " +
         "VALUES ( ? , ?, ? )" );

      /* insere email */
      sqlInsertEmail = connection.prepareStatement(
         "INSERT INTO emailAddresses " +
            "( personID, emailID, emailAddress ) " +
         "VALUES ( ? , ?, ? )" );

      /* atualiza primeiro e ultimo nome */
      sqlUpdateName = connection.prepareStatement(
         "UPDATE persons SET firstName = ?, lastName = ? " +
         "WHERE personID = ?" );

      /* atualiza endereco */
      sqlUpdateAddress = connection.prepareStatement(
         "UPDATE addresses SET address1 = ?, address2 = ?, " +
            "city = ?, state = ?, zipcode = ? " +
         "WHERE addressID = ?" );

      /* atualiza telefones */
      sqlUpdatePhone = connection.prepareStatement(
         "UPDATE phoneNumbers SET phoneNumber = ? " +
         "WHERE phoneID = ?" );

      /* atualiza e-mail */
      sqlUpdateEmail = connection.prepareStatement(
         "UPDATE emailAddresses SET emailAddress = ? " +
         "WHERE emailID = ?" );

      /* Apaga registros da tabela nomes */
      sqlDeleteName = connection.prepareStatement(
         "DELETE FROM persons WHERE personID = ?" );

      /* apaga registros de endereço */
      sqlDeleteAddress = connection.prepareStatement(
         "DELETE FROM addresses WHERE personID = ?" );

      /* apaga registros de numero de telefone */
      sqlDeletePhone = connection.prepareStatement(
         "DELETE FROM phoneNumbers WHERE personID = ?" );

      /* apaga registros de email */
      sqlDeleteEmail = connection.prepareStatement(
         "DELETE FROM emailAddresses WHERE personID = ?" );
   }  // end FirebirdDataAccess constructor
   
   
   /**
    * Obtem uma conexao com o BD addressbook. O metodo pode jogar uma 
    * ClassNotFoundException ou SQLException 
    */
   private void connect() throws Exception {
      
      /* nome da class do Driver do BD, no caso do Firebird */
      String driver = "org.firebirdsql.jdbc.FBDriver";
     
      /* URL para conectar com o BD */
      String url = "jdbc:firebirdsql://150.162.60.54/home/databases/AddressBook.fdb";
      
      /* login para o BD */
      String login = "aluno_cd";
      
      /* senha de acesso */
      String senha= "aluno_pw";
      
      /* carrega a clase do driver do BD */
      Class.forName( driver );

      /* conecta ao BD */
      connection = DriverManager.getConnection(url, login, senha); 

      /* Marca manual commit para as transações */
      connection.setAutoCommit( false );      
   }
   
   
   /** 
    * Localiza uma pessoa especifica
    * @return AddressBookEntry contendo a informação
    */
   public AddressBookEntry findPerson( String lastName )
   {
      try {
         // set query parameter and execute query
         sqlFind.setString( 1, lastName );
         ResultSet resultSet = sqlFind.executeQuery();

         // if no records found, return immediately
         if ( !resultSet.next() ) 
            return null;

         // create new AddressBookEntry
         AddressBookEntry person = new AddressBookEntry( 
            resultSet.getInt( 1 ) );
         
         // set AddressBookEntry properties
         person.setFirstName( resultSet.getString( 2 ) );
         person.setLastName( resultSet.getString( 3 ) );

         person.setAddressID( resultSet.getInt( 4 ) );
         person.setAddress1( resultSet.getString( 5 ) );
         person.setAddress2( resultSet.getString( 6 ) );
         person.setCity( resultSet.getString( 7 ) );
         person.setState( resultSet.getString( 8 ) );
         person.setZipcode( resultSet.getString( 9 ) );

         person.setPhoneID( resultSet.getInt( 10 ) );
         person.setPhoneNumber( resultSet.getString( 11 ) );

         person.setEmailID( resultSet.getInt( 12 ) );
         person.setEmailAddress( resultSet.getString( 13 ) );
 
         // return AddressBookEntry
         return person;
      }
         
      // catch SQLException
      catch ( SQLException sqlException ) {
         return null;
      }
   }  // end method findPerson
   
   
   /**
    * Atualiza uma entrada
    * @return boolean indicando sucesso ou falha
    */
   public boolean savePerson( AddressBookEntry person )
      throws DataAccessException
   {
      // update person in database
      try {
         int result;
         
         // update persons table
         sqlUpdateName.setString( 1, person.getFirstName() );
         sqlUpdateName.setString( 2, person.getLastName() );
         sqlUpdateName.setInt( 3, person.getPersonID() );
         result = sqlUpdateName.executeUpdate();

         // if update fails, rollback and discontinue 
         if ( result == 0 ) {
            connection.rollback(); // rollback update
            return false;          // update unsuccessful
         }      
         
         // update addresses table
         sqlUpdateAddress.setString( 1, person.getAddress1() );
         sqlUpdateAddress.setString( 2, person.getAddress2() );
         sqlUpdateAddress.setString( 3, person.getCity() );
         sqlUpdateAddress.setString( 4, person.getState() );
         sqlUpdateAddress.setString( 5, person.getZipcode() );
         sqlUpdateAddress.setInt( 6, person.getAddressID() );
         result = sqlUpdateAddress.executeUpdate();
         
         // if update fails, rollback and discontinue 
         if ( result == 0 ) {
            connection.rollback(); // rollback update
            return false;          // update unsuccessful
         }      
         
         // update phoneNumbers table
         sqlUpdatePhone.setString( 1, person.getPhoneNumber() );
         sqlUpdatePhone.setInt( 2, person.getPhoneID() );
         result = sqlUpdatePhone.executeUpdate();
         
         // if update fails, rollback and discontinue 
         if ( result == 0 ) {
            connection.rollback(); // rollback update
            return false;          // update unsuccessful
         }      
         
         // update emailAddresses table
         sqlUpdateEmail.setString( 1, person.getEmailAddress() );
         sqlUpdateEmail.setInt( 2, person.getEmailID() );
         result = sqlUpdateEmail.executeUpdate();

         // if update fails, rollback and discontinue 
         if ( result == 0 ) {
            connection.rollback(); // rollback update
            return false;          // update unsuccessful
         }      
         
         connection.commit();   // commit update
         return true;           // update successful
      }  // end try
      
      // detect problems updating database
      catch ( SQLException sqlException ) {
      
         // rollback transaction
         try {
            connection.rollback(); // rollback update
            return false;          // update unsuccessful
         }
         
         // handle exception rolling back transaction
         catch ( SQLException exception ) {
            throw new DataAccessException( exception );
         }
      }
   }  // end method savePerson

   
   /**
    * Insere uma nova entrada
    * @return boolean indicando sucesso ou falha
    */
   public boolean newPerson( AddressBookEntry person )
      throws DataAccessException
   {
      // insert person in database
      try {
         // determine new personID
         int personID=1;
         ResultSet resultPersonID = sqlPersonID.executeQuery();
         
         if ( resultPersonID.next() ) {
            personID =  resultPersonID.getInt( 1 );
            personID++;
         } //if   
         
         // insert first and last name in persons table

         int result;

         sqlInsertName.setInt( 1, personID);
         sqlInsertName.setString( 2, person.getFirstName() );
         sqlInsertName.setString( 3, person.getLastName() );
         result = sqlInsertName.executeUpdate();

         // if insert fails, rollback and discontinue 
         if ( result == 0 ) {
            connection.rollback(); // rollback insert
            return false;          // insert unsuccessful
         }      
         
        
        // insert address in addresses table
        sqlInsertAddress.setInt( 1, personID );
        sqlInsertAddress.setInt( 2, personID );
        sqlInsertAddress.setString( 3, person.getAddress1() );
        sqlInsertAddress.setString( 4, person.getAddress2() );
        sqlInsertAddress.setString( 5, person.getCity() );
        sqlInsertAddress.setString( 6, person.getState() );
        sqlInsertAddress.setString( 7, person.getZipcode() );
        result = sqlInsertAddress.executeUpdate();

        // if insert fails, rollback and discontinue 
        if ( result == 0 ) {
           connection.rollback(); // rollback insert
           return false;          // insert unsuccessful
        }      

        // insert phone number in phoneNumbers table
        sqlInsertPhone.setInt( 1, personID );
        sqlInsertPhone.setInt( 2, personID );
        sqlInsertPhone.setString( 3, person.getPhoneNumber() );
        result = sqlInsertPhone.executeUpdate();

        // if insert fails, rollback and discontinue 
        if ( result == 0 ) {
           connection.rollback(); // rollback insert
           return false;          // insert unsuccessful
        }      

        // insert email address in emailAddresses table
        sqlInsertEmail.setInt( 1, personID );
        sqlInsertEmail.setInt( 2, personID );
        sqlInsertEmail.setString( 3, person.getEmailAddress() );
        result = sqlInsertEmail.executeUpdate();

        // if insert fails, rollback and discontinue 
        if ( result == 0 ) {
           connection.rollback(); // rollback insert
           return false;          // insert unsuccessful
        }      

        connection.commit();   // commit insert
        return true;           // insert successful
         
      }  // end try
      
      // detect problems updating database
      catch ( SQLException sqlException ) {
         // rollback transaction
         try {
            connection.rollback(); // rollback update
            return false;          // update unsuccessful
         }
         
         // handle exception rolling back transaction
         catch ( SQLException exception ) {
            throw new DataAccessException( exception );
         }
      }
   }  // end method newPerson
      
   
   /**
    * Apaga uma entrada
    * @return boolean indicando sucesso ou falha
    */
   public boolean deletePerson( AddressBookEntry person )
      throws DataAccessException
   {
      // delete a person from database
      try {
         int result;
                  
         // delete address from addresses table
         sqlDeleteAddress.setInt( 1, person.getPersonID() );
         result = sqlDeleteAddress.executeUpdate();

         // if delete fails, rollback and discontinue 
         if ( result == 0 ) {
            connection.rollback(); // rollback delete
            return false;          // delete unsuccessful
         }      

         // delete phone number from phoneNumbers table
         sqlDeletePhone.setInt( 1, person.getPersonID() );
         result = sqlDeletePhone.executeUpdate();
         
         // if delete fails, rollback and discontinue 
         if ( result == 0 ) {
            connection.rollback(); // rollback delete
            return false;          // delete unsuccessful
         }      

         // delete email address from emailAddresses table
         sqlDeleteEmail.setInt( 1, person.getPersonID() );
         result = sqlDeleteEmail.executeUpdate();

         // if delete fails, rollback and discontinue 
         if ( result == 0 ) {
            connection.rollback(); // rollback delete
            return false;          // delete unsuccessful
         }      

         // delete name from persons table
         sqlDeleteName.setInt( 1, person.getPersonID() );
         result = sqlDeleteName.executeUpdate();

         // if delete fails, rollback and discontinue 
         if ( result == 0 ) {
            connection.rollback(); // rollback delete
            return false;          // delete unsuccessful
         }      

         connection.commit();   // commit delete
         return true;           // delete successful
      }  // end try
      
      // detect problems updating database
      catch ( SQLException sqlException ) {
         // rollback transaction
         try {
            connection.rollback(); // rollback update
            return false;          // update unsuccessful
         }
         
         // handle exception rolling back transaction
         catch ( SQLException exception ) {
            throw new DataAccessException( exception );
         }
      }
   }  // end method deletePerson

   
   /** método para fechar os statements e a conexao com BD */
   public void close() {
      try {
         sqlFind.close();
         sqlPersonID.close();
         sqlInsertName.close();
         sqlInsertAddress.close();
         sqlInsertPhone.close();
         sqlInsertEmail.close();
         sqlUpdateName.close();
         sqlUpdateAddress.close();
         sqlUpdatePhone.close();
         sqlUpdateEmail.close();
         sqlDeleteName.close();
         sqlDeleteAddress.close();
         sqlDeletePhone.close();
         sqlDeleteEmail.close();         
         connection.close();
      }  // end try
      
      // detect problems closing statements and connection
      catch ( SQLException sqlException ) {
         sqlException.printStackTrace();  
      }   
   }  // end method close

   
   /* Método para garantir a finalização do conexao */
   protected void finalize() {
      close(); 
   }
}  // end class FirebirdDataAccess


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
