package MultipleChoice.entity;

import org.garret.perst.IInputStream;
import org.garret.perst.IOutputStream;

public class UserDefinedAttribute_Entity extends Entity{

	protected Test_Entity test_Entity;
    protected String attribute;
    protected String value;

	public void setTest_Entity(Test_Entity test_Entity) {
        this.test_Entity=test_Entity;
    }

    public Test_Entity getTest_Entity() {
        return test_Entity;
    }

    public void setAttribute(String attribute) {
        this.attribute=attribute;
    }

    public String getAttribute() {
        return attribute;
    }

    public void setValue(String value) {
        this.value=value;
    }

    public String getValue() {
        return value;
    }

    UserDefinedAttribute_Entity(Test_Entity test_Entity,String attribute,String value){
        setAttribute(attribute);
        setValue(value);
        setTest_Entity(test_Entity);
        setIndex(-1);
    }

    public void clone(Entity e, long index)       // this will put all the the attributes and index in the entity e
    {
       ((UserDefinedAttribute_Entity)e).setAttribute(attribute);
        ((UserDefinedAttribute_Entity)e).setValue(value);
        ((UserDefinedAttribute_Entity)e).setTest_Entity(test_Entity);
        setIndex(index);
        e.setIndex(index);
    }

    public void readObject(IInputStream in)      //for persistent this two methods should be implemented it somehow shows the   serializability order
    {
        setAttribute(in.readString());
        setValue(in.readString());
        setIndex(in.readLong());
    }

    public void writeObject(IOutputStream out) {
        out.writeString(getAttribute());
        out.writeString(getValue());
        out.writeLong(getIndex());
    }
}
