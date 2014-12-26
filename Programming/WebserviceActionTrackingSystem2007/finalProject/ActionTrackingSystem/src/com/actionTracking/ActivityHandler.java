package com.actionTracking;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ActivityHandler {
	String username;
	String password;
	String Ip;
	String port;
	String DBName;
	MysqlConnector con;
	ActivityLogHandling log;

	public ActivityHandler(String username, String password, String Ip,
			String port, String DBName) {
		this.con = new MysqlConnector();
		this.username = username;
		this.password = password;
		this.Ip = Ip;
		this.port = port;
		this.DBName = DBName;
		this.log = new ActivityLogHandling(username, password, Ip, port, DBName);

	}

	String defineActivity(String name, String type, String description,
			long state, long deadline, long lastUpdate, long initializedDate,
			long employeeID, long assignedBy, long upperActivity) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "select id from activity where name= '" + name
					+ "' AND " + "type='" + type + "' AND initializedDate="
					+ initializedDate + " AND deadline=" + deadline
					+ " AND lastUpdate=" + lastUpdate;
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (rslt.next()) {
				connection.close();
				return "Creation failes because of redundancy in defnition";
			}
			String insert = "insert into activity (ID,Name,Type,Description,State,"
					+ "deadline,LastUpdate"
					+ ",InitializedDate,EmployeeID,assignedBy,upperActivity)	"
					+ "values (null,'"
					+ name
					+ "','"
					+ type
					+ "','"
					+ description
					+ "',"
					+ state
					+ ","
					+ deadline
					+ ","
					+ lastUpdate
					+ ","
					+ initializedDate
					+ ","
					+ employeeID
					+ "," + assignedBy + "," + upperActivity + ")";
			System.out.print(insert);
			con.runUpdateQuery(insert, connection, true);
			connection.close();
			return "Creation done successfuly";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "Creation failes because of db error";
		}
	}

	private String setActivityAttribute(long activityID, String type,
			long employeeID, String attribute, String value, boolean integer) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "select id from activity where id= '"
					+ activityID + "' AND " + "type='" + type
					+ "' AND employeeID=" + employeeID;
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return "Update failes because of no predefinition of Activity";
			}
			String update = "UPDATE activity SET ";
			if (integer == true)
				update = update + attribute + "=" + Long.parseLong(value);
			else
				update = update + attribute + "='" + value + "'";
			update = update + " WHERE type='" + type + "' AND id='"
					+ activityID + "' AND employeeID=" + employeeID;
			con.runUpdateQuery(update, connection, true);
			connection.close();
			return "Update done successfully";
		} catch (SQLException e) {
			e.printStackTrace();
			return "Update failed because of error";
		}
	}

	String reassign(long activityID, long personID, String type,
			long secondPersonID, String secondPersonType, long date,
			long changerID) {
		log.refrenceChange("manager", date, Long.toString(personID), changerID,
				activityID, type);
		return setActivityAttribute(activityID, type, personID, "employeeID",
				Long.toString(secondPersonID), true)
				+ setActivityAttribute(activityID, type, personID, "type",
						secondPersonType, false);
	}

	String changeState(long activityID, String personType, long personID,
			long changerID, long state, long date) {// only employee could do
													// this
		try {
			String temp = "";
			if (state == 0 || state == 100)
				temp = releaseAllResource(activityID, personType, personID);
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "select state from activity where id= '"
					+ activityID + "' AND " + "type='" + personType
					+ "' AND employeeID=" + personID;
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return temp
						+ "Update failes because of no predefinition of Activity";
			}
			long oldState = (Long) rslt.getObject(1);
			if (oldState > state)// means to do prohibitedwork
				log.avoidedChange("employee", date, Long.toString(oldState),
						changerID,activityID, "");
			String update = "UPDATE activity SET ";
			update = update + "State=" + state + "," + "lastUpdate=" + date;
			update = update + " WHERE type='" + personType + "' AND id='"
					+ activityID + "' AND employeeID=" + personID;
			con.runUpdateQuery(update, connection, true);
			connection.close();
			return temp + "Update done successfully";
		} catch (SQLException e) {
			e.printStackTrace();
			return "Update failed because of error";
		}
	}

	String preciseDescription(long activityID, String type,
			long employeeID, String description) {
		return setActivityAttribute(activityID, type, employeeID,
				"Description", description, false);
	}

	String extendDeadline(long activityID, String personType,
			long personID, long changerID, long deadline, long date) {// only
																		// manager
																		// could
																		// do
																		// this
		try {
			String temp = "";
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "select deadline from activity where id= '"
					+ activityID + "' AND " + "type='" + personType
					+ "' AND employeeID=" + personID;
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return temp
						+ "Update failes because of no predefinition of Activity";
			}
			long oldDeadline = (Long) rslt.getObject(1);
			log.changeDeadline("manager", date, Long.toString(oldDeadline),
					changerID,
					activityID, "");
			String update = "UPDATE activity SET ";
			update = update + "deadline=" + deadline;
			update = update + " WHERE type='" + personType + "' AND id='"
					+ activityID + "' AND employeeID=" + personID;
			con.runUpdateQuery(update, connection, true);
			connection.close();
			return temp + "Update done successfully";
		} catch (SQLException e) {
			e.printStackTrace();
			return "Update failed because of error";
		}
	}

	String unActivateActivity(long activityID, String personType,
			long personID, long changerID, long date) {// only manger could do
														// this
		try {
			String temp = "";
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "select state from activity where id= '"
					+ activityID + "' AND " + "type='" + personType
					+ "' AND employeeID=" + personID;
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return temp
						+ "Update failes because of no predefinition of Activity";
			}
			long oldState = (Long) rslt.getObject(1);
			log.removeActivityLogItem("manager", date, Long.toString(oldState),
					changerID,
					activityID, "");
			String update = "UPDATE activity SET ";
			update = update + "State=-1";
			update = update + " WHERE type='" + personType + "' AND id='"
					+ activityID + "' AND employeeID=" + personID;
			con.runUpdateQuery(update, connection, true);
			connection.close();
			return temp + "Update done successfully";
		} catch (SQLException e) {
			e.printStackTrace();
			return "Update failed because of error";
		}
	}

	String addResourceToActivity(long activityID, String type,
			long personID, String resourceName, String resourcePlace,
			long resourceQuantity) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);

			String select="SELECT * FROM actiontracking.resource_need,resource " +
			"where resource.id=resource_need.resourceId and"+
			"resource.place='"+resourcePlace+"' and resource.name='"+resourceName+"' " +
					"and resource_need.activityID="+activityID;
			select = "select id,inHand from resource where name='"
					+ resourceName + "' AND place='" + resourcePlace + "'";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return "Resource Adding faile because "
						+ "of not having this resource defined in organization before";
			}
			long resourceInHand = (Long) rslt.getObject(2);
			if (resourceInHand < resourceQuantity) {
				connection.close();
				return "Resource adding fails because "
						+ "of not having enough resource in organization";
			} else
				resourceInHand -= resourceQuantity;
			long resourceID = (Long) rslt.getObject(1);
			String insert = "insert into resource_need (activityid,resourceid,quantity) values("
					+ activityID
					+ ","
					+ resourceID
					+ ","
					+ resourceQuantity
					+ ")";
			con.runUpdateQuery(insert, connection, true);
			String update = "update resource set inhand=" + resourceInHand
					+ " where id=" + resourceID;
			con.runUpdateQuery(update, connection, true);
			connection.close();
			return "resource added successfuly";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "resource adding failes because of having error in db";
		}
	}

	String defineResourceForOrganization(String name, String place, int inHand) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "select id from resource where name='" + name
					+ "' and place='" + place + "'";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (rslt.next()) {
				connection.close();
				return "Definition Failed Because of redundancy";
			}
			String insert = "insert into resource(ID,name,place,inhand) values (null,'"
					+ name + "','" + place + "'," + inHand + ")";
			con.runUpdateQuery(insert, connection, true);
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return "Resource definition failed because of db error";
		}
		return "Resource definition was successful";
	}

	String addReportToActivity(long activityID, String type, String title,
			long personID, String reportpath, long date) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			long version = 0;
			String select = "select version from report where activityID="
					+ activityID;
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			while (rslt.next())
				version++;
			String insert = "insert into report(ID,Title,Version,ActivityID,Filepath,date) values (null,'"
					+ title
					+ "',"
					+ version
					+ ","
					+ activityID
					+ ",'"
					+ reportpath + "'," + date + ")";
			con.runUpdateQuery(insert, connection, true);
			connection.close();
			return "Report addition done succesfully";
		} catch (SQLException e) {
			e.printStackTrace();
			return "Report addition failed because of error in db";
		}
	}

	String changeResourceQuantityOfActivity(long activityID, String type,
			long personID, String resourceName, String resourcePlace,
			long resourceQuantity) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "select id,inhand from resource where name='"
					+ resourceName + "' and place='" + resourcePlace + "'";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return "Changed Resource fails because of "
						+ "not having resource defined for organization";
			}
			long resourceID = (Long) rslt.getObject(1);
			long resourceOldQuantity = (Long) rslt.getObject(2);
			select = "select quantity from resource_need where activityID="
					+ activityID + " AND resourceID=" + resourceID;
			rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return "Resource Change fails because "
						+ "of not having this resource allocated to this activity before";
			}
			long oldQuantity = (Long) rslt.getObject(1);
			oldQuantity = oldQuantity - resourceQuantity;
			resourceOldQuantity += oldQuantity;
			if (resourceOldQuantity < 0) {
				connection.close();
				return "Resource Change faile because "
						+ "of not having enough resource in company";
			}
			String update = "update resource_need set quantity="
					+ resourceQuantity + " where activityID=" + activityID
					+ " and resourceid=" + resourceID;
			con.runUpdateQuery(update, connection, true);
			update = "update resource set inhand=" + resourceOldQuantity
					+ " where id=" + resourceID;
			con.runUpdateQuery(update, connection, true);
			connection.close();
			return "resource Quantity changed successfuly";
		} catch (SQLException e) {
			e.printStackTrace();
			return "resource Quantity change fails because of db error";
		}
	}

	String changeResourceQuantityOfOrganization(String name, String place,
			long inHand) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "select id from resource where name='" + name
					+ "' and place='" + place + "'";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return "Changed Resource fails because of "
						+ "not having resource defined for organization";
			}
			long resourceID = (Long) rslt.getObject(1);
			select = "select sum(quantity) from resource_need where "
					+ " resourceID=" + resourceID;
			rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return "Resource Change fails because "
						+ "of not having this resource allocated to this activity before";
			}
			Object o = rslt.getObject(1);
			java.math.BigDecimal b = (java.math.BigDecimal) o;
			long totalUse = b.longValue();
			if (inHand < totalUse) {
				return "Resource Change failse because "
						+ "of preallocation please first release it and then change quantity";
			}

			String update = "update resource set inhand=" + inHand + " "
					+ "where id=" + resourceID;
			con.runUpdateQuery(update, connection, true);
			connection.close();
			return "Resource Change done successfully";
		} catch (SQLException e) {
			e.printStackTrace();
			return "Change Resource fails because of error in db";
		}
	}

	private String releaseAllResource(long activityID, String type,
			long personID) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String delete = "delete from resource_need where " + " activityID="
					+ activityID;
			con.runUpdateQuery(delete, connection, true);
			connection.close();
			return "release all resource Done successfully";
		} catch (SQLException e) {
			e.printStackTrace();
			return "Change Release Resource fails because of error in db";
		}
	}

	String getActivityName(long activityID) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "select name from activity where id= " + activityID;
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return null;
			}
			String activityName=(String) rslt.getObject(1);
			connection.close();
			return activityName;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	long getActivityID(String name, long employeeID, String type) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			System.out.print(name+" "+employeeID+" "+type);
			String select = "select id from activity where name= '" + name
					+ "' AND " + "employeeID=" + employeeID + " AND type='"
					+ type + "'";
			System.out.print(select);
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return -1;
			}
			long temp=(Long) rslt.getObject(1);
			connection.close();
			return temp;
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}
	}

	String getResourceName(long resourceID) {
		try {
			Connection connection = con.getDbConnection(username, password,
					port, Ip, DBName);
			String select = "select name from resource where id= " + resourceID;
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next()) {
				connection.close();
				return null;
			}
			String resourceName=(String) rslt.getObject(1);
			connection.close();
			return resourceName;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	// boolean updateLog(String activityName, String type, int employeeID,
	// int managerID, int date, String action, String changeType,
	// String oldValue) {
	// try {
	// Connection connection = con.getDbConnection(username, password,
	// port, Ip, DBName);
	// String select = "select id from activity where name= '"
	// + activityName + "' AND" + "type='" + type
	// + "'AND employeeID=";
	// if (type.compareTo("manager") == 0)
	// select = select + managerID;
	// else
	// select = select + employeeID;
	// ResultSet rslt = con.runSqlQuery(select, connection, true);
	// if (!rslt.next()) {
	// connection.close();
	// return false;
	// }
	// int activityID = (Long) rslt.getObject(1);
	// String insert = "insert into activitylog(ID, changerType, changeType,"
	// + " Date, oldValue, employeeID, managerID, activityID) "
	// + "values (null,'"
	// + type
	// + "','"
	// + changeType
	// + "',"
	// + date
	// + ",'"
	// + oldValue
	// + "',"
	// + employeeID
	// + ","
	// + managerID + "," + activityID + ")";
	// con.runUpdateQuery(insert, connection, true);
	// connection.close();
	// } catch (SQLException e) {
	// e.printStackTrace();
	// }
	// return false;
	// }

}
