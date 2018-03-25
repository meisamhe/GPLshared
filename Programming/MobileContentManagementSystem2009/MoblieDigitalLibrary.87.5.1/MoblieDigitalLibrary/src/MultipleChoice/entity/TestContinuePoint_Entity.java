package MultipleChoice.entity;

import MultipleChoice.control.Interactive_Control;
import org.garret.perst.IInputStream;
import org.garret.perst.IOutputStream;

public class TestContinuePoint_Entity extends Entity {


	protected Interactive_Control interactive;
    protected String typeOfContinuePoint;
	protected Test_Entity currentTest;

	void loadTestContinuePoint() {
	}

	void deleteTestContinuePoint() {
	}

	void saveTestContinuePoint() {
    }

    public void setInteractive(Interactive_Control interactive) {
        this.interactive=interactive;
    }

    public Interactive_Control getTest() {
        return interactive;
    }

    public void setTypeOfContinuePoint(String typeOfContinuePoint) {
        this.typeOfContinuePoint=typeOfContinuePoint;
    }

    public String getTypeOfContinuePoint() {
        return typeOfContinuePoint;
    }

    public void setCurrentTest(Test_Entity currentTest) {
        this.currentTest=currentTest;
    }

    public Test_Entity getCurrentTest() {
        return currentTest;
    }

    public void TestContinuePoint_Entity(Interactive_Control interactive,String typeOfContinuePoint,Test_Entity currentTest){
        setTypeOfContinuePoint(typeOfContinuePoint);
        setCurrentTest(currentTest);
        setInteractive(interactive);
        setIndex(-1);
    }

    public void clone(Entity e, long index)       // this will put all the the attributes and index in the entity e
    {
        ((TestContinuePoint_Entity)e).setTypeOfContinuePoint(typeOfContinuePoint);
        ((TestContinuePoint_Entity)e).setCurrentTest(currentTest);
        ((TestContinuePoint_Entity)e).setInteractive(interactive);
        e.setIndex(index);
        setIndex(index);
    }

    public void readObject(IInputStream in)      //for persistent this two methods should be implemented it somehow shows the   serializability order
    {
        setTypeOfContinuePoint(in.readString());
        setCurrentTest((Test_Entity)in.readObject());
        setIndex(in.readLong());
    }

    public void writeObject(IOutputStream out) {
        out.writeString(getTypeOfContinuePoint());
        out.writeObject(getCurrentTest());
        out.writeLong(getIndex());
    }
}
