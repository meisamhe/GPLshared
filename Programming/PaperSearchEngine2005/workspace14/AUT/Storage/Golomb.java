/*
 * Created on Jul 24, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package Storage;

import java.util.BitSet;
import java.util.Iterator;
import java.util.Vector;

/**
 * @author MeysamH && ManiBH
 *
 */
public class Golomb {
	private int b;
	public Golomb(int base)
	{
		this.b=base;// b = 2 ^k
	}
	public boolean search(int i,BitSet golomb)
	{
		int div = i /b;
		int mod = i %b;
		int temp;
		if(golomb.length()==0)
			return false;
		int lastIndex=0;
		int newIndex=golomb.nextClearBit(lastIndex);
		while(newIndex >= 0 && newIndex<golomb.length())
		{
			if(div == (newIndex - lastIndex))
			{
				temp =0;
				//dar for zir ma kare casting golomb(newIndex,newIndex+log(b) ra anjam midahim
				for(int i1 =newIndex  ; i1 <=newIndex+(int)(Math.log(b)/Math.log(2));i1++)
				{
					temp *=2;
					if(golomb.get(i1))
						temp++;
				}
				if(temp == mod)
					return true;
			}
			lastIndex = newIndex+1+(int)(Math.log(b)/Math.log(2));
			newIndex=golomb.nextClearBit(lastIndex);//peida kardan adad jadid
		}
		return false;
	}
	public void add( int insertElement, BitSet golomb)
	{
		int div = insertElement /b;
		int mod = insertElement %b;
		int temp = mod;
		int i=0 ;
		int j=0;
		int size=(int)(Math.log(b)/Math.log(2));
		BitSet bs=new BitSet(size);
		if(!search(insertElement,golomb))
		{
			if(golomb.length()==0)
				golomb.set(golomb.length(),golomb.length()+div);
			else
				golomb.set(golomb.length()-1,golomb.length()+div-1);
			if(golomb.length()!=0 && div == 0)
			{
				i=golomb.length();
				golomb.clear(golomb.length()-1);//baraye inke oon khane i ke 1 boode ro sefr konim
			}
			else
			{
				golomb.clear(golomb.length());//baraye inke oon khane i ke 1 boode ro sefr konim
				i = golomb.length()+1;
			}
			//while zir irad darad
			j=size;
			while(temp >= 2)
			{
				j--;
				if(temp % 2 == 1)
					bs.set(j);
				else 
					bs.clear(j);
				temp /=2;
			}
			j--;
			if(temp==1)
				bs.set(j);
			else
				bs.clear(j);
			for(j=0;j<size; j++)
			{
				golomb.set(j+i,bs.get(j));
			}
			golomb.set(i+j);
		}
//		return golomb;
	}
	public Vector contains(BitSet golomb)
	{
		Vector result= new Vector();
		int lastIndex=0;
		int newIndex=golomb.nextClearBit(lastIndex);
		int temp;
		while(newIndex >= 0 && newIndex<golomb.length() )
		{
			temp =0;
			//dar for zir ma kare casting golomb(newIndex,newIndex+log(b) ra anjam midahim
			for(int i1 =newIndex  ; i1 <=newIndex+(int)(Math.log(b)/Math.log(2));i1++)
			{
				temp *=2;
				if(golomb.get(i1))
					temp++;
			}
			result.add(new Integer((newIndex-lastIndex)*b+temp));
			lastIndex = newIndex+(int)(Math.log(b)/Math.log(2))+1;
			newIndex=golomb.nextClearBit(lastIndex);
			
		}
		return result;
	}
	public BitSet add(Vector golomb)
	{
		BitSet golombResult=new BitSet();
		Iterator it=golomb.iterator();
		while(it.hasNext())
		{
			add(((Integer)it.next()).intValue(),golombResult);
		}
		return golombResult;
	}
	//in tabe golomb ra gerefte va string ra bar migardanad
	// bayad dar file andaze in mored ghablash zakhire shavad
	//size biti ham bayad negahdari shavad
	public StringBuffer toString(BitSet golomb)
	{
		int i=golomb.size()/8;
//		Vector chVctr= new Vector();
		StringBuffer strBuf=new StringBuffer();
		byte ch;
		for(int j=0; j < i ;j++)
		{
			ch= 0;
			//dar for zir adad aval sakhte mishavad
			for(int k = 0; k < 8; k++)
			{
				ch*=2;
				if(golomb.get(j*8+k))
					ch+=1;
			}
//			chVctr.add(new Byte(ch));//vared kardane charachter ha ba vector mazkoor
			strBuf.append((char)ch);
//			ch=(byte)strBuf.charAt(j);
		}
		return strBuf;
	}
	// vector ke be in tabe ferestade mishavad haman vectori az char ast ke ghablan sakhte
	// shodeh ast
	//size zir size biti ast ke bayad negahdari shavad
	public BitSet retrive(StringBuffer golomb,int size)
	{
		BitSet temp = new BitSet();
		byte ch ;
		byte tempCh;
		int i=0;
		for(int k=0;k<golomb.length();k++){
			ch= (byte)golomb.charAt(k);
			for(int j= 128; j> 0 && i<size; j/=2)
			{
				tempCh= (byte)(ch & j);
				if(tempCh!= 0)
					temp.set(i,true);
				else
					temp.set(i,false);
				i++;
			}
		}
		return temp;
	}
}
