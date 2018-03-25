/*
 * MM JDBC Drivers for MySQL
 *
 * $Id: PreparedStatement.java,v 1.3 2000/05/28 21:21:07 mmatthew Exp $
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

/**
 * A SQL Statement is pre-compiled and stored in a PreparedStatement object.
 * This object can then be used to efficiently execute this statement multiple
 * times.
 *
 * <p><B>Note:</B> The setXXX methods for setting IN parameter values must
 * specify types that are compatible with the defined SQL type of the input
 * parameter.  For instance, if the IN parameter has SQL type Integer, then
 * setInt should be used.
 *
 * <p>If arbitrary parameter type conversions are required, then the setObject 
 * method should be used with a target SQL type.
 *
 * @see java.sql.ResultSet
 * @see java.sql.PreparedStatement
 * @author Mark Matthews <mmatthew@worldserver.com>
 * @version $Id: PreparedStatement.java,v 1.3 2000/05/28 21:21:07 mmatthew Exp $
 */

package org.gjt.mm.mysql.jdbc2;

import java.sql.Blob;
import java.sql.Clob;
import java.sql.Array;
import java.sql.Ref;
import java.sql.SQLException;

import java.util.Calendar;

public class PreparedStatement extends org.gjt.mm.mysql.PreparedStatement
    implements java.sql.PreparedStatement  
{
    /**
     * Constructor for the PreparedStatement class.
     * Split the SQL statement into segments - separated by the arguments.
     * When we rebuild the thing with the arguments, we can substitute the
     * args and join the whole thing together.
     *
     * @param conn the instanatiating connection
     * @param sql the SQL statement with ? for IN markers
     * @exception java.sql.SQLException if something bad occurs
     */

    public PreparedStatement(Connection Conn, String Sql, String Catalog) throws java.sql.SQLException
    {
	super(Conn, Sql, Catalog);
    }

   

    //--------------------------JDBC 2.0-----------------------------

    /**
     * Set a parameter to SQL NULL.
     *
     * <P><B>Note:</B> You must specify the parameter's SQL type.
     *
     * @param parameterIndex the first parameter is 1, the second is 2, ...
     * @param sqlType SQL type code defined by java.sql.Types
     * @exception SQLException if a database-access error occurs.
     */

    public void setNull(int parameterIndex, int sqlType, String Arg) throws SQLException
    {
	super.setNull(parameterIndex, sqlType);
    }

    /**
     * JDBC 2.0
     *
     * Add a set of parameters to the batch.
     * 
     * @exception SQLException if a database-access error occurs.
     * @see Statement#addBatch
     */

    public void addBatch() throws SQLException
    {
	throw new NotImplemented();
    }

    /**
     * JDBC 2.0
     *
     * When a very large UNICODE value is input to a LONGVARCHAR
     * parameter, it may be more practical to send it via a
     * java.io.Reader. JDBC will read the data from the stream
     * as needed, until it reaches end-of-file.  The JDBC driver will
     * do any necessary conversion from UNICODE to the database char format.
     * 
     * <P><B>Note:</B> This stream object can either be a standard
     * Java stream object or your own subclass that implements the
     * standard interface.
     *
     * @param parameterIndex the first parameter is 1, the second is 2, ...
     * @param x the java reader which contains the UNICODE data
     * @param length the number of characters in the stream 
     * @exception SQLException if a database-access error occurs.
     */

    public void setCharacterStream(int parameterIndex,
				   java.io.Reader reader,
				   int length) throws SQLException
    {
	throw new NotImplemented();
    }

    /**
     * JDBC 2.0
     *
     * Set a REF(&lt;structured-type&gt;) parameter.
     *
     * @param i the first parameter is 1, the second is 2, ...
     * @param x an object representing data of an SQL REF Type
     */

    public void setRef (int i, Ref x) throws SQLException
    {
	throw new NotImplemented();
    }

    /**
     * JDBC 2.0
     *
     * Set a BLOB parameter.
     *
     * @param i the first parameter is 1, the second is 2, ...
     * @param x an object representing a BLOB
     */

    public void setBlob (int i, Blob x) throws SQLException
    {
	setBinaryStream(i, x.getBinaryStream(), Integer.MAX_VALUE);
    }

    /**
     * JDBC 2.0
     *
     * Set a CLOB parameter.
     *
     * @param i the first parameter is 1, the second is 2, ...
     * @param x an object representing a CLOB
     */

    public void setClob (int i, Clob x) throws SQLException
    {
	throw new NotImplemented();
    }

    /**
     * JDBC 2.0
     *
     * Set an Array parameter.
     *
     * @param i the first parameter is 1, the second is 2, ...
     * @param x an object representing an SQL array
     */

    public void setArray (int i, Array x) throws SQLException
    {
	throw new NotImplemented();
    }

    /**
     * The number, types and properties of a ResultSet's columns
     * are provided by the getMetaData method.
     *
     * @return the description of a ResultSet's columns
     * @exception SQLException if a database-access error occurs.
     */

    public java.sql.ResultSetMetaData getMetaData() throws SQLException
    {
	throw new NotImplemented();
    }

    /**
     * Set a parameter to a java.sql.Date value.  The driver converts this
     * to a SQL DATE value when it sends it to the database.
     *
     * @param parameterIndex the first parameter is 1, the second is 2, ...
     * @param x the parameter value
     * @exception SQLException if a database-access error occurs.
     */

    public void setDate(int parameterIndex, 
			java.sql.Date X, 
			Calendar Cal)
	    throws SQLException
    {
	setDate(parameterIndex, X);
    }

    /**
     * Set a parameter to a java.sql.Time value.  The driver converts this
     * to a SQL TIME value when it sends it to the database.
     *
     * @param parameterIndex the first parameter is 1, the second is 2, ...
     * @param x the parameter value
     * @exception SQLException if a database-access error occurs.
     */

    public void setTime(int parameterIndex, 
			java.sql.Time X, 
			Calendar Cal) 
	throws SQLException
    {
	setTime(parameterIndex, X);
    }

    /**
     * Set a parameter to a java.sql.Timestamp value.  The driver
     * converts this to a SQL TIMESTAMP value when it sends it to the
     * database.
     *
     * @param parameterIndex the first parameter is 1, the second is 2, ...
     * @param x the parameter value 
     * @exception SQLException if a database-access error occurs.
     */

    public void setTimestamp(int parameterIndex, 
			     java.sql.Timestamp X, 
			     Calendar Cal)
	throws SQLException
    {
	setTimestamp(parameterIndex, X);
    }

    byte[] getBytes(int parameterIndex) throws SQLException
    {
	if (_IsStream[parameterIndex]) {
	    return null;
	}
	else {
	    String Encoding = null;

	    if (_Conn.useUnicode()) {
		Encoding = _Conn.getEncoding();
	    }
	    
	    if (Encoding != null) {
		try {
		    return _ParameterStrings[parameterIndex].getBytes(Encoding);
		}
		catch (java.io.UnsupportedEncodingException UEE) {
		    throw new SQLException("Unsupported character encoding '" + Encoding + "'");
		}
	    }
	    else {
		String StringVal = _ParameterStrings[parameterIndex];

		if (StringVal.startsWith("'") && StringVal.endsWith("'")) {
		    StringVal = StringVal.substring(1, StringVal.length() -1);
		}

		return StringVal.getBytes();
	    }
	}
    }
}
