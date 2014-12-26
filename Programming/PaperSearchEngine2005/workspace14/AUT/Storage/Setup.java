package Storage;

import java.io.File;
import java.util.HashMap;
import java.util.Set;

import javax.swing.JOptionPane;

import Retrieval.Search;
import Retrieval.ViewResault;

public class Setup {

	
	public Setup() {
		super();
	}

	public static void main(String[] args) {
		FileIO io=new FileIO();
		String path="C:\\testhome\\";
		String Document=path+"document.txt";
		String GeneralFileJmpPath=(path+"generalJmp.txt");
		String GeneralFileTriePath=(path+"generalTrie.txt");
		String GeneralFileLevelPath=(path+"generalLevel.txt");
		String docTermFile=path+"docTermFile.txt";
		String workHashFile=path+"workHashFile.txt";
		String WorkFileJmpPath=(path+"WorkJmp.txt");
		String WorkFileTriePath=(path+"WorkTrie.txt");
		String WorkFileLevelPath=(path+"WorkLevel.txt");
		String docNum=(path+"docNum.txt");
		try{
			PreInitialize pre = new PreInitialize(new File(path+"doc1.txt"),
			io.createFile(path+"stemming.txt"),new File(path+"Lexical.txt"),new File(Document),"<p>");
			Trie workTrie = new Trie(60,GeneralFileJmpPath,GeneralFileTriePath,GeneralFileLevelPath);
			Trie generalTrie = new Trie(60,WorkFileJmpPath,WorkFileTriePath,WorkFileLevelPath);
			HashMap wordsHash = new HashMap();
			HashMap workHash = new HashMap();
			Initialize init= new Initialize(new File(path+"stemming.txt"),
					io.createFile(path+"termDoc.txt"),io.createFile(path+"termHashFile.txt")
					,io.createFile(docTermFile),io.createFile(docNum),io.createFile(workHashFile),
					wordsHash,workHash,generalTrie,workTrie,path);
			
			PostInitialize ps=new PostInitialize(0.5f,new File(docTermFile));
			JOptionPane.showMessageDialog(null,"Congradulations setup successfully compleated!!!","Congratulation",JOptionPane.INFORMATION_MESSAGE);
		}
		catch(Exception e){
			System.out.println(e.getMessage());
			JOptionPane.showMessageDialog(null,"Sorry the setup progress didn`t finish successfully!","Error Occured",JOptionPane.ERROR_MESSAGE);
		}
		finally{
			System.exit(0);
		}	
	}
}
