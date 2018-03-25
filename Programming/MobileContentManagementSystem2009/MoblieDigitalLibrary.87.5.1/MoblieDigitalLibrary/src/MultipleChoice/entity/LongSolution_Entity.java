package MultipleChoice.entity; /**
 * checked
 */


import org.garret.perst.IInputStream;
import org.garret.perst.IOutputStream;

import java.util.Vector;


public class LongSolution_Entity extends Entity{

	protected PersistentVector primitiveData;
	protected Test_Entity test;

    public void setTest(Test_Entity test){
        this.test=test;
    }

    public Test_Entity getTest(){
        return test;
    }

    public void setPrimitiveData(Vector primitiveData){
         this.primitiveData.setContent(primitiveData);
    }

    public void setPrimitiveData(PersistentVector primitiveData){
        this.primitiveData=primitiveData;
    }

    public PersistentVector getPrimitiveData(){
        return primitiveData;
    }

    public LongSolution_Entity(PersistentVector primitiveData, Test_Entity test){
        setIndex(-1);
        setPrimitiveData(primitiveData);
        setTest(test);
    }
    
    public void clone(Entity e, long index)       // this will put all the the attributes and index in the entity e
    {
        setIndex(index);
        e.setIndex(index);
        ((LongSolution_Entity)e).setPrimitiveData(primitiveData);
        ((LongSolution_Entity)e).setTest(test);
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
