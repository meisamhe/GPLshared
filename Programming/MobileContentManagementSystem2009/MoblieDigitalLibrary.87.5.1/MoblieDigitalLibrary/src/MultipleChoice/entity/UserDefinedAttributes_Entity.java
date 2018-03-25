package MultipleChoice.entity;

import MultipleChoice.control.Interactive_Control;
import org.garret.perst.IInputStream;
import org.garret.perst.IOutputStream;


public class UserDefinedAttributes_Entity extends Entity{

	protected Interactive_Control interactive;
    protected String attribute;

	public void CreateHierarchy() {
   	}

	void setAttribute(String attribute) {
        this.attribute=attribute;
    }

    public String getAttribute() {
        return attribute;
    }

    public void setInteractive(Interactive_Control interactive) {
        this.interactive=interactive;
    }

    public Interactive_Control getInteractive() {
        return interactive;
    }

    public UserDefinedAttributes_Entity(Interactive_Control interactive,String attribute){
        setAttribute(attribute);
        setInteractive(interactive);
        setIndex(-1);
    }

    public void clone(Entity e, long index)       // this will put all the the attributes and index in the entity e
    {
        ((UserDefinedAttributes_Entity)e).setAttribute(attribute);
        ((UserDefinedAttributes_Entity)e).setInteractive(interactive);
        e.setIndex(index);
        setIndex(index);

    }

    public void readObject(IInputStream in)      //for persistent this two methods should be implemented it somehow shows the   serializability order
    {
        setAttribute(in.readString());
        setIndex(in.readLong());
    }

    public void writeObject(IOutputStream out) {
        out.writeString(getAttribute());
        out.writeLong(getIndex());
    }
}
