package MultipleChoice.entity; /**
 * checked
 */

import java.util.Vector;

import org.garret.perst.IInputStream;
import org.garret.perst.IOutputStream;

public class MiddleNode_Entity extends Hierarchy_Entity {

    protected PersistentVector hierarchy;
    protected String value;

    public void traverse1() {
    }

	public void traverse2() {
    }

    public void traverse3() {
    }

	public void traverse4() {
    }

	public void traverse5() {
    }

    public void traverse6() {
    }

    public void traverse7() {
    }

    public void setValue(String Value) {
        this.value=Value;
    }

    public String getValue() {
        return value;
    }

    public void setHierarchy(PersistentVector hierarchy) {
        this.hierarchy=hierarchy;
    }

    public PersistentVector getHierarchy() {
        return hierarchy;
    }

    public void setHierarchy(Vector hierarchy){
        this.hierarchy.setContent(hierarchy);
    }

    public MiddleNode_Entity(long testReference, Vector hierarchy, String value ) {
        super(testReference);
        setIndex(-1);
        setHierarchy(hierarchy);
        setValue(value);
    }

    public void clone(Entity e, long index)       // this will put all the the attributes and index in the entity e
    {
       e.setIndex(index);
       setIndex(index);
       ((MiddleNode_Entity)e).setHierarchy(getHierarchy());
       ((MiddleNode_Entity)e).setValue(getValue());
       ((MiddleNode_Entity)e).setTestReference(getTestReference());
    }

    public void readObject(IInputStream in)      //for persistent this two methods should be implemented it somehow shows the   serializability order
    {
        setTestReference(in.readLong());
        setIndex(in.readLong());
        setHierarchy((PersistentVector)in.readObject());
        setValue(in.readString());
    }

    public void writeObject(IOutputStream out) {
        out.writeLong(getTestReference());
        out.writeLong(getIndex());
        out.writeObject(getHierarchy());
        out.writeString(getValue());
    }
}
