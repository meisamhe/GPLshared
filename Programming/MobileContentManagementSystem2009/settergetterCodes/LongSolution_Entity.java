/**
 * checked
 */
 
package testEntities;
import java.util.Vector;


public class LongSolution_Entity extends Entity{

	protected Vector primitiveData;
	protected Test_Entity test;

    public void setTest(Test_Entity test){
        this.test=test;
    }

    public Test_Entity getTest(){
        return test;
    }

    public void setPrimitiveData(Vector primitiveData){
        this.primitiveData=primitiveData;
    }

    public Vector getPrimitiveData(){
        return primitiveData;
    }
}
