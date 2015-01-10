import java.sql.*;
     
public class CriaTab {
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
		stmt  = con.createStatement();
   	String query = 
        "create table NovaTab " +
		  "(CODIGO int NOT NULL, " +
		  "DESCRICAO varchar(80)," +
		  "primary key(CODIGO))";
		stmt.executeUpdate(query);
		stmt.close();
		con.close();
	 } catch(SQLException ex) {
      System.err.print("Erro no SQL: "); 
		System.err.println(ex.getMessage());
	 }
  }
}