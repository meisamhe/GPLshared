package MultipleChoice.entity;

import org.garret.perst.IInputStream;
import org.garret.perst.IOutputStream;
import MultipleChoice.control.Interactive_Control;

import java.util.Vector;

public class TestCache_Entity extends Entity{

	protected Interactive_Control interactive;
    protected PersistentVector tests;
    int cacheSize;

	public void search() {
    }

   	public void loadCache() {
	}

	public void save() {
    }

	public void update() {
    }

	public void setInteractive(Interactive_Control interactive) {
        this.interactive=interactive;
    }

    public Interactive_Control getInteractive() {
        return interactive;
    }

    public void setTests(Vector tests) {
        this.tests.setContent(tests);
    }

    public void setTests(PersistentVector tests){
        this.tests=tests;
    }

    public PersistentVector getTests() {
        return tests;
    }

    public void setCacheSize(int cacheSize) {
        this.cacheSize=cacheSize;
    }

    public int getCacheSize() {
        return cacheSize;
    }

    public void Choice_Entity(Interactive_Control interactive,PersistentVector tests,int cacheSize){
        setInteractive(interactive);
        setTests(tests);
        setCacheSize(cacheSize);
        setIndex(-1);
    }

    public void clone(Entity e, long index){       // this will put all the the attributes and index in the entity e
        (( TestCache_Entity)e).setInteractive(interactive);
        (( TestCache_Entity)e).setTests(tests);
        (( TestCache_Entity)e).setCacheSize(cacheSize);
        e.setIndex(index);
        setIndex(index);
    }

    public void readObject(IInputStream in){      //for persistent this two methods should be implemented it somehow shows the   serializability order
        setTests((PersistentVector)in.readObject());
        setCacheSize(in.readInt());
        setIndex(in.readLong());
    }

    public void writeObject(IOutputStream out) {
        out.writeObject(getTests());
        out.writeInt(getCacheSize());
        out.writeLong(getIndex());
    }
}
