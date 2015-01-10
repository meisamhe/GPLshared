package bmp;

import javax.naming.*;
import javax.rmi.PortableRemoteObject;
import java.util.Properties;
import java.util.Enumeration;
import com.brainysoftware.ejb.Product;
import com.brainysoftware.ejb.ProductHome;

public class BeanClient {

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
      Object ref  = jndiContext.lookup("BMPProduct");
      System.out.println("Got reference");

      // Get a reference from this to the Bean's Home interface
      ProductHome home = (ProductHome)
        PortableRemoteObject.narrow (ref, ProductHome.class);

      // Create an Interest object from the Home interface
      home.create(11, "Franklin Spring Water", "400ml", 2.25);
      home.create(12, "Franklin Spring Water", "600ml", 3.25);
      home.create(13, "Choco Bar", "Chocolate Bar 200g", 2.95);
      home.create(14, "Timtim Biscuit", "Biscuit w. mint flavor, 300g", 9.25);
      Product product = home.create(15, "Supermie", "Instant Noodle", 1.05);
      product.remove();

      Enumeration enum = home.findByName("Franklin Spring Water");
      while (enum.hasMoreElements()) {
        product = (Product) enum.nextElement();
        System.out.println("Id: " + product.getProductId());
        System.out.println("Product Name: " + product.getProductName());
        System.out.println("Description: " + product.getDescription());
        System.out.println("Price: " + product.getPrice());
      }

    }
    catch(Exception e) {
      System.out.println(e.toString());
    }
  }
}
