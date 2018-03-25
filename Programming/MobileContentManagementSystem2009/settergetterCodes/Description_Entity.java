/**
 * checked
 */
 
package testEntities;

import testEntities.Test_Entity;

import java.util.Vector;


public class Description_Entity {


	private Test_Entity test;
	private Vector primitiveData;
	private String type;
	private String author;

	public void setType(String type) {
        this.type=type;
	}
	
    public String getType( ) {
        return type;
	}
	
    public void setAuthor(String author) {
        this.author=author;
	}
	
    public String getAuthor( ) {
        return author;
	}
	
    public void setTest_Entity(Test_Entity test_Entity){
        this.test_Entity=test_Entity;
    }
	
    public Test_Entity getTest_Entity(){
        return test_Entity;
    }
	
    public void setPrimitiveData(Vector primitiveData){
        this.primitiveData=primitiveData;
    }
	
    public Vector getPrimitiveData(){
         return primitiveData;
    }
	
	public void setTest(Test_Entity test){
		this.test=test;
	}
	
	public Test_Entity getTest(){
		return test;
	}
}
