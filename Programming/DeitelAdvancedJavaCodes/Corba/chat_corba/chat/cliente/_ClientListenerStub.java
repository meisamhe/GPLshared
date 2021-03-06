package chat.cliente;


/**
* chat/cliente/_ClientListenerStub.java .
* Generated by the IDL-to-Java compiler (portable), version "3.1"
* from ChatServide.idl
* Quarta-feira, 2 de Junho de 2004 19h33min52s GMT-03:00
*/

public class _ClientListenerStub extends org.omg.CORBA.portable.ObjectImpl implements chat.cliente.ClientListener
{

  public void addApelido (String apelido)
  {
            org.omg.CORBA.portable.InputStream $in = null;
            try {
                org.omg.CORBA.portable.OutputStream $out = _request ("addApelido", true);
                $out.write_string (apelido);
                $in = _invoke ($out);
                return;
            } catch (org.omg.CORBA.portable.ApplicationException $ex) {
                $in = $ex.getInputStream ();
                String _id = $ex.getId ();
                throw new org.omg.CORBA.MARSHAL (_id);
            } catch (org.omg.CORBA.portable.RemarshalException $rm) {
                addApelido (apelido        );
            } finally {
                _releaseReply ($in);
            }
  } // addApelido

  public void delApelido (String apelido)
  {
            org.omg.CORBA.portable.InputStream $in = null;
            try {
                org.omg.CORBA.portable.OutputStream $out = _request ("delApelido", true);
                $out.write_string (apelido);
                $in = _invoke ($out);
                return;
            } catch (org.omg.CORBA.portable.ApplicationException $ex) {
                $in = $ex.getInputStream ();
                String _id = $ex.getId ();
                throw new org.omg.CORBA.MARSHAL (_id);
            } catch (org.omg.CORBA.portable.RemarshalException $rm) {
                delApelido (apelido        );
            } finally {
                _releaseReply ($in);
            }
  } // delApelido

  public void recebeMensagem (chat.Mensagem msg)
  {
            org.omg.CORBA.portable.InputStream $in = null;
            try {
                org.omg.CORBA.portable.OutputStream $out = _request ("recebeMensagem", true);
                chat.MensagemHelper.write ($out, msg);
                $in = _invoke ($out);
                return;
            } catch (org.omg.CORBA.portable.ApplicationException $ex) {
                $in = $ex.getInputStream ();
                String _id = $ex.getId ();
                throw new org.omg.CORBA.MARSHAL (_id);
            } catch (org.omg.CORBA.portable.RemarshalException $rm) {
                recebeMensagem (msg        );
            } finally {
                _releaseReply ($in);
            }
  } // recebeMensagem

  // Type-specific CORBA::Object operations
  private static String[] __ids = {
    "IDL:chat/cliente/ClientListener:1.0"};

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
} // class _ClientListenerStub
