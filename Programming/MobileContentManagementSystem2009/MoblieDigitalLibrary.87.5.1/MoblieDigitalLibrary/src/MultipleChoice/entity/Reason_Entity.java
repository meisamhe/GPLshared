package MultipleChoice.entity;

import org.garret.perst.IInputStream;
import org.garret.perst.IOutputStream;

import java.util.Vector;

public class Reason_Entity extends Entity {

	protected PersistentVector primitiveData;
   	public Test_Entity test;

	public void setTest_Entity(Test_Entity test){
        this.test=test;
    }

    public Test_Entity getTest_Entity(){
        return test;
    }

    public void setPrimitiveData(PersistentVector primitiveData){
        this.primitiveData=primitiveData;
    }

    public PersistentVector getPrimitiveData(){
        return primitiveData;
    }

    public void setPrimitiveData(Vector primitiveData){
        this.primitiveData.setContent(primitiveData);
    }

    public Reason_Entity(Vector primitiveData, Test_Entity test){
        setTest_Entity(test);
        setPrimitiveData(primitiveData);
        setIndex(-1);
    }
    
    public void clone(Entity e, long index)       // this will put all the the attributes and index in the entity e
    {
        ((Reason_Entity)e).setTest_Entity(test);
        ((Reason_Entity)e).setPrimitiveData(primitiveData);
        e.setIndex(index);
        setIndex(index);
    }

    public void readObject(IInputStream in)      //for persistent this two methods should be implemented it somehow shows the   serializability order
    {
       setIndex(in.readLong());
       setPrimitiveData((PersistentVector)in.readObject());
    }

    public void writeObject(IOutputStream out) {
        out.writeLong(getIndex());
        out.writeObject(getPrimitiveData());
    }
}
