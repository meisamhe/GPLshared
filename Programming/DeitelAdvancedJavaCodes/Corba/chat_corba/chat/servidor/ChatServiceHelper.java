package chat.servidor;


/**
* chat/servidor/ChatServiceHelper.java .
* Generated by the IDL-to-Java compiler (portable), version "3.1"
* from ChatServide.idl
* Quarta-feira, 2 de Junho de 2004 19h33min52s GMT-03:00
*/

abstract public class ChatServiceHelper
{
  private static String  _id = "IDL:chat/servidor/ChatService:1.0";

  public static void insert (org.omg.CORBA.Any a, chat.servidor.ChatService that)
  {
    org.omg.CORBA.portable.OutputStream out = a.create_output_stream ();
    a.type (type ());
    write (out, that);
    a.read_value (out.create_input_stream (), type ());
  }

  public static chat.servidor.ChatService extract (org.omg.CORBA.Any a)
  {
    return read (a.create_input_stream ());
  }

  private static org.omg.CORBA.TypeCode __typeCode = null;
  synchronized public static org.omg.CORBA.TypeCode type ()
  {
    if (__typeCode == null)
    {
      __typeCode = org.omg.CORBA.ORB.init ().create_interface_tc (chat.servidor.ChatServiceHelper.id (), "ChatService");
    }
    return __typeCode;
  }

  public static String id ()
  {
    return _id;
  }

  public static chat.servidor.ChatService read (org.omg.CORBA.portable.InputStream istream)
  {
    return narrow (istream.read_Object (_ChatServiceStub.class));
  }

  public static void write (org.omg.CORBA.portable.OutputStream ostream, chat.servidor.ChatService value)
  {
    ostream.write_Object ((org.omg.CORBA.Object) value);
  }

  public static chat.servidor.ChatService narrow (org.omg.CORBA.Object obj)
  {
    if (obj == null)
      return null;
    else if (obj instanceof chat.servidor.ChatService)
      return (chat.servidor.ChatService)obj;
    else if (!obj._is_a (id ()))
      throw new org.omg.CORBA.BAD_PARAM ();
    else
    {
      org.omg.CORBA.portable.Delegate delegate = ((org.omg.CORBA.portable.ObjectImpl)obj)._get_delegate ();
      chat.servidor._ChatServiceStub stub = new chat.servidor._ChatServiceStub ();
      stub._set_delegate(delegate);
      return stub;
    }
  }

}
