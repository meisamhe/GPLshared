package peer2me.domain;

import java.util.Enumeration;
import java.util.Vector;

/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Sep 5, 2009
 * Time: 4:22:35 PM
 * To change this template use File | Settings | File Templates.
 */
public class Hashtable {
    private Vector vector;

    public Hashtable(){
        vector= new Vector();
    }

    public Vector getVector() {
        return vector;
    }

    public void remove(String address) {
        for (int i=0; i < vector.size();i++) {
            if (address.equals(((Hash)vector.elementAt(i)).key)){
                vector.removeElementAt(i);
                return;
            }
        }
    }

    public boolean containsKey(java.lang.String key) {
        for (int i=0; i < vector.size();i++) {
            if (key.equals(((Hash)vector.elementAt(i)).key)){
                return true;
            }
        }
        return false;
    }


    public void put(String address, Object node) {
        vector.addElement(new Hash(address, node));
    }

    public Object get(String address) {
        for (int i=0; i < vector.size();i++) {
            if (address.equals(((Hash)vector.elementAt(i)).key)){
                return ((Hash)vector.elementAt(i)).value;
            }
        }
        return null;
    }

    public void clear() {
        for (int i=0; i < vector.size();i++) {
           vector.removeElementAt(i);
        }
    }

    public Enumeration keys() {
        Vector temp = new Vector();
        for (int i=0; i < vector.size(); i++) {
            temp.addElement(((Hash)vector.elementAt(i)).key);
        }
        return temp.elements();
    }

    public int size() {
        return vector.size();
    }

    public boolean contains(Object remoteNodeName) {
       for (int i=0; i < vector.size();i++) {
            if (remoteNodeName ==((Hash)vector.elementAt(i)).value){
                return true;
            }
        }
        return false;
    }


}
