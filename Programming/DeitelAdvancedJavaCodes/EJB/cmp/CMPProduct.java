package cmp;

import javax.ejb.EJBObject;
import java.rmi.RemoteException;

/* this is the remote interface for Product */
public interface CMPProduct extends EJBObject {
  public String getProductId() throws RemoteException;
  public double getPrice() throws RemoteException;
  public String getProductName() throws RemoteException;
  public String getDescription() throws RemoteException;
}
