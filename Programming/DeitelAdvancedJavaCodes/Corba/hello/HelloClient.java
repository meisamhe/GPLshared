// Copyright and License 
 
import HelloApp.*;
import org.omg.CosNaming.*;
import org.omg.CosNaming.NamingContextPackage.*;
import org.omg.CORBA.*;

public class HelloClient {
   static Hello helloImpl;

   public static void main(String args[]) {
      try{
          /* cria e inicializa o ORB */
          ORB orb = ORB.init(args, null);

          /* obtem a raiz do contexto de nome */
          org.omg.CORBA.Object objRef = orb.resolve_initial_references("NameService");

          /* Usa NamingContextExt ao inves de NamingContext */ 
          NamingContextExt ncRef = NamingContextExtHelper.narrow(objRef);

          /* obtem a Referencia do Objeto pelo "nome" */
          String name = "Hello";
          helloImpl = HelloHelper.narrow(ncRef.resolve_str(name));

          /* executa os métodos no objeto remoto */
          System.out.println(helloImpl.sayHello("Hello Servidor!!!"));
          helloImpl.shutdown();

      } catch (Exception e) {
          System.out.println("ERROR : " + e) ;
	  e.printStackTrace(System.out);
      } //catch
    } //main

} //class HelloClient

