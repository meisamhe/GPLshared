package databaseTest.Guess;

import org.garret.perst.*;

public class TreeNode extends Persistent { 
    public String   question;
    public TreeNode yes;    
    public TreeNode no;
    
    public void writeObject(IOutputStream out) {//for persistent this two methods should be implemented 
        out.writeString(question);              //it somehow shows the   serializability order
        out.writeObject(yes);        
        out.writeObject(no);
    }

    
    public void readObject(IInputStream in) { 
        question = in.readString();
        yes = (TreeNode)in.readObject();        
        no = (TreeNode)in.readObject();        
    }

    public TreeNode(TreeNode no, String question, TreeNode yes) {    //it is some how a linkList
        this.yes = yes;                                              //has  treenode  for yes leaf
        this.question = question;                                    //the other tree is for answer
        this.no = no;                                                //and this node haz string with null
    }                                                                //in prev and null in next pointer

    public TreeNode() {}
}
