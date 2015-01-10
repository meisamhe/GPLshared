// HelloServer.java

import HelloApp.*;
import org.omg.CosNaming.*;
import org.omg.CosNaming.NamingContextPackage.*;
import org.omg.CORBA.*;
import org.omg.PortableServer.*;
import org.omg.PortableServer.POA;

import java.util.Properties;


public class HelloServer {

  public static void main(String args[]) {
    try{
        /* cria e inicializa o ORB */
        ORB orb = ORB.init(args, null);

        /* obtem a referencia para o RootPOA e ativa o POAManager */
        POA rootpoa = POAHelper.narrow(orb.resolve_initial_references("RootPOA"));
        rootpoa.the_POAManager().activate();

        /* cria o servant e resgistra-o com o ORB */
        HelloImpl helloImpl = new HelloImpl();
        helloImpl.setORB(orb); 

        /* obtem a referencia do objeto do servant */
        org.omg.CORBA.Object ref = rootpoa.servant_to_reference(helloImpl);
        Hello href = HelloHelper.narrow(ref);

        /* obtem a raiz do contexto de nome
        NameService invoca o serviço de nome */
        org.omg.CORBA.Object objRef = orb.resolve_initial_references("NameService");

        /* Usa NamingContextExt qual é parte da especificação Interoperable Naming
        Service (INS) */
        NamingContextExt ncRef = NamingContextExtHelper.narrow(objRef);

        /* mapeia a referência ao objeto em um "nome" */
        String name = "Hello";
        NameComponent path[] = ncRef.to_name( name );
        ncRef.rebind(path, href);

        System.out.println("HelloServer pronto e aguardando ...");

        /* aguarda por chamadas dos clientes */
        orb.run();
      
    } catch (Exception e) {
        System.err.println("ERROR: " + e);
        e.printStackTrace(System.out);
    } //catch
	  
    System.out.println("HelloServer terminando ...");
  } //main
  
}//class HelloServer


