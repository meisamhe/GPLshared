package bmp;

import java.sql.*;
import java.util.Properties;
import java.util.Enumeration;
import java.util.Vector;
import java.rmi.RemoteException;
import javax.ejb.EntityBean;
import javax.ejb.EntityContext;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import javax.ejb.ObjectNotFoundException;
import javax.naming.InitialContext;
import javax.naming.Context;
import javax.naming.NamingException;

public class ProductBean implements EntityBean {

  EntityContext context;
  int productId;
  String productName;
  String description;
  double price;

  public int getProductId() {
    System.out.println("getProductId");
    return productId;
  }

  public String getProductName() {
    System.out.println("getProductName");
    return productName;
  }

  public String getDescription() {
    System.out.println("getDescription");
    return description;
  }
  public double getPrice() {
    System.out.println("getPrice");
    return price;
  }

  public ProductPK ejbCreate(int productId, String productName,
    String description, double price)
    throws RemoteException, CreateException {
    System.out.println("ejbCreate");
    this.productId = productId;
    this.productName = productName;
    this.description = description;
    this.price = price;
    Connection con = null;
    PreparedStatement ps = null;
    try {
      String sql = "INSERT INTO Products" +
        " (ProductId, ProductName, Description, Price)" +
        " VALUES" +
        " (?, ?, ?, ?)";
      con = getConnection();
      ps = con.prepareStatement(sql);
      ps.setInt(1, productId);
      ps.setString(2, productName);
      ps.setString(3, description);
      ps.setDouble(4, price);
      ps.executeUpdate();
    }
    catch (SQLException e) {
      System.out.println(e.toString());
    }
    finally {
      try {
        if (ps!=null)
          ps.close();
        if (con!=null)
          con.close();
      }
      catch (SQLException e) {
      }
    }
    return new ProductPK(Integer.toString(productId));
  }


  public void ejbPostCreate(int productId, String productName,
    String description, double price)
    throws RemoteException, CreateException {
    System.out.println("ejbPostCreate");
  }

  public ProductPK ejbFindByPrimaryKey(ProductPK primaryKey)
    throws RemoteException, FinderException {
    System.out.println("ejbFindByPrimaryKey");
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
      String sql = "SELECT ProductName" +
        " FROM Products" +
        " WHERE ProductId=?";
      int productId = Integer.parseInt(primaryKey.productId);
      con = getConnection();
      ps = con.prepareStatement(sql);
      ps.setInt(1, productId);
      rs = ps.executeQuery();
      if (rs.next()) {
        rs.close();
        ps.close();
        con.close();
        return primaryKey;
      }
    }
    catch (SQLException e) {
      System.out.println(e.toString());
    }
    finally {
      try {
        if (rs!=null)
          rs.close();
        if (ps!=null)
          ps.close();
        if (con!=null)
          con.close();
      }
      catch (SQLException e) {
      }
    }
    throw new ObjectNotFoundException();

  }

  public Enumeration ejbFindByName(String name)
    throws RemoteException, FinderException {
    System.out.println("ejbFindByName");
    Vector products = new Vector();
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
      String sql = "SELECT ProductId " +
        " FROM Products" +
        " WHERE ProductName=?";
      con = getConnection();
      ps = con.prepareStatement(sql);
      ps.setString(1, name);
      rs = ps.executeQuery();
      while (rs.next()) {
        int productId = rs.getInt(1);
        products.addElement(new ProductPK(Integer.toString(productId)));
      }
    }
    catch (SQLException e) {
      System.out.println(e.toString());
    }
    finally {
      try {
        if (rs!=null)
          rs.close();
        if (ps!=null)
          ps.close();
        if (con!=null)
          con.close();
      }
      catch (SQLException e) {
      }
    }
    return products.elements();
  }

  public void ejbRemove() throws RemoteException {
    System.out.println("ejbRemove");
    Connection con = null;
    PreparedStatement ps = null;
    try {
      String sql = "DELETE FROM Products" +
        " WHERE ProductId=?";
      ProductPK key = (ProductPK) context.getPrimaryKey();
      int productId = Integer.parseInt(key.productId);
      con = getConnection();
      ps = con.prepareStatement(sql);
      ps.setInt(1, productId);
      ps.executeUpdate();
    }
    catch (SQLException e) {
      System.out.println(e.toString());
    }
    finally {
      try {
        if (ps!=null)
          ps.close();
        if (con!=null)
          con.close();
      }
      catch (SQLException e) {
      }
    }
  }

  public void ejbActivate() {
    System.out.println("ejbActivate");
  }

  public void ejbPassivate() {
    System.out.println("ejbPassivate");
  }

  public void ejbLoad() {
    System.out.println("ejbLoad");
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
      String sql = "SELECT ProductName, Description, Price" +
        " FROM Products" +
        " WHERE ProductId=?";
      con = getConnection();
      ps = con.prepareStatement(sql);
      ps.setInt(1, this.productId);
      rs = ps.executeQuery();
      if (rs.next()) {
        this.productName = rs.getString(1);
        this.description = rs.getString(2);
        this.price = rs.getDouble(3);
      }
    }
    catch (SQLException e) {
      System.out.println(e.toString());
    }
    finally {
      try {
        if (rs!=null)
          rs.close();
        if (ps!=null)
          ps.close();
        if (con!=null)
          con.close();
      }
      catch (SQLException e) {
      }
    }
  }
  public void ejbStore() {
    System.out.println("ejbStore");
    Connection con = null;
    PreparedStatement ps = null;
    try {
      String sql = "UPDATE Products" +
        " SET ProductName=?, Description=?, Price=?" +
        " WHERE ProductId=?";
      ProductPK key = (ProductPK) context.getPrimaryKey();
      int productId = Integer.parseInt(key.productId);
      con = getConnection();
      ps = con.prepareStatement(sql);
      ps.setString(1, this.productName);
      ps.setString(2, this.description);
      ps.setDouble(3, this.price);
      ps.setInt(4, productId);
      ps.executeUpdate();
    }
    catch (SQLException e) {
      System.out.println(e.toString());
    }
    finally {
      try {
        if (ps!=null)
          ps.close();
        if (con!=null)
          con.close();
      }
      catch (SQLException e) {
      }
    }


  }
  public void setEntityContext(EntityContext context) {
    System.out.println("setEntityContext");
    this.context = context;

  }

  public void unsetEntityContext() {
    System.out.println("unsetEntityContext");
    context = null;
  }

  public Connection getConnection() {

    String dbUrl = null;
    String userName = null;
    String password = null;
    Context initialContext;
    Context environment;
    Connection connection = null;

    try {
      initialContext = new InitialContext();
      environment = (Context) initialContext.lookup("java:comp/env");
      dbUrl = (String) environment.lookup("dbUrl");
      userName = (String) environment.lookup("dbUserName");
      password = (String) environment.lookup("dbPassword");
    }
    catch (NamingException e) {
      System.out.println(e.toString());
    }
    try {
      connection = DriverManager.getConnection(dbUrl, userName, password);
    }
    catch (SQLException e) {
      System.out.println(e.toString());
    }
    return connection;
  }
}
