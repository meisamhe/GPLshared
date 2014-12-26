package com.actionTracking;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

public class reportGenerator {
	String username;
	String password;
	String Ip;
	String port;
	String DBName;
	MysqlConnector con;

	reportGenerator(String username, String password, String Ip, String port,
			String DBName) {
		this.con = new MysqlConnector();
		this.username = username;
		this.password = password;
		this.Ip = Ip;
		this.port = port;
		this.DBName = DBName;

	}

	Activity[] uncompletedActivityUntilDateOfSpecialPerson(long employeeID,
			String type, long date) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "select * from Activity where " + "type='" + type
					+ "' AND employeeID=" + employeeID
					+ " AND state>=0 AND state<100" + " AND deadline<=" + date;
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return null;
			}
			Vector<Activity> v = new Vector<Activity>();
			Activity a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2), (String) rslt
					.getObject(3), (String) rslt.getObject(4), (Long) rslt
					.getObject(5), (Long) rslt.getObject(6), (Long) rslt
					.getObject(7), (Long) rslt.getObject(8), (Long) rslt
					.getObject(9), new EmployeeAffairs(username, password, Ip,
					port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
			v.add(a);
			while (rslt.next()) {
				a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2), (String) rslt
						.getObject(3), (String) rslt.getObject(4), (Long) rslt
						.getObject(5), (Long) rslt.getObject(6), (Long) rslt
						.getObject(7), (Long) rslt.getObject(8), (Long) rslt
						.getObject(9), new EmployeeAffairs(username, password,
						Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
				v.add(a);
			}
			connection.close();
			Activity[] ActivityList = new Activity[v.size()];
			for (int i = 0; i < v.size(); i++) {
				ActivityList[i] = v.get(i);
			}
			return ActivityList;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	Activity[] uncompletedActivityUntilDateOfsubsidary(long managerID, long date) {
		// algorithm: first find all manager subsidary and add their activities
		// to
		// vector second find all employee of subsidary and add theri activities
		// also.
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			Activity a;
			Vector<Activity> v = null;
			String firstSelect = "select ID from manager where managerID="
					+ managerID;
			ResultSet firstrslt = con
					.runSqlQuery(firstSelect, connection, true);
			boolean sw = false;
			long employeeID;
			v = new Vector<Activity>();
			while (firstrslt.next()) {
				employeeID = (Long) firstrslt.getObject(1);
				String select = "select * from Activity where "
						+ "type='manager'" + " AND employeeID=" + employeeID
						+ " AND state>=0 AND state<100" + " AND deadline<="
						+ date+" and assignedBy<>"+employeeID;
				ResultSet rslt = con.runSqlQuery(select, connection, true);
				if (rslt.next()) {
					sw = true;
					a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2), (String) rslt
							.getObject(3), (String) rslt.getObject(4),
							(Long) rslt.getObject(5), (Long) rslt.getObject(6),
							(Long) rslt.getObject(7), (Long) rslt.getObject(8),
							(Long) rslt.getObject(9), new EmployeeAffairs(
									username, password, Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
					;
					v.add(a);
					while (rslt.next()) {
						a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2),
								(String) rslt.getObject(3), (String) rslt
										.getObject(4),
								(Long) rslt.getObject(5), (Long) rslt
										.getObject(6),
								(Long) rslt.getObject(7), (Long) rslt
										.getObject(8),
								(Long) rslt.getObject(9), new EmployeeAffairs(
										username, password, Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
						;
						v.add(a);
					}
				}
			}
			firstSelect = "select ID from employee where managerID="
					+ managerID;
			firstrslt = con.runSqlQuery(firstSelect, connection, true);
			while (firstrslt.next()) {
				employeeID = (Long) firstrslt.getObject(1);
				String select = "select * from Activity where "
						+ "type='employee'" + " AND employeeID=" + employeeID
						+ " AND state>=0 AND state<100" + " AND deadline<="
						+ date+" and assignedBy<>"+employeeID;
				ResultSet rslt = con.runSqlQuery(select, connection, true);
				if (rslt.next()) {
					sw = true;
					a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2), (String) rslt
							.getObject(3), (String) rslt.getObject(4),
							(Long) rslt.getObject(5), (Long) rslt.getObject(6),
							(Long) rslt.getObject(7), (Long) rslt.getObject(8),
							(Long) rslt.getObject(9), new EmployeeAffairs(
									username, password, Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
					;
					v.add(a);
					while (rslt.next()) {
						a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2),
								(String) rslt.getObject(3), (String) rslt
										.getObject(4),
								(Long) rslt.getObject(5), (Long) rslt
										.getObject(6),
								(Long) rslt.getObject(7), (Long) rslt
										.getObject(8),
								(Long) rslt.getObject(9), new EmployeeAffairs(
										username, password, Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
						;
						v.add(a);
					}
				}
			}
			if (sw == false) {// means that there is no element in vector
				connection.close();
				return null;
			}
			connection.close();
			Activity[] ActivityList = new Activity[v.size()];
			for (int i = 0; i < v.size(); i++) {
				ActivityList[i] = v.get(i);
			}
			return ActivityList;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}catch (Exception e){
			e.printStackTrace();
			return null;
		}
	}

	Activity[] completedActivityBetweenDatesEmployee(long employeeID,
			String type, long firstDate, long lastDate) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "select * from Activity where " + "type='" + type
					+ "' AND employeeID=" + employeeID + " AND state=100"
					+ " AND " + "deadline<=" + lastDate + " and deadline>="
					+ firstDate;
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return null;
			}
			Vector<Activity> v = new Vector<Activity>();
			Activity a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2), (String) rslt
					.getObject(3), (String) rslt.getObject(4), (Long) rslt
					.getObject(5), (Long) rslt.getObject(6), (Long) rslt
					.getObject(7), (Long) rslt.getObject(8), (Long) rslt
					.getObject(9), new EmployeeAffairs(username, password, Ip,
					port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
			;
			v.add(a);
			while (rslt.next()) {
				a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2), (String) rslt
						.getObject(3), (String) rslt.getObject(4), (Long) rslt
						.getObject(5), (Long) rslt.getObject(6), (Long) rslt
						.getObject(7), (Long) rslt.getObject(8), (Long) rslt
						.getObject(9), new EmployeeAffairs(username, password,
						Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
				;
				v.add(a);
			}
			connection.close();
			Activity[] ActivityList = new Activity[v.size()];
			for (int i = 0; i < v.size(); i++) {
				ActivityList[i] = v.get(i);
			}
			return ActivityList;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	Activity[] completedActivityTodaySubsidary(long managerID,
			long date) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			Activity a;
			Vector<Activity> v = null;
			String firstSelect = "select ID from manager where managerID="
					+ managerID;
			ResultSet firstrslt = con
					.runSqlQuery(firstSelect, connection, true);
			boolean sw = false;
			long employeeID;
			v = new Vector<Activity>();
			date=date-1;//yesterday finished
			while (firstrslt.next()) {
				employeeID = (Long) firstrslt.getObject(1);
				String select = "select * from Activity where "
						+ "type='manager'" + " AND employeeID=" + employeeID
						+ " AND state=100" + " AND " + "lastupdate=" + date
						+ " and state=" + 100;
				ResultSet rslt = con.runSqlQuery(select, connection, true);
				if (rslt.next()) {
					sw = true;
					a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2), (String) rslt
							.getObject(3), (String) rslt.getObject(4),
							(Long) rslt.getObject(5), (Long) rslt.getObject(6),
							(Long) rslt.getObject(7), (Long) rslt.getObject(8),
							(Long) rslt.getObject(9), new EmployeeAffairs(
									username, password, Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
					;
					v.add(a);
					while (rslt.next()) {
						a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2),
								(String) rslt.getObject(3), (String) rslt
										.getObject(4),
								(Long) rslt.getObject(5), (Long) rslt
										.getObject(6),
								(Long) rslt.getObject(7), (Long) rslt
										.getObject(8),
								(Long) rslt.getObject(9), new EmployeeAffairs(
										username, password, Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
						;
						v.add(a);
					}
				}
			}
			firstSelect = "select ID from employee where managerID="
					+ managerID;
			firstrslt = con.runSqlQuery(firstSelect, connection, true);
			while (firstrslt.next()) {
				employeeID = (Long) firstrslt.getObject(1);
				String select = "select * from Activity where "
						+ "type='employee'" + " AND employeeID=" + employeeID
						+ " AND state=100" + " AND " + "lastupdate=" + date
						+ " and state=" + 100;
				ResultSet rslt = con.runSqlQuery(select, connection, true);
				if (rslt.next()) {
					sw = true;
					a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2), (String) rslt
							.getObject(3), (String) rslt.getObject(4),
							(Long) rslt.getObject(5), (Long) rslt.getObject(6),
							(Long) rslt.getObject(7), (Long) rslt.getObject(8),
							(Long) rslt.getObject(9), new EmployeeAffairs(
									username, password, Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
					;
					v.add(a);
					while (rslt.next()) {
						a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2),
								(String) rslt.getObject(3), (String) rslt
										.getObject(4),
								(Long) rslt.getObject(5), (Long) rslt
										.getObject(6),
								(Long) rslt.getObject(7), (Long) rslt
										.getObject(8),
								(Long) rslt.getObject(9), new EmployeeAffairs(
										username, password, Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
						;
						v.add(a);
					}
				}
			}
			if (sw == false) {// means that there is no element in vector
				connection.close();
				return null;
			}
			connection.close();
			Activity[] ActivityList = new Activity[v.size()];
			for (int i = 0; i < v.size(); i++) {
				ActivityList[i] = v.get(i);
			}
			return ActivityList;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	Activity[] completedActivityBetweenDatesSubsidary(long managerID,
			long firstDate, long lastDate) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			Activity a;
			Vector<Activity> v = null;
			String firstSelect = "select ID from manager where managerID="
					+ managerID;
			ResultSet firstrslt = con
					.runSqlQuery(firstSelect, connection, true);
			boolean sw = false;
			long employeeID;
			v = new Vector<Activity>();
			while (firstrslt.next()) {
				employeeID = (Long) firstrslt.getObject(1);
				String select = "select * from Activity where "
						+ "type='manager'" + " AND employeeID=" + employeeID
						+ " AND state=100" + " AND " + "deadline<=" + lastDate
						+ " and deadline>=" + firstDate+" and assignedBy<>"+employeeID;;
				ResultSet rslt = con.runSqlQuery(select, connection, true);
				if (rslt.next()) {
					sw = true;
					a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2), (String) rslt
							.getObject(3), (String) rslt.getObject(4),
							(Long) rslt.getObject(5), (Long) rslt.getObject(6),
							(Long) rslt.getObject(7), (Long) rslt.getObject(8),
							(Long) rslt.getObject(9), new EmployeeAffairs(
									username, password, Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
					;
					v.add(a);
					while (rslt.next()) {
						a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2),
								(String) rslt.getObject(3), (String) rslt
										.getObject(4),
								(Long) rslt.getObject(5), (Long) rslt
										.getObject(6),
								(Long) rslt.getObject(7), (Long) rslt
										.getObject(8),
								(Long) rslt.getObject(9), new EmployeeAffairs(
										username, password, Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
						;
						v.add(a);
					}
				}
			}
			firstSelect = "select ID from employee where managerID="
					+ managerID;
			firstrslt = con.runSqlQuery(firstSelect, connection, true);
			while (firstrslt.next()) {
				employeeID = (Long) firstrslt.getObject(1);
				String select = "select * from Activity where "
						+ "type='employee'" + " AND employeeID=" + employeeID
						+ " AND state=100" + " AND " + "deadline<=" + lastDate
						+ " and deadline>=" + firstDate+" and assignedBy<>"+employeeID;;
				ResultSet rslt = con.runSqlQuery(select, connection, true);
				if (rslt.next()) {
					sw = true;
					a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2), (String) rslt
							.getObject(3), (String) rslt.getObject(4),
							(Long) rslt.getObject(5), (Long) rslt.getObject(6),
							(Long) rslt.getObject(7), (Long) rslt.getObject(8),
							(Long) rslt.getObject(9), new EmployeeAffairs(
									username, password, Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
					;
					v.add(a);
					while (rslt.next()) {
						a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2),
								(String) rslt.getObject(3), (String) rslt
										.getObject(4),
								(Long) rslt.getObject(5), (Long) rslt
										.getObject(6),
								(Long) rslt.getObject(7), (Long) rslt
										.getObject(8),
								(Long) rslt.getObject(9), new EmployeeAffairs(
										username, password, Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
						;
						v.add(a);
					}
				}
			}
			if (sw == false) {// means that there is no element in vector
				connection.close();
				return null;
			}
			connection.close();
			Activity[] ActivityList = new Activity[v.size()];
			for (int i = 0; i < v.size(); i++) {
				ActivityList[i] = v.get(i);
			}
			return ActivityList;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	Activity[] unCompletedActivityBetweenDatesEmployee(long employeeID,
			String type, long firstDate, long lastDate) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "select * from Activity where " + "type='" + type
					+ "' AND employeeID=" + employeeID
					+ " AND state<100 AND state>=0" + " AND " + "deadline<="
					+ lastDate + " and deadline>=" + firstDate;
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return null;
			}
			Vector<Activity> v = new Vector<Activity>();
			Activity a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2), (String) rslt
					.getObject(3), (String) rslt.getObject(4), (Long) rslt
					.getObject(5), (Long) rslt.getObject(6), (Long) rslt
					.getObject(7), (Long) rslt.getObject(8), (Long) rslt
					.getObject(9), new EmployeeAffairs(username, password, Ip,
					port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
			;
			v.add(a);
			while (rslt.next()) {
				a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2), (String) rslt
						.getObject(3), (String) rslt.getObject(4), (Long) rslt
						.getObject(5), (Long) rslt.getObject(6), (Long) rslt
						.getObject(7), (Long) rslt.getObject(8), (Long) rslt
						.getObject(9), new EmployeeAffairs(username, password,
						Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
				;
				v.add(a);
			}
			connection.close();
			Activity[] ActivityList = new Activity[v.size()];
			for (int i = 0; i < v.size(); i++) {
				ActivityList[i] = v.get(i);
			}
			return ActivityList;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	Activity[] unCompletedActivityBetweenDatesSubsidary(long managerID,
			long firstDate, long lastDate) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			Activity a;
			Vector<Activity> v = null;
			String firstSelect = "select ID from manager where managerID="
					+ managerID;
			ResultSet firstrslt = con
					.runSqlQuery(firstSelect, connection, true);
			boolean sw = false;
			long employeeID;
			v = new Vector<Activity>();
			while (firstrslt.next()) {
				employeeID = (Long) firstrslt.getObject(1);
				String select = "select * from Activity where "
						+ "type='manager'" + " AND employeeID=" + employeeID
						+ " AND state<100 AND state>=0" + " AND "
						+ "deadline<=" + lastDate + " and deadline>="
						+ firstDate+" and assignedBy<>"+employeeID;;
				ResultSet rslt = con.runSqlQuery(select, connection, true);
				if (rslt.next()) {
					sw = true;
					a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2), (String) rslt
							.getObject(3), (String) rslt.getObject(4),
							(Long) rslt.getObject(5), (Long) rslt.getObject(6),
							(Long) rslt.getObject(7), (Long) rslt.getObject(8),
							(Long) rslt.getObject(9), new EmployeeAffairs(
									username, password, Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
					;
					v.add(a);
					while (rslt.next()) {
						a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2),
								(String) rslt.getObject(3), (String) rslt
										.getObject(4),
								(Long) rslt.getObject(5), (Long) rslt
										.getObject(6),
								(Long) rslt.getObject(7), (Long) rslt
										.getObject(8),
								(Long) rslt.getObject(9), new EmployeeAffairs(
										username, password, Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
						;
						v.add(a);
					}
				}
			}
			firstSelect = "select ID from employee where managerID="
					+ managerID;
			firstrslt = con.runSqlQuery(firstSelect, connection, true);
			while (firstrslt.next()) {
				employeeID = (Long) firstrslt.getObject(1);
				String select = "select * from Activity where "
						+ "type='employee'" + " AND employeeID=" + employeeID
						+ " AND state<100 AND state>=0" + " AND "
						+ "deadline<=" + lastDate + " and deadline>="
						+ firstDate+" and assignedBy<>"+employeeID;;
				ResultSet rslt = con.runSqlQuery(select, connection, true);
				if (rslt.next()) {
					sw = true;
					a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2), (String) rslt
							.getObject(3), (String) rslt.getObject(4),
							(Long) rslt.getObject(5), (Long) rslt.getObject(6),
							(Long) rslt.getObject(7), (Long) rslt.getObject(8),
							(Long) rslt.getObject(9), new EmployeeAffairs(
									username, password, Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
					;
					v.add(a);
					while (rslt.next()) {
						a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2),
								(String) rslt.getObject(3), (String) rslt
										.getObject(4),
								(Long) rslt.getObject(5), (Long) rslt
										.getObject(6),
								(Long) rslt.getObject(7), (Long) rslt
										.getObject(8),
								(Long) rslt.getObject(9), new EmployeeAffairs(
										username, password, Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
						;
						v.add(a);
					}
				}
			}
			if (sw == false) {// means that there is no element in vector
				connection.close();
				return null;
			}
			connection.close();
			Activity[] ActivityList = new Activity[v.size()];
			for (int i = 0; i < v.size(); i++) {
				ActivityList[i] = v.get(i);
			}
			return ActivityList;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	Activity[] allActivityBetweenDatesEmployee(long employeeID, String type,
			long firstDate, long lastDate) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "select * from Activity where " + "type='" + type
					+ "' AND employeeID=" + employeeID + " AND " + "deadline<="
					+ lastDate + " and deadline>=" + firstDate;
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return null;
			}
			Vector<Activity> v = new Vector<Activity>();
			Activity a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2), (String) rslt
					.getObject(3), (String) rslt.getObject(4), (Long) rslt
					.getObject(5), (Long) rslt.getObject(6), (Long) rslt
					.getObject(7), (Long) rslt.getObject(8), (Long) rslt
					.getObject(9), new EmployeeAffairs(username, password, Ip,
					port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
			;
			v.add(a);
			while (rslt.next()) {
				a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2), (String) rslt
						.getObject(3), (String) rslt.getObject(4), (Long) rslt
						.getObject(5), (Long) rslt.getObject(6), (Long) rslt
						.getObject(7), (Long) rslt.getObject(8), (Long) rslt
						.getObject(9), new EmployeeAffairs(username, password,
						Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
				;
				v.add(a);
			}
			connection.close();
			Activity[] ActivityList = new Activity[v.size()];
			for (int i = 0; i < v.size(); i++) {
				ActivityList[i] = v.get(i);
			}
			return ActivityList;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	Activity[] allActivityBetweenDatesSubsidary(long managerID, long firstDate,
			long lastDate) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			Activity a;
			Vector<Activity> v = null;
			String firstSelect = "select ID from manager where managerID="
					+ managerID;
			ResultSet firstrslt = con
					.runSqlQuery(firstSelect, connection, true);
			boolean sw = false;
			long employeeID;
			v = new Vector<Activity>();
			while (firstrslt.next()) {
				employeeID = (Long) firstrslt.getObject(1);
				String select = "select * from Activity where "
						+ "type='manager'" + " AND employeeID=" + employeeID
						+ " AND " + "deadline<=" + lastDate + " and deadline>="
						+ firstDate+" and assignedBy<>"+employeeID;;
				ResultSet rslt = con.runSqlQuery(select, connection, true);
				if (rslt.next()) {
					sw = true;
					a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2), (String) rslt
							.getObject(3), (String) rslt.getObject(4),
							(Long) rslt.getObject(5), (Long) rslt.getObject(6),
							(Long) rslt.getObject(7), (Long) rslt.getObject(8),
							(Long) rslt.getObject(9), new EmployeeAffairs(
									username, password, Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
					;
					v.add(a);
					while (rslt.next()) {
						a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2),
								(String) rslt.getObject(3), (String) rslt
										.getObject(4),
								(Long) rslt.getObject(5), (Long) rslt
										.getObject(6),
								(Long) rslt.getObject(7), (Long) rslt
										.getObject(8),
								(Long) rslt.getObject(9), new EmployeeAffairs(
										username, password, Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
						;
						v.add(a);
					}
				}
			}
			firstSelect = "select ID from employee where managerID="
					+ managerID;
			firstrslt = con.runSqlQuery(firstSelect, connection, true);
			while (firstrslt.next()) {
				employeeID = (Long) firstrslt.getObject(1);
				String select = "select * from Activity where "
						+ "type='employee'" + " AND employeeID=" + employeeID
						+ " AND " + "deadline<=" + lastDate + " and deadline>="
						+ firstDate+" and assignedBy<>"+employeeID;;
				ResultSet rslt = con.runSqlQuery(select, connection, true);
				if (rslt.next()) {
					sw = true;
					a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2), (String) rslt
							.getObject(3), (String) rslt.getObject(4),
							(Long) rslt.getObject(5), (Long) rslt.getObject(6),
							(Long) rslt.getObject(7), (Long) rslt.getObject(8),
							(Long) rslt.getObject(9), new EmployeeAffairs(
									username, password, Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
					;
					v.add(a);
					while (rslt.next()) {
						a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2),
								(String) rslt.getObject(3), (String) rslt
										.getObject(4),
								(Long) rslt.getObject(5), (Long) rslt
										.getObject(6),
								(Long) rslt.getObject(7), (Long) rslt
										.getObject(8),
								(Long) rslt.getObject(9), new EmployeeAffairs(
										username, password, Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
						;
						v.add(a);
					}
				}
			}
			if (sw == false)// means that there is no element in vector
				return null;
			connection.close();
			Activity[] ActivityList = new Activity[v.size()];
			for (int i = 0; i < v.size(); i++) {
				ActivityList[i] = v.get(i);
			}
			return ActivityList;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	Person[] getPersonel(String type, long department) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select;
			select = "select " + type + ".name," + type
					+ ".family,department.name,department.location," +type+".user"+
							" from " + type
					+ ",manager m,department where " + type
					+ ".managerID=m.id AND m."
					+ "departmentID=department.ID AND department.ID="
					+ department;

			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return null;
			}
			Vector<Person> v = new Vector<Person>();
			Person p = new Person((String) rslt.getObject(1), (String) rslt
					.getObject(2), (String) rslt.getObject(3),(String)rslt.getObject(4), type,(String)rslt.getObject(5));
			v.add(p);
			while (rslt.next()) {
				p = new Person((String) rslt.getObject(1), (String) rslt
						.getObject(2), (String) rslt.getObject(3),(String)rslt.getObject(4), type,
						(String)rslt.getObject(5));
				v.add(p);
			}
			Person[] PersonList = new Person[v.size()];
			for (int i = 0; i < v.size(); i++) {
				PersonList[i] = v.get(i);
			}
			return PersonList;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	Person[] getSubsidaryPersonel(String type,long department) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String selectEmployee;
			boolean sw=false;// for checking if its null
				selectEmployee = "select employee.name,employee.family,department.name,department.location," +type+".user"+
						" from "+
			"employee,manager,department where employee.managerID=manager.id AND manager."+
			"departmentID=department.ID AND department.ID=";
			String selectManager;
				selectManager="select m.name,m.family,department.name,department.location," +type+".user"+
						" from "+
				"manager as m,"+type+",department where m.managerID="+type+".id AND m."+
				"departmentID=department.ID AND department.ID=";
			ResultSet rslt = con.runSqlQuery(selectEmployee+department, connection, true);
			Vector<Person> v=new Vector<Person>();
			if (!rslt.next()) {
				sw=true;
			}else{
			Person p=new Person((String)rslt.getObject(1),(String)rslt.getObject(2),
					(String)rslt.getObject(3),(String)rslt.getObject(4),"employee",(String)rslt.getObject(5));
			v.add(p);
			while(rslt.next()){
				p=new Person((String)rslt.getObject(1),(String)rslt.getObject(2),
						(String)rslt.getObject(3),(String)rslt.getObject(4),"employee",(String)rslt.getObject(5));
				v.add(p);
			}
			// all employee are added until now
			// now we select managers
			}
			ResultSet rslt1=con.runSqlQuery(selectManager+department, connection, true);
			if (!rslt1.next()) {
				if (sw==true)// means we have no manager and no employee
					return null;
				else{
					Person[] PersonList = new Person[v.size()];
					for (int i = 0; i < v.size(); i++) {
						PersonList[i] = v.get(i);
					}
					return PersonList;
				}
			}// to do selection according to the manager
			selectEmployee = "select employee.name,employee.family,department.name,department.location," +type+".user"+
					" from "+
			"employee,manager,department where employee.managerID=manager.id AND manager."+
			"id=";
			Person p1=new Person((String)rslt1.getObject(1),(String)rslt1.getObject(2),
					(String)rslt1.getObject(3),(String)rslt1.getObject(4),"manager",(String)rslt1.getObject(5));
			v.add(p1);
			while(rslt.next()){
				long managerID=(Long)rslt1.getObject(1);
				rslt = con.runSqlQuery(selectEmployee+managerID, connection, true);
				Person p=new Person((String)rslt.getObject(1),(String)rslt.getObject(2),
						(String)rslt.getObject(3),(String)rslt.getObject(4),"employee",(String)rslt.getObject(5));
				v.add(p);
				while(rslt.next()){
					p=new Person((String)rslt.getObject(1),(String)rslt.getObject(2),
							(String)rslt.getObject(3),(String)rslt.getObject(4),"employee",(String)rslt.getObject(5));
					v.add(p);
				}
				p=new Person((String)rslt1.getObject(2),(String)rslt1.getObject(2),
						(String)rslt1.getObject(3),(String)rslt1.getObject(4),"manager",(String)rslt1.getObject(5));
				v.add(p1);
			}
			Person[] PersonList = new Person[v.size()];
			for (int i = 0; i < v.size(); i++) {
				PersonList[i] = v.get(i);
			}
			return PersonList;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	Person[] getPersonel(String type) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select;
			if (type.compareTo("employee") == 0) {
				select = "select employee.name,employee"
						+ ".family,department.name,department.location," +
						"employee.user from employee"
						+ ",manager,department where employee"
						+ ".managerID=manager.id AND manager."
						+ "departmentID=department.ID";
			} else {
				select = "select manager.name,manager.family,department.name," +
						"department.location,manager.user"+
						" from"
						+ " manager,department where manager.departmentID=department.id";
			}
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return null;
			}
			Vector<Person> v = new Vector<Person>();
			Person p = new Person((String) rslt.getObject(1), (String) rslt
					.getObject(2), (String) rslt.getObject(3),
					(String)rslt.getObject(4), type,(String)rslt.getObject(5));
			v.add(p);
			while (rslt.next()) {
				p = new Person((String) rslt.getObject(1), (String) rslt
						.getObject(2), (String) rslt.getObject(3),(String)rslt.getObject(4), type,(String)rslt.getObject(5));
				v.add(p);
			}
			Person[] PersonList = new Person[v.size()];
			for (int i = 0; i < v.size(); i++) {
				PersonList[i] = v.get(i);
			}
			return PersonList;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	Person[] getPersonelWithName(String type, String name) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select;
			if (type.compareTo("employee") == 0) {
				select = "select employee.name,employee"
						+ ".family,department.name,department.location," +
						",employee.user from employee"
						+ ",manager,department where employee"
						+ ".managerID=manager.id AND manager."
						+ "departmentID=department.ID and (" + type
						+ ".name like '%" + name + "%' or "+ type
						+ ".family like '%" + name + "%')";
			} else {
				select = "select manager.name,manager.family,department.name," +
						"department.location,manager.user"+
						" from"
						+ " manager,department where manager.departmentID=department.id"
						+ " and ( manager.name like '%" + name + "%' or "+
						"manager.family like '%"+name+"%')";
			}

			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return null;
			}
			Vector<Person> v = new Vector<Person>();
			Person p = new Person((String) rslt.getObject(1), (String) rslt
					.getObject(2), (String) rslt.getObject(3),(String)rslt.getObject(4), type,(String)rslt.getObject(5));
			v.add(p);
			while (rslt.next()) {
				p = new Person((String) rslt.getObject(1), (String) rslt
						.getObject(2), (String) rslt.getObject(3),(String)rslt.getObject(4), type,(String)rslt.getObject(5));
				v.add(p);
			}
			Person[] PersonList = new Person[v.size()];
			for (int i = 0; i < v.size(); i++) {
				PersonList[i] = v.get(i);
			}
			return PersonList;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	Department[] getDepartments() {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "select name,location from department";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return null;
			}
			Vector<Department> v = new Vector<Department>();
			v.add(new Department((String) rslt.getObject(1),(String) rslt.getObject(2)));
			while (rslt.next()) {
				v.add(new Department((String) rslt.getObject(1),(String) rslt.getObject(2)));
			}
			Department[] DepartmentList = new Department[v.size()];
			for (int i = 0; i < v.size(); i++) {
				DepartmentList[i] = v.get(i);
			}
			return DepartmentList;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	Department[] getDepartmentsWithName(String name) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "select name,location from department where name"
					+ " like '%" + name + "%'";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return null;
			}
			Vector<Department> v = new Vector<Department>();
			v.add(new Department((String) rslt.getObject(1),(String) rslt.getObject(2)));
			while (rslt.next()) {
				v.add(new Department((String) rslt.getObject(1),(String) rslt.getObject(2)));
			}
			Department[] DepartmentList = new Department[v.size()];
			for (int i = 0; i < v.size(); i++) {
				DepartmentList[i] = v.get(i);
			}
			return DepartmentList;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	String[] getLocation() {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "select distinct location from department";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return null;
			}
			Vector<String> v = new Vector<String>();
			v.add((String) rslt.getObject(1));
			while (rslt.next()) {
				v.add((String) rslt.getObject(1));
			}
			String[] DepartmentList = new String[v.size()];
			for (int i = 0; i < v.size(); i++) {
				DepartmentList[i] = v.get(i);
			}
			return DepartmentList;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	String[] getLocationWithName(String name) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "select distinct location from department where name"
					+ " like '%" + name + "%'";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return null;
			}
			Vector<String> v = new Vector<String>();
			v.add((String) rslt.getObject(1));
			while (rslt.next()) {
				v.add((String) rslt.getObject(1));
			}
			String[] DepartmentList = new String[v.size()];
			for (int i = 0; i < v.size(); i++) {
				DepartmentList[i] = v.get(i);
			}
			return DepartmentList;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	Report[] viewReportOfActivity(long ActivityID) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "select * from report where " + "ActivityID="
					+ ActivityID;
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return null;
			}
			Vector<Report> v = new Vector<Report>();
			Report r = new Report((String) rslt.getObject(2), (String) rslt
					.getObject(5), (Long) rslt.getObject(3),(Long)rslt.getObject(6));
			v.add(r);
			while (rslt.next()) {
				r = new Report((String) rslt.getObject(2), (String) rslt
						.getObject(5), (Long) rslt.getObject(3),(Long)rslt.getObject(6));
				v.add(r);
			}
			connection.close();
			Report[] ReportList = new Report[v.size()];
			for (int i = 0; i < v.size(); i++) {
				ReportList[i] = v.get(i);
			}
			return ReportList;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	int getReportCountOfActivity(long ActivityID) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "select count(*) from report where "
					+ "ActivityID=" + ActivityID;
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return -1;
			}
			int count = (Integer) rslt.getObject(1);
			connection.close();
			return count;
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	Resource[] viewAvailableResource(String user){
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "SELECT resource.name,resource.place,sum(r.quantity) FROM " +
					"resource_need r,activity,resource,employee where activity.employeeId=1 and"+
			"activity.id=r.activityID and resource.id=r.resourceID " +
			"and employee.id=activity.employeeID  and activity.type='manager' and employee.user='"+user+
			"' group by resource.name,resource.place"
			;
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return null;
			}
			Vector<Resource> v = new Vector<Resource>();
			Resource r = new Resource((String) rslt.getObject(2), (String) rslt
					.getObject(3), (Long) rslt.getObject(4));
			v.add(r);
			while (rslt.next()) {
				r = new Resource((String) rslt.getObject(2), (String) rslt
						.getObject(3), (Long) rslt.getObject(4));
				v.add(r);
			}
			connection.close();
			Resource[] ResourceList = new Resource[v.size()];
			for (int i = 0; i < v.size(); i++) {
				ResourceList[i] = v.get(i);
			}
			return ResourceList;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
	}
	
	Resource[] viewUsedResource(String user){
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
		String select = "Select name,place,sum(quantity)"+
		"From(SELECT resource.name,resource.place,sum(r.quantity) as quantity"+
				"FROM resource_need r,activity,resource,employee,manager where activity.employeeId=1 and"+
				"activity.id=r.activityID and resource.id=r.resourceID and activity.type='employee'"+
				"and  employee.id=activity.employeeID and employee.managerID=manager.id"+
				 "and manager.user='"+user+"'"+
				"group by resource.name,resource.place"+
				"Union"+
				"SELECT resource.name,resource.place,sum(r.quantity) as quantity"+
				"FROM resource_need r,activity,resource,manager m,manager where activity.employeeId=1 and"+
				"activity.id=r.activityID and resource.id=r.resourceID and activity.type='manager'"+
				"and m.id=activity.employeeID and m.managerID=manager.id"+
				 "and manager.user='"+user+"'"+
				"group by resource.name,resource.place) d"+
				"group by name,place"
				;
		ResultSet rslt = con.runSqlQuery(select, connection, true);
		if (!rslt.next()) {
			connection.close();
			return null;
		}
		Vector<Resource> v = new Vector<Resource>();
		Resource r = new Resource((String) rslt.getObject(2), (String) rslt
				.getObject(3), (Long) rslt.getObject(4));
		v.add(r);
		while (rslt.next()) {
			r = new Resource((String) rslt.getObject(2), (String) rslt
					.getObject(3), (Long) rslt.getObject(4));
			v.add(r);
		}
		connection.close();
		Resource[] ResourceList = new Resource[v.size()];
		for (int i = 0; i < v.size(); i++) {
			ResourceList[i] = v.get(i);
		}
		return ResourceList;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	Resource[] viewResourceOfOrganization() {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "select * from resource";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return null;
			}
			Vector<Resource> v = new Vector<Resource>();
			Resource r = new Resource((String) rslt.getObject(2), (String) rslt
					.getObject(3), (Long) rslt.getObject(4));
			v.add(r);
			while (rslt.next()) {
				r = new Resource((String) rslt.getObject(2), (String) rslt
						.getObject(3), (Long) rslt.getObject(4));
				v.add(r);
			}
			connection.close();
			Resource[] ResourceList = new Resource[v.size()];
			for (int i = 0; i < v.size(); i++) {
				ResourceList[i] = v.get(i);
			}
			return ResourceList;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	Resource[] viewResourceOfActivity(long ActivityID) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "select resource.name,resource.place,resource_need.quantity"
					+ " from resource_need,resource where activityID="
					+ ActivityID + " and resource.id=resource_need.resourceID";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return null;
			}
			Vector<Resource> v = new Vector<Resource>();
			Resource r = new Resource((String) rslt.getObject(1), (String) rslt
					.getObject(2), (Long) rslt.getObject(3));
			v.add(r);
			while (rslt.next()) {
				r = new Resource((String) rslt.getObject(1), (String) rslt
						.getObject(2), (Long) rslt.getObject(3));
				v.add(r);
			}
			connection.close();
			Resource[] ResourceList = new Resource[v.size()];
			for (int i = 0; i < v.size(); i++) {
				ResourceList[i] = v.get(i);
			}
			return ResourceList;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	private boolean MiladiIsLeap(int miladiYear) {
		if (((miladiYear % 100) != 0 && (miladiYear % 4) == 0)
				|| ((miladiYear % 100) == 0 && (miladiYear % 400) == 0))
			return true;
		else
			return false;
	}

	ShamsiDate MiladiToShamsi(int iMiladiYear, int iMiladiMonth, int iMiladiDay) {

		int shamsiDay, shamsiMonth, shamsiYear;
		int dayCount, farvardinDayDiff, deyDayDiff;
		int sumDayMiladiMonth[] = { 0, 31, 59, 90, 120, 151, 181, 212, 243,
				273, 304, 334 };
		int sumDayMiladiMonthLeap[] = { 0, 31, 60, 91, 121, 152, 182, 213, 244,
				274, 305, 335 };

		farvardinDayDiff = 79;

		if (MiladiIsLeap(iMiladiYear)) {
			dayCount = sumDayMiladiMonthLeap[iMiladiMonth - 1] + iMiladiDay;
		} else {
			dayCount = sumDayMiladiMonth[iMiladiMonth - 1] + iMiladiDay;
		}
		if ((MiladiIsLeap(iMiladiYear - 1))) {
			deyDayDiff = 11;
		} else {
			deyDayDiff = 10;
		}
		if (dayCount > farvardinDayDiff) {
			dayCount = dayCount - farvardinDayDiff;
			if (dayCount <= 186) {
				switch (dayCount % 31) {
				case 0:
					shamsiMonth = dayCount / 31;
					shamsiDay = 31;
					break;
				default:
					shamsiMonth = (dayCount / 31) + 1;
					shamsiDay = (dayCount % 31);
					break;
				}
				shamsiYear = iMiladiYear - 621;
			} else {
				dayCount = dayCount - 186;
				switch (dayCount % 30) {
				case 0:
					shamsiMonth = (dayCount / 30) + 6;
					shamsiDay = 30;
					break;
				default:
					shamsiMonth = (dayCount / 30) + 7;
					shamsiDay = (dayCount % 30);
					break;
				}
				shamsiYear = iMiladiYear - 621;
			}
		} else {
			dayCount = dayCount + deyDayDiff;

			switch (dayCount % 30) {
			case 0:
				shamsiMonth = (dayCount / 30) + 9;
				shamsiDay = 30;
				break;
			default:
				shamsiMonth = (dayCount / 30) + 10;
				shamsiDay = (dayCount % 30);
				break;
			}
			shamsiYear = iMiladiYear - 622;

		}
		ShamsiDate s = new ShamsiDate(shamsiYear, shamsiMonth, shamsiDay);
		return s;
	}
	
	Activity[] getSubsidaryActivity(long activityID) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "select * from Activity where activityID="+activityID; 
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return null;
			}
			Vector<Activity> v = new Vector<Activity>();
			Activity a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2), (String) rslt
					.getObject(3), (String) rslt.getObject(4), (Long) rslt
					.getObject(5), (Long) rslt.getObject(6), (Long) rslt
					.getObject(7), (Long) rslt.getObject(8), (Long) rslt
					.getObject(9), new EmployeeAffairs(username, password, Ip,
					port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
			;
			v.add(a);
			while (rslt.next()) {
				a = new Activity((Long)rslt.getObject(1),(String) rslt.getObject(2), (String) rslt
						.getObject(3), (String) rslt.getObject(4), (Long) rslt
						.getObject(5), (Long) rslt.getObject(6), (Long) rslt
						.getObject(7), (Long) rslt.getObject(8), (Long) rslt
						.getObject(9), new EmployeeAffairs(username, password,
						Ip, port, DBName),(Long)rslt.getObject(10),(Long)rslt.getObject(11));
				;
				v.add(a);
			}
			connection.close();
			Activity[] ActivityList = new Activity[v.size()];
			for (int i = 0; i < v.size(); i++) {
				ActivityList[i] = v.get(i);
			}
			return ActivityList;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
}
