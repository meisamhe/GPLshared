package ninja.Domain;

import ninja.rmi.NinjaObjectOutputStream;
import ninja.rmi.NinjaObjectInputStream;

import java.util.Calendar;
import java.io.IOException;

import peer2me.util.DataInputStreamWrapper;
import peer2me.util.DataOutputStreamWrapper;

//import org.garret.perst.IInputStream;
//import org.garret.perst.IOutputStream;


/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Aug 5, 2009
 * Time: 12:46:51 PM
 * To change this template use File | Settings | File Templates.
 */
public class ObjID {

     public long d;
     public long t;

    public ObjID(){
       t= Calendar.HOUR_OF_DAY*3600+ Calendar.MINUTE*60 + Calendar.SECOND;
       d= Calendar.DAY_OF_MONTH+30* Calendar.MONTH+ 365*Calendar.YEAR;
    }

    public ObjID(long d, long t){
        this.d = d;
        this.t = t;
    }

    public boolean equals(ObjID theobj){
        if (theobj.t == t && theobj.d ==theobj.d)
             return true;
        else return false;
    }

    public void write (NinjaObjectOutputStream n)  {
        n.writeLong(d);
        n.writeLong(t);
    }
     public  ObjID read (NinjaObjectInputStream nois)     {
        d=nois.readLong();
        t= nois.readLong();
        return this;
    }

    public void read(DataInputStreamWrapper in) throws IOException {
        d=in.readLong();
        t= in.readLong();
//        return this;
    }


    public void write(DataOutputStreamWrapper out) throws IOException {
        out.writeLong(d);
        out.writeLong(t);
    }
}
