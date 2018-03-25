package MultipleChoice.entity;


import MultipleChoice.control.Interactive_Control;
import org.garret.perst.IInputStream;
import org.garret.perst.IOutputStream;

public class PercentageCalculator_Entity extends Entity {

    protected Interactive_Control interactive;
    protected long firstItem;
	protected int type;
	protected int numberOfQuestions;
	protected int numberOfTestInTheMiddle;

	public void setType(int type) {
        this.type=type;
    }

    public int getType() {
        return type;
    }

    public void setNumberOfQuestions(int numberOfQuestions) {
        this.numberOfQuestions=numberOfQuestions;
    }

    public int getNumberOfQuestions() {
        return numberOfQuestions;
    }

    public void setNumberOfTestInTheMiddle(int numberOfTestInTheMiddle) {
        this.numberOfTestInTheMiddle=numberOfTestInTheMiddle;
    }

    public int getNumberOfTestInTheMiddle() {
        return numberOfTestInTheMiddle;
    }

    public void setInteractive(Interactive_Control interactive) {
        this.interactive=interactive;
    }

    public Interactive_Control getInteractive() {
        return interactive;
    }
    
    public void setFirstItem(long firstItem) {
        this.firstItem=firstItem;
    }

    public long getFirstItem(){
        return firstItem;
    }

    public long interactive() {
        return firstItem;
    }

    public void PercentageCalculator_Entity(Interactive_Control interactive,long firstItem,int type,int numberOfQuestions,int numberOfTestInTheMiddle){
        setNumberOfQuestions(numberOfQuestions);
        setType(type);
        setInteractive(interactive);
        setFirstItem(firstItem);
        setNumberOfTestInTheMiddle(numberOfTestInTheMiddle);
        setIndex(-1);
    }

    public void clone(Entity e, long index)       // this will put all the the attributes and index in the entity e
    {
        ((PercentageCalculator_Entity)e).setNumberOfQuestions(numberOfQuestions);
        ((PercentageCalculator_Entity)e).setType(type);
        ((PercentageCalculator_Entity)e).setInteractive(interactive);
        ((PercentageCalculator_Entity)e).setFirstItem(firstItem);
        ((PercentageCalculator_Entity)e).setNumberOfTestInTheMiddle(numberOfTestInTheMiddle);
        e.setIndex(index);
        setIndex(index);
    }

    public void readObject(IInputStream in)      //for persistent this two methods should be implemented it somehow shows the   serializability order
    {
        setNumberOfQuestions(in.readInt());
        setType(in.readInt());
        setNumberOfTestInTheMiddle(in.readInt());
        setFirstItem(in.readLong());
        setIndex(in.readLong());

    }

    public void writeObject(IOutputStream out) {
        out.writeInt(getNumberOfQuestions());
        out.writeInt(getType());
        out.writeInt(getNumberOfQuestions());
        out.writeLong(getFirstItem());
        out.writeLong(getIndex());
    }
}

