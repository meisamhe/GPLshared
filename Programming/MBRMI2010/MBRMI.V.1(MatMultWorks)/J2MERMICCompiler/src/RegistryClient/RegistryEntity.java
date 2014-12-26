package RegistryClient;

import databaseCore.Entity;
//import org.garret.perst.IInputStream;
//import org.garret.perst.IOutputStream;
import ninja.Domain.RemoteObject;
import ninja.rmi.NinjaRemoteObject;
import peer2me.util.DataInputStreamWrapper;
import peer2me.util.DataOutputStreamWrapper;

import java.io.IOException;

/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Sep 12, 2009
 * Time: 4:28:13 PM
 * To change this template use File | Settings | File Templates.
 */
public class RegistryEntity extends Entity {

    public String name;
    public RemoteObject obj;

//    public RegistryEntity(){
//        name="";
//        port="";
//    }
    public RegistryEntity(){
        obj= new NinjaRemoteObject();
    }
    public RegistryEntity(String name, RemoteObject obj){
        this.name=name;
        this.obj=obj;
    }

//    public void clone(Entity e,long index)//, long index)       // this will put all the the attributes and index in the entity e
//    {
//        ((RegistryEntity)e).name=name;
//        ((RegistryEntity)e).obj = obj;
//        e.setIndex(index);
//        setIndex(index);
//        //To change body of implemented methods use File | Settings | File Templates.
//    }

    public void readObject(DataInputStreamWrapper in) throws IOException, ClassNotFoundException, IllegalAccessException, InstantiationException      //for persistent this two methods should be implemented it somehow shows the   serializability order
    {
//        name=
//                in.readString(name);
        name=in.readUTF();
//        obj =
//                (RemoteObject)
          in.readObject((NinjaRemoteObject)obj);
        //To change body of implemented methods use File | Settings | File Templates.
    }

    public void writeObject(DataOutputStreamWrapper out) throws IOException {
        //To change body of implemented methods use File | Settings | File Templates.
//        out.writeString(name);
        out.writeUTF(name);
        out.writeObject((NinjaRemoteObject)obj);
    }
}
