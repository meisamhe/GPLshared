/**
 * checked
 */
 
package testEntities;

import java.util.Vector;

public class MiddleNode_Entity extends Hierarchy_Entity {

    protected Vector hierarchy;
    protected String Value;
	protected int contentNumber;

    public void traverse1() {
    }

	public void traverse2() {
    }

    public void traverse3() {
    }

	public void traverse4() {
    }

	public void traverse5() {
    }

    public void traverse6() {
    }

    public void traverse7() {
    }

    public void setValue(String Value) {
        this.Value=Value;
    }

    public String getValue() {
        return Value;
    }

    public void setContentNumber(int contentNumber) {
        this.contentNumber=contentNumber;
    }

    public int getContentNumbere() {
        return contentNumber;
    }

    public void setVector(Vector hierarchy) {
        this.hierarchy=hierarchy;
    }

    public Vector getVector() {
        return hierarchy;
    }
}
