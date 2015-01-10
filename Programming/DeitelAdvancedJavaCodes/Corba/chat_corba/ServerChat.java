import chat.servidor.*;
import org.omg.CosNaming.*;
import org.omg.CosNaming.NamingContextPackage.*;
import org.omg.CORBA.*;
import org.omg.PortableServer.*;
import org.omg.PortableServer.POA;

import java.util.Properties;


public class ServerChat
{
    /**
     * Principal
     */
    public static void main(String[] args) {
        try {
            /* configura e inicializa o ORB */
            Properties props = new Properties();
            props.put("org.omg.CORBA.ORBInitialPort", "6666");

            ORB orb = ORB.init(args, props);

            POA rootpoa = POAHelper.narrow(orb.resolve_initial_references("RootPOA"));
            rootpoa.the_POAManager().activate();

            ServerChatServant serverChat = new ServerChatServant();

            org.omg.CORBA.Object ref = rootpoa.servant_to_reference(serverChat);
            ChatService chatService = ChatServiceHelper.narrow(ref);

            /* obtem a raiz do contexto de nome NameService invoca o serviço de nome */
            org.omg.CORBA.Object objRef = orb.resolve_initial_references("NameService");

            /* Usa NamingContextExt qual é parte da especificação Interoperable Naming
            Service (INS) */
            NamingContextExt ncRef = NamingContextExtHelper.narrow(objRef);

           /* mapeia a referência ao objeto em um "nome" */
           String name = "ChatService";
           NameComponent path[] = ncRef.to_name(name);
           ncRef.rebind(path, ref);

           System.out.println("ChatService pronto e aguardando ...");

           /* aguarda por chamadas dos clientes */
           orb.run();

        } catch (Exception e) {
            System.err.println("Erro: " + e.getMessage());
            e.printStackTrace();
        } //catch

    } //main

} //class ServerChat
