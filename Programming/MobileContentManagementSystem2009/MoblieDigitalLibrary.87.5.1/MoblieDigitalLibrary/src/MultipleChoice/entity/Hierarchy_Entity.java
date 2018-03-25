package MultipleChoice.entity; /**
 * checked
 */


public abstract class Hierarchy_Entity extends Entity {
	private long testReference;

    public void setTestReference(long testReference){
        this.testReference=testReference;
    }

    public long getTestReference(){
        return testReference;
    }

    public Hierarchy_Entity(long testReference){
        setTestReference(testReference);
    }

}
