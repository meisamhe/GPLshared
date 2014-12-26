package ninja.MatrixMultiplicationRMI;

import ninja.Domain.Serializable;
import ninja.Domain.DataOutputStream;
import ninja.Domain.DataInputStream;
import peer2me.util.DataInputStreamWrapper;
import peer2me.util.DataOutputStreamWrapper;

import java.io.IOException;
import java.util.Vector;

/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Oct 24, 2009
 * Time: 10:05:56 AM
 * To change this template use File | Settings | File Templates.
 */
public class SerializableVector extends Serializable {
    public Vector v;
    public int length;
    public  SerializableVector(){}
    public SerializableVector(int elements[]){
        v = new Vector();
        length=elements.length;
        for (int i=0; i<elements.length;i++){
            v.addElement(new Integer(elements[i]));
        }
    }
    public SerializableVector(SerializableVector temp, int i,int j){
        v = new Vector();
        for (int k=i;k<j;k++)
            v.addElement(temp.v.elementAt(k));
        length=v.size();
    }
    public void writeObject(DataOutputStream dos) {
        dos.writeInt(length);
        for (int i=0;i<v.size();i++)
            dos.writeInt(((Integer)v.elementAt(i)).intValue());
    }

    public Serializable readObject(DataInputStream dis) {
        v = new Vector();
        length=dis.readInt();
        for (int i=0;i<length;i++)
            v.addElement(new Integer(dis.readInt()));
        return this;  //To change body of implemented methods use File | Settings | File Templates.
    }

    public void readObject(DataInputStreamWrapper in) throws ClassNotFoundException, IllegalAccessException, InstantiationException, IOException      //for persistent this two methods should be implemented it somehow shows the   serializability order
    {
        v = new Vector();
        length=in.readInt();
        for (int i=0;i<length;i++)
            v.addElement(new Integer(in.readInt()));
    }

    public void writeObject(DataOutputStreamWrapper out) throws IOException {
        out.writeInt(length);
        for (int i=0;i<v.size();i++)
            out.writeInt(((Integer)v.elementAt(i)).intValue());
    }
    public int getElement (int i){
        return ((Integer)v.elementAt(i)).intValue();
    }
}
