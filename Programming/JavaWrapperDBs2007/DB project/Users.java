package jdbcMySql;

import java.sql.Connection;

public class Users {
	private Connection mySql = null;

	private MySqlConnector msc = null;

	public Users(Connection mySql) {
		this.mySql = mySql;
		msc = new MySqlConnector();
	}
	/**
	 * 
	 * @param id
	 * @param name
	 * @param l_name
	 * @param password
	 * @param deposit
	 * @param email
	 * @param gender
	 * @param address
	 * @param tel
	 * @param isactive
	 * @param description
	 * @param createdDate
	 * @param expirationDate
	 * @param modifiedDate
	 * @param type
	 * @return 0 if no rows inserted or row counter that means number of inserted rows.
	 */
	protected int insert(String name,String l_name,String userName,
			String password,double deposit,String email,char gender,
			String address,String tel,char isactive,String description,
			String createdDate,String expirationDate,String modifiedDate,int type){
		String sql="INSERT INTO USERS VALUES (NULL,'"+name+"','"+l_name+"','"+userName+"','"+password;
		sql+="','"+deposit+"','"+email+"','"+gender+"','"+address+"','"+tel+"','"+isactive+"','"+description;
		sql+="','"+createdDate+"','"+expirationDate+"','"+modifiedDate+"','"+type+"')";	
		int test=msc.runSqlDDL(sql, mySql);
		return test;
	}
	/**
	 * @param id : record id(primary key) that you want to be updated.
	 * @param setClause : fields that you want to be updated with related values.
	 * @see UPDATE users SET NAME='Mani',USERNAME='MBH' WHERE (ID=1);
	 * @return number of updated rows.
	 */
	protected int update(int id,String setClause){
		//UPDATE `users` SET `NAME`='Mani',`USERNAME`='MBH' WHERE (`ID`='1')    
		String sql="UPDATE USERS SET "+setClause+ " WHERE (ID="+id+")";
		int test=msc.runSqlDDL(sql, mySql);
		return test;
	}
	/**
	 * @param clause : only the where clause of delete statement like "ID=1 AND NAME='MANI'".
	 * @return number of deleted rows.
	 */
	protected int delete(String clause){
		//DELETE FROM USERS WHERE (ID=1)    
		String sql="DELETE FROM USERS WHERE ("+clause+")";
		int test=msc.runSqlDDL(sql, mySql);
		return test;
	}	
}
