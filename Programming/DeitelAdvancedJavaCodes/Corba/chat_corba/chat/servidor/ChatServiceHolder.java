package chat.servidor;

/**
* chat/servidor/ChatServiceHolder.java .
* Generated by the IDL-to-Java compiler (portable), version "3.1"
* from ChatServide.idl
* Quarta-feira, 2 de Junho de 2004 19h33min52s GMT-03:00
*/

public final class ChatServiceHolder implements org.omg.CORBA.portable.Streamable
{
  public chat.servidor.ChatService value = null;

  public ChatServiceHolder ()
  {
  }

  public ChatServiceHolder (chat.servidor.ChatService initialValue)
  {
    value = initialValue;
  }

  public void _read (org.omg.CORBA.portable.InputStream i)
  {
    value = chat.servidor.ChatServiceHelper.read (i);
  }

  public void _write (org.omg.CORBA.portable.OutputStream o)
  {
    chat.servidor.ChatServiceHelper.write (o, value);
  }

  public org.omg.CORBA.TypeCode _type ()
  {
    return chat.servidor.ChatServiceHelper.type ();
  }

}