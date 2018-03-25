package MultipleChoice.entity; /**
 * checked
 */

import org.garret.perst.IOutputStream;
import org.garret.perst.IInputStream;


public class AnalyzeNode_Entity extends Entity {

	protected StatisticalAnalyzer_Entity statisticalAnalyzer;
	protected String name;
	protected int value;
	
	public void setStatisticalAnalyzer(StatisticalAnalyzer_Entity statisticalAnalyzer){
		this.statisticalAnalyzer = statisticalAnalyzer;
	}
    public StatisticalAnalyzer_Entity getStatisticalAnalyzer() {
            return statisticalAnalyzer;
    }

    public void setName(String Name) {
        this.name=Name;

	}

    public String getName() {
        return name;
	}

    public void setValue(int Value) {
        this.value=Value;

	}

    public int getValue() {
         return value;

	}

    public AnalyzeNode_Entity(StatisticalAnalyzer_Entity statisticalAnalyzer, String name,
                              int value) {
        this.setName(name);
        this.setValue(value);
        this.setStatisticalAnalyzer(statisticalAnalyzer);
        this.setIndex(-1);
    }

    public void clone(Entity e, long index)       // this will put all the the attributes and index in the entity e
    {
        ((AnalyzeNode_Entity)e) .setStatisticalAnalyzer(statisticalAnalyzer);
        ((AnalyzeNode_Entity)e).setName(name);
        ((AnalyzeNode_Entity)e).setValue(value);
        e.setIndex(index);
        setIndex(index);
    }

    public void readObject(IInputStream in) {  //for persistent this two methods should be implemented it somehow shows the   serializability order
        this.setName(in.readString());
        this.setValue(in.readInt());
        this.setIndex(in.readLong());
    }

    public void writeObject(IOutputStream out) {
        out.writeString(getName());
        out.writeInt(getValue());
        out.writeLong(getIndex());

    }
    
}
