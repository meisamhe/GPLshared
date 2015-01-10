import java.sql.*;

public class MostraDado {

  public static void main(String args[]) {
    // 1a. Parte  
    try {
      Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
      String url = "jdbc:odbc:meuODBC";
      Connection con;
      con = DriverManager.getConnection(url, "", "");

      // 2a. Parte  
      Statement stmt;
      stmt = con.createStatement();							
   	String query = "SELECT * FROM minhaTabela";
      con.rollback();
		ResultSet rs = stmt.executeQuery(query);
      // 3a. Parte
      int i;
      String s;
      while (rs.next()) {
        i = rs.getInt(1);     // Pega o primeiro campo do tipo Int
        s = rs.getString(2);  // Pega o segundo campo do tipo String
        System.out.println("" + i + " - " +  s);
      }
      rs.close();
      stmt.close();
      con.close();
    } catch(java.lang.ClassNotFoundException e) {
      System.err.print("Erro na Classe: " + e.getMessage());
    } catch (SQLException e) {
      System.err.print("Erro no SQL: " + e.getMessage());
    }
  }
}

