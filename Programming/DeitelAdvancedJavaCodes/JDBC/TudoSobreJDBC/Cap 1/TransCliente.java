import java.sql.*;
     
public class TransCliente {
  public static void main(String args[]) {
    String url = "jdbc:odbc:meuODBC";
    Connection con = null;
    Statement stmt;

    Statement alteraClienteA;
    Statement alteraClienteB;

    String alteraA = "update CLIENTE " +
      "set SALDO = SALDO - 10 where CONTA = 'A'";
    String alteraB = "update CLIENTE " +
      "set SALDO = SALDO + 10 where CONTA = 'B'";
	
    try {
      Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
    } catch(java.lang.ClassNotFoundException e) {
      System.err.print("Erro na Classe: "); 
      System.err.println(e.getMessage());
    }

    try {
      con = DriverManager.getConnection(url, "", "");
  	   con.setAutoCommit(false);

      alteraClienteA = con.createStatement();
      alteraClienteA.executeUpdate(alteraA);
      alteraClienteB = con.createStatement();
      alteraClienteB.executeUpdate(alteraB);
      con.commit();

      alteraClienteA.close();
      alteraClienteB.close();
      con.setAutoCommit(true);
      con.close();
    } catch(SQLException ex) {
		System.err.println("Erro no SQL: " + ex.getMessage());
 		if (con != null) {
        try {
		    System.err.print("Voltando as Transações");
 		    con.rollback();
		  } catch(SQLException excep) {
		    System.err.print("Erro no SQL: ");
		    System.err.println(excep.getMessage());
		  }
		}
    }
  }
}

