import java.sql.*;

public class GeraLote {
  public static void main(String args[]) {
    try {
      Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
    } catch(java.lang.ClassNotFoundException e) {
      System.err.print("Erro na Classe: "); 
      System.err.println(e.getMessage());
    }
    try {
      String url = "jdbc:odbc:meuODBC";
      Connection con;
      con = DriverManager.getConnection(url, "", "");
      Statement stmt;
      stmt = con.createStatement();
      String query = "create table NovaTab " +
		  "(CODIGO int NOT NULL, " +
		  "DESCRICAO varchar(80)," +
		  "primary key(CODIGO))";
      stmt.addBatch(query);
      for (int i = 1; i <= 10; i++) {
        query = "INSERT INTO novaTab (codigo, descricao) " +
          "VALUES (" + i + ", 'Isto é um registro novo')";
        stmt.addBatch(query);
      }
      int [] updTotal = stmt.executeBatch();        
      stmt.close();
      con.close();
    } catch (BatchUpdateException b) {
      System.err.println("Erro no SQL: " + b.getMessage());
      System.err.println("Status do SQL: " + b.getSQLState());
      System.err.println("Código do Erro: " + b.getErrorCode());
      System.err.println("Total de Inclusões: ");
      int [] updTotal = b.getUpdateCounts();  
      for (int i = 0; i < updTotal.length; i++) {
        System.err.println(updTotal[i] + "  ");
      }
    } catch (SQLException e) {
      System.err.print("Erro no SQL: "); 
   	System.err.println(e.getMessage());
    }	
  }
}
