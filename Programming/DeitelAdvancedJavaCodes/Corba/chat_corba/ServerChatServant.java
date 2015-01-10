import chat.cliente.*;
import chat.servidor.*;
import chat.*;

import java.util.*;


public class ServerChatServant extends ChatServicePOA  {

    private ArrayList listaNome;
    private HashMap listaListeners;


    /**
     * Construtor
     */
    public ServerChatServant()  {
        initServer();
    } //construtor

    /**
     * Inicializa o servidor e suas variáveis
     */
    private void initServer() {
        try {
            listaNome = new ArrayList();
            listaListeners = new HashMap();

            listaNome.add(new String ("Todos"));

            System.out.println ("Propriedades inicializadas ...");
        } catch (Exception e) {
            System.out.println(e);
        } //catch
    } //initServer


    // Implementar metodos remotos
      public String[] conectar (String apelido, chat.cliente.ClientListener listener) {
          if (listaNome.contains(apelido)) return null;

          listaNome.add(apelido);
          listaListeners.put(apelido, listener);

          System.out.println(apelido + " conectado");

          // implementar callback para avisar conexao
          for (int i=1; i<listaNome.size()-1; i++) {
              String ap = String.valueOf(listaNome.get(i));
              ClientListener l = (ClientListener)listaListeners.get(ap);
 	      l.addApelido(apelido);
	  } //for

          String[] lista = new String [listaNome.size()];
          for (int i=0; i<lista.length; i++)
              lista[i] = String.valueOf(listaNome.get(i));

         return lista;
      } //conectar

      public void desconectar (String apelido, chat.cliente.ClientListener listener) {
         int idx = listaNome.indexOf(apelido);

         if  (!listener.equals(listaListeners.get(apelido)))
             return;

         if ((listaNome.remove(idx) != null)) {
             listaListeners.remove(apelido);

             // implementa callback avisando desconexao
             for (int i=1; i<listaNome.size(); i++) {
                 String ap = String.valueOf(listaNome.get(i));
                 ClientListener l = (ClientListener)listaListeners.get(ap);
                 l.delApelido(apelido);
	     } //for

             System.out.println(apelido + " desconectado");
         } //if
      } //desconectar

      public void enviaMensagem (String apelido, chat.Mensagem msg) {
         if (apelido.equals("Todos")) {
             DespachaMensagem m = new DespachaMensagem (listaListeners, msg);
         } else {
             ClientListener l = (ClientListener) listaListeners.get(apelido);
             l.recebeMensagem (msg);
         } //else
      } //enviaMensagem

};//ServerChatServant





/**
 * Classe DespachaMensagem
 * Funcao: Envia mensagens para todos clientes atraves de uma thread
 */
class DespachaMensagem implements Runnable {

    private Mensagem msg;
    private HashMap listaListeners;

    public DespachaMensagem (HashMap listeners, Mensagem mensagem) {
        listaListeners = listeners;
        msg = mensagem;
        this.run();
    } //construtor


    public void run () {
        //implementa o callback para todos os clientes
        if (listaListeners.size() > 0) {
           Iterator clientes = listaListeners.values().iterator();
           while (clientes.hasNext()) {
                 ClientListener l = (ClientListener)clientes.next();
                 l.recebeMensagem(msg);
           } // while
        } //if

    } //run

} //MessaseDispacher
