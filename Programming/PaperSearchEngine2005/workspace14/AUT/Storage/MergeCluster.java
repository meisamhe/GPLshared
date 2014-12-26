/*
 * Created on Aug 11, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package Storage;

import java.io.File;

/**
 * @author ManiBH
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class MergeCluster {
	int docDocTreeNum;//tedade file haye doc az sefr shoro mishavad
	String path;
	FileIO io=new FileIO();
	MergeCluster(int docDocTreeNum,String path){
		this.docDocTreeNum=docDocTreeNum;
		this.path=path;
	}
	public void merge(){
		int size=1,cntr=1,lineNum=0;
		String temp="",strBuf="",dummy="";
		File docTree=null;
		File file=new File(path+docDocTreeNum+".txt");
		if(file.length()==0 && docDocTreeNum!=0){
			docDocTreeNum--;
			file=new File(path+docDocTreeNum+".txt");
		}
		if(!io.isExists(path+"docDocTree.txt"))
			docTree=io.createFile(path+"docDocTree.txt");
		if(file.length()!=0 || docDocTreeNum!=0)
			io.appendStringToFile(docTree,Integer.toString(numberOfLines(file)));
		while(docDocTreeNum>0){
			file=new File(path+docDocTreeNum+".txt");
			size+=numberOfLines(file);
			cntr=1;
			while(true){
				temp=io.readFileAsString(file,cntr++);
				strBuf="";
				if(temp==null || temp.length()==0)
					break;
				strBuf=temp.substring(0,temp.indexOf(" "))+" ";
				temp=temp.substring(temp.indexOf(" ")+1);
				while(temp.length()>0){
					if(temp.indexOf(" ")!=-1)
						dummy=temp.substring(0,temp.indexOf(" "));
					else if(temp.length()!=0)
						dummy=temp;
					else
						break;
					lineNum=scanText(new File(path+(docDocTreeNum-1)+".txt"),dummy);
					strBuf+=dummy+","+(lineNum+size)+" ";
					if(temp.indexOf(" ")!=-1)
						temp=temp.substring(temp.indexOf(" ")+1);
					else
						break;
				}
				io.appendStringToFile(docTree,strBuf.trim());
			}
			docDocTreeNum--;
		}
		strBuf="";
		cntr=1;
		if(docDocTreeNum==0){
			File zero=new File(path+"0.txt");
			if(zero.length()!=0){
				cntr=1;
				while(true){
					temp=io.readFileAsString(zero,cntr++);
					strBuf="";
					if(temp==null || temp.length()==0)
						break;
					strBuf=temp.substring(0,temp.indexOf(" "))+" ";//central id in cluster
					temp=temp.substring(temp.indexOf(" ")+1);//hazfe namayande fogh az khat
					while(temp.length()>0){
						if(temp.indexOf(" ")!=-1)
							dummy=temp.substring(0,temp.indexOf(" "));
						else if(temp.length()!=0)
							dummy=temp;
						else
							break;
						strBuf+=dummy+","+"*"+" ";
						if(temp.indexOf(" ")!=-1)
							temp=temp.substring(temp.indexOf(" ")+1);
						else
							break;
					}
					io.appendStringToFile(new File(path+"docDocTree.txt"),strBuf.trim());
				}
			}
				
		}
	}//end merge
	private int scanText(File trg,String word){
		String temp;
		int cntr=1;
		while(true){
			temp=io.readFileAsString(trg,cntr);
			if(temp==null || temp.length()==0)
				break;
			temp=temp.substring(0,temp.indexOf(" "));
			if(word.equals(temp))
				return cntr;
			cntr++;
		}
		return -1;
	}
	private int numberOfLines(File trg){
		String temp;
		int cntr=1;
		while(true){
			temp=io.readFileAsString(trg,cntr);
			if(temp==null || temp.length()==0)
				break;
			cntr++;
		}
		return --cntr;
	}
//	public static void main(String[] args){
//		MergeCluster mc=new MergeCluster(3,"c:\\testhome\\");
//		mc.merge();
//	}
}
