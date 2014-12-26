package ninja.Domain;

import ninja.rmi.NinjaObjectOutputStream;
import ninja.rmi.NinjaObjectInputStream;
import databaseCore.Entity;

/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Aug 5, 2009
 * Time: 10:55:24 AM
 * To change this template use File | Settings | File Templates.
 */
public abstract class Serializable extends Entity {
    public abstract void writeObject(DataOutputStream dos);
    public abstract Serializable readObject(DataInputStream dis ) throws ClassNotFoundException, IllegalAccessException, InstantiationException;

}
