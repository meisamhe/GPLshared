package cmp;

import javax.naming.*;
import javax.rmi.PortableRemoteObject;
import java.util.Properties;
import java.util.Enumeration;
import com.brainysoftware.ejb.CMPProduct;
import com.brainysoftware.ejb.CMPProductHome;
import java.util.Collection;
import java.util.Iterator;

public class CMPBeanClient {

  public static void main(String[] args) {
    // preparing properties for constructing an InitialContext object
    Properties properties = new Properties();
    properties.put(Context.INITIAL_CONTEXT_FACTORY, "org.jnp.interfaces.NamingContextFactory");
    properties.put(Context.PROVIDER_URL, "localhost:1099");

    try {
      // Get an initial context
      InitialContext jndiContext = new InitialContext(properties);
      System.out.println("Got context");

      // Get a reference to the Bean
      Object ref  = jndiContext.lookup("CMPProduct");
      System.out.println("Got reference");

      // Get a reference from this to the Bean's Home interface
      CMPProductHome home = (CMPProductHome) PortableRemoteObject.narrow(ref, CMPProductHome.class);

      // Create an Interest object from the Home interface
      home.create(61, "Franklin Spring Water", "400ml", 2.25);
      home.create(62, "Franklin Spring Water", "600ml", 3.25);
      home.create(63, "Choco Bar", "Chocolate Bar 200g", 2.95);
      home.create(64, "Timtim Biscuit", "Biscuit w. mint flavor, 300g", 9.25);
      CMPProduct product = home.create(65, "Supermie", "Instant Noodle", 1.05);
      product.remove();

      Collection allProducts = home.findAll();
      Iterator iterator = allProducts.iterator();
      while (iterator.hasNext()) {
        product = (CMPProduct) iterator.next();
        System.out.println("Id: " + product.getProductId());
        System.out.println("Product Name: " + product.getProductName());
        System.out.println("Description: " + product.getDescription());
        System.out.println("Price: " + product.getPrice());
      }

      product = home.findByPrimaryKey("53");
      System.out.println("Displaying product with id=63");
      System.out.println("Product Name: " + product.getProductName());
      System.out.println("Description: " + product.getDescription());
      System.out.println("Price: " + product.getPrice());

      Enumeration enum = home.findByProductName("Franklin Spring Water");
      while (enum.hasMoreElements()) {
        product = (CMPProduct) enum.nextElement();
        System.out.println("Product Id: " + product.getProductId());
        System.out.println("Description: " + product.getDescription());
        System.out.println("Price: " + product.getPrice());
      }


    }
    catch(Exception e) {
      System.out.println(e.toString());
    }
  }
}
