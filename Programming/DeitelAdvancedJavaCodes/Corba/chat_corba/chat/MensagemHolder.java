package chat;

/**
* chat/MensagemHolder.java .
* Generated by the IDL-to-Java compiler (portable), version "3.1"
* from ChatServide.idl
* Quarta-feira, 2 de Junho de 2004 19h33min52s GMT-03:00
*/

public final class MensagemHolder implements org.omg.CORBA.portable.Streamable
{
  public chat.Mensagem value = null;

  public MensagemHolder ()
  {
  }

  public MensagemHolder (chat.Mensagem initialValue)
  {
    value = initialValue;
  }

  public void _read (org.omg.CORBA.portable.InputStream i)
  {
    value = chat.MensagemHelper.read (i);
  }

  public void _write (org.omg.CORBA.portable.OutputStream o)
  {
    chat.MensagemHelper.write (o, value);
  }

  public org.omg.CORBA.TypeCode _type ()
  {
    return chat.MensagemHelper.type ();
  }

}
