package chat.cliente;


/**
* chat/cliente/ClientListenerHelper.java .
* Generated by the IDL-to-Java compiler (portable), version "3.1"
* from ChatServide.idl
* Quarta-feira, 2 de Junho de 2004 19h33min52s GMT-03:00
*/

abstract public class ClientListenerHelper
{
  private static String  _id = "IDL:chat/cliente/ClientListener:1.0";

  public static void insert (org.omg.CORBA.Any a, chat.cliente.ClientListener that)
  {
    org.omg.CORBA.portable.OutputStream out = a.create_output_stream ();
    a.type (type ());
    write (out, that);
    a.read_value (out.create_input_stream (), type ());
  }

  public static chat.cliente.ClientListener extract (org.omg.CORBA.Any a)
  {
    return read (a.create_input_stream ());
  }

  private static org.omg.CORBA.TypeCode __typeCode = null;
  synchronized public static org.omg.CORBA.TypeCode type ()
  {
    if (__typeCode == null)
    {
      __typeCode = org.omg.CORBA.ORB.init ().create_interface_tc (chat.cliente.ClientListenerHelper.id (), "ClientListener");
    }
    return __typeCode;
  }

  public static String id ()
  {
    return _id;
  }

  public static chat.cliente.ClientListener read (org.omg.CORBA.portable.InputStream istream)
  {
    return narrow (istream.read_Object (_ClientListenerStub.class));
  }

  public static void write (org.omg.CORBA.portable.OutputStream ostream, chat.cliente.ClientListener value)
  {
    ostream.write_Object ((org.omg.CORBA.Object) value);
  }

  public static chat.cliente.ClientListener narrow (org.omg.CORBA.Object obj)
  {
    if (obj == null)
      return null;
    else if (obj instanceof chat.cliente.ClientListener)
      return (chat.cliente.ClientListener)obj;
    else if (!obj._is_a (id ()))
      throw new org.omg.CORBA.BAD_PARAM ();
    else
    {
      org.omg.CORBA.portable.Delegate delegate = ((org.omg.CORBA.portable.ObjectImpl)obj)._get_delegate ();
      chat.cliente._ClientListenerStub stub = new chat.cliente._ClientListenerStub ();
      stub._set_delegate(delegate);
      return stub;
    }
  }

}