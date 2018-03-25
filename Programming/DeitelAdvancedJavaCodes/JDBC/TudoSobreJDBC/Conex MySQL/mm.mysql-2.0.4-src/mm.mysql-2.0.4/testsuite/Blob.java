package testsuite;

/*
 * Blob.java
 *
 * Created on July 4, 2000, 8:49 AM
 */
 
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.DriverManager;


/** 
 *
 * @author  Administrator
 * @version 
 */
public class Blob extends Object {

   Connection Conn = null;
    ResultSet RS = null;
    Statement Stmt = null;

    static String DBUrl = "jdbc:mysql://192.168.1.1:3307/test?user=root&password=changeme";

    public static void main(String[] Args) throws Exception
    {
	Blob  B = new Blob();
    }

    public Blob() throws Exception
    {
	try {
	    Class.forName("org.gjt.mm.mysql.Driver").newInstance();
	    
	    Conn = DriverManager.getConnection(DBUrl);

	    Stmt = Conn.createStatement();

	    System.out.print("Create test data: ");
	    boolean create_ok = createTestData();
	    System.out.println(create_ok ? "passed" : "failed");
	}
	catch (SQLException E) {
	    throw E;
	}
	finally {
	    if (RS != null) {
		try {
		    RS.close();
		}
		catch (SQLException SQLE) {}
	    }
	    
	    if (Stmt != null) {
		try {
		    Stmt.close();
		}
		catch (SQLException SQLE) {}
	    }

	    if (Conn != null) {
		try {
		    Conn.close();
		}
		catch (SQLException SQLE) {}
	    }
	}
    }

    private boolean createTestData() throws java.sql.SQLException
    {
	try {
	    
	    //
	    // Catch the error, the table might exist
	    //
	    
	    try {
		Stmt.executeUpdate("DROP TABLE BLOBTEST");
	    }
	    catch (SQLException SQLE) {}
	    
	    Stmt.executeUpdate("CREATE TABLE BLOBTEST (pos int PRIMARY KEY, blobdata LONGBLOB)");
	    
            byte[] testBlob = new byte[128 * 1024]; // 128k blob
            
            int dataRange = Byte.MAX_VALUE - Byte.MIN_VALUE;
            
	    for (int i = 0; i < testBlob.length; i++) {
		testBlob[i] = (byte)((Math.random() * dataRange) + Byte.MIN_VALUE);
              }
              
              PreparedStatement pstmt = Conn.prepareStatement("INSERT INTO BLOBTEST(pos, blobdata) VALUES (1, ?)");
              
              pstmt.setBytes(1, testBlob);
              
              int rowsUpdated = pstmt.executeUpdate();
              
              System.out.println("Updated " + rowsUpdated + " row(s)");
              
              
                
            
	}
	catch (SQLException E) {
	    E.printStackTrace();
	    return false;
	}

	return true;
    }
  
}