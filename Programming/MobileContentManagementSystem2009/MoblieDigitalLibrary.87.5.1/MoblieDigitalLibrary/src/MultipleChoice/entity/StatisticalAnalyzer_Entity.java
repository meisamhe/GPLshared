package MultipleChoice.entity;

import MultipleChoice.control.Interactive_Control;
import org.garret.perst.IInputStream;
import org.garret.perst.IOutputStream;
import org.garret.perst.IPersistent;

import java.util.Vector;

public class StatisticalAnalyzer_Entity extends Entity {

	protected Interactive_Control interactivel;
	protected PersistentVector analyzedNodeList;
    protected int Date;

	public void saveStatisticalAnalysis() {
    }

    public void loadStatisticalAnalysis() {
    }

    public void setDate(int Date) {
        this.Date=Date;
    }

    public int getDate() {
        return Date;
    }

    public void setInteractive_Control(Interactive_Control interactivel) {
        this.interactivel=interactivel;
    }

    public Interactive_Control getInteractive_Control() {
        return interactivel;
    }

    public void setAnalyzedNodeList(PersistentVector analyzedNodeList) {
        this.analyzedNodeList=analyzedNodeList;
    }

    public PersistentVector getAnalyzedNodeList() {
        return analyzedNodeList;
    }

    public void setAnalyzedNodeList(Vector analyzedNodeList){
        this.analyzedNodeList.setContent(analyzedNodeList);
    }



    public void Choice_Entity(Interactive_Control interactivel,Vector analyzedNodeList ,int Date){
        setAnalyzedNodeList(analyzedNodeList);
        setDate(Date);
        setInteractive_Control(interactivel);
        setIndex(-1);
    }

    public void clone(Entity e, long index)       // this will put all the the attributes and index in the entity e
    {
       e.setIndex(index);
       setIndex(index);
       ((StatisticalAnalyzer_Entity)e).setInteractive_Control(getInteractive_Control());
       ((StatisticalAnalyzer_Entity)e).setDate(getDate());
       ((StatisticalAnalyzer_Entity)e).setAnalyzedNodeList(getAnalyzedNodeList());

    }

    public void readObject(IInputStream in)      //for persistent this two methods should be implemented it somehow shows the   serializability order
    {
        setAnalyzedNodeList((PersistentVector)in.readObject());
        setDate(in.readInt());
        setIndex(in.readLong());
    }

    public void writeObject(IOutputStream out) {
        out.writeObject(getAnalyzedNodeList());
        out.writeInt(getDate());
        out.writeLong(getIndex());
    }
}
