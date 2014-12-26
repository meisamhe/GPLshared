package jdbcMySql;

import java.io.File;
import java.sql.Connection;

import com.mysql.jdbc.Blob;

public class Cds {
	private Connection mySql = null;

	private MySqlConnector msc = null;

	public Cds(Connection mySql) {
		this.mySql = mySql;
		msc = new MySqlConnector();
	}
	/**
	 * @param title
	 * @param name
	 * @param publisher
	 * @param serialno
	 * @param picture
	 * @param price
	 * @param quantity
	 * @param description
	 * @return 0 if no rows inserted or row counter that means number of inserted rows.
	 */
	public int insert(String title,String name,
			String publisher,String serialno,Blob picture,
			double price,int quantity,String description){
		File fl=new File("c:\\img.bmp");

		String sql="INSERT INTO CDS VALUES(NULL,'"+title+"','"+name;
		sql+="','"+publisher+"','"+serialno+"',"+picture+"','"+price+"','"+quantity;
		sql+="','"+description+")";
		int test=msc.runSqlDDL(sql, mySql);
		return test;
	}
	/**
	 * @param id : record id(primary key) that you want to be updated.
	 * @param setClause : fields that you want to be updated with related values.
	 * @see UPDATE users SET NAME='Mani',USERNAME='MBH' WHERE (ID=1);
	 * @return number of updated rows.
	 */
	public int update(int id,String setClause){
		//UPDATE `users` SET `NAME`='Mani',`USERNAME`='MBH' WHERE (`ID`='1')
		String sql="UPDATE CDS SET "+setClause+ " WHERE (ID="+id+")";
		int test=msc.runSqlDDL(sql, mySql);
		return test;
	}
	/**
	 * @param clause : only the where clause of delete statement like "ID=1 AND NAME='MANI'".
	 * @return number of deleted rows.
	 */
	public int delete(String clause){
		//DELETE FROM USERS WHERE (ID=1)
		String sql="DELETE FROM CDS WHERE ("+clause+")";
		int test=msc.runSqlDDL(sql, mySql);
		return test;
	}
}

