package databaseCore;

import javax.microedition.midlet.MIDlet;

import MultipleChoice.entity.Entity;

/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Jul 19, 2008
 * Time: 11:00:55 AM
 * To change this template use File | Settings | File Templates.
 */
public interface DatabaseCore {  // you should first time openDB and do your work and in closing the app just closeDB
    public void openDB(String name, MIDlet cur);
    public void closeDB();
    public boolean insertDB(MIDlet cur, Entity entity)throws ClassNotFoundException, IllegalAccessException, InstantiationException;
    public boolean deleteDB(MIDlet cur, long key);
    public boolean searchDB(long key);
    public Entity getEntity(long key);
}
