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
 * Time: 10:04:04 AM
 * To change this template use File | Settings | File Templates.
 */
public class SerializableMatrix extends Serializable {
   Vector v;
    int length;
   public SerializableMatrix(int elements[][]){
        v = new Vector();
        for (int i=0; i<elements.length;i++){
            SerializableVector sv = new SerializableVector(elements[i]);
            v.addElement(sv);
        }
    }
    public void writeObject(DataOutputStream dos) {
        dos.writeInt(length);
        for (int i=0;i<length;i++)
            dos.writeObject((SerializableVector)v.elementAt(i));
    }

    public Serializable readObject(DataInputStream dis) throws ClassNotFoundException, IllegalAccessException, InstantiationException {
        v = new Vector();
        length = dis.readInt();
        for (int i=0; i<length;i++){
            SerializableVector sv = new SerializableVector(); 
            sv = (SerializableVector)dis.readObject(sv);
            v.addElement(sv);
        }
        return this;  //To change body of implemented methods use File | Settings | File Templates.
    }

    public void readObject(DataInputStreamWrapper in) throws ClassNotFoundException, IllegalAccessException, InstantiationException, IOException      //for persistent this two methods should be implemented it somehow shows the   serializability order
    {
       v = new Vector();
        length = in.readInt();
        for (int i=0; i<length;i++){
            SerializableVector sv = new SerializableVector();
            in.readObject(sv);
            v.addElement(sv);
        }
    }

    public void writeObject(DataOutputStreamWrapper out) throws IOException {
        out.writeInt(length);
        for (int i=0;i<length;i++)
            out.writeObject((SerializableVector)v.elementAt(i));
    }

    public int getElement (int i, int j){
        return ((SerializableVector)v.elementAt(i)).getElement(j);
    }
}
