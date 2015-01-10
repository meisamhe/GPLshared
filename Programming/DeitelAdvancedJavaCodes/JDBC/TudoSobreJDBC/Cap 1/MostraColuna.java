import java.sql.*;
     
class MostraColuna {
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
      String query = "select * from novaTab";
      ResultSet rs = stmt.executeQuery(query);
      // Chama o procedimento para os tipos
      ResultSetMetaData rsmd = rs.getMetaData();
		System.out.println(" ");
      mstTipoCol(rsmd);
      // Mostra os nomes das Colunas
		System.out.println(" ");
		System.out.println("Estes são os nomes das Colunas:");
      int numDeColunas = rsmd.getColumnCount();
	   for (int i = 1; i <= numDeColunas; i++) {
		  if (i > 1) System.out.print(",  ");
        String nomeCol = rsmd.getColumnName(i);
        System.out.print(nomeCol);
      }
      // Mostra os Dados
		System.out.println(" ");
		System.out.println(" ");
		System.out.println("Estes são os Dados:");
	   while (rs.next()) {
		  for (int i = 1; i <= numDeColunas; i++) {
		    if (i > 1) System.out.print(",  ");
          String columnValue = rs.getString(i);
          System.out.print(columnValue);
        }
        System.out.println("");	
      }
	   stmt.close();
		con.close();
    } catch(SQLException ex) {
      System.err.print("Erro no SQL: "); 
		System.err.println(ex.getMessage());
	 }	
  }

  public static void mstTipoCol(ResultSetMetaData rsmd) 
    throws SQLException {
    int columns = rsmd.getColumnCount();
    for (int i = 1; i <= columns; i++) {
      int jdbcType = rsmd.getColumnType(i);
      String name = rsmd.getColumnTypeName(i);
      System.out.print("Coluna " + i + " é um JDBC do tipo " + jdbcType);
      System.out.println(", e no DBMS é " + name);
    }
  }
}