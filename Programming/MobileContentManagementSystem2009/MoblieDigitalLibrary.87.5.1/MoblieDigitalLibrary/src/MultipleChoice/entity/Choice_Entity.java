package MultipleChoice.entity; /**
 * checked
 */


import java.util.Vector;
import org.garret.perst.IInputStream;
import org.garret.perst.IOutputStream;


public class Choice_Entity extends Entity {

    protected Test_Entity test;
	protected PersistentVector primitiveData;
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
    
    public void setCorrectAnswer(String correctAnswer){
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
             this.primitiveData.setContent(primitiveData);
    }
	
    public PersistentVector getPrimitiveData(){
             return primitiveData;
    }

    public void setPrimitiveData(PersistentVector primitiveData){
             this.primitiveData=primitiveData;
    }

    public Choice_Entity(Test_Entity test, Vector primitiveData, String DescriptionType, String correctAnswer,
                         String userAnswer, boolean correctAnswered){
        setCorrectAnswer(correctAnswer);
        setCorrectAnswered(correctAnswered);
        setDescriptionType(DescriptionType);
        setPrimitiveData(primitiveData);
        setTest(test);
        setUserAnswer(userAnswer);
        setIndex(-1);
    }

    public void clone(Entity e, long index)       // this will put all the the attributes and index in the entity e
    {
        ((Choice_Entity)e).setCorrectAnswer(correctAnswer);
        ((Choice_Entity)e).setCorrectAnswered(correctAnswered);
        ((Choice_Entity)e).setDescriptionType(DescriptionType);
        ((Choice_Entity)e).setPrimitiveData(primitiveData.getContent());
        ((Choice_Entity)e).setTest(test);
        ((Choice_Entity)e).setUserAnswer(userAnswer);
        e.setIndex(index);
        setIndex(index);
    }

    public void readObject(IInputStream in)      //for persistent this two methods should be implemented it somehow shows the   serializability order
    {
        setCorrectAnswer(in.readString());
        setCorrectAnswered(in.readBoolean());
        setDescriptionType(in.readString());
        setPrimitiveData((PersistentVector)in.readObject());
        setUserAnswer(in.readString());
        setIndex(in.readLong());

    }

    public void writeObject(IOutputStream out) {
        out.writeString(getCorrectAnswer());
        out.writeBoolean(getCorrectAnswered());
        out.writeString(getDescriptionType());
        out.writeObject(getPrimitiveData());
        out.writeString(getUserAnswer());
        out.writeLong(getIndex());
    }

}
