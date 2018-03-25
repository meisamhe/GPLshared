package MultipleChoice.entity;

/*
* checked
 */

/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Jul 20, 2008
 * Time: 8:57:45 AM
 * To change this template use File | Settings | File Templates.
 */

import org.garret.perst.Persistent;
import org.garret.perst.IOutputStream;
import org.garret.perst.IInputStream;

import java.util.Vector;

public class PersistentVector extends Persistent { // deligation of a Vector for having persistency

    private Vector    content;

    public void setContent(Vector content){
        this.content=content;
    }

    public Vector getContent(){
        return content;
    }

    public void writeObject(IOutputStream out) {//for persistent this two methods should be implemented it somehow shows the   serializability order
            out.writeLong(content.size());
            out.writeString(content.elementAt(0).getClass().getName());
            for (int i=0; i<content.size(); i++)
                out.writeObject((Entity)content.elementAt(i));
        }


        public void readObject(IInputStream in) {
            content=new Vector() ;
            long size= in.readLong();
            String className=in.readString();
            for (int i=0; i<size; i++)
                try {
                    content.addElement((Class.forName(className)));
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
                }
            in.readObject();

        }


}
