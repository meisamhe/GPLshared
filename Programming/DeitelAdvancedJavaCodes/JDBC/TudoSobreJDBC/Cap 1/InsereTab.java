import java.sql.*;
     
public class InsereTab {
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

/* Não suportada esta Operação
PreparedStatement stmt;
String query = "INSERT INTO novaTab (codigo, descricao) " +
               "VALUES (? , ?)";
stmt = con.prepareStatement(query);
stmt.setString(2, "Isto é um teste");
for (int i = 2; i < 5; i++) { 
  stmt.setInt(1, i);
  stmt.executeUpdate(query);
} */ 
	   Statement stmt;
      stmt = con.createStatement();
      for (int i = 2; i < 5; i++) { 
        stmt.executeUpdate("INSERT INTO novaTab (codigo, descricao) " +
          "VALUES (" + i + ", 'Isto é um registro novo')");
        } 
 	   stmt.close();
 		con.close();
	 } catch(SQLException ex) {
      System.err.print("Erro na SQL: "); 
	   System.err.println(ex.getMessage());
  	 }
  }
}