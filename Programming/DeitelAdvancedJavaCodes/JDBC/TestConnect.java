import java.sql.*;

class TestConnect {
   private String login="aluno_cd";
   private String password="aluno_pw";
   private String driver="org.firebirdsql.jdbc.FBDriver";
   private String url="jdbc:firebirdsql://150.162.60.54/home/databases/aula_jdbc.fdb";
   private Connection connection;
   

   /**
    * Construtor
    */
   public TestConnect () {
       System.out.println("Iniciando Teste");
       startConnection();
       System.out.println("Conexão completada");
       destroyConnection();
       System.out.println ("Finalizando Teste");
   } //Construtor


   /**
    * Inicia a conexao com o banco de dados
    */
   public void startConnection () {
      try {
         /* carregar e registrar a classe do driver JDBC */
         Class.forName(driver);

         /* obter uma conexao com o banco de dados */
         connection = DriverManager.getConnection(url,login,password);

      } catch ( ClassNotFoundException cnfe ) {
         System.err.println ("Driver not found\n" + cnfe);

      } catch ( SQLException sqle ) {
          System.err.println ("Error on create connection with database\n");
          System.err.println ("Error Message: " + sqle.getMessage());
          System.err.println ("Error Code: " + sqle.getErrorCode());
          System.err.println ("SQL State: " + sqle.getSQLState());

      } catch ( Exception e) {
           System.err.println ("Error\n" + e);
      } // catch
   } // startConnection


   /**
    * Destroi a conexao com o banco de dados
    */
   public void destroyConnection ()  {
      try {
          connection.close();
      } catch (SQLException sqle) {
          System.err.println ("Error on close database\n" + sqle);
      } //catch
   } //destroyConnection

   
    /* main */
   public static void main(String args[]) {
       new TestConnect();
   } //main


} // class ANStoreConnect
