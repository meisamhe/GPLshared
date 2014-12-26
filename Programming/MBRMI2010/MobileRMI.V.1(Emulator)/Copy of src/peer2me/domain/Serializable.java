package peer2me.domain;

import peer2me.util.DataOutputStreamWrapper;
import peer2me.util.DataInputStreamWrapper;


/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Aug 5, 2009
 * Time: 10:55:24 AM
 * To change this template use File | Settings | File Templates.
 */
public interface Serializable {
    public void writeObject(DataOutputStreamWrapper dos);
    public Serializable readObject(DataInputStreamWrapper dis );

}
