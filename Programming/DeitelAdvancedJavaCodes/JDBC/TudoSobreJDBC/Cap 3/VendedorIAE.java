import java.sql.*;

public class VendedorIAE {
  final private String url = "jdbc:mysql://casa:3306/vendas";
  final private String drv = "org.gjt.mm.mysql.Driver";
  final private String query = "SELECT * FROM vendedor";
  private Statement stm;
  private ResultSet rs;
  private Connection con;

  public VendedorIAE() {
    try {
      Class.forName(drv);
      con = DriverManager.getConnection(url,"root","");
      stm = con.createStatement();
      rs = stm.executeQuery(query);
      mostraReg("Tabela Original");
      rs.moveToInsertRow();
      rs.updateString(1, "44444444444");
      rs.updateString(2, "Vendedor 4");
      rs.insertRow();
      mostraReg("Tabela após a inserção");
      rs.last();
      rs.updateString(2, "Vendedor Alterado");
      rs.updateRow();
      mostraReg("Tabela após a modificação");
      rs.absolute(4);
      rs.deleteRow();
      mostraReg("Tabela após a exclusão");
    } catch (ClassNotFoundException err) {
      System.err.print(err.getMessage());
    } catch (SQLException err) {
      System.err.print(err.getMessage());
    }
  }
  
  public void mostraReg(String mens) {
    System.out.println("** " + mens + " **");
    try {
      rs.close();
      rs = stm.executeQuery(query);
      while (rs.next()) {
        System.out.println(rs.getString(1) + " " + 
          rs.getString(2));
      }
    } catch (SQLException err) {
      System.err.print(err.getMessage());
    }
  }

  public static void main(String args[]) {
    VendedorIAE aplic = new VendedorIAE();
  }

}
