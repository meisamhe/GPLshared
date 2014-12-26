package com.actionTracking;

import java.sql.ResultSet;
import java.io.BufferedWriter;

/**
 * <p>Title: </p>
 *
 * <p>Description: </p>
 *
 * <p>Copyright: Copyright (c) 2007</p>
 *
 * <p>Company: </p>
 *
 * @author not attributable
 * @version 1.0
 */
public abstract class Connector {
    abstract void makeConnection(String user, String pass,
                                 String portNumber,
                                 String host, String sid,BufferedWriter out
            );

    abstract boolean executeQuery(String query, boolean type
            );

    abstract int executeCountQuery(String query, boolean type);

//    public static void main(String[] args) {
//        Connector connector = new Connector();
//    }
}
