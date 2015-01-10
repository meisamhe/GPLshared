//HelloImpl - Servant

import HelloApp.*;
import org.omg.CORBA.*;

class HelloImpl extends HelloPOA {
   private ORB orb;

   /* construtor */
   public void setORB(ORB orb_val) {
       orb = orb_val; 
   } //construtor
    
   /* implementa metodo sayHello() */
   public String sayHello(String msg) {
       System.out.println (msg);
       return "\nHello cliente !!!\n";
   } //sayHello
    
   /* implementa metodo shutdown() */
   public void shutdown() {
       orb.shutdown(false);
   } //shutdown
  
} //class HelloImpl
