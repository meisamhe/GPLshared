package MultipleChoice.entity;

import MultipleChoice.control.Interactive_Control;
import org.garret.perst.IInputStream;
import org.garret.perst.IOutputStream;
import org.garret.perst.IPersistent;

public class StatisticalAnalyzer_Entity extends Entity {

	protected Interactive_Control interactivel;
	protected AnalyzeNode_Entity analyzeNode;
 	protected long anlyzeNodeList;
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

    public void setAnalyzeNode_Entity(AnalyzeNode_Entity analyzeNode) {
        this.analyzeNode=analyzeNode;
    }

    public AnalyzeNode_Entity getAnalyzeNode_Entity() {
        return analyzeNode;
    }

    public void setAnlyzeNodeList(long anlyzeNodeList) {
        this.anlyzeNodeList=anlyzeNodeList;
    }

    public long getAnlyzeNodeList() {
        return anlyzeNodeList;
    }

    public void Choice_Entity(Interactive_Control interactivel,AnalyzeNode_Entity analyzeNode,java.lang.Object aanlyzeNodeList,int Date){
        saveStatisticalAnalysis();
        loadStatisticalAnalysis();
        setDate(Date);
        setInteractive_Control(interactivel);
        setIndex(-1);
    }

    public void clone(Entity e, long index)       // this will put all the the attributes and index in the entity e
    {
       e.setIndex(index);
       setIndex(index);
       ((StatisticalAnalyzer_Entity)e).setInteractive_Control(getInteractive_Control());
       ((StatisticalAnalyzer_Entity)e).setAnlyzeNodeList(getAnlyzeNodeList());
       ((StatisticalAnalyzer_Entity)e).setDate(getDate());
       ((StatisticalAnalyzer_Entity)e).setAnalyzeNode_Entity(getAnalyzeNode_Entity());

    }

    public void readObject(IInputStream in)      //for persistent this two methods should be implemented it somehow shows the   serializability order
    {
        setDate(in.readInt());
        setAnlyzeNodeList(in.readLong());
        setIndex(in.readLong());
    }

    public void writeObject(IOutputStream out) {
        out.writeLong(getIndex());
        out.writeInt(getDate());
        out.writeLong(getAnlyzeNodeList());
    }
}
