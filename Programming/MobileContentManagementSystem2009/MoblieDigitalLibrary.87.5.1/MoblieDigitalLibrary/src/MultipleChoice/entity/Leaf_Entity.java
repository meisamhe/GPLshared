package MultipleChoice.entity; /**
 * checked
 */
 
import org.garret.perst.IInputStream;
import org.garret.perst.IOutputStream;

public class Leaf_Entity extends Hierarchy_Entity {

    public Leaf_Entity(long testReference){
        super(testReference);
        setIndex(-1);
    }

    public void clone(Entity e, long index)       // this will put all the the attributes and index in the entity e
    {
       e.setIndex(index);
       setIndex(index);
       ((Hierarchy_Entity)e).setTestReference(getTestReference());
    }

    public void readObject(IInputStream in)      //for persistent this two methods should be implemented it somehow shows the   serializability order
    {
        setTestReference(in.readLong());
        setIndex(in.readLong());
    }

    public void writeObject(IOutputStream out) {
        out.writeLong(getTestReference());
        out.writeLong(getIndex());
    }

}
