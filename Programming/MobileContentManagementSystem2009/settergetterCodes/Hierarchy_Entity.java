/**
 * checked
 */
 
package testEntities;

public class Hierarchy_Entity extends Entity{
	protected long testReference;
	protected Index index;
	protected Interactive interactive;
	
    public void setTestReference(long testReference){
        this.testRefereence=testRefereence;
    }
	
    public long getReference(){
        return testReference;
    }
	
    public void setIndex(Index index){
             this.index=index;
    }
	
    public Index getIndex(){
             return index;
    }
}
