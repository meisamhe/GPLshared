import chat.*;
import chat.cliente.*;


public class ClientChatListener extends ClientListenerPOA {
    private ClientChat clientChat;

    /**
     * Construtor
     */
    public ClientChatListener (ClientChat chat) {
        clientChat = chat;
    } //construtor

    /**
     * Implementar o listener, ou seja, a interface no lado do cliente
     */
    public void addApelido (String apelido) {
        clientChat.addNick(apelido);
    } //addApelido

    public void delApelido (String apelido){
        clientChat.removeNick(apelido);
    } //delApelido

    public void recebeMensagem (chat.Mensagem msg) {
        clientChat.writeMessage (msg.origem, msg.mensagem);
    } //recebeMensagem

} //ClientChatListener
