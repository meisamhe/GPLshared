/*
 * Created on Jul 14, 2005
 *
 * MeysamH To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package Storage;

import java.util.Vector;
import java.io.File;

/**
 * @author Meysam Hejazinia
 *
 *  To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
//MeysamH inja bayad vector ra ebteda bekhanim va sepas benevisim ino khoede mani dorost kone
public class Trie {

	private int MaxWordSize ;
	private File TrieFile;
	private File JmpFile;
	private File LevelFile;
	private String JmpPath;
	private String TriePath;
	private String LevelPath;
	private FileIO f=new FileIO();
	private Vector levelNumber= new Vector();
	private Vector JmpVctr = new Vector();
	private Vector TrieVctr= new Vector();
	public Trie(int MaxWordSize,String FileJmpPath,String FileTriePath,String FileLevelPath)
	{
		JmpPath=FileJmpPath;
		TriePath=FileTriePath;
		LevelPath=FileLevelPath;
//		FileIO f= new FileIO();
		this.MaxWordSize = MaxWordSize;
		int temp1 =128;// az int be char taghiresh dadam
		TrieFile = new File(FileTriePath);
		JmpFile =  new File(FileJmpPath);
		LevelFile = new File(FileLevelPath);
		for ( int for1 = 0; for1 < MaxWordSize; for1++)
		{
//			f.appendStringToFile(TrieFile,new Integer(temp1).toString());// inja file ra be andaze 1 bite ziad mikonam
			TrieVctr.add( for1,new Integer(temp1));
//			f.appendStringToFile(JmpFile,new Integer(for1+1).toString());
			JmpVctr.add(for1,new Integer(for1+1));
//			f.appendStringToFile(LevelFile,new Integer(for1).toString());
			levelNumber.add( for1,new Integer(for1));
		}
		
	}
	
	
	public boolean search(String str)
	{
		char temp = str.charAt(0);
		// esefade az jadvale khodemoon
		temp -='A';
		temp +=1;
		temp *=2;
		int k = ((Integer)levelNumber.get(0)).intValue();
		int level = 0;
		boolean sw = true;// baraye inke bedanim ta inja yaftim ya kheir
		boolean sw1 = true;
		int counter = 0;
		int i = 0;
		int store= 0; // meghdare pedar ra negah midarad
		k = 0;
		while (sw == true)
		{
			sw = false;
			sw1 = true;
			// estefade az jadvale khodemoon
			temp = str.charAt(counter++);// dar har marhale shomare harfi ke darim check mikonim ra negah midarad
			temp -='A';
			temp +=1;
			temp *=2;
			for ( i = k;sw1; i++)
			{
				int ch =(((Integer)TrieVctr.get(i)).intValue()^  temp ) & 62; //moghayese do charactre
				if (ch == 0)//dar soorati ke do karaketer mosavi boodand
				{
					level++;
					store = k; // meghdare pedar ra negah midarad
					k =((Integer)JmpVctr.get(i)).intValue();
					sw = true;
					if ( counter == str.length())// agar kalame kamelan peida shod
					{
						sw = false;
						
						if (((Integer)TrieVctr.get(i)).intValue()%2 == 1)// dar soorati ke payani bashad
							return true;
						else
							return false;// agar payani nabashad
					}
					break;
				}
				if (level == 0 && (i+1) >= ((Integer)levelNumber.get(1)).intValue())// dar sath aval agar be akhar resid tamam mishavad
					sw1 = false;
				int s =((Integer)TrieVctr.get(i)).intValue()& 192 ;
				if ( level!= 0 && s!= 0)// yani dar soorati ke ta inja ke jeloo oomadim space nabashad
					sw1 = false;
			}			
		}
		return false;// peida nashod		
	} 
	
	// in tabe dar soorati ke be un string pass konid agar dar trie bashad true va agar nabashad false bar migardanad 
	public boolean searchFile(String str)
	{
		if(str.indexOf(" ")!= -1)
			str=str.substring(0,str.indexOf(" "))+str.substring(str.indexOf(" ")+1);
		
		char temp = str.charAt(0);
		// esefade az jadvale khodemoon
		temp -='A';
		temp +=1;
		temp *=2;
	//	int k = ((Integer)levelNumber.get(0)).intValue();
		int level = 0;
		boolean sw = true;// baraye inke bedanim ta inja yaftim ya kheir
		boolean sw1 = true;
		int counter = 0;
		int i = 0;
		int store= 0; // meghdare pedar ra negah midarad
		int k = 0;// inja yani ma az makane 0 shoroo mikonim
		while (sw == true)
		{
			sw = false;
			sw1 = true;
			// estefade az jadvale khodemoon
			temp = str.charAt(counter++);// dar har marhale shomare harfi ke darim check mikonim ra negah midarad
			temp -='A';
			temp +=1;
			temp *=2;
			for ( i = k;sw1; i++)
			{
		//		int ch =(((Integer)TrieVctr.get(i)).intValue()^  temp ) & 62; //moghayese do charactre
				int ch =((Integer.parseInt(f.readFileAsString(TrieFile,i+1)))^  temp ) & 62;
				if (ch == 0)//dar soorati ke do karaketer mosavi boodand
				{
					level++;
					store = k; // meghdare pedar ra negah midarad
				//	k =((Integer)JmpVctr.get(i)).intValue();
					k = Integer.parseInt(f.readFileAsString(JmpFile,i+1));
					sw = true;
					if ( counter == str.length())// agar kalame kamelan peida shod
					{
						sw = false;
						
			//			if (((Integer)TrieVctr.get(i)).intValue()%2 == 1)// dar soorati ke payani bashad
						if(Integer.parseInt(f.readFileAsString(TrieFile,i+1))%2 == 1)
							return true;
						else
							return false;// agar payani nabashad
					}
					break;
				}
				//if (level == 0 && (i+1) >= ((Integer)levelNumber.get(1)).intValue())// dar sath aval agar be akhar resid tamam mishavad
				if(level == 0 && (i+1) >= Integer.parseInt(f.readFileAsString(LevelFile,2)))
					sw1 = false;
			//	int s =((Integer)TrieVctr.get(i)).intValue()& 192 ;
				int s = Integer.parseInt(f.readFileAsString(TrieFile,i+1))&192;
				if ( level!= 0 && s!= 0)// yani dar soorati ke ta inja ke jeloo oomadim space nabashad
					sw1 = false;
			}			
		}
		return false;// peida nashod		
	} 
	public void addRunTime(String str)
	{
		if(str.indexOf(" ")!= -1)
			str=str.substring(0,str.indexOf(" "))+str.substring(str.indexOf(" ")+1);
		char temp = str.charAt(0);
		// emale hash function khodemoon
//		FileIO f= new FileIO();
		Vector levelNumber1= f.readFileAsVector(LevelFile);
		Vector TrieVctr1 = f.readFileAsVector(TrieFile);
		Vector JmpVctr1 = f.readFileAsVector(JmpFile);
		Vector levelNumber= new Vector();
		Vector JmpVctr = new Vector();
		Vector TrieVctr= new Vector();
		for(int i=0; i < levelNumber1.size();i++)
		{
			levelNumber.add(new Integer(Integer.parseInt((String)levelNumber1.get(i))));
		}
		for(int i=0; i< TrieVctr1.size();i++)
		{
			JmpVctr.add(new Integer(Integer.parseInt((String)JmpVctr1.get(i))));
			TrieVctr.add(new Integer(Integer.parseInt((String)TrieVctr1.get(i))));
		}
		levelNumber1.clear();
		JmpVctr1.clear();
		TrieVctr1.clear();
		temp +=1;
		temp -='A';
		temp +=temp;
		int k = ((Integer)levelNumber.get(0)).intValue();// avalin jayi ke bayad baraye jostojoo estefade shavad
		int level = 0;
		boolean sw = true;// baraye inke bedanim ta inja yaftim ya kheir
		boolean sw1 = true;
		int counter = 0;
		int i = 0;
		int store= 0; // meghdare pedar ra negah midarad
		k = 0;
		boolean sw3 = true; // baraye inke befahmim ke seprator che bashad
		while (sw == true)
		{
			sw = false;
			sw1 = true;
			// emal hash function khodemoon
			temp = str.charAt(counter++);// dar har marhale shomare harfi ke darim check mikonim ra negah midarad
			temp -='A';
			temp +=1;
			temp *=2;
			for ( i = k;sw1; i++)
			{
				int ch =(((Integer)TrieVctr.get(i)).intValue()^  temp ) & 62; //moghayese do charactre
				if (ch == 0)//dar soorati ke do karaketer mosavi boodand
				{
					level++;
					sw1 = false;// agar charachter match shod bayad soraghe charachter badi beravim
					store = i; // meghdare pedar ra negah midarad
					k =((Integer)JmpVctr.get(i)).intValue();
					sw = true;
					if ( counter == str.length())// agar kalame kamelan peida shod
					{
						sw = false;
						TrieVctr.set(i,new Integer(((Integer)TrieVctr.get(i)).intValue()|1));// yani in onsor bayad payani shavad
						if (((Integer)JmpVctr.get(i)).intValue() < i)// dar soorati ke akharesh shod
							JmpVctr.set(i,new Integer(i));// inja neshan midahim ke in radif tamam shod
						TrieFile.delete();
						JmpFile.delete();
						LevelFile.delete();
						File TrieFile = new File(TriePath);
						File JmpFile = new File(JmpPath);
						File LevleFile = new File(LevelPath);
						for (int i1 = 0; i1< TrieVctr.size(); i1++)
						{
							f.appendStringToFile(TrieFile,TrieVctr.get(i1).toString());
							f.appendStringToFile(JmpFile,JmpVctr.get(i1).toString());
						}
						for(int i1= 0; i1< levelNumber.size();i1++)
						{
							f.appendStringToFile(LevleFile,levelNumber.get(i1).toString());
						}
						return;// yani agar kamel peida kard bargard
					}
					sw3 = true;
					if (((Integer)JmpVctr.get(i)).intValue() == i)//dar soorati ke akhari bashad
						sw3 = false;
					break;
				}
				if (level == 0 && (i+1) >= ((Integer)levelNumber.get(1)).intValue())// dar sath aval agar be akhar resid tamam mishavad
					sw1 = false;
				int s =((Integer)TrieVctr.get(i)).intValue()& 192 ;
				if ( level!= 0 && s!= 0)// yani dar soorati ke ta inja ke jeloo oomadim space nabashad
					sw1 = false;
			}			
		}
		// agar kaleme peida nashod:
		if (i == 1 && ((Integer)TrieVctr.get(0)).intValue()== 128) // yani dar ebtedaye vector bashim (avalin dafe i ke mikhahim darj konim
		{
			if (counter == str.length())
				temp |= 1; // yani in payani ast
			TrieVctr.set( 0,new Integer((((Integer)TrieVctr.get(0)).intValue()|temp)));
			store = 0;// pedar 0 mishavad
		
		}
		else// agar dar ebtedaye vector nabashim
			if (((Integer)TrieVctr.get(((Integer)levelNumber.get(level)).intValue())).intValue() == 128)// yani dar soorati ke in onsor null bood yani in sath taze darad pour mishavad
			{// dar soorati ke onsor ma yek null dasht
				if ( counter == str.length())
					temp |= 1; // yani in payani ast
				TrieVctr.set( ((Integer)levelNumber.get(level)).intValue() ,new Integer((((Integer)TrieVctr.get(level)).intValue()|temp)));
				i = ((Integer)levelNumber.get(level)).intValue();// chon az i badan estefade mikonim update mishavad
				JmpVctr.set(store,levelNumber.get(level));// inja tanzim mikoad ke paresh pedar be koja bashad
				store = ((Integer)levelNumber.get(level)).intValue();// update pedar
			}
			else //yani vaghti ke bayad onsor ghabli ro ham eslah kard
			{
				if (counter == str.length())
					temp |= 1;// yani in payani ast
				// az unjayi ke semicolon dashtim na yeki badish
				//dar dastoor zir bit neshane ra semicolon mikonim
				temp |=128;// yani dar akhare in mored bayad semicolon gharar begirad
				// gharar dadane temp dar makane khodash
				TrieVctr.insertElementAt(new Integer(temp),((Integer)levelNumber.get(level)).intValue()+1);
				JmpVctr.insertElementAt(new Integer(0),((Integer)levelNumber.get(level)).intValue()+1); // inja darim yek onsor jadid ra gharar midahim
				int for1;
				if (level == 0)
				{
					for1= 0;// dar soorati ke dar sathe 0 bashad pedari baraye eslah nadarad
				}
				else
					for1 = ((Integer)levelNumber.get(level-1)).intValue()+1;
				for (  ;for1 <((Integer)levelNumber.get(MaxWordSize-1)).intValue() ; for1++ )// shifting all the array
				{// dalile estefade az levele - 1 in ast ke sathe ghabli ham adadash bayad taghir konad
					// nokt inja in ast ke bayad ma tamam jmp ha ra yeki ezafe konim
					if (((Integer)JmpVctr.get(for1)).intValue() >= ((Integer)levelNumber.get(level)).intValue()+1)// dar soorati ke aslan meghdar jmp taghir karde bashad taghir dahim
						JmpVctr .set( for1,new Integer(((Integer)JmpVctr.get(for1)).intValue()+1));// inja ham yakdor hame makan ha ra update mikonim
				}
				for (int for2 = level; for2< MaxWordSize ; for2++)//update tamame levelha
				{
					levelNumber.set(for2,new Integer(((Integer)levelNumber.get(for2)).intValue()+1));// eslahe sathe level
				}
				// da ghesmate payin bit seprate ra az semicolon be fasele ya ',' taghir mikonad
				int updatedValue = ((((Integer)TrieVctr.get(((Integer)levelNumber.get(level)).intValue()-1)).intValue())& 63);
				if (sw3 == false)// dar soorati ke level seprator ',' bashad
				{
					updatedValue |= 64;
				}
				TrieVctr.set(((Integer)levelNumber.get(level)).intValue()-1,new Integer(updatedValue));// gharar dadane temp dar makane khodash
				i = ((Integer)levelNumber.get(level)).intValue();// chon badan az in i estefade mikonim updatash mikonim
				if (sw3 == false)// yani dar soorati ke level jadid dashte bashim
					JmpVctr.set(store,levelNumber.get(level));// inja tanzim mikonad ke paresh pedar be koja bashad
				store = ((Integer)levelNumber.get(level)).intValue();// update pedar
			}
		if (counter == str.length())
		{
			JmpVctr.add(i,new Integer(i));// inja neshan midahim ke in radif tamam shod
			return;
		}
		// inja faze sevvom ast yani vaghti jayi ke digar faghat ya virgool migozarim ya null ast darj mikonim
		sw3 = false;// yani az in be bad dige ma faghat ',' insert mikonim
		while(counter <str.length())
		{
			level++;// soraghe sat he bad miravim
			temp = str.charAt(counter++);// dar har marhale shomare harfi ke darim check mikonim ra negah midarad
			temp -='A';
			temp +=1;
			temp +=temp;
			if (((Integer)TrieVctr.get(((Integer)levelNumber.get(level)).intValue())).intValue() == 128)// yani dar soorati ke in onsor null bood yani in sath taze darad pour mishavad
			{// dar soorati ke onsor ma yek null dasht
				if ( counter == str.length() )
					temp |= 1; // yani in payani ast
				TrieVctr.set( ((Integer)levelNumber.get(level)).intValue() ,new Integer((((Integer)TrieVctr.get(((Integer)levelNumber.get(level)).intValue())).intValue()|temp)));
				i = ((Integer)levelNumber.get(level)).intValue();// chon az i badan estefade mikonim update mishavad
				JmpVctr.set(store,levelNumber.get(level));// inja tanzim mikoad ke paresh pedar be koja bashad
				store = ((Integer)levelNumber.get(level)).intValue();// update pedar
			}
			else //yani vaghti ke bayad onsor ghabli ro ham eslah kard
			{
				if (counter == str.length())
					temp |= 1;// yani in payani ast
				// az unjayi ke semicolon dashtim na yeki badish
				//dar dastoor zir bit neshane ra semicolon mikonim
				temp |=128;
				// gharar dadane temp dar makane khodash
				TrieVctr.insertElementAt(new Integer(temp),((Integer)levelNumber.get(level)).intValue()+1);
				JmpVctr.insertElementAt(new Integer(0),((Integer)levelNumber.get(level)).intValue()+1); // inja darim yek onsor jadid ra gharar midahim
				int for1;
				if (level == 0)
				{
					for1= 0;// dar soorati ke dar sathe 0 bashad pedari baraye eslah nadarad
				}
				else
					for1 = ((Integer)levelNumber.get(level-1)).intValue()+1;
				for (;for1 < TrieVctr.size(); for1++ )// shifting all the array
				{   // dalile estefade az level-1 in ast ke adade in sath ham taghiir mikonand
					// nokt inja in ast ke bayad ma tamam jmp ha ra yeki ezafe konim
					if (((Integer)JmpVctr.get(for1)).intValue() >= ((Integer)levelNumber.get(level)).intValue()+1)// dar soorati ke aslan meghdar jmp taghir karde bashad taghir dahim
						JmpVctr .set( for1,new Integer(((Integer)JmpVctr.get(for1)).intValue()+1));// inja ham yakdor hame makan ha ra update mikonim
				}
				for (int for2 = level; for2 < MaxWordSize ; for2++)//update tamame levelha
				{
						levelNumber.set(for2,new Integer(((Integer)levelNumber.get(for2)).intValue()+1));// eslahe sathe level
				}
				// da ghesmate payin bit seprate ra az semicolon be fasele ya ',' taghir mikonad
				int updatedValue = ((((Integer)TrieVctr.get(((Integer)levelNumber.get(level)).intValue()-1)).intValue())& 63);
				if (sw3 == false)// dar soorati ke level seprator ',' bashad
				{
					updatedValue |= 64;
				}
				TrieVctr.set(((Integer)levelNumber.get(level)).intValue()-1,new Integer(updatedValue));// gharar dadane temp dar makane khodash
				i = ((Integer)levelNumber.get(level)).intValue();// chon badan az in i estefade mikonim updatash mikonim
				JmpVctr.set(store,levelNumber.get(level));// inja tanzim mikonad ke paresh pedar be koja bashad
				store = ((Integer)levelNumber.get(level)).intValue();// update pedar
			}
			if (counter == str.length())
			{
				JmpVctr.set(i,new Integer(i));// inja neshan midahim ke in radif tamam shod
				TrieFile.delete();
				JmpFile.delete();
				LevelFile.delete();
				File TrieFile = new File(TriePath);
				File JmpFile = new File(JmpPath);
				File LevleFile = new File(LevelPath);
				for (int i1 = 0; i1< TrieVctr.size(); i1++)
				{
					f.appendStringToFile(TrieFile,TrieVctr.get(i1).toString());
					f.appendStringToFile(JmpFile,JmpVctr.get(i1).toString());
				}
				for(int i1= 0; i1< levelNumber.size();i1++)
				{
					f.appendStringToFile(LevleFile,levelNumber.get(i1).toString());
				}
				return;
			}
		}
	TrieFile.delete();
	JmpFile.delete();
	LevelFile.delete();
	File TrieFile = new File(TriePath);
	File JmpFile = new File(JmpPath);
	File LevleFile = new File(LevelPath);
	for (int i1 = 0; i1< TrieVctr.size(); i1++)
	{
		f.appendStringToFile(TrieFile,TrieVctr.get(i1).toString());
		f.appendStringToFile(JmpFile,JmpVctr.get(i1).toString());
	}
	for(int i1= 0; i1< levelNumber.size();i1++)
	{
		f.appendStringToFile(LevleFile,levelNumber.get(i1).toString());
	}
	return;
	}
	
	
	
	public void add(String str)
	{
		char temp = str.charAt(0);
		// emale hash function khodemoon
		temp +=1;
		temp -='A';
		temp +=temp;
		int k = ((Integer)levelNumber.get(0)).intValue();// avalin jayi ke bayad baraye jostojoo estefade shavad
		int level = 0;
		boolean sw = true;// baraye inke bedanim ta inja yaftim ya kheir
		boolean sw1 = true;
		int counter = 0;
		int i = 0;
		int store= 0; // meghdare pedar ra negah midarad
		k = 0;
		boolean sw3 = true; // baraye inke befahmim ke seprator che bashad
		while (sw == true)
		{
			sw = false;
			sw1 = true;
			// emal hash function khodemoon
			temp = str.charAt(counter++);// dar har marhale shomare harfi ke darim check mikonim ra negah midarad
			temp -='A';
			temp +=1;
			temp *=2;
			for ( i = k;sw1; i++)
			{
				int ch =(((Integer)TrieVctr.get(i)).intValue()^  temp ) & 62; //moghayese do charactre
				if (ch == 0)//dar soorati ke do karaketer mosavi boodand
				{
					level++;
					sw1 = false;// agar charachter match shod bayad soraghe charachter badi beravim
					store = i; // meghdare pedar ra negah midarad
					k =((Integer)JmpVctr.get(i)).intValue();
					sw = true;
					if ( counter == str.length())// agar kalame kamelan peida shod
					{
						sw = false;
						TrieVctr.set(i,new Integer(((Integer)TrieVctr.get(i)).intValue()|1));// yani in onsor bayad payani shavad
						if (((Integer)JmpVctr.get(i)).intValue() < i)// dar soorati ke akharesh shod
							JmpVctr.set(i,new Integer(i));// inja neshan midahim ke in radif tamam shod
						return;// yani agar kamel peida kard bargard
					}
					sw3 = true;
					if (((Integer)JmpVctr.get(i)).intValue() == i)//dar soorati ke akhari bashad
						sw3 = false;
					break;
				}
				if (level == 0 && (i+1) >= ((Integer)levelNumber.get(1)).intValue())// dar sath aval agar be akhar resid tamam mishavad
					sw1 = false;
				int s =((Integer)TrieVctr.get(i)).intValue()& 192 ;
				if ( level!= 0 && s!= 0)// yani dar soorati ke ta inja ke jeloo oomadim space nabashad
					sw1 = false;
			}			
		}
		// agar kaleme peida nashod:
		if (i == 1 && ((Integer)TrieVctr.get(0)).intValue()== 128) // yani dar ebtedaye vector bashim (avalin dafe i ke mikhahim darj konim
		{
			if (counter == str.length())
				temp |= 1; // yani in payani ast
			TrieVctr.set( 0,new Integer((((Integer)TrieVctr.get(0)).intValue()|temp)));
			store = 0;// pedar 0 mishavad
		
		}
		else// agar dar ebtedaye vector nabashim
			if (((Integer)TrieVctr.get(((Integer)levelNumber.get(level)).intValue())).intValue() == 128)// yani dar soorati ke in onsor null bood yani in sath taze darad pour mishavad
			{// dar soorati ke onsor ma yek null dasht
				if ( counter == str.length())
					temp |= 1; // yani in payani ast
				TrieVctr.set( ((Integer)levelNumber.get(level)).intValue() ,new Integer((((Integer)TrieVctr.get(level)).intValue()|temp)));
				i = ((Integer)levelNumber.get(level)).intValue();// chon az i badan estefade mikonim update mishavad
				JmpVctr.set(store,levelNumber.get(level));// inja tanzim mikoad ke paresh pedar be koja bashad
				store = ((Integer)levelNumber.get(level)).intValue();// update pedar
			}
			else //yani vaghti ke bayad onsor ghabli ro ham eslah kard
			{
				if (counter == str.length())
					temp |= 1;// yani in payani ast
				// az unjayi ke semicolon dashtim na yeki badish
				//dar dastoor zir bit neshane ra semicolon mikonim
				temp |=128;// yani dar akhare in mored bayad semicolon gharar begirad
				// gharar dadane temp dar makane khodash
				TrieVctr.insertElementAt(new Integer(temp),((Integer)levelNumber.get(level)).intValue()+1);
				JmpVctr.insertElementAt(new Integer(0),((Integer)levelNumber.get(level)).intValue()+1); // inja darim yek onsor jadid ra gharar midahim
				int for1;
				if (level == 0)
				{
					for1= 0;// dar soorati ke dar sathe 0 bashad pedari baraye eslah nadarad
				}
				else
					for1 = ((Integer)levelNumber.get(level-1)).intValue()+1;
				for (  ;for1 <((Integer)levelNumber.get(MaxWordSize-1)).intValue() ; for1++ )// shifting all the array
				{// dalile estefade az levele - 1 in ast ke sathe ghabli ham adadash bayad taghir konad
					// nokt inja in ast ke bayad ma tamam jmp ha ra yeki ezafe konim
					if (((Integer)JmpVctr.get(for1)).intValue() >= ((Integer)levelNumber.get(level)).intValue()+1)// dar soorati ke aslan meghdar jmp taghir karde bashad taghir dahim
						JmpVctr .set( for1,new Integer(((Integer)JmpVctr.get(for1)).intValue()+1));// inja ham yakdor hame makan ha ra update mikonim
				}
				for (int for2 = level; for2< MaxWordSize ; for2++)//update tamame levelha
				{
					levelNumber.set(for2,new Integer(((Integer)levelNumber.get(for2)).intValue()+1));// eslahe sathe level
				}
				// da ghesmate payin bit seprate ra az semicolon be fasele ya ',' taghir mikonad
				int updatedValue = ((((Integer)TrieVctr.get(((Integer)levelNumber.get(level)).intValue()-1)).intValue())& 63);
				if (sw3 == false)// dar soorati ke level seprator ',' bashad
				{
					updatedValue |= 64;
				}
				TrieVctr.set(((Integer)levelNumber.get(level)).intValue()-1,new Integer(updatedValue));// gharar dadane temp dar makane khodash
				i = ((Integer)levelNumber.get(level)).intValue();// chon badan az in i estefade mikonim updatash mikonim
				if (sw3 == false)// yani dar soorati ke level jadid dashte bashim
					JmpVctr.set(store,levelNumber.get(level));// inja tanzim mikonad ke paresh pedar be koja bashad
				store = ((Integer)levelNumber.get(level)).intValue();// update pedar
			}
		if (counter == str.length())
		{
			JmpVctr.add(i,new Integer(i));// inja neshan midahim ke in radif tamam shod
			return;
		}
		// inja faze sevvom ast yani vaghti jayi ke digar faghat ya virgool migozarim ya null ast darj mikonim
		sw3 = false;// yani az in be bad dige ma faghat ',' insert mikonim
		while(counter <str.length())
		{
			level++;// soraghe sat he bad miravim
			temp = str.charAt(counter++);// dar har marhale shomare harfi ke darim check mikonim ra negah midarad
			temp -='A';
			temp +=1;
			temp +=temp;
			if (((Integer)TrieVctr.get(((Integer)levelNumber.get(level)).intValue())).intValue() == 128)// yani dar soorati ke in onsor null bood yani in sath taze darad pour mishavad
			{// dar soorati ke onsor ma yek null dasht
				if ( counter == str.length() )
					temp |= 1; // yani in payani ast
				TrieVctr.set( ((Integer)levelNumber.get(level)).intValue() ,new Integer((((Integer)TrieVctr.get(((Integer)levelNumber.get(level)).intValue())).intValue()|temp)));
				i = ((Integer)levelNumber.get(level)).intValue();// chon az i badan estefade mikonim update mishavad
				JmpVctr.set(store,levelNumber.get(level));// inja tanzim mikoad ke paresh pedar be koja bashad
				store = ((Integer)levelNumber.get(level)).intValue();// update pedar
			}
			else //yani vaghti ke bayad onsor ghabli ro ham eslah kard
			{
				if (counter == str.length())
					temp |= 1;// yani in payani ast
				// az unjayi ke semicolon dashtim na yeki badish
				//dar dastoor zir bit neshane ra semicolon mikonim
				temp |=128;
				// gharar dadane temp dar makane khodash
				TrieVctr.insertElementAt(new Integer(temp),((Integer)levelNumber.get(level)).intValue()+1);
				JmpVctr.insertElementAt(new Integer(0),((Integer)levelNumber.get(level)).intValue()+1); // inja darim yek onsor jadid ra gharar midahim
				int for1;
				if (level == 0)
				{
					for1= 0;// dar soorati ke dar sathe 0 bashad pedari baraye eslah nadarad
				}
				else
					for1 = ((Integer)levelNumber.get(level-1)).intValue()+1;
				for (;for1 < TrieVctr.size(); for1++ )// shifting all the array
				{   // dalile estefade az level-1 in ast ke adade in sath ham taghiir mikonand
					// nokt inja in ast ke bayad ma tamam jmp ha ra yeki ezafe konim
					if (((Integer)JmpVctr.get(for1)).intValue() >= ((Integer)levelNumber.get(level)).intValue()+1)// dar soorati ke aslan meghdar jmp taghir karde bashad taghir dahim
						JmpVctr .set( for1,new Integer(((Integer)JmpVctr.get(for1)).intValue()+1));// inja ham yakdor hame makan ha ra update mikonim
				}
				for (int for2 = level; for2 < MaxWordSize ; for2++)//update tamame levelha
				{
						levelNumber.set(for2,new Integer(((Integer)levelNumber.get(for2)).intValue()+1));// eslahe sathe level
				}
				// da ghesmate payin bit seprate ra az semicolon be fasele ya ',' taghir mikonad
				int updatedValue = ((((Integer)TrieVctr.get(((Integer)levelNumber.get(level)).intValue()-1)).intValue())& 63);
				if (sw3 == false)// dar soorati ke level seprator ',' bashad
				{
					updatedValue |= 64;
				}
				TrieVctr.set(((Integer)levelNumber.get(level)).intValue()-1,new Integer(updatedValue));// gharar dadane temp dar makane khodash
				i = ((Integer)levelNumber.get(level)).intValue();// chon badan az in i estefade mikonim updatash mikonim
				JmpVctr.set(store,levelNumber.get(level));// inja tanzim mikonad ke paresh pedar be koja bashad
				store = ((Integer)levelNumber.get(level)).intValue();// update pedar
			}
			if (counter == str.length())
			{
				JmpVctr.set(i,new Integer(i));// inja neshan midahim ke in radif tamam shod
				return;
			}
		}
	return;
	}
	
	public final void dispose(){
		TrieFile.delete();
		JmpFile.delete();
		LevelFile.delete();
		File TrieFile = new File(TriePath);
		File JmpFile = new File(JmpPath);
		File LevleFile = new File(LevelPath);
		for (int i1 = 0; i1< TrieVctr.size(); i1++)
		{
			f.appendStringToFile(TrieFile,TrieVctr.get(i1).toString());
			f.appendStringToFile(JmpFile,JmpVctr.get(i1).toString());
		}
		for(int i1= 0; i1< levelNumber.size();i1++)
		{
			f.appendStringToFile(LevleFile,levelNumber.get(i1).toString());
		}
		levelNumber.clear();
		JmpVctr.clear();
		TrieVctr.clear();
	}
}
