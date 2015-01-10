package cmp;

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

public class CMPProductBean implements EntityBean {

  EntityContext context;

  public String productId;
  public String productName;
  public String description;
  public double price;

  public String getProductId() {
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

  public String ejbCreate(int productId, String productName,
    String description, double price)
    throws RemoteException, CreateException {
    System.out.println("ejbCreate");
    this.productId = Integer.toString( productId);
    this.productName = productName;
    this.description = description;
    this.price = price;
    return Integer.toString(productId);
  }

  public void ejbPostCreate(int productId, String productName,
    String description, double price)
    throws RemoteException, CreateException {
    System.out.println("ejbPostCreate");
  }

  public void ejbRemove() throws RemoteException {
    System.out.println("ejbRemove");
  }

  public void ejbActivate() {
    System.out.println("ejbActivate");
  }

  public void ejbPassivate() {
    System.out.println("ejbPassivate");
  }

  public void ejbLoad() {
    System.out.println("ejbLoad");
  }
  public void ejbStore() {
    System.out.println("ejbStore");
  }
  public void setEntityContext(EntityContext context) {
    System.out.println("setEntityContext");
    this.context = context;

  }

  public void unsetEntityContext() {
    System.out.println("unsetEntityContext");
    context = null;
  }
}
