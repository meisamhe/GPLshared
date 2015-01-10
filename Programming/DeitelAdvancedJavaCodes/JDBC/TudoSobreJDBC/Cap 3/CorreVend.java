import java.sql.*;

public class CorreVend {

  final private String url = "jdbc:mysql://casa:3306/vendas";
  final private String drv = "org.gjt.mm.mysql.Driver";

  private CorreVend() {
    try {
      Class.forName(drv);
      Connection con = DriverManager.getConnection(url,"root","");
      Statement stm = con.createStatement();
      ResultSet rs = stm.executeQuery("SELECT * FROM vendedor");
      // ***
      if (rs.isAfterLast() == false)
        rs.afterLast();
      while (rs.previous())
        System.out.println(rs.getString(1) + " " + rs.getString(2));
    } catch (ClassNotFoundException e) {
      System.err.print(e.getMessage());
    } catch (SQLException e1) {
      System.err.print(e1.getMessage());
    } catch (Exception e3) {
      System.err.print(e3.getMessage());
    }
  }

  public static void main(String args[]) {
    CorreVend aplic = new CorreVend();
  }

}
