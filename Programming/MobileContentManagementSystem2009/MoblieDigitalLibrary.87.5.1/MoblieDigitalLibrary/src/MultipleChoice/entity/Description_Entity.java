package MultipleChoice.entity;
/**
 * checked
 */


import java.util.Vector;
import org.garret.perst.IInputStream;
import org.garret.perst.IOutputStream;


public class Description_Entity extends Entity {


	private Test_Entity test;
	private PersistentVector primitiveData;
	private String type;
	private String author;

	public void setType(String type) {
        this.type=type;
	}
	
    public String getType( ) {
        return type;
	}
	
    public void setAuthor(String author) {
        this.author=author;
	}
	
    public String getAuthor( ) {
        return author;
	}
	
    public void setPrimitiveData(Vector primitiveData){
        this.primitiveData.setContent(primitiveData);
    }
	
    public PersistentVector getPrimitiveData(){
         return primitiveData;
    }
	
	public void setTest(Test_Entity test){
		this.test=test;
	}
	
	public Test_Entity getTest(){
		return test;
	}

    public Description_Entity(Test_Entity test, Vector primitiveData, String type,String author){
        setAuthor(author);
        setIndex(-1);
        setPrimitiveData(primitiveData);
        setTest(test);
        setType(type);
    }

    public void setPrimitiveData(PersistentVector primitiveData){
             this.primitiveData=primitiveData;
    }

    public void clone(Entity e, long index)       // this will put all the the attributes and index in the entity e
    {
        ((Description_Entity)e).setAuthor(author);
        e.setIndex(index);
        setIndex(index);
        ((Description_Entity)e).setPrimitiveData(primitiveData);
        ((Description_Entity)e).setTest(test);
        ((Description_Entity)e).setType(type);
    }

    public void readObject(IInputStream in)      //for persistent this two methods should be implemented it somehow shows the   serializability order
    {
        setAuthor(in.readString());
        setIndex(in.readLong());
        setPrimitiveData((PersistentVector)in.readObject());
        setType(in.readString());

    }

    public void writeObject(IOutputStream out) {
        out.writeString(getAuthor());
        out.writeLong(getIndex());
        out.writeObject(getPrimitiveData());
    }
}
