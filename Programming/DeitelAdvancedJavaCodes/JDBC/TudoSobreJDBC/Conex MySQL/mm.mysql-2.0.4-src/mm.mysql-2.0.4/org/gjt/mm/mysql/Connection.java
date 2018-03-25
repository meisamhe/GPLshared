/*
 * MM JDBC Drivers for MySQL
 *
 * $Id: Connection.java,v 1.6 2000/07/04 02:05:40 mmatthew Exp $
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
 *
 * Some portions:
 *
 * Copyright (c) 1996 Bradley McLean / Jeffrey Medeiros
 * Modifications Copyright (c) 1996/1997 Martin Rode
 * Copyright (c) 1997 Peter T Mount
 */

/**
 * A Connection represents a session with a specific database.  Within the
 * context of a Connection, SQL statements are executed and results are
 * returned.
 *
 * <P>A Connection's database is able to provide information describing
 * its tables, its supported SQL grammar, its stored procedures, the
 * capabilities of this connection, etc.  This information is obtained
 * with the getMetaData method.
 *
 * <p><B>Note:</B> MySQL does not support transactions, so all queries
 *                 are committed as they are executed.
 *
 * @see java.sql.Connection
 * @author Mark Matthews <mmatthew@worldserver.com>
 * @version $Id: Connection.java,v 1.6 2000/07/04 02:05:40 mmatthew Exp $
 */

package org.gjt.mm.mysql;

import java.io.UnsupportedEncodingException;

import java.sql.*;
import java.util.Hashtable;
import java.util.Properties;

public abstract class Connection
{
    MysqlIO _IO                 = null;
    private boolean _isClosed   = true;
    
    private String  _Host       = null;
    private int     _port       = 3306;
    private String  _User       = null;
    private String  _Password   = null;
    protected String  _Database   = null;
    
    private boolean _autoCommit = true;
    private boolean _readOnly   = false;

    private boolean _do_unicode = false;
    private String  _Encoding   = null;
    
    private String  _MyURL      = null;

    private int     _max_rows   = -1;
    private boolean _max_rows_changed = false;

    private org.gjt.mm.mysql.Driver _MyDriver;

    private Hashtable _ServerVariables = null;

    private int _max_allowed_packet = 65536;
    private int _net_buffer_length = 16384;

    private boolean _use_fast_ping = false;

    //
    // This is for the high availability :) routines 
    //

    private boolean _high_availability = false;
    private int     _max_reconnects    = 3;
    private double  _initial_timeout   = 2.0D;
    
    // The command used to "ping" the database.
    // Newer versions of MySQL server have a ping() command,
    // but this works for everything.4

    private static final String _PING_COMMAND = "SELECT 1";
    
    /** Are transactions supported by the MySQL server we are connected to? */
    
    private boolean transactionsSupported = false;
    
    /** Do we relax the autoCommit semantics? (For enhydra, for example) */
    
    private boolean relaxAutoCommit = false;
    
    /** Should we return PreparedStatements for UltraDev's stupid bug? */
    
    private boolean useUltraDevWorkAround = false;
    
    /**
     * Connect to a MySQL Server.
     *
     * <p><b>Important Notice</b>
     *
     * <br>Although this will connect to the database, user code should open
     * the connection via the DriverManager.getConnection() methods only.
     *
     * <br>This should only be called from the org.gjt.mm.mysql.Driver class.
     *
     * @param Host the hostname of the database server
     * @param port the port number the server is listening on
     * @param Info a Properties[] list holding the user and password
     * @param Database the database to connect to
     * @param Url the URL of the connection
     * @param D the Driver instantation of the connection
     * @return a valid connection profile
     * @exception java.sql.SQLException if a database access error occurs
     */

  public void connectionInit(String Host, 
			     int port, 
			     Properties Info, 
			     String Database, 
			     String Url, 
			     Driver D) throws java.sql.SQLException
    {
      if (Driver.trace) {
	  Object[] Args = {Host, new Integer(port), Info,
			   Database, Url, D};
	  Debug.methodCall(this, "constructor", Args);
      }

      if (Host == null) {
	  _Host = "localhost";
      }
      else {
	  _Host = new String(Host);
      }
      
      _port = port;
      
      if (Database == null) {
	  throw new SQLException("Malformed URL '" + Url + "'.", "S1000");
      }
      _Database = new String(Database);
      
      _MyURL = new String(Url);
      _MyDriver = D;
      
      String U = Info.getProperty("user");
      String P = Info.getProperty("password");
      
      if (U == null || U.equals(""))
	  _User = "nobody";
      else
	  _User = new String(U);
      
      if (P == null)
	  _Password = "";
      else
	  _Password = new String(P);
      
      // Check for driver specific properties
      
      if (Info.getProperty("relaxAutocommit") != null) {
        relaxAutoCommit = Info.getProperty("relaxAutocommit").toUpperCase().equals("TRUE");
      }
      
      if (Info.getProperty("autoReconnect") != null) {
	  _high_availability = Info.getProperty("autoReconnect").toUpperCase().equals("TRUE");
      }
      
      if (Info.getProperty("ultraDevHack") != null) {
          useUltraDevWorkAround = Info.getProperty("ultraDevHack").toUpperCase().equals("TRUE");
      }
      
      if (_high_availability) {
	  if (Info.getProperty("maxReconnects") != null) {
	      try {
		  int n = Integer.parseInt(Info.getProperty("maxReconnects"));
		  _max_reconnects = n;
	      }
	      catch (NumberFormatException NFE) {
		  throw new SQLException("Illegal parameter '" + 
					 Info.getProperty("maxReconnects") 
					 +"' for maxReconnects", "0S100");
	      }
	  }
	  
	  if (Info.getProperty("initialTimeout") != null) {
	      try {
		  double n = Integer.parseInt(Info.getProperty("intialTimeout"));
		  _initial_timeout = n;
	      }
	      catch (NumberFormatException NFE) {
		  throw new SQLException("Illegal parameter '" + 
					 Info.getProperty("initialTimeout") 
					 +"' for initialTimeout", "0S100");
	      }
	  }
      }
      
      if (Info.getProperty("maxRows") != null) {
	  try {
	      int n = Integer.parseInt(Info.getProperty("maxRows"));
	      
	      if (n == 0) {
		  n = -1;
	      } // adjust so that it will become MysqlDefs.MAX_ROWS
              // in execSQL()
	      _max_rows = n;
	  }
	  catch (NumberFormatException NFE) {
	      throw new SQLException("Illegal parameter '" + 
				     Info.getProperty("maxRows") 
				     +"' for maxRows", "0S100");
	  }
      }
      
      if (Info.getProperty("useUnicode") != null) {
	  String UseUnicode = Info.getProperty("useUnicode").toUpperCase();
	  if (UseUnicode.startsWith("TRUE")) {
	      _do_unicode = true;
	  }
	  if (Info.getProperty("characterEncoding") != null) {
	      _Encoding = Info.getProperty("characterEncoding");
	      
	      // Attempt to use the encoding, and bail out if it
	      // can't be used
	      try {
		  String TestString = "abc";
		  TestString.getBytes(_Encoding);
	      }
	      catch (UnsupportedEncodingException UE) {
		  throw new SQLException("Unsupported character encoding '" + 
					 _Encoding + "'.", "0S100"); 
	      }
	  }
      }
      
      if (Driver.debug)
	  System.out.println("Connect: " + _User + " to " + _Database);
      try {
	  _IO = createNewIO(Host, port);
	  _IO.init(_User, _Password);

	  if (_Database.length() != 0) {
	      _IO.sendCommand(MysqlDefs.INIT_DB, _Database, null);
	  }
	  _isClosed = false;

	  _ServerVariables = new Hashtable();

	  if (_IO.versionMeetsMinimum(3, 22, 1)) {
	      _use_fast_ping = true;
	  }

	  //
	  // If version is greater than 3.21.22 get the server
	  // variables.
	  
	  if (_IO.versionMeetsMinimum(3, 21, 22)) {

	      org.gjt.mm.mysql.Statement Stmt = null;
	      org.gjt.mm.mysql.ResultSet RS = null;
	      
	      try {
		  Stmt = (org.gjt.mm.mysql.Statement)createStatement();
		  RS = (org.gjt.mm.mysql.ResultSet)Stmt.executeQuery("SHOW VARIABLES");
		  
		  while (RS.next()) {
		      _ServerVariables.put(RS.getString(1), RS.getString(2));
		  }
	      }
	      catch (java.sql.SQLException E) {
		  throw E;
	      }
	      finally {
		  if (RS != null) {
		      try {
			  RS.close();
		      }
		      catch (java.sql.SQLException SQLE) {}
		  }
		  
		  if (Stmt != null) {
		      try {
			  Stmt.close();
		      }
		      catch (java.sql.SQLException SQLE) {}
		  }
	      }   

	      if (_ServerVariables.containsKey("max_allowed_packet")) {
		  _max_allowed_packet = Integer.parseInt((String)_ServerVariables.get("max_allowed_packet"));
	      }
	      if (_ServerVariables.containsKey("net_buffer_length")) {
		  _net_buffer_length = Integer.parseInt((String)_ServerVariables.get("net_buffer_length"));
	      }
	  }
          
          if (_IO.versionMeetsMinimum(3, 23, 15)) {
            transactionsSupported = true;
          }
          else {
            transactionsSupported = false;
          }
          
          _IO.resetMaxBuf();
      } 
      catch (java.sql.SQLException E) { // don't clobber SQL exceptions
	  throw E;
      }
      catch (Exception E) {
	  throw new java.sql.SQLException("Cannot connect to MySQL server on " + _Host + ":" + _port + ". Is there a MySQL server running on the machine/port you are trying to connect to? (" + E.getClass().getName() + ")", "08S01");
      }
  }
  
  /**
   * SQL statements without parameters are normally executed using
   * Statement objects.  If the same SQL statement is executed many
   * times, it is more efficient to use a PreparedStatement
   *
   * @return a new Statement object
   * @exception java.sql.SQLException passed through from the constructor
   */

    public abstract java.sql.Statement createStatement() throws java.sql.SQLException;
  

  /**
   * A SQL statement with or without IN parameters can be pre-compiled
   * and stored in a PreparedStatement object.  This object can then
   * be used to efficiently execute this statement multiple times.
   * 
   * <p>
   * <B>Note:</B> This method is optimized for handling parametric
   * SQL statements that benefit from precompilation if the driver
   * supports precompilation. 
   * In this case, the statement is not sent to the database until the
   * PreparedStatement is executed.  This has no direct effect on users;
   * however it does affect which method throws certain java.sql.SQLExceptions
   *
   * <p>
   * MySQL does not support precompilation of statements, so they
   * are handled by the driver. 
   *
   * @param sql a SQL statement that may contain one or more '?' IN
   *    parameter placeholders
   * @return a new PreparedStatement object containing the pre-compiled
   *    statement.
   * @exception java.sql.SQLException if a database access error occurs.
   */

  public abstract java.sql.PreparedStatement prepareStatement(String Sql) throws java.sql.SQLException;
 

  /**
   * A SQL stored procedure call statement is handled by creating a
   * CallableStatement for it.  The CallableStatement provides methods
   * for setting up its IN and OUT parameters and methods for executing
   * it.
   *
   * <B>Note:</B> This method is optimised for handling stored procedure
   * call statements.  Some drivers may send the call statement to the
   * database when the prepareCall is done; others may wait until the
   * CallableStatement is executed.  This has no direct effect on users;
   * however, it does affect which method throws certain java.sql.SQLExceptions
   *
   * @param sql a SQL statement that may contain one or more '?' parameter
   *    placeholders.  Typically this statement is a JDBC function call
   *    escape string.
   * @return a new CallableStatement object containing the pre-compiled
   *    SQL statement
   * @exception java.sql.SQLException if a database access error occurs
   */

  public java.sql.CallableStatement prepareCall(String Sql) throws java.sql.SQLException
  {
      if (Driver.trace) {
	  Object[] Args = {Sql};
	  Debug.methodCall(this, "prepareCall", Args);
      }
      
      if (useUltraDevWorkAround) {
          return new UltraDevWorkAround(prepareStatement(Sql));
      }
      else {
          throw new java.sql.SQLException("Callable statments not suppoted.", "S1C00"); 
      }
  }

  /**
   * A driver may convert the JDBC sql grammar into its system's
   * native SQL grammar prior to sending it; nativeSQL returns the
   * native form of the statement that the driver would have sent.
   *
   * @param sql a SQL statement that may contain one or more '?'
   *    parameter placeholders
   * @return the native form of this statement
   * @exception java.sql.SQLException if a database access error occurs
   */

  public String nativeSQL(String Sql) throws java.sql.SQLException
  {
      if (Driver.trace) {
	  Object[] Args = {Sql};
	  Debug.methodCall(this, "nativeSQL", Args);
	  Debug.returnValue(this, "nativeSQL", Sql);
      }

    return Sql;
  }

  /**
   * If a connection is in auto-commit mode, than all its SQL
   * statements will be executed and committed as individual
   * transactions.  Otherwise, its SQL statements are grouped
   * into transactions that are terminated by either commit()
   * or rollback().  By default, new connections are in auto-
   * commit mode.  The commit occurs when the statement completes
   * or the next execute occurs, whichever comes first.  In the
   * case of statements returning a ResultSet, the statement
   * completes when the last row of the ResultSet has been retrieved
   * or the ResultSet has been closed.  In advanced cases, a single
   * statement may return multiple results as well as output parameter
   * values.  Here the commit occurs when all results and output param
   * values have been retrieved.
   *
   * <p><b>Note:</b> MySQL does not support transactions, so this
   *                 method is a no-op.
   *
   * @param autoCommit - true enables auto-commit; false disables it
   * @exception java.sql.SQLException if a database access error occurs
   */

  public void setAutoCommit(boolean autoCommit) throws java.sql.SQLException
  {
      if (Driver.trace) {
	  Object[] Args = {new Boolean(autoCommit)};
	  Debug.methodCall(this, "setAutoCommit", Args);
      }

      if (transactionsSupported) {
        String sql = "SET autocommit=" + (autoCommit ? "1" : "0");
        
        execSQL(sql, -1);
        
        _autoCommit = autoCommit;
      }
      else {
        if (autoCommit == false && relaxAutoCommit == false) {
	    throw new SQLException("MySQL Versions Older than 3.23.15 do not support transactions", "08003");
        }
        else {
          _autoCommit = autoCommit;
        }
      }

      return;
  }

  /**
   * gets the current auto-commit state
   *
   * @return Current state of the auto-commit mode
   * @exception java.sql.SQLException (why?)
   * @see setAutoCommit
   */

  public boolean getAutoCommit() throws java.sql.SQLException
  {
      if (Driver.trace) {
	  Object[] Args = new Object[0];
	  Debug.methodCall(this, "getAutoCommit", Args);
	  Debug.returnValue(this, "getAutoCommit", new Boolean(_autoCommit));
      }

    return _autoCommit;
  }

  /**
   * The method commit() makes all changes made since the previous
   * commit/rollback permanent and releases any database locks currently
   * held by the Connection.  This method should only be used when
   * auto-commit has been disabled.
   * 
   * <p><b>Note:</b> MySQL does not support transactions, so this
   *                 method is a no-op.
   *
   * @exception java.sql.SQLException if a database access error occurs
   * @see setAutoCommit
   */

  public void commit() throws java.sql.SQLException
  {
      if (Driver.trace) {
	  Object[] Args = new Object[0];
	  Debug.methodCall(this, "commit", Args);
      }

      // no-op if relaxAutoCommit == true
      if (_autoCommit && !relaxAutoCommit) {
        throw new SQLException("Can't call commit when autocommit=true");
      }
      else if (transactionsSupported) {
        execSQL("commit", -1);
      }
      
    return;
  }

  /**
   * The method rollback() drops all changes made since the previous
   * commit/rollback and releases any database locks currently held by
   * the Connection.
   *
   * @exception java.sql.SQLException if a database access error occurs
   * @see commit
   */

  public void rollback() throws java.sql.SQLException
  {
      if (Driver.trace) {
	  Object[] Args = new Object[0];
	  Debug.methodCall(this, "rollback", Args);
      }

      // no-op if relaxAutoCommit == true
      
      if (_autoCommit && !relaxAutoCommit) {
        throw new SQLException("Can't call commit when autocommit=true", "08003");
      }
      else if (transactionsSupported) {
        execSQL("rollback", -1);
      }
      
      if (_isClosed) {
        throw new java.sql.SQLException("Rollback attempt on closed connection.", "08003");
      }
  }
  
  /**
   * In some cases, it is desirable to immediately release a Connection's
   * database and JDBC resources instead of waiting for them to be
   * automatically released (cant think why off the top of my head)
   *
   * <B>Note:</B> A Connection is automatically closed when it is
   * garbage collected.  Certain fatal errors also result in a closed
   * connection.
   *
   * @exception java.sql.SQLException if a database access error occurs
   */

  public void close() throws java.sql.SQLException
  {
      if (Driver.trace) {
	  Object[] Args = new Object[0];
	  Debug.methodCall(this, "close", Args);
      }
      
    if (_IO != null)
      {
        try {
            _IO.quit();
          } 
        catch (Exception e) {}
        _IO = null;
      }
    _isClosed = true;
  }
  
  /**
   * Tests to see if a Connection is closed
   *
   * @return the status of the connection
   * @exception java.sql.SQLException (why?)
   */

  public boolean isClosed() throws java.sql.SQLException
  {
      if (Driver.trace) {
	  Object[] Args = new Object[0];
	  Debug.methodCall(this, "isClosed", Args);
	  Debug.returnValue(this, "isClosed", new Boolean(_isClosed));
      }

      if (!_isClosed) {
	 // Test the connection
    
        try {
            synchronized (_IO) {
		   execSQL(_PING_COMMAND, -1);
            }
        } 
        catch (Exception E) {
		_isClosed = true;
        }
      }
	
      return _isClosed;
  }

  /**
   * A connection's database is able to provide information describing
   * its tables, its supported SQL grammar, its stored procedures, the
   * capabilities of this connection, etc.  This information is made
   * available through a DatabaseMetaData object.
   *
   * @return a DatabaseMetaData object for this connection
   * @exception java.sql.SQLException if a database access error occurs
   */

  public abstract java.sql.DatabaseMetaData getMetaData() throws java.sql.SQLException;
 
  /**
   * You can put a connection in read-only mode as a hint to enable
   * database optimizations
   *
   * <B>Note:</B> setReadOnly cannot be called while in the middle
   * of a transaction
   *
   * @param readOnly - true enables read-only mode; false disables it
   * @exception java.sql.SQLException if a database access error occurs
   */

  public void setReadOnly (boolean readOnly) throws java.sql.SQLException
  {
      if (Driver.trace) {
	  Object[] Args = {new Boolean(readOnly)};
	  Debug.methodCall(this, "setReadOnly", Args);
	  Debug.returnValue(this, "setReadOnly", new Boolean(readOnly));
      }
    _readOnly = readOnly;
  } 

  /**
   * Tests to see if the connection is in Read Only Mode.  Note that
   * we cannot really put the database in read only mode, but we pretend
   * we can by returning the value of the readOnly flag
   *
   * @return true if the connection is read only
   * @exception java.sql.SQLException if a database access error occurs
   */

  public boolean isReadOnly() throws java.sql.SQLException
  {
      if (Driver.trace) {
	  Object[] Args = new Object[0];
	  Debug.methodCall(this, "isReadOnly", Args);
	  Debug.returnValue(this, "isReadOnly", new Boolean(_readOnly));
      }

    return _readOnly;
  }

  /**
   * A sub-space of this Connection's database may be selected by
   * setting a catalog name.  If the driver does not support catalogs,
   * it will silently ignore this request
   *
   * <p><b>Note:</b> MySQL's notion of catalogs are individual databases.
   *
   * @exception java.sql.SQLException if a database access error occurs
   */

  public void setCatalog(String Catalog) throws java.sql.SQLException
  {
      if (Driver.trace) {
	  Object[] Args = {Catalog};
	  Debug.methodCall(this, "setCatalog", Args);
      }

        execSQL("USE " + Catalog, -1);
        _Database = Catalog;
  }
  
  /**
   * Return the connections current catalog name, or null if no
   * catalog name is set, or we dont support catalogs.
   *
   * <p><b>Note:</b> MySQL's notion of catalogs are individual databases.
   * @return the current catalog name or null
   * @exception java.sql.SQLException if a database access error occurs
   */

  public String getCatalog() throws java.sql.SQLException
  {
      if (Driver.trace) {
	  Object[] Args = new Object[0];
	  Debug.methodCall(this, "getCatalog", Args);
	  Debug.returnValue(this, "getCatalog", _Database);
      }

    return _Database;
  }

  /**
   * You can call this method to try to change the transaction
   * isolation level using one of the TRANSACTION_* values.
   *
   * <B>Note:</B> setTransactionIsolation cannot be called while
   * in the middle of a transaction
   *
   * @param level one of the TRANSACTION_* isolation values with
   *    the exception of TRANSACTION_NONE; some databases may
   *    not support other values
   * @exception java.sql.SQLException if a database access error occurs
   * @see java.sql.DatabaseMetaData#supportsTransactionIsolationLevel
   */

  public void setTransactionIsolation(int level) throws java.sql.SQLException
  {
      if (Driver.trace) {
	  Object[] Args = {new Integer(level)};
	  Debug.methodCall(this, "setTransactionIsolation", Args);
      }

    throw new java.sql.SQLException("Transaction Isolation Levels are not supported.", "S1C00");
  }
  
  /**
   * Get this Connection's current transaction isolation mode.
   *
   * @return the current TRANSACTION_* mode value
   * @exception java.sql.SQLException if a database access error occurs
   */

  public int getTransactionIsolation() throws java.sql.SQLException
  {
      if (Driver.trace) {
	  Object[] Args = new Object[0];
	  Debug.methodCall(this, "getTransactionIsolation", Args);
	  Debug.returnValue(this, "getTransactionIsolation", new Integer(java.sql.Connection.TRANSACTION_SERIALIZABLE));
      }
    return java.sql.Connection.TRANSACTION_SERIALIZABLE;
  }
  
  /**
   * The first warning reported by calls on this Connection is
   * returned.
   *
   * <B>Note:</B> Sebsequent warnings will be changed to this
   * java.sql.SQLWarning
   *
   * @return the first java.sql.SQLWarning or null
   * @exception java.sql.SQLException if a database access error occurs
   */

  public java.sql.SQLWarning getWarnings() throws java.sql.SQLException
  {
      if (Driver.trace) {
	  Object[] Args = new Object[0];
	  Debug.methodCall(this, "getWarnings", Args);
	  Debug.returnValue(this, "getWarnings", null);
      }

    return null;
  }

  /**
   * After this call, getWarnings returns null until a new warning
   * is reported for this connection.
   *
   * @exception java.sql.SQLException if a database access error occurs
   */
  
  public void clearWarnings() throws java.sql.SQLException
  {
      if (Driver.trace) {
	  Object[] Args = new Object[0];
	  Debug.methodCall(this, "clearWarnings", Args);
      }

    // firstWarning = null;
  }

  // *********************************************************************
  //
  //                END OF PUBLIC INTERFACE
  //
  // *********************************************************************

  /**
   * Send a query to the server.  Returns one of the ResultSet
   * objects.
   *
   * This is synchronized, so Statement's queries
   * will be serialized.
   *
   * @param sql the SQL statement to be executed
   * @return a ResultSet holding the results
   * @exception java.sql.SQLException if a database error occurs
   */

  ResultSet execSQL(String Sql, int max_rows) 
      throws java.sql.SQLException
  {
	  return execSQL(Sql, max_rows, null);
  }
  
  ResultSet execSQL(String Sql, int max_rows, Buffer Packet) 
      throws java.sql.SQLException
  {  
      synchronized (_IO) {

	  if (_high_availability) {
	      try {

		  if (_use_fast_ping) {
		      _IO.sendCommand(MysqlDefs.PING, null, null);
		  }
		  else {
		      _IO.sqlQuery(_PING_COMMAND, MysqlDefs.MAX_ROWS);
		  }
	      }
	      catch (Exception Ex) {
		  double timeout = _initial_timeout;
		  boolean connection_good = false;

		  for (int i = 0; i < _max_reconnects; i++) {
        
		      try {
			  _IO = createNewIO(_Host, _port);
			  _IO.init(_User, _Password);
			  if (_Database.length() != 0) {
			      _IO.sendCommand(MysqlDefs.INIT_DB, _Database, null);
			  }

			  if (_use_fast_ping) {
			      _IO.sendCommand(MysqlDefs.PING, null, null);
			  }
			  else {
			      _IO.sqlQuery(_PING_COMMAND, MysqlDefs.MAX_ROWS);
			  }
					  
			  connection_good = true;
			  break;
		      } 
		      catch (Exception EEE) {}
                  
		      try {
			  Thread.currentThread().sleep((long)timeout * 1000);
			  timeout = timeout * timeout;
		      }
		      catch (InterruptedException IE) {}
		  }

		  if (!connection_good) { // We've really failed!
		      throw new SQLException("Server connection failure during transaction. \nAttemtped reconnect " + _max_reconnects + " times. Giving up.", "08001");
		  }
	      }
	  }

	  try {
	      int real_max_rows = ( max_rows == -1 ) ? 
		  MysqlDefs.MAX_ROWS : max_rows;

	      if (Packet == null) {
		  String Encoding = null;

		  if (useUnicode()) {
		      Encoding = getEncoding();
		  }

		  return _IO.sqlQuery(Sql, real_max_rows, Encoding, this);
	      }
	      else {
		  return _IO.sqlQueryDirect(Packet, real_max_rows, this);
	      }
	  }
	  catch (java.io.EOFException EOFE) {
	      throw new java.sql.SQLException("Lost connection to server during query", "08007");
	  }
          catch (java.sql.SQLException SQLE) { // don't clobber SQL exceptions
            throw SQLE;
          }
	  catch (Exception E) {
	      String ExceptionType = E.getClass().getName();
	      String ExceptionMessage = E.getMessage();
    
	      throw new java.sql.SQLException("Error during query: Unexpected Exception: " + ExceptionType + " message given: " + ExceptionMessage, "S1000");
	  }
      }
  }
    
  /** JDBC1 and JDBC2 version of Connection create their own IO classes */
  
    protected abstract MysqlIO createNewIO(String Host, int port) throws Exception;
   
    String getURL()
    {
	return _MyURL;
    }
    
    String getUser()
    {
	return _User;
    }

    String getServerVersion()
    {
	return _IO.getServerVersion();
    }

    int getServerMajorVersion()
    {
        return _IO.getServerMajorVersion();
    }

    int getServerMinorVersion()
    {
        return _IO.getServerMinorVersion();
    }

    int getServerSubMinorVersion()
    {
        return _IO.getServerSubMinorVersion();
    }

    /** Has the maxRows value changed? */
    
    void maxRowsChanged()
    {
        _max_rows_changed = true;
    }

    /** Has maxRows() been set? */
    
    boolean useMaxRows()
    {
        return _max_rows_changed;
    }

    /** Should unicode character mapping be used ? */
    
    public boolean useUnicode()
    {
	return _do_unicode;
    }

    /** Returns the character encoding for this Connection */
    
    public String getEncoding()
    {
	return _Encoding;
    }

    /** Returns the Mutex all queries are locked against */
    
    Object getMutex()
    {
	return _IO;
    }

    /** Returns the maximum packet size the MySQL server will accept */
    
    int getMaxAllowedPacket()
    {
	return _max_allowed_packet;
    }

    /** Returns the packet buffer size the MySQL server reported
     *  upon connection */
    
    int getNetBufferLength()
    {
	return _net_buffer_length;
    }
    
    /**
     * Wrapper class for UltraDev CallableStatements that 
     * are really PreparedStatments.
     *
     * Nice going, macromedia!
     */
    
    class UltraDevWorkAround implements java.sql.CallableStatement {
        java.sql.PreparedStatement delegate = null;

        UltraDevWorkAround(java.sql.PreparedStatement pstmt) {
            delegate = pstmt;
        }
        
        public void addBatch() throws java.sql.SQLException {
            delegate.addBatch();
        }
        
        public void addBatch(java.lang.String p1) throws java.sql.SQLException {
            delegate.addBatch(p1);
        }
        
        public void cancel() throws java.sql.SQLException {
            delegate.cancel();
        }
        
        public void clearBatch() throws java.sql.SQLException {
            delegate.clearBatch();
        }
        
        public void clearParameters() throws java.sql.SQLException {
            delegate.clearParameters();
        }
        
        public void clearWarnings() throws java.sql.SQLException {
            delegate.clearWarnings();
        }
        
        public void close() throws java.sql.SQLException {
            delegate.close();
        }
        
        public boolean execute() throws java.sql.SQLException {
            return delegate.execute();
        }
        
        public boolean execute(java.lang.String p1) throws java.sql.SQLException {
            return delegate.execute(p1);
        }
        
        public int[] executeBatch() throws java.sql.SQLException {
            return delegate.executeBatch();
        }
        
        public java.sql.ResultSet executeQuery() throws java.sql.SQLException {
            return delegate.executeQuery();
        }
        
        public java.sql.ResultSet executeQuery(java.lang.String p1) throws java.sql.SQLException {
            return delegate.executeQuery(p1);
        }
        
        public int executeUpdate() throws java.sql.SQLException {
            return delegate.executeUpdate();
        }
        
        public int executeUpdate(java.lang.String p1) throws java.sql.SQLException {
            return delegate.executeUpdate(p1);
        }
        
        public java.sql.Array getArray(int p1) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public java.math.BigDecimal getBigDecimal(int p1) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public java.math.BigDecimal getBigDecimal(int p1,int p2) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public java.sql.Blob getBlob(int p1) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public boolean getBoolean(int p1) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public byte getByte(int p1) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public byte[] getBytes(int p1) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public java.sql.Clob getClob(int p1) throws java.sql.SQLException {
            throw new SQLException("Not supported");
            
        }
        
        public java.sql.Connection getConnection() throws java.sql.SQLException {
            return delegate.getConnection();
        }
        
        public java.sql.Date getDate(int p1) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public java.sql.Date getDate(int p1,final java.util.Calendar p2) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public double getDouble(int p1) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public int getFetchDirection() throws java.sql.SQLException {
            return delegate.getFetchDirection();
        }
        
        public int getFetchSize() throws java.sql.SQLException {
            return delegate.getFetchSize();
        }
        
        public float getFloat(int p1) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public int getInt(int p1) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public long getLong(int p1) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public int getMaxFieldSize() throws java.sql.SQLException {
            return delegate.getMaxFieldSize();
        }
        
        public int getMaxRows() throws java.sql.SQLException {
            return delegate.getMaxRows();
        }
        
        public java.sql.ResultSetMetaData getMetaData() throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public boolean getMoreResults() throws java.sql.SQLException {
            return delegate.getMoreResults();
        }
        
        public java.lang.Object getObject(int p1) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public java.lang.Object getObject(int p1,final java.util.Map p2) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public int getQueryTimeout() throws java.sql.SQLException {
            return delegate.getQueryTimeout();
        }
        
        public java.sql.Ref getRef(int p1) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public java.sql.ResultSet getResultSet() throws java.sql.SQLException {
            return delegate.getResultSet();
        }
        
        public int getResultSetConcurrency() throws java.sql.SQLException {
            return delegate.getResultSetConcurrency();
        }
        
        public int getResultSetType() throws java.sql.SQLException {
            return delegate.getResultSetType();
        }
        
        public short getShort(int p1) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public java.lang.String getString(int p1) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public java.sql.Time getTime(int p1) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public java.sql.Time getTime(int p1,final java.util.Calendar p2) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public java.sql.Timestamp getTimestamp(int p1) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public java.sql.Timestamp getTimestamp(int p1,final java.util.Calendar p2) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public int getUpdateCount() throws java.sql.SQLException {
            return delegate.getUpdateCount();
        }
        
        public java.sql.SQLWarning getWarnings() throws java.sql.SQLException {
            return delegate.getWarnings();
        }
        
        public void registerOutParameter(int p1,int p2) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public void registerOutParameter(int p1,int p2,int p3) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public void registerOutParameter(int p1,int p2,java.lang.String p3) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public void setArray(int p1,final java.sql.Array p2) throws java.sql.SQLException {
            delegate.setArray(p1, p2);
        }
        
        public void setAsciiStream(int p1,final java.io.InputStream p2,int p3) throws java.sql.SQLException {
            delegate.setAsciiStream(p1, p2, p3);
        }
        
        public void setBigDecimal(int p1,final java.math.BigDecimal p2) throws java.sql.SQLException {
            delegate.setBigDecimal(p1, p2);
        }
        
        public void setBinaryStream(int p1,final java.io.InputStream p2,int p3) throws java.sql.SQLException {
            delegate.setBinaryStream(p1, p2, p3);
        }
        
        public void setBlob(int p1,final java.sql.Blob p2) throws java.sql.SQLException {
            delegate.setBlob(p1, p2);
        }
        
        public void setBoolean(int p1,boolean p2) throws java.sql.SQLException {
            delegate.setBoolean(p1, p2);
        }
        
        public void setByte(int p1,byte p2) throws java.sql.SQLException {
            delegate.setByte(p1, p2);
        }
        
        public void setBytes(int p1,byte[] p2) throws java.sql.SQLException {
            delegate.setBytes(p1, p2);
        }
        
        public void setCharacterStream(int p1,final java.io.Reader p2,int p3) throws java.sql.SQLException {
            delegate.setCharacterStream(p1, p2, p3);
        }
        
        public void setClob(int p1,final java.sql.Clob p2) throws java.sql.SQLException {
            delegate.setClob(p1, p2);
        }
        
        public void setCursorName(java.lang.String p1) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public void setDate(int p1,final java.sql.Date p2) throws java.sql.SQLException {
            delegate.setDate(p1, p2);
        }
        
        public void setDate(int p1,final java.sql.Date p2,final java.util.Calendar p3) throws java.sql.SQLException {
            delegate.setDate(p1, p2, p3);
        }
        
        public void setDouble(int p1,double p2) throws java.sql.SQLException {
            delegate.setDouble(p1, p2);
        }
        
        public void setEscapeProcessing(boolean p1) throws java.sql.SQLException {
            delegate.setEscapeProcessing(p1);
        }
        
        public void setFetchDirection(int p1) throws java.sql.SQLException {
            delegate.setFetchDirection(p1);
        }
        
        public void setFetchSize(int p1) throws java.sql.SQLException {
            delegate.setFetchSize(p1);
        }
        
        public void setFloat(int p1,float p2) throws java.sql.SQLException {
            delegate.setFloat(p1, p2);
        }
        
        public void setInt(int p1,int p2) throws java.sql.SQLException {
            delegate.setInt(p1, p2);
        }
        
        public void setLong(int p1,long p2) throws java.sql.SQLException {
            delegate.setLong(p1, p2);
        }
        
        public void setMaxFieldSize(int p1) throws java.sql.SQLException {
            delegate.setMaxFieldSize(p1);
        }
        
        public void setMaxRows(int p1) throws java.sql.SQLException {
            delegate.setMaxRows(p1);
        }
        
        public void setNull(int p1,int p2) throws java.sql.SQLException {
            delegate.setNull(p1, p2);
        }
        
        public void setNull(int p1,int p2,java.lang.String p3) throws java.sql.SQLException {
            delegate.setNull(p1, p2, p3);
        }
        
        public void setObject(int p1,final java.lang.Object p2) throws java.sql.SQLException {
            delegate.setObject(p1, p2);
        }
        
        public void setObject(int p1,final java.lang.Object p2,int p3) throws java.sql.SQLException {
            delegate.setObject(p1, p2, p3);
        }
        
        public void setObject(int p1,final java.lang.Object p2,int p3,int p4) throws java.sql.SQLException {
            delegate.setObject(p1, p2, p3, p4);
        }
        
        public void setQueryTimeout(int p1) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public void setRef(int p1,final java.sql.Ref p2) throws java.sql.SQLException {
            throw new SQLException("Not supported");
        }
        
        public void setShort(int p1,short p2) throws java.sql.SQLException {
            delegate.setShort(p1, p2);
        }
        
        public void setString(int p1,java.lang.String p2) throws java.sql.SQLException {
            delegate.setString(p1, p2);
        }
        
        public void setTime(int p1,final java.sql.Time p2) throws java.sql.SQLException {
            delegate.setTime(p1, p2);
        }
        
        public void setTime(int p1,final java.sql.Time p2,final java.util.Calendar p3) throws java.sql.SQLException {
            delegate.setTime(p1, p2, p3);
        }
        
        public void setTimestamp(int p1,final java.sql.Timestamp p2) throws java.sql.SQLException {
            delegate.setTimestamp(p1, p2);
        }
        
        public void setTimestamp(int p1,final java.sql.Timestamp p2,final java.util.Calendar p3) throws java.sql.SQLException {
            delegate.setTimestamp(p1, p2, p3);
        }
        
        public void setUnicodeStream(int p1,final java.io.InputStream p2,int p3) throws java.sql.SQLException {
            delegate.setUnicodeStream(p1, p2, p3);
        }
        
        public boolean wasNull() throws java.sql.SQLException {
           throw new SQLException("Not supported");
        }
        
    }
}
