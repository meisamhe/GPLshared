/*
 * Created on Jul 15, 2005
 *
 * To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package Storage;

import java.io.File;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import java.util.TreeSet;
import java.util.Vector;
import javax.swing.JOptionPane;

/**
 * @author Mani Baradaran Hosseini & Meysam Hejazi nia
 * 
 * To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class Initialize {
	private File inFile = null, sparceFile = null, termHashFile = null,
			docTermFile = null,docNum=null, workHashFile = null;

	private FileIO io = new FileIO();

	private HashMap wordsHash = null;// hashi ke dar un term haye general trie
									 // ra negah midarim

	private Trie generalTrie = null;// general Trie ast

	private Trie workTrie = null; // workTrie

	private HashMap workHash = null;// dar in hashmap ma kalamat trie ra negah
									// midarim ke shomare entry

	// un term dar deraye ra be ma midahad
	private Vector maxTermFreqPerDoc = new Vector();

	private int totalTermsNumber = 0;
	private String path="";
	public Initialize(File inFile, File sparceFile, File termHashFile,
			File docTermFile,File docNum, File workHashFile, HashMap wordsHash,
			HashMap workHash, Trie generalTrie, Trie workTrie,String path) {
		this.inFile = inFile;
		this.sparceFile = sparceFile;
		this.termHashFile = termHashFile;
		this.docTermFile = docTermFile;
		this.workHashFile = workHashFile;
		this.wordsHash = wordsHash;
		this.workHash = workHash;
		this.workTrie = workTrie;
		this.generalTrie = generalTrie;
		this.docNum=docNum;
		this.path=path;
		init();
		dispose();
	}

	private void init() {
		int cntr = 0;
		Vector checkDoc = new Vector();
		Vector checkDocNo = new Vector();
		CheckStruct chS = new CheckStruct("");
		String line = io.readFileAsString(inFile, ++cntr);
		String temp = "", doc = line;
		//		HashMap words=new HashMap();
		Vector pairWord = new Vector();
		Set invalidDoc = new HashSet(); //hash table
		invalidDoc = new TreeSet(); //stored set
		while (line != null) {
			// dar code zir ma term ha ra estekhraj karde dar general trie va
			// wordshash gharar midahim
			// dar zemn in kalamat ra dar yek vector gharar midahim va kare pair
			// kardan ra ham anjam midahim
			int docNum = 0, curDocNum = -1;// baraye inke dah dafe naporsim hazf
										   // konim ya na
			while (true) {
				line.trim();
				if (line.indexOf(" ") != -1) {
					temp = line.substring(0, line.indexOf(" "));
					insertWord(wordsHash, temp);// gharar dadane terme jadid dar
												// hash

					pairWord.add(temp);
					if (findFrequency(doc, temp) > 0.5 && docNum != curDocNum) {
						if (!invalidDoc.contains(new Integer(cntr))) {
							chS.doc = doc;
							checkDoc.add(chS);
							checkDocNo.add(new Integer(cntr));

						}
						curDocNum = docNum;
					}
				} else if (line.indexOf(" ") == -1) {
					if (line.length() > 0) {
						insertWord(wordsHash, line);
						pairWord.add(line);
					}
					break;
				}
				line = line.substring(line.indexOf(" ") + 1);
			}
			if (pairWord.size() > 0) {
				String dummy = "";
				// dar code zir ma fasele meydani ha ra dar nazar migirim
				for (int i = 0; i < pairWord.size() - 3; i++) {
					for (int j = 1; j < 4; j++) {
						if (!((String) pairWord.get(i))
								.equals((String) pairWord.get(i + j))) {
							dummy = (String) pairWord.get(i) + " "
									+ (String) pairWord.get(i + j);//beine
																   // kalamat
																   // fasele
																   // migozarim
							insertWord(wordsHash, dummy);
							dummy = "";
						}

					}
				}
				// dar r khate zir un anasory ke fasele meydanieshan kam ast va
				// dar for
				// bala fasele meydanieshan dar nazar gerefte nashod gharar dade
				// mishavad
				if (pairWord.size() - 3 >= 0) {
					if (!((String) pairWord.get(pairWord.size() - 3))
							.equals((String) pairWord.get(pairWord.size() - 1))) {
						dummy = (String) pairWord.get(pairWord.size() - 3)
								+ " "
								+ (String) pairWord.get(pairWord.size() - 1);
						insertWord(wordsHash, dummy);
					}
				}
				if (pairWord.size() - 2 >= 0) {
					if (!((String) pairWord.get(pairWord.size() - 2))
							.equals((String) pairWord.get(pairWord.size() - 1))) {
						dummy = (String) pairWord.get(pairWord.size() - 2)
								+ " "
								+ (String) pairWord.get(pairWord.size() - 1);
						insertWord(wordsHash, dummy);
					}
				}
				if (pairWord.size() - 3 >= 0) {
					if (!((String) pairWord.get(pairWord.size() - 3))
							.equals((String) pairWord.get(pairWord.size() - 2))) {
						dummy = (String) pairWord.get(pairWord.size() - 3)
								+ " "
								+ (String) pairWord.get(pairWord.size() - 2);
						insertWord(wordsHash, dummy);
					}
				}
				pairWord.clear();
			}
			docNum++;
			line = io.readFileAsString(inFile, ++cntr);
			doc = line;
		}
		CheckList chL = new CheckList(checkDoc,
				"Do you want to delete these documents!!!");
		chL.setVisible(true);
		Iterator it = checkDoc.iterator();
		int itCounter = 0;
		while (it.hasNext()) {
			if (((CheckStruct) it.next()).status == true)
				invalidDoc.add(((Integer) checkDocNo.get(itCounter++)));
		}
		System.out
				.println("Inserting the words into HashMap succesfully finished");
		writeTermHashToFile(wordsHash);
		System.out.println("Write term hash map succesfully into file");
		buildTermDoc(wordsHash, invalidDoc);
		System.out.println("Building term doc finished succesfully");
		buildDocTerm();
		System.out.println("Building doc term finished succesfully");
		writeTermNumberInWorkHashToFile();
		System.out.println("Write work hash terms succesfully into file");
	}

	private void insertWord(HashMap hm, String str) {
		int i = 0;
		if (!hm.containsKey(str)) {
			WordFrequency wf = new WordFrequency(str, 0);
			hm.put(wf.word, wf);
			//			System.out.println(str + " " + i++);
		}
	}

	private void resetHashMap(HashMap hm) {
		//set all freq = 0
		Iterator it = hm.values().iterator();
		while (it.hasNext()) {
			try {
				((WordFrequency) it.next()).freq = 0;
			} catch (Throwable e) {
				System.out.println("unable to reset HashMap " + e.getMessage());
			}
		}
	}

	private void readWord(HashMap hm) {
		String dummy = null;
		Iterator it = hm.values().iterator();
		WordFrequency wf;
		while (it.hasNext()) {
			try {
				wf = ((WordFrequency) it.next());
				dummy = (wf.word + " " + wf.freq + " @ ");
			} catch (Throwable e) {
			}
			io.appendStringToFile(io.createFile("c:\\freq.txt"), dummy);
		}
	}

	private int numberOfWordsInDoc(String doc) {
		int cntr = 0;
		String temp = "";
		while (true) {
			doc = doc.trim();
			if (doc.indexOf(" ") != -1) {
				temp = doc.substring(0, doc.indexOf(" "));
				cntr++;
			} else if (doc.indexOf(" ") == -1) {
				if (doc.length() > 0)
					cntr++;
				break;
			}
			doc = doc.substring(doc.indexOf(" ") + 1);
		}

		//		cntr++;
		int termNum;
		if (cntr == 0)
			return 0;
		if (cntr == 1)
			return 1;
		if (cntr == 2)
			return 3;
		return (4 * cntr - 6);
		//	return cntr++;

	}

	private float findFrequency(String doc, String term) {
		float freq = 0;
		boolean flg = false;
		String temp = doc;
		String str1 = "", str2 = "";
		if (term.indexOf(" ") != -1)//dar soorati ke kalame moratab dashte
									// bashim do ghesmat ra joda mikonimf
		{
			str2 = term.substring(term.indexOf(" ") + 1);//kalame dovomi ra bar
														 // midarim
			str1 = term.substring(0, term.indexOf(" "));// kalame avali ra bar
														// midarim
		}
		while (doc != null) {
			if ((term).indexOf(" ") != -1) {
				int first = doc.indexOf(str1);// index avali ra miyabim
				String tempString;
				if (first == -1)
					break;
				boolean flag = false;// in migooyad in term inja peida shod ya
									 // na
				doc = doc.substring(first + str1.length() + 1);// inja kalame i
															   // ke yaftim ra
															   // bar midarim
				//String useString = doc.substring(0, doc.indexOf(" "));// inja ma
																	  // kalame
																	  // aval ra
																	  // biroon
																	  // mikeshim
				//String cutString = doc.substring(doc.indexOf(" ") + 1);// inja
																	   // ma
																	   // chizi
																	   // ra ke
																	   // badan
																	   // ghesmat
																	   // mikonim
																	   // ra
																	   // negah
																	   // midarim
				String useString="",cutString="";
				if(doc.indexOf(" ")!=-1){
					useString = doc.substring(0, doc.indexOf(" "));
					cutString = doc.substring(doc.indexOf(" ") + 1);
				}else{
					if(doc.equals(str2))
						freq++;
					break;
				}
				if (useString.equals(str2)) {
					flag = true;
				}
				//useString = cutString.substring(0, cutString.indexOf(" "));
				//cutString = doc.substring(doc.indexOf(" ") + 1);
				if(doc.indexOf(" ")!=-1){
					useString = doc.substring(0, doc.indexOf(" "));
					cutString = doc.substring(doc.indexOf(" ") + 1);
				}else{
					if(doc.equals(str2))
						freq++;
					break;
				}
				if (useString.equals(str2)) {
					flag = true;
				}
//				useString = cutString.substring(0, cutString.indexOf(" "));
				if(doc.indexOf(" ")!=-1){
					useString = doc.substring(0, doc.indexOf(" "));
				}else{
					if(doc.equals(str2))
						freq++;
					break;
				}
				if (useString.equals(str2)) {
					flag = true;
				}
				if (flag == true) {
					freq++;
				}
			} else {
				while (true) {
					if (doc.indexOf(term) != -1) {
						freq++;
						doc = doc.substring(doc.indexOf(term) + term.length(),
								doc.length());
					} else {
						flg = true;
						break;
					}
				}
			}
			if (flg)
				break;
		}

		return freq / numberOfWordsInDoc(temp);
	}

	/**
	 * behar hal be general trie tamam term ha ra ezafe mikonim(bekhater ehtemal
	 * be estefade mojadad dar ayande) vali dar morede work Trie tanha ba
	 * gereftan tayiidiye az user be un ezafe mikonim
	 * 
	 * @param hm
	 * @param invalidDoc
	 */
	private void buildTermDoc(HashMap hm, Set invalidDoc) {
		resetHashMap(hm);
		String useString = "", cutString = "";
		String dummy = null, temp = null;
		Iterator it = hm.values().iterator();
		StringBuffer buf = new StringBuffer();
		WordFrequency wf;
		boolean inValid = false;
		float freq = 0;
		int cntr = 0;
		int cntr1 = -1; // inja shomare term ra negah midarim
		Vector invalidTerms = new Vector();
		float toatalTermFreq = 0;
		int termValidInDoc = 0;
		while (it.hasNext()) {
			cntr1++;// inja miravim soraghe terme badi
			cntr = 0;
			toatalTermFreq = 0;
			termValidInDoc = 0;
			try {
				wf = ((WordFrequency) it.next());
				dummy = io.readFileAsString(inFile, ++cntr);
				if (invalidDoc.contains(new Integer(cntr)))
					dummy = io.readFileAsString(inFile, ++cntr);
				temp = dummy;

				String str1 = "", str2 = "";
				if (wf.word.indexOf(" ") != -1)//dar soorati ke kalame moratab
											   // dashte bashim do ghesmat ra
											   // joda mikonimf
				{
					str2 = wf.word.substring(wf.word.indexOf(" ") + 1);//kalame
																	   // dovomi
																	   // ra bar
																	   // midarim
					str1 = wf.word.substring(0, wf.word.indexOf(" "));// kalame
																	  // avali
																	  // ra bar
																	  // midarim
				}
				while (dummy != null) {
					if ((wf.word).indexOf(" ") != -1) {
						while (true) {
							int first = dummy.indexOf(str1);// index avali ra
															// miyabim
							String tempString = "";
							if (first == -1)
								break;
							boolean flag = false;// in migooyad in term inja
												 // peida shod ya na
							dummy = dummy.substring(first + str1.length());// inja
																		   // kalame
																		   // i ke
																		   // yaftim
																		   // ra
																		   // bar
																		   // midarim
							if (dummy.length() > 0)
								dummy = dummy.trim();
							if (dummy == null || dummy.equals(""))
								break;
							if (dummy.equals(str2))
								flag = true;
							if (dummy.indexOf(" ") != -1) {
								useString = dummy.substring(0, dummy
										.indexOf(" "));// inja ma kalame aval ra
													   // biroon mikeshim
								cutString = dummy
										.substring(dummy.indexOf(" ") + 1);// inja ma chizi
																		   // ra ke badan
																		   // ghesmat mikonim
																		   // ra negah midarim
								if (useString.equals(str2)) {
									flag = true;
								}
							}
							if (cutString.indexOf(" ") != -1) {
								useString = cutString.substring(0, cutString
										.indexOf(" "));
								cutString = cutString.substring(cutString
										.indexOf(" ") + 1);
								if (useString.equals(str2)) {
									flag = true;
								}
							}
							if (cutString.indexOf(" ") != -1) {
								useString = cutString.substring(0, cutString
										.indexOf(" "));
								if (useString.equals(str2)) {
									flag = true;
								}
							} else {
								if (cutString.equals(str2)) {
									flag = true;
								}
							}
							if (flag == true) {
								freq++;
							}
						}// end while
					} else {
						while (true) {
							//soorati ke avalaesh booda ya akharesh bood ya
							// vasat bood(ba fasele)
							if (dummy.length() != 0)
								dummy = dummy.trim();
							if ((dummy.indexOf(" " + wf.word) != -1 && dummy
									.length() == wf.word.length()
									+ dummy.indexOf(" " + wf.word) + 1)) {
								freq++;
								break;
							}// if
							else if (dummy.indexOf(wf.word + " ") == 0) {
								freq++;
								dummy = dummy.substring(wf.word.length() + 1);
							} else if (dummy.indexOf(" " + wf.word + " ") != -1) {
								freq++;
								dummy = dummy.substring(dummy.indexOf(" "
										+ wf.word + " ")
										+ wf.word.length() + 2);
							} else if (dummy.length() == wf.word.length()
									&& dummy.indexOf(wf.word) != -1) {
								freq++;
								break;
							} else {
								break;
							}
						}//while
					}
					float saveFreq = freq;
					double f = 0;
					if (freq != 0 && distinctTermsInDoc(temp)!=1)
						f = Math.log(freq) / Math.log(distinctTermsInDoc(temp));
					float insertFrequency = 0; // frequency ra hesab mikonim bad
											   // mibinim age sefr nashod too
											   // file migozarim
					int numWordDoc = numberOfWordsInDoc(temp);
					setMaxFreqTerm(maxTermFreqPerDoc, cntr, freq / numWordDoc);
					if (f < 0.8)
						insertFrequency = freq / numWordDoc;
					else {
						if (freq != 0) {
							int check = JOptionPane
									.showConfirmDialog(null,"The term \""+ wf.word+ "\""
													+ "has invalid frequency in document"
													+ "\""+ temp+ "\""+ ".do you wangt to omit it?",
													"term omit?",JOptionPane.YES_NO_OPTION);
							if (check == 0) {
								insertFrequency = 0;
								saveFreq = 0;
							} else
								insertFrequency = freq / numWordDoc;
						} 
						else {
							insertFrequency = 0;
							saveFreq = 0;
						}
					}
					freq = 0;
					entry insertEntry = new entry();
					insertEntry.index = cntr - 1;
					insertEntry.frequency = insertFrequency;
					if (insertFrequency != 0) {
						buf.append(insertEntry.index + ":"
								+ insertEntry.frequency + " ");
					}
					totalTermsNumber += saveFreq;
					//					System.out.println(wf.word + " and freq = " +saveFreq);
					dummy = io.readFileAsString(inFile, ++cntr);
					temp = dummy;
					if (invalidDoc.contains(new Integer(cntr)))// dar soorati ke
															   // doc valid
															   // bashad
					{
						dummy = io.readFileAsString(inFile, ++cntr);
						temp = dummy;
					}
				}//ends of while
				//				System.out.println(wf.word);
				generalTrie.add(wf.word);// gharar dadane terme jadid dar
										 // general trie
				dummy = "";
				freq = 0;
				if (buf.length() != 0)//dar soorati ke onsori ra dar in buf
									  // gharar dade bashim yani satr khali
									  // bashad
					io.appendStringToFile(sparceFile, wf.word + "$" + cntr1
							+ " " + buf.toString());// baraye rikhtan ferequency
													// dar file
				buf.delete(0, buf.length());
			} catch (Throwable e) {
				System.out.println(e.getMessage());
			}

		}
		System.out.println("Total number of terms is equal to :"
				+ totalTermsNumber);
		System.out.println(maxTermFreqPerDoc.toString());
		invalidDoc.clear();
	}

	private void buildDocTerm() {
		Vector chekVctr=new Vector(),invalidTermNo=new Vector();
		Set invalidTerms = new HashSet();
		invalidTerms = new TreeSet();
		Vector temp = null;
		termDocEntry tde = null;
		int numberOfTerms = wordsHash.size(), cntr = 0, docSize = 0;
		float totalOccurance = 0;
		Iterator it = null;
		Vector idf = new Vector();// Inversed Document Frequency
//		Vector termValidity = new Vector();
		int docNumber = maxTermFreqPerDoc.size() - 1;// zakhire kardane tedad
													 // doc ha
		io.appendStringToFile(docNum,new Integer(docNumber).toString());
		try {
			for (cntr = 0; cntr < numberOfTerms; cntr++) {
				totalOccurance = 0;
				temp = io.readSparceAsVector(sparceFile, cntr); //satri az
																// term*doc ra
																// mikhanim
				idf.add(new Float(Math.log((docNumber) / temp.size())));//zakhire
																		// kardane
																		// idf
																		// ha
				it = temp.iterator();
				//rooye doc ha be ezaye yek term migardim
				//dar while zir tatal occurance term i om dar tamam doc ha ra
				// miyabim
				while (it.hasNext()) {
					tde = (termDocEntry) it.next();//rooye doc ha harkat
												   // mikonim
					//  do khate zir mohasebeye andazeye doc i om
					String dummy = io.readFileAsString(inFile,
							tde.docNumber + 1);
					docSize = numberOfWordsInDoc(dummy);
					float termOccuranceInDoc = tde.freq * docSize;
					totalOccurance += termOccuranceInDoc;
				}//while
				//total term number tedade kole termhast
				float Information = (float) (-1 * Math.log(totalOccurance
						/ totalTermsNumber));
				//dar if va else zir ma kare dar avardane weight ra anjam
				// midahim
				if (Information < 3) {
					invalidTermNo.add(new Integer(cntr));
					chekVctr.add(new CheckStruct(io.getTermName(termHashFile,cntr)));
//					int check = JOptionPane
//							.showConfirmDialog(
//									null,"We want to omit \""
//									+ io.getTermName(termHashFile,cntr)
//									+ "\" from all documents, do you accept it?",
//									"Warrning", JOptionPane.YES_NO_OPTION);
//					if (check == 0) {
//						invalidTerms.add(new Integer(cntr));
//						termValidity.add(new Boolean(true));
//					} else
//						termValidity.add(new Boolean(false));
				} else {
//					termValidity.add(new Boolean(false));
				}
			}//for
			CheckList checkLst=new CheckList(chekVctr,"We want to omit these terms from all documents!!");
			checkLst.setVisible(true);
			Iterator itCheck=chekVctr.iterator();
			cntr=0;
			while(itCheck.hasNext()){
				
				if (((CheckStruct)itCheck.next()).status==true) {
					invalidTerms.add((Integer)invalidTermNo.get(cntr));
//					termValidity.add(new Boolean(true));
				} else
//					termValidity.add(new Boolean(false));
				cntr++;
			}
			chekVctr.clear();
			DocTermCheckStruct struct=null;
			float freq = 0, weight = 0;
			String buf = "";
			int termCntr = 0;
			for (int i = 1; i <= docNumber; i++) {
				for (int j = 0; j < numberOfTerms; j++) {
					if (!invalidTerms.contains(new Integer(j))) {
						freq = io.searchSparceForFreq(sparceFile, j, i - 1);
						weight = freq/((Float) maxTermFreqPerDoc.get(i)).floatValue();//kheili mohem ast ke in
					    // andaze ha yeki jabeja shode
						weight *= ((Float) idf.get(j)).floatValue();
						//dar if zir kare hazf bar asas thereshold rooye vazn
						// ha ra anjam midahim
						//		if((weight<=0.4 && weight>0.36) || (weight>=0.7 &&
						// weight<0.74)){
						if (weight >= 0.4 && weight <= 0.7) {
							struct=new DocTermCheckStruct(i,j,weight);
							chekVctr.add(struct);
//							String term = io.getTermName(termHashFile, j);
//							workTrie.add(term);
//							if (!workHash.containsValue(term))
//								workHash.put(new Integer(termCntr++), term);
//							buf += findTermNumberInWorkHash(term) + ":"
//									+ weight + " ";
						}
						else if (freq != 0) {
							struct=new DocTermCheckStruct(i,j,weight);
							struct.status=true;
							chekVctr.add(struct);
//							int check = JOptionPane.showConfirmDialog(null,
//									"We want to omit \""
//											+ io.getTermName(termHashFile, j)
//											+ "\" from document\n \""
//											+ io.readFileAsString(inFile, i)
//											+ "\", do you accept it?",
//									"Warrning", JOptionPane.YES_NO_OPTION);
//							if (check != 0) {
//								String term = io.getTermName(termHashFile, j);
//								workTrie.add(term);
//								if(!workHash.containsValue(term))
//									workHash.put(new Integer(termCntr++), term);
//								//							termValidity.set(j,new Boolean(true));
//								buf += findTermNumberInWorkHash(term) + ":"
//										+ weight + " ";
//							}
						}//end else if
					}
				}// end inner for
				//i haman shomare document ast va dar buf weight.
//				io.appendStringToFile(docTermFile, i + "$" + buf.trim());
//				buf = "";
			}// outer for
			String note="These words will be deleted from documents";
			DocTermCheckList dtch=new DocTermCheckList(chekVctr,note,path);
			String term="";
			DocTermCheckStruct prev=null;
			int j=0;
			for(int i=1;i<=docNumber;i++){
				for(;j<chekVctr.size();j++){
					struct=(DocTermCheckStruct)chekVctr.get(j);
					if(struct.docNumber==i){
						term = io.getTermName(termHashFile, struct.termNumber);
						workTrie.add(term);
						if (!workHash.containsValue(term))
							workHash.put(new Integer(termCntr++), term);
						buf += findTermNumberInWorkHash(term) + ":"
							+ struct.weight + " ";
					}
					else
						break;					
				}
				io.appendStringToFile(docTermFile, i + "$" + buf.trim());
				buf = "";
			}// outer for
			chekVctr.clear();
		} catch (ClassCastException e) {
			System.out.println(e.getMessage());
		}

	}

	private int findTermNumberInWorkHash(String term) {
		for (int i = 0; i < workHash.size(); i++)
			if (term.equals((String) workHash.get(new Integer(i))))
				return i;
		return -1;
	}

	private void writeTermNumberInWorkHashToFile() {
		Vector vctr=new Vector();
		for(int i=0;i<workHash.size();i++){
			if(!vctr.contains((String) workHash.get(new Integer(i))))
				vctr.add((String) workHash.get(new Integer(i)));
		}
		for (int i = 0; i < vctr.size(); i++) {
			io.appendStringToFile(workHashFile,(String)vctr.get(i)+ "$" + i);
		}
	}

	private void insertDocTermFreq(HashMap hm) {
		int cntr = 0;
		String line = io.readFileAsString(inFile, ++cntr);
		String temp = "";
		resetHashMap(hm);
		while (line != null) {
			while (true) {
				line.trim();
				if (line.indexOf(" ") != -1) {
					temp = line.substring(0, line.indexOf(" "));
					((WordFrequency) hm.get(temp)).freq++;
				} else if (line.indexOf(" ") == -1) {
					if (line.length() > 0)
						((WordFrequency) hm.get(line)).freq++;
					break;
				}
				line = line.substring(line.indexOf(" ") + 1);
			}

			//			readWord(hm);
			line = io.readFileAsString(inFile, ++cntr);
			//			resetHashMap(hm);
		}
	}

	private int distinctTermsInDoc(String doc) {
		Set set = new HashSet();
		set = new TreeSet();
		String temp = null;
		Vector termVctr = new Vector();
		while (doc != null) {
			doc = doc.trim();
			if (doc.indexOf(" ") != -1) {
				temp = doc.substring(0, doc.indexOf(" "));
				set.add(temp);
				termVctr.add(temp);
				doc = doc.substring(doc.indexOf(" ") + 1);
			} else {
				if (doc.length() > 0) {
					termVctr.add(doc);
					set.add(doc);
					break;
				}
			}
		}

		String dummy = "";
		for (int i = 0; i < termVctr.size() - 3; i++) {
			for (int j = 1; j < 4; j++) {
				if (!((String) termVctr.get(i)).equals((String) termVctr.get(i
						+ j))) {
					dummy = (String) termVctr.get(i) + " "
							+ (String) termVctr.get(i + j);//beine kalamat
														   // fasele migozarim
					set.add(dummy);
					dummy = "";
				}
			}
		}
		if (termVctr.size() - 3 >= 0) {
			if (!((String) termVctr.get(termVctr.size() - 3))
					.equals((String) termVctr.get(termVctr.size() - 1))) {
				dummy = (String) termVctr.get(termVctr.size() - 3) + " "
						+ (String) termVctr.get(termVctr.size() - 1);
				set.add(dummy);
			}
		}
		if (termVctr.size() - 2 >= 0) {
			if (!((String) termVctr.get(termVctr.size() - 2))
					.equals((String) termVctr.get(termVctr.size() - 1))) {
				dummy = (String) termVctr.get(termVctr.size() - 2) + " "
						+ (String) termVctr.get(termVctr.size() - 1);
				set.add(dummy);
			}
		}
		if (termVctr.size() - 3 >= 0) {
			if (!((String) termVctr.get(termVctr.size() - 3))
					.equals((String) termVctr.get(termVctr.size() - 2))) {
				dummy = (String) termVctr.get(termVctr.size() - 3) + " "
						+ (String) termVctr.get(termVctr.size() - 2);
				set.add(dummy);
			}
		}
		termVctr.clear();
		return set.size();
	}

	/**
	 * 
	 * @param file
	 * @param hm
	 */
	private void writeTermHashToFile(HashMap hm) {
		Iterator it = hm.values().iterator();
		int cntr = 0;
		String str = "";
		while (it.hasNext()) {
			str = ((WordFrequency) it.next()).word;
			io.appendStringToFile(termHashFile, str + "$" + cntr++);
		}

	}

	private void setMaxFreqTerm(Vector vctr, int docNumber, float freq) {
		if (vctr.size() <= docNumber) {
			for (int i = vctr.size(); i <= docNumber; i++)
				vctr.add(i, new Float(0));
			vctr.set(docNumber, new Float(freq));
		} else {
			float dummy = ((Float) vctr.get(docNumber)).floatValue();
			if (dummy < freq) {
				vctr.set(docNumber, new Float(freq));
			}
		}
	}

	protected void dispose() {
		generalTrie.dispose();
		workTrie.dispose();
		workHash.clear();
		wordsHash.clear();
	}

	class WordFrequency {
		String word = null;

		int freq = 0;

		public WordFrequency(String str, int frq) {
			word = str;
			freq = frq;
		}

		/**
		 * I override the hashCode method, so now for the same string this class
		 * will return the same address and i will just increase the frequency
		 * of the term.
		 */
		public int hashCode() {
			return word.hashCode();
		}

	}

	class entry {
		public int index;

		public float frequency;
	}

	class DocFreqElement {
		int row = 0;

		int col = 0;

		float weight = 0;

		boolean flag = false;
	}
 
}

