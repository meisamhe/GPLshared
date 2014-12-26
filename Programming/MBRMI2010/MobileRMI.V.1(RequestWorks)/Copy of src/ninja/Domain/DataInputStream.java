package ninja.Domain;

import peer2me.framework.Framework;
import peer2me.framework.FrameworkFrontEnd;

import java.util.Vector;

import ninja.rmi.NinjaSkeleton;
import ninja.rmi.Reliable_ServerThread;

/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Aug 29, 2009
 * Time: 1:30:59 AM
 * To change this template use File | Settings | File Templates.
 */
public class DataInputStream {

    static String buffer;
    static Vector q;

    public DataInputStream(){
        buffer=null;
//        this.q =  new Vector();
    }

    public byte readByte(){
        if (buffer == null)
            flushQueue();
        byte b=Byte.parseByte(buffer.substring(0,buffer.indexOf(" ")));
        buffer = buffer.substring(buffer.indexOf(" ")+1,buffer.length());
        return b;
    }
     public int readInt(){
         if (buffer == null)
            flushQueue();
        int i=Integer.parseInt(buffer.substring(0,buffer.indexOf(" ")));
        buffer = buffer.substring(buffer.indexOf(" ")+1,buffer.length());
        return i;
    }
     public short readShort(){
         if (buffer == null)
            flushQueue();
        short s=Short.parseShort(buffer.substring(0,buffer.indexOf(" ")));
        buffer = buffer.substring(buffer.indexOf(" ")+1,buffer.length());
        return s;
    }

    public long readLong()  {
        if (buffer == null)
            flushQueue();
        long l=Long.parseLong(buffer.substring(0,buffer.indexOf(" ")));
        buffer = buffer.substring(buffer.indexOf(" ")+1,buffer.length());
        return l;
    }

    public String readUTF(){
        if (buffer == null)
            flushQueue();
        String s=buffer.substring(0,buffer.indexOf(" "));
        buffer = buffer.substring(buffer.indexOf(" ")+1,buffer.length());
        return s;
    }

    public Serializable readObject (Serializable s) throws ClassNotFoundException, IllegalAccessException, InstantiationException {
        if (buffer == null)
            flushQueue();
        if (s == null) {
           s= (Serializable) Class.forName(s.getClass().getName()).newInstance();
        }
        return s.readObject(this);
    }

    public static void flush(ServerRequestEntity sre, Reliable_ServerThread rst){
        if (q== null)
          q =  new Vector();
        q.addElement(sre);
        if (q.size()==1 && rst!=null && !rst.runActive)     // ServerThread would be null if it is stub
          rst.run();
    }
    
     public static void flushQueue(){
       if (checkQueue()) {
         buffer = ((ServerRequestEntity)q.elementAt(0)).getRequest();
         ((FrameworkFrontEnd)DataOutputStream.getFramework()).participatingNodeAddress =
                 ((ServerRequestEntity)q.elementAt(0)).getAddress();
         q.removeElementAt(0); 
       }
    }

    public static boolean checkQueue(){
        if (q.size()>=1)
            return  true;
        return false;
    }
}
