package peer2me.util;

import peer2me.domain.Serializable;

import javax.microedition.io.file.FileConnection;
import javax.microedition.io.file.FileSystemRegistry;
import javax.microedition.io.Connector;
import java.io.*;

import databaseCore.Entity;
import RegistryClient.RegistryEntity;
import ninja.Domain.RemoteObject;
import ninja.rmi.NinjaRemoteObject;

/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Aug 29, 2009
 * Time: 1:30:51 AM
 * To change this template use File | Settings | File Templates.
 */
public class DataOutputStreamWrapper {

    // The path to the file
	public String filePath;

	// The streams related to the file
	private DataOutputStream outputStream;

    // The connection to the file
	private FileConnection fileConnection;
    public long size;

    public DataOutputStreamWrapper (String filePath) throws ClassNotFoundException, InstantiationException, IllegalAccessException {
      this.filePath=filePath;
        try{
			// Connects to the file
			if(fileConnection == null){
                String temp=FileSystemRegistry.listRoots().nextElement().toString();
//                 temp = "e:/" ;// for sony erricson while it doesn't let to write in c:\
                String url= new StringBuffer().append("file:///").append(temp).append(filePath).toString();

//                fileConnection = (FileConnection) Connector.open(new StringBuffer().append("file:///").append(filePath).append(";append=true").toString(),Connector.WRITE );
                  FileConnection fileConnection = (FileConnection) Connector.open(url, Connector.READ_WRITE);
//                  if (!fileConnection.exists())
//                    fileConnection.create();
                   size=fileConnection.fileSize();
                   if (size==-1)
                      fileConnection.create();
                   OutputStream outputStream =    //fileConnection.openOutputStream();
                          fileConnection.openOutputStream();
                   this.outputStream= new DataOutputStream(outputStream);
                   size=fileConnection.fileSize();
                   if (size==0)
                     this.outputStream.writeLong(1); // while now we are going to write an element
                   else{
//                       InputStream inputStream = fileConnection.openInputStream();
//                       DataInputStream dis= new DataInputStream(inputStream);
                       DataInputStreamWrapper disw=new DataInputStreamWrapper(filePath);
                       long numberofElements= disw.size;
                       this.outputStream.writeLong(numberofElements+1);
                       RegistryEntity tempRE = new RegistryEntity();
                        for (int i=0; i<numberofElements; i++) {
                            tempRE.readObject(disw);
                            tempRE.writeObject(this);
                        }
                   }
//                   byte b[]= new byte[50];
//                   dis.read(b);
//                   this.outputStream.write(b);
//                   int i = dis.readInt();
//                    this.outputStream.writeInt(i*2);
//                   i = dis.readInt();
//                    this.outputStream.writeInt(i);
//                    this.outputStream.writeInt(i);

            }
//             outputStream = fileConnection.openDataOutputStream();

        }catch(IOException ioe){
			Log.getInstance().logException("FileHandler.FileHandler()",ioe,false);
		}
    }

    public void writeByte (byte b) throws IOException {
           outputStream.writeByte(b);
    }

    public void writeInt (int i) throws IOException {
          outputStream .writeInt(i);
    }

    public void writeShort (short s) throws IOException {
          outputStream.writeShort(s);
    }

    public void writeLong(long l) throws IOException {
           outputStream.writeLong(l);
    }


    public void writeUTF(String u) throws IOException {
          outputStream.writeUTF(u);
    }

     public void writeObject(Entity obj) throws IOException {
         obj.writeObject(this);
     }

    public void resume(){
        try{
			// Connects to the file
			if(fileConnection == null){

//                fileConnection = (FileConnection) Connector.open(new StringBuffer().append("file:///").append(filePath).append(";append=true").toString(),Connector.WRITE );
                FileConnection fileConnection = (FileConnection) Connector.open(
                  new StringBuffer().append("file:///").append(filePath).toString(), Connector.WRITE);
            }
//             outputStream = fileConnection.openDataOutputStream();
               OutputStream outputStream = fileConnection.openOutputStream(Long.MAX_VALUE);
               this.outputStream= new DataOutputStream(outputStream);
        }catch(IOException ioe){
			Log.getInstance().logException("FileHandler.FileHandler()",ioe,false);
		}
    }

    public void close() throws IOException {
       if(outputStream != null) outputStream.close();
        if (fileConnection!=null)   fileConnection.close();
    }
}
