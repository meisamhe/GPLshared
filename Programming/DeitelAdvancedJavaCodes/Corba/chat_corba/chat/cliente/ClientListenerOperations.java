package chat.cliente;


/**
* chat/cliente/ClientListenerOperations.java .
* Generated by the IDL-to-Java compiler (portable), version "3.1"
* from ChatServide.idl
* Quarta-feira, 2 de Junho de 2004 19h33min52s GMT-03:00
*/

public interface ClientListenerOperations 
{
  void addApelido (String apelido);
  void delApelido (String apelido);
  void recebeMensagem (chat.Mensagem msg);
} // interface ClientListenerOperations