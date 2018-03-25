/*
 * MM JDBC Drivers for MySQL
 *
 * Copyright (C) 1998 Mark Matthews <mmatthew@worldserver.com>
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 * 
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA  02111-1307, USA.
 *
 * See the COPYING file located in the top-level-directory of
 * the archive of this library for complete text of license.
 */

package org.gjt.mm.mysql;

import java.io.*;
import java.sql.*;
import java.util.Properties;
import javax.naming.*;
import javax.sql.DataSource;

/**
 * A JNDI DataSource for a Mysql JDBC connection
 */

public class MysqlDataSource implements DataSource, 
					Referenceable, 
					Serializable 
{
    /**
     * The driver to create connections with
     */

    protected static org.gjt.mm.mysql.Driver _MysqlDriver = null;

    static {
	try {
	    _MysqlDriver = (org.gjt.mm.mysql.Driver)Class.forName("org.gjt.mm.mysql.Driver").newInstance();
	}
	catch (Exception E) {
	    throw new RuntimeException("Can not load Driver class org.gjt.mm.mysql.Driver");
	}
    }
	
    /**
     * Hostname
     */

    protected String _HostName = null;

    /**
     * Port number
     */

    protected int _port = 1306;

    /**
     * Database Name
     */

    protected String _DatabaseName = null;

    /**
     * Character Encoding
     */

    protected String _Encoding = null;

    /**
     * User name
     */

    protected String _User = null;

    /**
     * Password
     */

    protected String _Password = null;

    /**
     * Log stream
     */

    protected PrintWriter _LogWriter = null;

    /**
     * Default no-arg constructor for Serialization
     */

    public MysqlDataSource() 
    {
    }

    /**
     * Creates a new connection using the already configured
     * username and password.
     */

    public java.sql.Connection getConnection() throws SQLException 
    {
	return getConnection(_User, _Password);
    }

    /**
     * Creates a new connection with the given username and password
     */

    public java.sql.Connection getConnection(String UserID, String Password)
	throws SQLException 
    {
	Properties Props = new Properties();
	
	
	if (UserID == null) {
		UserID = "";
	}


	if (Password == null) {
	    Password = "";
	}

	Props.put("user", UserID);
	Props.put("password", Password);

	return getConnection(Props);
    }

    /**
     * Creates a connection using the specified properties.
     */

    protected java.sql.Connection getConnection(Properties Props)
	throws SQLException 
    {
	StringBuffer JDBCUrl = new StringBuffer("jdbc:mysql://");
	if (_HostName != null) {
	    JDBCUrl.append(_HostName);
	}

	JDBCUrl.append(":");
	JDBCUrl.append(_port);
	JDBCUrl.append("/");

	if (_DatabaseName != null) {
	    JDBCUrl.append(_DatabaseName);
	}

	return _MysqlDriver.connect(JDBCUrl.toString(), Props);
    }

    /**
     * Gets the name of the database
     */
    
    public String getDatabaseName() 
    {
	return _DatabaseName;
    }
    
    public PrintWriter getLogWriter() throws SQLException 
    {
	return _LogWriter;
    }


    public int getLoginTimeout() throws SQLException 
    {
	return 0;
    }

    public int getPort() 
    {
	return _port;
    }

    /**
     * Required method to support this class as a <CODE>Referenceable</CODE>.
     */

    public Reference getReference() throws NamingException 
    {
	String FactoryName = "org.gjt.mm.mysql.MysqlDataSourceFactory";

	Reference Ref = new Reference(getClass().getName(), FactoryName, null);

	Ref.add(new StringRefAddr("user", getUser()));
	Ref.add(new StringRefAddr("password", _Password));
	Ref.add(new StringRefAddr("serverName", getServerName()));
	Ref.add(new StringRefAddr("port", "" + getPort()));
	Ref.add(new StringRefAddr("databaseName", getDatabaseName()));

	return Ref;
    }

    /**
     * Gets the name of the database server
     */

    public String getServerName() 
    {
	return _HostName;
    }

    /**
     * Gets the JDBC URL that will be used to create the
     * database connection.
     */

    public String getURL() {
	String Url = "jdbc:mysql://";

	Url = Url + getServerName() + ":" + getPort()+ "/"+ getDatabaseName();

	return Url;
    }

    /**
     * Gets the configured user for this connection
     */

    public String getUser() 
    {
	return _User;
    }
    
    /**
     * Sets the database name.
     * @param nom the name of the database
     */

    public void setDatabaseName(String DBName) 
    {
	_DatabaseName = DBName;
    }
    
    /**
     * Sets the log writer for this data source.
     */

    public void setLogWriter(PrintWriter Output) throws SQLException 
    {
	_LogWriter = Output;
    }

    public void setLoginTimeout(int seconds) throws SQLException 
    {
    }

    /**
     * Sets the password
     */

    public void setPassword(String Pass) 
    {
	_Password = Pass;
    }

    /**
     * Sets the database port.
     */

    public void setPort(int p) 
    {
	_port = p;
    }

    /**
     * Sets the server name.
     */

    public void setServerName(String ServerName) 
    {
	_HostName = ServerName;
    }

    /**
     * Sets the user ID.
     */

    public void setUser(String UserID) {
	_User = UserID;
    }
}
