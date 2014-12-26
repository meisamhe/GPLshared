package databaseCore;

import peer2me.util.DataInputStreamWrapper;
import peer2me.util.DataOutputStreamWrapper;

/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Sep 25, 2009
 * Time: 9:28:30 AM
 * To change this template use File | Settings | File Templates.
 */
public class DatabaseCore {
    DataInputStreamWrapper disw;
    DataOutputStreamWrapper dosw;
    public DatabaseCore (String dbname) throws ClassNotFoundException, IllegalAccessException, InstantiationException {
        disw = new DataInputStreamWrapper(dbname);
        dosw = new DataOutputStreamWrapper(dbname);
        
    }
}
