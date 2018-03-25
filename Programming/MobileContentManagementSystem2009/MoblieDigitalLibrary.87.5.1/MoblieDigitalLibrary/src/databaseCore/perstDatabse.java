package databaseCore;

import org.garret.perst.*;

import javax.microedition.lcdui.Alert;
import javax.microedition.lcdui.AlertType;
import javax.microedition.lcdui.Display;
import javax.microedition.midlet.*;

import MultipleChoice.entity.Entity;

/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Jul 19, 2008
 * Time: 11:05:59 AM
 * To change this template use File | Settings | File Templates.
 */
public class perstDatabse implements DatabaseCore{
    private Storage storage;
    private Index root;
    private String name;
    // for insert just we can use root.size for the last index 

    public perstDatabse(String name, MIDlet cur){
            openDB(name,cur);
    }

    protected void createStorage() {
         storage = StorageFactory.getInstance().createStorage();
    }

    public void openDB(String name, MIDlet cur) { // if it is empty it just produces root for it
        this.name=name;
        createStorage();
        try {
            storage.open(name+".dbs");
        } catch (StorageError x) {
            Alert alert = new Alert("Error",
                                    "Failed to open database",
                                    null, AlertType.ERROR);
            alert.setTimeout(Alert.FOREVER);
            Display.getDisplay(cur).setCurrent(alert);
            return;
        }
         root = (Index)storage.getRoot();
         if (root == null) {
            root = storage.createIndex(Types.Long, true);
            storage.setRoot(root);
        }
    }

    public void closeDB() {
         storage.close();
    }
     private  void error(String msg,MIDlet cur) {
        Alert alert = new Alert("Error",
                                msg,
                                null,
                                AlertType.ERROR);
        alert.setTimeout(Alert.FOREVER);
        Display.getDisplay(cur).setCurrent(alert);
    }
    public boolean insertDB(MIDlet cur, Entity entity) throws ClassNotFoundException, IllegalAccessException, InstantiationException {
        long key = root.size();
        Entity newEntity=(Entity)(Class.forName( entity.getClass().getName()).newInstance());
        entity.clone(newEntity, key);
        if (!root.put(new Key(key), newEntity)) {
            error("Duplicates in tree",cur);
            closeDB();
            openDB(name,cur);
            return false;
        }
        storage.commit();
        // it is better to close this DB for the problem of commit  , if the problem is solved then you can delet the closeDB and openDB from this method
        closeDB();
        openDB(name,cur);
        return true;
    }

    public boolean deleteDB(MIDlet cur, long key) {
        Entity check = (Entity)root.get(new Key(key));
        if (check == null || check.getIndex() != key) {
            closeDB();
            openDB(name,cur);
            return false;
        }
        root.remove(new Key(key));
         storage.commit();
        // it is better to close this DB for the problem of commit  , if the problem is solved then you can delet the closeDB and openDB from this method
         closeDB();
         openDB(name,cur);
        return true;
    }

    public boolean searchDB(long key) {
        Entity check = (Entity)root.get(new Key(key));
        if (check == null || check.getIndex() != key) {
            return false;
        }
        return true;
    }

    public Entity getEntity(long key) { // voroodi in method lazem nist pichide i bashad chera ke behar hal sakhtar ha chon derakht hastand avalin bar
                                // ba onsore 1 farakhani shode va mavared badi ba index haye marboot ba estefade az etelaate objecte node aval
                                // traverse anjam migirad.
             return (Entity)root.get(new Key(key));
    }
}
