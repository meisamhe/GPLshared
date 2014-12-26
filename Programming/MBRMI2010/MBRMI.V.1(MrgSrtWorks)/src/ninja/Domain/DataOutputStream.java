package ninja.Domain;

import peer2me.framework.Framework;
import peer2me.framework.FrameworkFrontEnd;
import peer2me.framework.FrameworkListener;
import peer2me.domain.Hash;

/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Aug 29, 2009
 * Time: 1:30:51 AM
 * To change this template use File | Settings | File Templates.
 */
public class DataOutputStream {

    private String buffer;
    private static Framework f;
    private static DataOutputStream singleton;

//    public DataOutputStream (FrameworkListener f)   {
//        buffer="";
//        this.f = FrameworkFrontEnd.getInstance(f);
//    }
//
    public static  DataOutputStream getInstance(FrameworkListener f)
//            , int theport)
    {
		if(singleton == null){
			singleton = new DataOutputStream();
            singleton.buffer="";
            singleton.f = FrameworkFrontEnd.getInstance(f);
        }
		DataOutputStream dos = singleton;
        return dos;
	}

    public static Framework getFramework(){
        return f;
    }

    public void writeByte (byte b){
        buffer = buffer+b+" ";
    }

    public void writeInt (int i){
        buffer = buffer + i + " ";
    }

    public void writeShort (short s){
        buffer = buffer + s + " ";
    }

    public void writeLong(long l)  {
        buffer = buffer + l + " ";
    }


    public void writeUTF(String u) {
        buffer = buffer + u + " ";
    }

     public void writeObject(Serializable obj) {
         obj.writeObject(this);
     }

    public void flush(){
         f.sendTextPackage(((FrameworkFrontEnd)f).participatingNodeAddress,buffer);
         buffer = "";
    }
}
