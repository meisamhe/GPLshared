package peer2me.util;

import peer2me.domain.Serializable;

import javax.microedition.io.file.FileConnection;
import javax.microedition.io.file.FileSystemRegistry;
import javax.microedition.io.Connector;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;

import databaseCore.Entity;

/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Aug 29, 2009
 * Time: 1:30:59 AM
 * To change this template use File | Settings | File Templates.
 */
public class DataInputStreamWrapper {
    // The path to the file
	public String filePath;

	// The streams related to the file
	private DataInputStream inputStream;
    
    // The connection to the file
	private FileConnection fileConnection;
    public long size;

    public DataInputStreamWrapper(String filePath){
       this.filePath=filePath;
        try{
			// Connects to the file
			if(fileConnection == null){
                String temp= FileSystemRegistry.listRoots().nextElement().toString();
                temp = "e:/" ;// for sony erricson while it doesn't let to write in c:\
                fileConnection = (FileConnection) Connector.open(new StringBuffer().append("file:///").append(temp).append(filePath).toString());
                size=fileConnection.fileSize();
                if (size==-1)
                      fileConnection.create();
            }
             inputStream = fileConnection.openDataInputStream();
            if (size!=0 && size!=-1)
                 size= inputStream.readLong();
        }catch(IOException ioe){
			Log.getInstance().logException("FileHandler.FileHandler()",ioe,false);
		}
    }

    public void resume(){
        try{
			// Connects to the file
			if(fileConnection == null){
				fileConnection = (FileConnection) Connector.open(new StringBuffer().append("file:///").append(filePath).toString());
			}
             inputStream = fileConnection.openDataInputStream();
        }catch(IOException ioe){
			Log.getInstance().logException("FileHandler.FileHandler()",ioe,false);
		}
    }

    public byte readByte() throws IOException {
        return inputStream.readByte();
    }
     public int readInt() throws IOException {
      return inputStream.readInt();
    }
     public short readShort() throws IOException {
       return inputStream.readShort();
    }

    public long readLong() throws IOException {
       return inputStream.readLong();
    }

    public String readUTF() throws IOException {
        return inputStream.readUTF();
    }

    public void readObject (Entity s) throws ClassNotFoundException, IllegalAccessException, InstantiationException, IOException {
//        if (s == null) {
//           s= (Entity) Class.forName(s.getClass().getName()).newInstance();
//        }
//        return
          s.readObject(this);
    }

    public void close() throws IOException {
        if(inputStream != null) inputStream.close();
        if (fileConnection!=null)   fileConnection.close();
    }
}
