package chat.servidor;


/**
* chat/servidor/_ChatServiceStub.java .
* Generated by the IDL-to-Java compiler (portable), version "3.1"
* from ChatServide.idl
* Quarta-feira, 2 de Junho de 2004 19h33min52s GMT-03:00
*/

public class _ChatServiceStub extends org.omg.CORBA.portable.ObjectImpl implements chat.servidor.ChatService
{

  public String[] conectar (String apelido, chat.cliente.ClientListener listener)
  {
            org.omg.CORBA.portable.InputStream $in = null;
            try {
                org.omg.CORBA.portable.OutputStream $out = _request ("conectar", true);
                $out.write_string (apelido);
                chat.cliente.ClientListenerHelper.write ($out, listener);
                $in = _invoke ($out);
                String $result[] = chat.ListaClientesHelper.read ($in);
                return $result;
            } catch (org.omg.CORBA.portable.ApplicationException $ex) {
                $in = $ex.getInputStream ();
                String _id = $ex.getId ();
                throw new org.omg.CORBA.MARSHAL (_id);
            } catch (org.omg.CORBA.portable.RemarshalException $rm) {
                return conectar (apelido, listener        );
            } finally {
                _releaseReply ($in);
            }
  } // conectar

  public void desconectar (String apelido, chat.cliente.ClientListener listener)
  {
            org.omg.CORBA.portable.InputStream $in = null;
            try {
                org.omg.CORBA.portable.OutputStream $out = _request ("desconectar", true);
                $out.write_string (apelido);
                chat.cliente.ClientListenerHelper.write ($out, listener);
                $in = _invoke ($out);
                return;
            } catch (org.omg.CORBA.portable.ApplicationException $ex) {
                $in = $ex.getInputStream ();
                String _id = $ex.getId ();
                throw new org.omg.CORBA.MARSHAL (_id);
            } catch (org.omg.CORBA.portable.RemarshalException $rm) {
                desconectar (apelido, listener        );
            } finally {
                _releaseReply ($in);
            }
  } // desconectar

  public void enviaMensagem (String apelido, chat.Mensagem msg)
  {
            org.omg.CORBA.portable.InputStream $in = null;
            try {
                org.omg.CORBA.portable.OutputStream $out = _request ("enviaMensagem", true);
                $out.write_string (apelido);
                chat.MensagemHelper.write ($out, msg);
                $in = _invoke ($out);
                return;
            } catch (org.omg.CORBA.portable.ApplicationException $ex) {
                $in = $ex.getInputStream ();
                String _id = $ex.getId ();
                throw new org.omg.CORBA.MARSHAL (_id);
            } catch (org.omg.CORBA.portable.RemarshalException $rm) {
                enviaMensagem (apelido, msg        );
            } finally {
                _releaseReply ($in);
            }
  } // enviaMensagem

  // Type-specific CORBA::Object operations
  private static String[] __ids = {
    "IDL:chat/servidor/ChatService:1.0"};

  public String[] _ids ()
  {
    return (String[])__ids.clone ();
  }

  private void readObject (java.io.ObjectInputStream s) throws java.io.IOException
  {
     String str = s.readUTF ();
     String[] args = null;
     java.util.Properties props = null;
     org.omg.CORBA.Object obj = org.omg.CORBA.ORB.init (args, props).string_to_object (str);
     org.omg.CORBA.portable.Delegate delegate = ((org.omg.CORBA.portable.ObjectImpl) obj)._get_delegate ();
     _set_delegate (delegate);
  }

  private void writeObject (java.io.ObjectOutputStream s) throws java.io.IOException
  {
     String[] args = null;
     java.util.Properties props = null;
     String str = org.omg.CORBA.ORB.init (args, props).object_to_string (this);
     s.writeUTF (str);
  }
} // class _ChatServiceStub
