package MultipleChoice.entity;

import org.garret.perst.IInputStream;
import org.garret.perst.IOutputStream;

public class StandardTimer_Entity extends Entity {

	protected Test_Entity test;
    protected TestList testList;
    protected String filePath;
    protected String type;


    public void setTestList(TestList testList) {
        this.testList=testList;
    }

    public TestList getTestList() {
        return testList;
    }

    public void setTest(Test_Entity test) {
        this.test=test;
    }

     public Test_Entity getTest() {
         return test;
    }

    public void setFilePath(String filePath) {
        this.filePath=filePath;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setType(String type) {
        this.type=type;
    }

    public String getType() {
        return type;
    }

    public StandardTimer_Entity(Test_Entity test,TestList testList,String filePath,String type){
        setTest(test);
        setFilePath(filePath);
        setType(type);
        setTestList(testList);
        setIndex(-1);
    }

    public void clone(Entity e, long index)       // this will put all the the attributes and index in the entity e
    {
        setIndex(index);
        e.setIndex(index);
        ((StandardTimer_Entity)e).setFilePath(filePath);
        ((StandardTimer_Entity)e).setTest(test);
        ((StandardTimer_Entity)e).setTestList(testList);
        ((StandardTimer_Entity)e).setType(type);
    }

    public void readObject(IInputStream in)      //for persistent this two methods should be implemented it somehow shows the   serializability order
    {
        setIndex(in.readLong());
        setTest((Test_Entity)in.readObject());
        setFilePath(in.readString());
        setType(in.readString());
        setFilePath(in.readString());

    }

    public void writeObject(IOutputStream out) {
        out.writeLong(getIndex());
        out.writeObject((TestList)getTestList();
        out.writeString(getFilePath());
        out.writeString(getType());
    }
}
