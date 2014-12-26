package com.actionTracking;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLWarning;
import java.util.Properties;
import java.io.*;

import com.mysql.jdbc.Statement;

public class MysqlConnector extends Connector {
    private Connection mySql;

    public Connection getDbConnection(String user, String pass, String port,
                                      String host, String sid) {
        if (mySql == null) {
            String mySqlDriver = "com.mysql.jdbc.Driver"; // URI of driver class
            // in driver jar file
            Connection mySql = null;
            String url = "jdbc:mysql://" + host + ":" + port + "/" + sid;
            System.out.println(url);
            try {
                Class.forName(mySqlDriver); 
                Properties prop = new Properties();
                prop.put("useUnicode", "true");
    			prop.put("characterEncoding", "utf8");

           //     con = DriverManager.getConnection(dbUrl, prop);
                prop.put("user", user);         // Set user ID for connection
                prop.put("password", pass);     // Set password for connection
            //    mySql = DriverManager.getConnection(url, user, pass);
                mySql=DriverManager.getConnection(url,prop);
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return mySql;
        } else {
            return mySql;
        }
    }

    /**
     * this class will return the result of your query in a result set.
     * @param sql: this parameter is your sql query string.
     * @param mySql: this parameter is your connection object;
     * @return this class will return ResultSet object.
     */

    public ResultSet runSqlQuery(String sql, Connection mySql,boolean type)  {
    	try{
        if (mySql == null) {
            return null;
        }
        PreparedStatement pstmt = null;
        ResultSet rslt = null;
        pstmt = mySql.prepareStatement(sql);
        if (type==true)
            rslt = pstmt.executeQuery();
        else
            pstmt.executeUpdate();

        	return rslt;
    	}catch(SQLException e){
        	System.out.print(e);
        }
    	return null;
    }
    
    public void runUpdateQuery(String sql, Connection mySql,boolean type){
    	 try {
    		 System.out.print(sql);
//             java.sql.Statement stmt = mySql.createStatement();
//             stmt.executeUpdate(sql);
    		 PreparedStatement pstmt = mySql.prepareStatement(sql);
    		 pstmt.executeUpdate();
         } catch (SQLException ex) {
             System.out.println(ex);
         }
    }
    /**
     *
     * @param sql : sql statement for insert,update or delete.
     * @param mySql : mySql database connection object.
     * @return if it returns -1 it means that there is no sql statement,
     * 		   if it returns 0 means no rows updated,inserted or deleted,
     * 		   if it returns more than zero means the number of updated,inserted or deleted.
     */
    public int runSqlDDL(String sql, Connection mySql) {
        int res = -1;
        if (mySql == null) {
            return res;
        }
        PreparedStatement pstmt = null;
        try {
            pstmt = mySql.prepareStatement(sql);
            res = pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("runSqlQuery failed ->" + e.getMessage());

        }
        return res;
    }

    /**
     * @param args
     */
    Connection con;
    BufferedWriter out;
    void makeConnection(String user, String pass,
                        String portNumber,
                        String host, String sid,BufferedWriter out
            ) {
        con = getDbConnection(user, pass, portNumber, host, sid);
        this.out= out;
    }

    boolean executeQuery(String query, boolean type
            ) {
        ResultSet rslt;
        try {
            rslt = runSqlQuery(query, con,type);
        } catch (Exception e) {
             System.out.println(e);
            try {
                out.write(e.toString()+"\n");
            } catch (IOException ex) {
                System.out.println("error in log writing"+ex);
            }
            return false;
        }
        return true;
    }
    int executeCountQuery(String query, boolean type
                ) {
            ResultSet rslt;
            try {
                rslt = runSqlQuery(query, con,type);
                rslt.next();
//                System.out.println("executCountQuery is"+rslt.getObject(1));
                 return Integer.parseInt((rslt.getObject(1).toString()));
            } catch (Exception e) {
                 System.out.println(e);
                return 0;
            }
    }
    public static void main(String[] args) {
        // TODO Auto-generated method stub
    	try {
        MysqlConnector us = new MysqlConnector();
        System.out.print("MysqlConnector is:"+us);
        Connection con = us.getDbConnection("root", "123456", "3306",
                                            "localhost",
                                            "actiontracking");
//        us.makeConnection("root", "123465", "3306",
//                                            "localhost",
//                                            "actiontracking",null);
        System.out.print("connection done successfuly");
        System.out.println(us.executeQuery("select * from manager",true));
     //   Connection con=us.con;
        System.out.print("successfull connection stabilished");
        
            ResultSet rslt = us.runSqlQuery("select * from manager",
                                        con,true);
            System.out.print("result is prepared\n");
            rslt.next();
            System.out.println(rslt.getObject(4));
        con.close();
        } 
    	catch (SQLException e) {
            // TODO Auto-generated catch block
            //e.printStackTrace();
            System.out.print(e);
        }
        //Users usr=new Users(con);
//		Stationaries st=new Stationaries(con);
//		st.insert("ketab", "amir kabir", 2000, 50, "ketabe khobie");
        //System.out.println(usr.insert("Meisam", "Hejazi nia","meisam","mbh",2000,"meysam@yahoo.com",'M',
        //		"tehran","4416",'Y',"","2007-01-27","2007-03-27","2007-01-27"));
        //System.out.println(usr.update(1, "L_NAME='HOSSEINI JAN'"));
    }

}
