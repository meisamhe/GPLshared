package jdbcMySql;

import java.sql.Connection;

import com.mysql.jdbc.Blob;

public class Books {

	private Connection mySql = null;

	private MySqlConnector msc = null;

	public Books(Connection mySql) {
		this.mySql = mySql;
		msc = new MySqlConnector();
	}
	/**
	 * @param userId
	 * @param orderDate
	 * @param issueDate
	 * @param isAccepted
	 * @param description
	 * @return 0 if no rows inserted or row counter that means number of inserted rows.
	 */
	protected int insert(int userId,String orderDate,
			String issueDate,char isAccepted,String description){
		String sql="INSERT INTO CDS VALUES(NULL,'"+userId+"','"+orderDate;
		sql+="','"+issueDate+"','"+isAccepted+"','"+description+")";	
		int test=msc.runSqlDDL(sql, mySql);
		return test;
	}
}
