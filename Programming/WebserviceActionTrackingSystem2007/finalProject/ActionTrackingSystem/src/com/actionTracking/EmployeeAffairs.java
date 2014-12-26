package com.actionTracking;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import com.actionTracking.MysqlConnector;

public class EmployeeAffairs {

	String username;
	String password;
	String ip;
	String port;
	String DBName;

	void setUsername(String username) {
		this.username = username;
	}

	String getUserName() {
		return username;
	}

	void setPassword(String password) {
		this.password = password;
	}

	String getPassword() {
		return password;
	}

	void setIp(String ip) {
		this.ip = ip;
	}

	String getIp() {
		return ip;
	}

	void setPort(String port) {
		this.port = port;
	}

	String getPort() {
		return port;
	}

	void setDBName(String DBName) {
		this.DBName = DBName;
	}

	String getDBName() {
		return DBName;
	}

	EmployeeAffairs(String username, String password, String ip, String port,
			String DBName) {

		setUsername(username);
		setPassword(password);
		setIp(ip);
		setPort(port);
		setDBName(DBName);

	}

	String defineEmployee(String name, String family, String user,
			String password, String department, String location) {
		if (checkUsername(user, "employee") == false)
			return "Creation fails beacause of redundancy in userName";
		MysqlConnector con = new MysqlConnector();
		Connection connection = con.getDbConnection(username, this.password,
				port, ip, DBName);
		try {
			String getDepartment = "select id from department where name='"
					+ department + "' AND location='" + location + "'";
			ResultSet rslt = con.runSqlQuery(getDepartment, connection, true);
			long departmentID;
			if (department.compareTo("organization") == 0)
				departmentID = 0;
			else {
				if (!rslt.next()) {
					connection.close();
					return "Creation fails because not having depatment defined";
				}
				departmentID = (Long) rslt.getObject(1);
			}
			 String select = "select id from manager where departmentID="
			 + departmentID;
			 System.out.print("before resut");
			 rslt = con.runSqlQuery(select, connection, true);
			 if (!rslt.next()) {
			 connection.close();
			 return "Creation fails beacause of not having manager defined for department";
			 }
			 long managerID = (Long) rslt.getObject(1);
			String insert = "insert into" + " employee(ID,Name,Family,"
					+ "User,Password,ManagerID) values (null,'" + name
					+ "','" + family + "','" + user + "','" + password + "',"
					+ managerID + ")";
			con.runUpdateQuery(insert, connection, true);
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "creation failed because of error in db";
		}
		return "creation successful";
	}

	String deleteEmployee(String user) {
		MysqlConnector con = new MysqlConnector();
		Connection connection = con.getDbConnection(username, password, port,
				ip, DBName);
		try {
			String select = "select id from employee where user= '" + user
					+ "'";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next())
				return "Deletion failes because of not having this employee Defined";
			String update = "UPDATE employee SET managerID=" + (9999999)
					+ " WHERE user='" +user+ "'";
			con.runUpdateQuery(update, connection, true);
			connection.close();

		} catch (SQLException e) {
			e.printStackTrace();
			return "Deletion was not successful because of db error";
		}
		return "deletion was successful";
	}

	String defineManager(String name, String family, String user,
			String password, String department,String departmentLocation) {
		MysqlConnector con = new MysqlConnector();
		if (checkUsername(user, "manager") == false) {
			return "Creation fails because of redundancy in userName";
		}
		Connection connection = con.getDbConnection(username, this.password,
				port, ip, DBName);
		long departmentID = 0;
		if (department.compareTo("organization") == 0)
			departmentID = 0;
		else {
			try {
				String select = "select id from department where name='"
						+ department + "' and location='"+departmentLocation+"'";
				ResultSet rslt = con.runSqlQuery(select, connection, true);
				if (!rslt.next())
					return "Creation fails because of not having department defined!";
				departmentID = (Long) rslt.getObject(1);

			} catch (SQLException e) {
				e.printStackTrace();
				return "Creation fails because of database error";
			}
		}
		// we have departementIDNow
		try {
			long upperDepartmentID;
			if (department.compareTo("organization") == 0)
				upperDepartmentID = 0;
			else {
				String select = "select departmentID from department where id="+departmentID;
				ResultSet rslt = con.runSqlQuery(select, connection, true);
				if (!rslt.next())
					return "Creation fails because of not having upper department defined!";
				upperDepartmentID = (Long) rslt.getObject(1);
			}
			String select = "select id from manager where departmentID= '"
					+ upperDepartmentID + "'";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			long managerID;
			if (department.compareTo("organization") == 0)
				managerID = 0;
			else if (!rslt.next())
				return "Creation failes because of not having upper manager Defined";
			else {
				managerID = (Long) rslt.getObject(1);
			}
			String insert = "insert into"
					+ " manager(ID,Name,Family,User,Password,managerID,departmentID)"
					+ " values (null,'" + name + "','" + family + "','" + user
					+ "','" + password + "'," + managerID + "," + departmentID
					+ ")";
			con.runUpdateQuery(insert, connection, true);
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return "Creation fails because of database error";
		}
		return "Creation done successfuly";
	}

	String defineDepartment(String name, String location,
			String upperDepartmentName, String upperDepartmentLocation) {
		MysqlConnector con = new MysqlConnector();
		Connection connection = con.getDbConnection(username, password, port,
				ip, DBName);
		try {
			String select = "select id from department where name='" + name
					+ "' AND location='" + location + "'";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (rslt.next()) {
				connection.close();
				return "Creation of Depatment failed because of redundancy";
			}
			long departmentID = 0;
			if (upperDepartmentName.compareTo("organization") == 0)
				departmentID = 0;
			else {
				try {
					select = "select departmentID from department where id="+departmentID;
					rslt = con.runSqlQuery(select, connection, true);
					if (!rslt.next()) {
						connection.close();
						System.out.print("Creation of Depatment failed because of no upper"
								+ "department is defined");
						return "Creation of Depatment failed because of no uppder"
								+ "department is defined";
					}
					departmentID = (Long) rslt.getObject(1);
					System.out.print(select);
					System.out.print(departmentID);

				} catch (SQLException e) {
					e.printStackTrace();
					return "Creation failed because of Database error";
				}
			}
			String insert = "insert into" + " department(ID,Name,"
					+ "location,DepartmentID) values (null,'" + name + "','"
					+ location + "'," + departmentID + ")";
			con.runUpdateQuery(insert, connection, true);
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return "Creation failed because of Database error";
		}
		return "creation done successfuly";
	}

	String replaceEmployee(String user, String secondName, String secondFamily,
			String secondUser, String secondPassword) {
		MysqlConnector con = new MysqlConnector();
		if (checkUsername(secondUser, "employee") == false)
			return "Replacement failes because of redundancy in userName";
		Connection connection = con.getDbConnection(username, password, port,
				ip, DBName);
		try {
			String select = "select id from employee where user= '" + user
					+ "'";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next())
				return "Replacement failes because of not having this employee Defined";
			String update = "UPDATE employee SET name='" + secondName
					+ "' , family='" + secondFamily + "' , User='" + secondUser
					+ "' , password='" + secondPassword + "' WHERE user='"+user
					+ "'";
			con.runUpdateQuery(update, connection, true);
			connection.close();

		} catch (SQLException e) {
			e.printStackTrace();
			return "Replacement failes because of error in db";
		}
		return "Replacement done successfuly";
	}

	String replaceManager(String user, String secondName, String secondFamily,
			String secondUser, String secondPassword) {
		MysqlConnector con = new MysqlConnector();
		if (checkUsername(secondUser, "manager") == false)
			return "Replacement failes because of redundancy in username";
		Connection connection = con.getDbConnection(username, password, port,
				ip, DBName);
		try {
			String select = "select id from manager where user= '" + user + "'";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next())
				return "Replacement failes because of not having this manager Defined";
			String update = "UPDATE manager SET name='" + secondName
					+ "', family='" + secondFamily + "', User='" + secondUser
					+ "', password='" + secondPassword + "' WHERE user='"
					+ user + "'";
			con.runUpdateQuery(update, connection, true);
			connection.close();

		} catch (SQLException e) {
			e.printStackTrace();
			return "Replacement failes bacause of error in db";
		}
		return "Repleacement done successfully";
	}

	private boolean checkUsername(String user, String table) {
		boolean sw = false;
		try {
			MysqlConnector con = new MysqlConnector();
			Connection connection = con.getDbConnection(username, password,
					port, ip, DBName);
			String select = "select id from " + table + " where User='" + user
					+ "'";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next())
				sw = true;
			else
				sw = false;
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return sw;
	}

	private boolean authenticate(String user, String password, String table) {
		try {
			MysqlConnector con = new MysqlConnector();
			Connection connection = con.getDbConnection(username,
					this.password, port, ip, DBName);
			String select = "select password from " + table + " where user='"
					+ user + "'";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (rslt.next()) {
				if (((String) rslt.getObject(1)).compareTo(password) == 0) {
					connection.close();
					return true;
				}
			}
			connection.close();
			return false;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	boolean authenticateManager(String user, String password) {
		return authenticate(user, password, "manager");
	}

	boolean authenticateEmployee(String user, String password) {
		return authenticate(user, password, "employee");
	}
	
	boolean authenticateUser(String user,String password){
		try {
			MysqlConnector con = new MysqlConnector();
			Connection connection = con.getDbConnection(username,
					this.password, port, ip, DBName);
			String select = "select password from users where user='"
					+ user + "'";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (rslt.next()) {
				if (((String) rslt.getObject(1)).compareTo(password) == 0) {
					connection.close();
					return true;
				}
			}
			connection.close();
			return false;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	// these function will return ID
	private long getManagerID(String user, String table) {
		try {
			MysqlConnector con = new MysqlConnector();
			Connection connection = con.getDbConnection(username, password,
					port, ip, DBName);
			String select = "select managerID from " + table + " where user='"
					+ user + "'";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return -1;
			}
			long managerID = (Long) rslt.getObject(1);
			connection.close();
			return managerID;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}

	private long getID(String user, String table) {
		try {
			MysqlConnector con = new MysqlConnector();
			Connection connection = con.getDbConnection(username, password,
					port, ip, DBName);
			String select = "select ID from " + table + " where user='" + user
					+ "'";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return -1;
			}
			long ID = (Long) rslt.getObject(1);
			connection.close();
			return ID;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;

	}

	long getIDOfPerson(String user, String type) {
		if (type.compareTo("manager") == 0)
			return getIDOfManager(user);
		else
			return getIDOfEmployee(user);
	}

	long getManagerIDOfManager(String user) {
		return getManagerID(user, "manager");
	}

	long getIDOfManager(String user) {
		return getID(user, "manager");
	}

	long getManagerIDOfEmployee(String user) {
		return getManagerID(user, "employee");
	}

	long getIDOfEmployee(String user) {
		return getID(user, "employee");
	}

	// String getEmployeeName(long employeeID, String type) {
	// try {
	// MysqlConnector con = new MysqlConnector();
	// Connection connection = con.getDbConnection(username, password,
	// port, ip, DBName);
	// String select = "select name,family from " + type + " where id= "
	// + employeeID;
	// ResultSet rslt = con.runSqlQuery(select, connection, true);
	// if (!rslt.next())
	// return null;
	// String name = (String) rslt.getObject(2) + " "
	// + (String) rslt.getObject(3);
	// connection.close();
	// return name;
	// } catch (SQLException e) {
	// e.printStackTrace();
	// }
	// return null;
	// }

	Person getEmployee(long employeeID, String type) {
		try {
			MysqlConnector con = new MysqlConnector();
			Connection connection = con.getDbConnection(username, password,
					port, ip, DBName);
			String select;
			if (type.equals("manager")) {
				select = "select " + type + ".name," + type
						+ ".family,department." + "name,department.location,"
						+ type + ".user" + " from " + type
						+ ",department where " + type
						+ ".departmentID=department.id AND " + type + ".id= "
						+ employeeID;
			} else {
				select = "select employee.name,employee.family,department.name,"
						+ "department.location,employee.user from employee,manager,department"
						+ " where employee.managerID=manager.id and manager.departmentID="
						+ "department.id and employee.id=" + employeeID;
			}
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next())
				return null;
			String name = (String) rslt.getObject(2) + " "
					+ (String) rslt.getObject(3);
			Person p = new Person((String) rslt.getObject(1), (String) rslt
					.getObject(2), (String) rslt.getObject(3), (String) rslt
					.getObject(4), type, (String) rslt.getObject(5));
			connection.close();
			return p;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	long getID(String requesterUser, String wantedUser, String type) {
		try {
			MysqlConnector con = new MysqlConnector();
			Connection connection = con.getDbConnection(username, password,
					port, ip, DBName);
			String select = "select ID from manager where user='"
					+ requesterUser + "'";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return -1;
			}
			long managerID = (Long) rslt.getObject(1);
			select = "select ID from " + type + " where user='" + wantedUser
					+ "' AND managerID=" + managerID;
			rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return -1;
			}
			long ID = (Long) rslt.getObject(1);
			connection.close();
			return ID;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}

	long getDepartmentID(String name, String location) {
		try {
			MysqlConnector con = new MysqlConnector();
			Connection connection = con.getDbConnection(username, password,
					port, ip, DBName);
			String select = "select ID from department where name='" + name + "'"
					+ " and location='" + location + "'";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return -1;
			}
			long ID = (Long) rslt.getObject(1);
			connection.close();
			return ID;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}

	String defineUser(String user, String password, String type) {
		MysqlConnector con = new MysqlConnector();
		Connection connection = con.getDbConnection(username, this.password, port,
				ip, DBName);
		try {
			String select = "select user from users where users='" + user + "'";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (rslt.next()) {
				connection.close();
				return "Creation of user failed because of redundancy";
			}
			
			String insert = "insert into users(id,user,type,password) values (null,'" +
					user+"','"+type+"','"+password+"')";
			con.runUpdateQuery(insert, connection, true);
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return "Creation failed because of Database error";
		}
		return "creation done successfuly";
	}
	String changePassowrd(String user,String type,String newPassword) {
		MysqlConnector con = new MysqlConnector();
		Connection connection = con.getDbConnection(username, password, port,
				ip, DBName);
		try {
			if (type.equals("finance")||type.equals("HR"))
				type="users";
			String update = "UPDATE "+type+" SET password='" + newPassword
					+ "' WHERE user='"
					+ user +"'";
			con.runUpdateQuery(update, connection, true);
			connection.close();

		} catch (SQLException e) {
			e.printStackTrace();
			return "Replacement failes bacause of error in db";
		}
		return "Repleacement done successfully";
	}
}
