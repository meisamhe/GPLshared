package bmp;

import java.rmi.RemoteException;
import javax.ejb.FinderException;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import java.util.Enumeration;

public interface ProductHome extends EJBHome {

  public Product create(int productId, String productName,
    String description, double price)
    throws RemoteException, CreateException;

  public Product findByPrimaryKey(ProductPK key)
    throws RemoteException, FinderException;

  public Enumeration findByName(String name)
    throws RemoteException, FinderException;
}
