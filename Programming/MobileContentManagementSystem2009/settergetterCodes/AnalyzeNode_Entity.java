/**
 * checked
 */

package testEntities;


public class AnalyzeNode_Entity {

	protected StatisticalAnalyzer_Entity statisticalAnalyzer;
	protected String Name;
	protected int Value;
	
	public void setStatisticalAnalyzer(StatisticalAnalyzer_Entity statisticalAnalyzer){
		this.statisticalAnalyzer = statisticalAnalyzer;
	}
	public void setName(String Name) {
        this.Name=Name;

	}
    public String getName() {
        return Name;
	}
    public void setValue(int Value) {
        this.Value=Value;

	}
    public int getValue() {
         return Value;

	}
}
