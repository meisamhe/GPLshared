package MultipleChoice.entity;

import org.garret.perst.Persistent;
import org.garret.perst.IOutputStream;
import org.garret.perst.IInputStream;

/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Jul 19, 2008
 * Time: 7:24:28 PM
 * To change this template use File | Settings | File Templates.
 */
public abstract class Entity extends Persistent {
    private  long index;                                    // this would be siple number index
    public  void setIndex(long index){
              this.index=index;
    }
    public  long getIndex(){
        return index;
    }
    public abstract void clone(Entity e, long index) ;      // this will put all the the attributes and index in the entity e
    public abstract void readObject(IInputStream in);      //for persistent this two methods should be implemented it somehow shows the   serializability order
    public abstract void writeObject(IOutputStream out);
}
