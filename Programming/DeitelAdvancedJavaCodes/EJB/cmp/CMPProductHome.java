package cmp;

import java.rmi.RemoteException;
import javax.ejb.FinderException;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import java.util.Collection;
import java.util.Enumeration;

public interface CMPProductHome extends EJBHome {

  public CMPProduct create(int productId, String productName,
    String description, double price)
    throws RemoteException, CreateException;

  public CMPProduct findByPrimaryKey(String productId)
    throws RemoteException, FinderException;

  public Enumeration findByProductName(String productName)
    throws RemoteException, FinderException;

  public Collection findAll()
    throws RemoteException, FinderException;
}
