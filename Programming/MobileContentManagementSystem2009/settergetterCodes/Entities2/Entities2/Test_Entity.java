package MultipleChoice.entity;

import org.garret.perst.IInputStream;
import org.garret.perst.IOutputStream;

import java.util.Vector;

public class Test_Entity extends Entity{

	protected TestList testList;
    protected PersistentVector choice;
    protected PersistentVector standardTimer;
    protected testEntities.UserDefinedAttribute_Entity userDefinedAttribute;
    protected Vector description;
    protected testEntities.TestCache_Entity testCache;
   	protected LongSolution_Entity longSolution;
   	protected Reason_Entity reason;
    protected int weight;
    protected int numberofQuestions;
    protected String levelOfDificulty;
   	protected String conceptual;
    protected String subject;
    protected String book;
    protected String author;
    protected int leitnerValue;
    protected int nextLeitnerDate;
    protected int Identifier;

	public void setLongSolution(LongSolution_Entity longSolution) {
        this.longSolution=longSolution;
    }

    public LongSolution_Entity getLongSolution() {
        return longSolution;
    }

	public void setTestList(TestList testList) {
        this.testList=testList;
    }

    public TestList getTestList() {
        return testList;
    }

    public void setChoice(Vector choice) {
        this.choice=choice;
    }

    public Vector getChoice() {
        return choice;
    }

    public void setStandardTimer(Vector standardTimer) {
        this.standardTimer=standardTimer;
    }

    public Vector getStandardTimer() {
        return standardTimer;
    }

    public void setUserDefinedAttribute(testEntities.UserDefinedAttribute_Entity userDefinedAttribute) {
        this.userDefinedAttribute=userDefinedAttribute;
    }

    public testEntities.UserDefinedAttribute_Entity getUserDefinedAttribute() {
        return userDefinedAttribute;
    }

    public void setDescription(Vector description) {
        this.description=description;
    }

    public Vector getDescription() {
        return description;
    }

    public void setTestCache(testEntities.TestCache_Entity testCache) {
        this.testCache=testCache;
    }

    public testEntities.TestCache_Entity getTestCache() {
        return testCache;
    }

    public void setReason(Reason_Entity reason) {
        this.reason=reason;
    }

    public Reason_Entity getReason() {
        return reason;
    }

    public void setWeight(int weight) {
        this.weight=weight;
    }

    public int getWeight() {
        return weight;
    }

    public void setNumberOfQuestions(int numberofQuestions) {
        this.numberofQuestions=numberofQuestions;
    }

    public int getNumberOfQuestions() {
        return numberofQuestions;
    }

    public void setLevelOfDificulty(String levelOfDificulty) {
        this.levelOfDificulty=levelOfDificulty;
    }

    public String getLevelOfDificulty() {
        return levelOfDificulty;
    }

    public void setConceptual(String conceptual) {
        this.conceptual=conceptual;
    }

    public String getConceptual() {
        return conceptual;
    }

    public void setSubject(String subject) {
        this.subject=subject;
    }

    public String getSubject() {
        return subject;
    }

    public void setBook(String book) {
        this.book=book;
    }

    public String getBook() {
        return book;
    }

    public void setAuthor(String author) {
        this.author=author;
    }

    public String getAuthor() {
        return author;
    }

    public void setLeitnerValue(int leitnerValue) {
        this.leitnerValue=leitnerValue;
    }

    public int getLeitnerValue() {
        return leitnerValue;
    }

    public void setNextLeitnerDate(int nextLeitnerDate) {
        this.nextLeitnerDate=nextLeitnerDate;
    }

    public int getNextLeitnerDate() {
        return nextLeitnerDate;
    }

    public void setIdentifier(int Identifier) {
        this.Identifier=Identifier;
    }

    public int getIdentifier() {
        return Identifier;
    }

	public void save() {
    }

    public void Test_Entity(TestList testList,Vector choice,Vector standardTimer, testEntities.UserDefinedAttribute_Entity userDefinedAttribute, Vector description, testEntities.TestCache_Entity testCache,LongSolution_Entity longSolution, Reason_Entity reason, int weight,int numberofQuestions, String levelOfDificulty,String conceptual,String subject,String book,String author,int leitnerValue,int nextLeitnerDate, int Identifier){
        setIdentifier(Identifier);
        setNextLeitnerDate(nextLeitnerDate);
        setLeitnerValue(leitnerValue);
        setAuthor(author);
        setBook(book);
        setTestList(testList);
        setChoice(choice);
        setStandardTimer(standardTimer);
        setUserDefinedAttribute(userDefinedAttribute);
        setDescription(description);
        setTestCache(testCache);
        setWeight(weight);
        setNumberOfQuestions(numberofQuestions);
        setConceptual(conceptual);
        setTestCache(testCache);
        setLongSolution(longSolution);
        setLevelOfDificulty(levelOfDificulty);
        setSubject(subject);
        setIndex(-1);
    }

    public void clone(Entity e, long index)       // this will put all the the attributes and index in the entity e
    {
        e.setIndex(index);
        setIndex(index);
       ((Test_Entity)e).setIdentifier(getIdentifier());
       ((Test_Entity)e).setNextLeitnerDate(getNextLeitnerDate());
       ((Test_Entity)e).setLeitnerValue(getLeitnerValue());
       ((Test_Entity)e).setAuthor(getAuthor());
       ((Test_Entity)e).setBook(getBook());
       ((Test_Entity)e).setUserDefinedAttribute(getUserDefinedAttribute());
       ((Test_Entity)e).setTestCache(getTestCache());
       ((Test_Entity)e).setWeight(getWeight());
       ((Test_Entity)e).setNumberOfQuestions(getNumberOfQuestions());
       ((Test_Entity)e).setConceptual(getConceptual());
       ((Test_Entity)e).setSubject(getSubject());
       ((Test_Entity)e).setLevelOfDificulty(getLevelOfDificulty());
    }

    public void readObject(IInputStream in)      //for persistent this two methods should be implemented it somehow shows the   serializability order
    {
        setIndex(in.readLong());      
        setIdentifier(in.readInt());
        setNextLeitnerDate(in.readInt());
        setLeitnerValue(in.readInt());
        setAuthor(in.readString());
        setBook(in.readString());
        setWeight(in.readInt());
        setNumberOfQuestions(in.readInt());
        setConceptual(in.readString());
        setSubject(in.readString());
        setLevelOfDificulty(in.readString());
    }

    public void writeObject(IOutputStream out)
    {
        out.writeInt(getIdentifier());
        out.writeInt(getNextLeitnerDate());
        out.writeInt(getLeitnerValue());
        out.writeString(getAuthor());
        out.writeString(getBook());
        out.writeInt(getWeight());
        out.writeInt(getNumberOfQuestions());
        out.writeString(getConceptual());
        out.writeString(getSubject());
        out.writeString(getLevelOfDificulty());
    }
}
