/**
 * checked
 */
 
package testEntities;

import testEntities.Test_Entity;

import java.util.Vector;


public class Choice_Entity {


	protected Test_Entity test;
	protected Vector primitiveData;
	protected String DescriptionType;
	protected String correctAnswer;
	protected String userAnswer;
	protected boolean correctAnswered;

	public void checkAnswer() {
		/* default generated stub */;

	}

    public void setDescriptionType(String setDescriptionType){
         this.DescriptionType=DescriptionType;
    }
	
    public String getDescriptionType(){
         return DescriptionType;
    }
    public void setCorrectAnswe(String correctAnswer){
         this.correctAnswer=correctAnswer;
    }
	
    public String getCorrectAnswer(){
         return correctAnswer;
    }
	
    public void setUserAnswer(String userAnswer){
         this.userAnswer=userAnswer;
    }
	
    public  String getUserAnswer(){
         return userAnswer;
    }
    public void setCorrectAnswered(boolean correctAnswered){
         this.correctAnswered=correctAnswered;
    }
	
    public  boolean getCorrectAnswered(){
         return correctAnswered;
    }
	
    public void setTest(Test_Entity test){
             this.test=test;
    }
	
    public   Test_Entity getTest(){
             return test;
    }
	
    public void setPrimitiveData(Vector primitiveData){
             this.primitiveData=primitiveData;
    }
	
    public Vector getPrimitiveData(){
             return primitiveData;
    }
 
}
