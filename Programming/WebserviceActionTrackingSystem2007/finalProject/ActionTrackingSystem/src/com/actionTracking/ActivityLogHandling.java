package com.actionTracking;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class ActivityLogHandling {
	String username;
	String password;
	String ip;
	String port;
	String DBName;
	MysqlConnector con;

	ActivityLogHandling(String username, String password, String ip, String port,
			String DBName) {
		this.con = new MysqlConnector();
		this.username = username;
		this.password = password;
		this.ip = ip;
		this.port = port;
		this.DBName = DBName;

	}
	
	String removeActivityLogItem(String changerType,
			long date,String oldValue,long personID,long activityID,String oldType){
		MysqlConnector con = new MysqlConnector();
		Connection connection = con.getDbConnection(username, password, port,
				ip, DBName);
		try {
			String insert = "insert into activitylog(id,changetype,changertype,changedate," +
					"oldvalue,personID,activityID,oldType) values"+
			"(null,'removeActivity','"+changerType+"',"+date+",'"+oldValue+"',"+personID+","+activityID+
			","+oldType+")";
			con.runUpdateQuery(insert, connection, true);
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return "Creation failed because of Database error";
		}
		return "creation done successfuly";
	}
	
	String changeDeadline(String changerType,
			long date,String oldValue,long personID,long activityID,String oldType){
		MysqlConnector con = new MysqlConnector();
		Connection connection = con.getDbConnection(username, password, port,
				ip, DBName);
		try {
			String insert = "insert into activitylog(id,changetype,changertype,changedate," +
					"oldvalue,personID,activityID,oldType) values"+
			"(null,'changeDeadline','"+changerType+"',"+date+",'"+oldValue+"',"+personID+","+activityID+
			","+oldType+")";
			con.runUpdateQuery(insert, connection, true);
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return "Creation failed because of Database error";
		}
		return "creation done successfuly";
	}
	
//	String stateUpdate(String changerType,
//			long date,String oldValue,long personID,long activityID){
//		MysqlConnector con = new MysqlConnector();
//		Connection connection = con.getDbConnection(username, password, port,
//				ip, DBName);
//		try {
//			String insert = "insert into activitylog(id,changetype,changertype,changedate," +
//					"oldvalue,personID,activityID) values"+
//			"(null,'stateUpdate','"+changerType+"',"+date+",'"+oldValue+"',"+personID+","+activityID+")";
//			con.runUpdateQuery(insert, connection, true);
//			connection.close();
//		} catch (SQLException e) {
//			e.printStackTrace();
//			return "Creation failed because of Database error";
//		}
//		return "creation done successfuly";
//	}
	
	String refrenceChange(String changerType,
			long date,String oldValue,long personID,long activityID,String oldType){
		MysqlConnector con = new MysqlConnector();
		Connection connection = con.getDbConnection(username, password, port,
				ip, DBName);
		try {
			String insert = "insert into activitylog(id,changetype,changertype,changedate," +
					"oldvalue,personID,activityID,oldType) values"+
			"(null,'referencChange','"+changerType+"',"+date+",'"+oldValue+"',"+personID+","+activityID+
			","+oldType+")";
			con.runUpdateQuery(insert, connection, true);
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return "Creation failed because of Database error";
		}
		return "creation done successfuly";
	}
	
	String avoidedChange(String changerType,
			long date,String oldValue,long personID,long activityID,String oldType){
		MysqlConnector con = new MysqlConnector();
		Connection connection = con.getDbConnection(username, password, port,
				ip, DBName);
		try {
			String insert = "insert into activitylog(id,changetype,changertype,changedate," +
					"oldvalue,personID,activityID,oldType) values"+
			"(null,'avoidedChange','"+changerType+"',"+date+",'"+oldValue+"',"+personID+","+activityID+
			","+oldType+")";
			con.runUpdateQuery(insert, connection, true);
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return "Creation failed because of Database error";
		}
		return "creation done successfuly";
	}
	
	public ActivityLogItem[] stateAvoidedChangeOneEmployee(long personID,String type){
		try {
			MysqlConnector con = new MysqlConnector();
			Connection connection = con.getDbConnection(username, password,
					port, ip, DBName);
			String select = "select *  from  activitylog  where employeeid=" +
					personID+" and changeType='avoidedChange' and changerType="+type;
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next())
				return null;
			Vector<ActivityLogItem> v=new Vector<ActivityLogItem>();
			ActivityLogItem l=new ActivityLogItem((String) rslt.getObject(2),(String) rslt.getObject(3),
					(Long) rslt.getObject(4),(String)rslt.getObject(5),(Long)rslt.getObject(6),
					(Long)rslt.getObject(7),(String) rslt.getObject(8));
			v.add(l);
			while(rslt.next()){
				l=new ActivityLogItem((String) rslt.getObject(2),(String) rslt.getObject(3),
						(Long) rslt.getObject(4),(String)rslt.getObject(5),(Long)rslt.getObject(6),
						(Long)rslt.getObject(7),(String) rslt.getObject(8));
				v.add(l);
			}
			ActivityLogItem[] logList=new ActivityLogItem[v.size()];
			for (int i=0; i<v.size();i++)
				logList[i]=v.get(i);
			connection.close();
			return logList;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	ActivityLogItem[] deadLineChangeOfActivity(long activityID){
		try {
			MysqlConnector con = new MysqlConnector();
			Connection connection = con.getDbConnection(username, password,
					port, ip, DBName);
			String select = "select *  from  activitylog  where activityID=" +
					activityID+" and changeType='changeDeadline'";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next())
				return null;
			Vector<ActivityLogItem> v=new Vector<ActivityLogItem>();
			ActivityLogItem l=new ActivityLogItem((String) rslt.getObject(2),(String) rslt.getObject(3),
					(Long) rslt.getObject(4),(String)rslt.getObject(5),(Long)rslt.getObject(6),
					(Long)rslt.getObject(7),(String) rslt.getObject(8));
			v.add(l);
			while(rslt.next()){
				l=new ActivityLogItem((String) rslt.getObject(2),(String) rslt.getObject(3),
						(Long) rslt.getObject(4),(String)rslt.getObject(5),(Long)rslt.getObject(6),
						(Long)rslt.getObject(7),(String) rslt.getObject(8));
				v.add(l);
			}
			ActivityLogItem[] logList=new ActivityLogItem[v.size()];
			for (int i=0; i<v.size();i++)
				logList[i]=v.get(i);
			connection.close();
			return logList;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	public ActivityLogItem[] stateAvoidedChangeAllEmployee(long managerID){
		try {
			MysqlConnector con = new MysqlConnector();
			Connection connection = con.getDbConnection(username, password,
					port, ip, DBName);
			boolean sw=false;
			String select = "select activitylog.id,activitylog.changetype," +
					"activitylog.changertype,activitylog.changedate,activitylog.oldvalue" +
					",activitylog.personid,activitylog.activityid,activitylog.oldType" +
					"  from  activitylog," +
					"employee where activitylog." +
					"employeeid= employee.id" +
					" and activitylog.changeType='avoidedChange' and employee.managerID=" +
					managerID+" and activitylog.changerType='employee'";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			Vector<ActivityLogItem> v=new Vector<ActivityLogItem>();
			ActivityLogItem l;
			if (!rslt.next())
				sw=true;
			else{
			l=new ActivityLogItem((String) rslt.getObject(2),(String) rslt.getObject(3),
					(Long) rslt.getObject(4),(String)rslt.getObject(5),(Long)rslt.getObject(6),
					(Long)rslt.getObject(7),(String) rslt.getObject(8));
			v.add(l);
			while(rslt.next()){
				l=new ActivityLogItem((String) rslt.getObject(2),(String) rslt.getObject(3),
						(Long) rslt.getObject(4),(String)rslt.getObject(5),(Long)rslt.getObject(6),
						(Long)rslt.getObject(7),(String) rslt.getObject(8));
				v.add(l);
			}
			}
			// here I have all the employees in the list
			select = "select activitylog.id,activitylog.changetype," +
			"activitylog.changertype,activitylog.changedate,activitylog.oldvalue" +
			",activitylog.personid,activitylog.activityid,activitylog.oldType" +
			"  from  activitylog," +
			"manager where activitylog." +
			"employeeid= manager.id" +
			" and activitylog.changeType='avoidedChange' and manager.managerID=" +
			managerID+" and activitylog.changerType='manager'";
			if (!rslt.next())
				sw=true;
			else{
			l=new ActivityLogItem((String) rslt.getObject(2),(String) rslt.getObject(3),
					(Long) rslt.getObject(4),(String)rslt.getObject(5),(Long)rslt.getObject(6),
					(Long)rslt.getObject(7),(String) rslt.getObject(8));
			v.add(l);
			while(rslt.next()){
				l=new ActivityLogItem((String) rslt.getObject(2),(String) rslt.getObject(3),
						(Long) rslt.getObject(4),(String)rslt.getObject(5),(Long)rslt.getObject(6),
						(Long)rslt.getObject(7),(String) rslt.getObject(8));
				v.add(l);
			}
			}
			ActivityLogItem[] logList=new ActivityLogItem[v.size()];
			for (int i=0; i<v.size();i++)
				logList[i]=v.get(i);
			connection.close();
			return logList;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	public ActivityLogItem[] refrenceChangeReport(long managerID){
		try {
			MysqlConnector con = new MysqlConnector();
			Connection connection = con.getDbConnection(username, password,
					port, ip, DBName);
			boolean sw=false;
			String select = "select activitylog.id,activitylog.changetype," +
					"activitylog.changertype,activitylog.changedate,activitylog.oldvalue" +
					",activitylog.personid,activitylog.activityid,activitylog.oldType" +
					"  from  activitylog," +
					"employee where activitylog." +
					"employeeid= employee.id" +
					" and activitylog.changeType='referencChange' and employee.managerID=" +
					managerID+" and activitylog.changerType='employee'";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			Vector<ActivityLogItem> v=new Vector<ActivityLogItem>();
			ActivityLogItem l;
			if (!rslt.next())
				sw=true;
			else{
			l=new ActivityLogItem((String) rslt.getObject(2),(String) rslt.getObject(3),
					(Long) rslt.getObject(4),(String)rslt.getObject(5),(Long)rslt.getObject(6),
					(Long)rslt.getObject(7),(String) rslt.getObject(8));
			v.add(l);
			while(rslt.next()){
				l=new ActivityLogItem((String) rslt.getObject(2),(String) rslt.getObject(3),
						(Long) rslt.getObject(4),(String)rslt.getObject(5),(Long)rslt.getObject(6),
						(Long)rslt.getObject(7),(String) rslt.getObject(8));
				v.add(l);
			}
			}
			// here I have all the employees in the list
			select = "select activitylog.id,activitylog.changetype," +
			"activitylog.changertype,activitylog.changedate,activitylog.oldvalue" +
			",activitylog.personid,activitylog.activityid,activitylog.oldType" +
			"  from  activitylog," +
			"manager where activitylog." +
			"employeeid= manager.id" +
			" and activitylog.changeType='referencChange' and manager.managerID=" +
			managerID+" and activitylog.changerType='manager'";
			if (!rslt.next())
				sw=true;
			else{
			l=new ActivityLogItem((String) rslt.getObject(2),(String) rslt.getObject(3),
					(Long) rslt.getObject(4),(String)rslt.getObject(5),(Long)rslt.getObject(6),
					(Long)rslt.getObject(7),(String) rslt.getObject(8));
			v.add(l);
			while(rslt.next()){
				l=new ActivityLogItem((String) rslt.getObject(2),(String) rslt.getObject(3),
						(Long) rslt.getObject(4),(String)rslt.getObject(5),(Long)rslt.getObject(6),
						(Long)rslt.getObject(7),(String) rslt.getObject(8));
				v.add(l);
			}
			}
			ActivityLogItem[] logList=new ActivityLogItem[v.size()];
			for (int i=0; i<v.size();i++)
				logList[i]=v.get(i);
			connection.close();
			return logList;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public ActivityLogItem[] removedActivityReport(long managerID){
		try {
			MysqlConnector con = new MysqlConnector();
			Connection connection = con.getDbConnection(username, password,
					port, ip, DBName);
			boolean sw=false;
			String select = "select activitylog.id,activitylog.changetype," +
					"activitylog.changertype,activitylog.changedate,activitylog.oldvalue" +
					",activitylog.personid,activitylog.activityid,activitylog.oldType  " +
					"from  activitylog," +
					"employee where activitylog." +
					"employeeid= employee.id" +
					" and activitylog.changeType='removeActivity' and employee.managerID=" +
					managerID+" and activitylog.changerType='employee'";
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			Vector<ActivityLogItem> v=new Vector<ActivityLogItem>();
			ActivityLogItem l;
			if (!rslt.next())
				sw=true;
			else{
			l=new ActivityLogItem((String) rslt.getObject(2),(String) rslt.getObject(3),
					(Long) rslt.getObject(4),(String)rslt.getObject(5),(Long)rslt.getObject(6),
					(Long)rslt.getObject(7),(String) rslt.getObject(8));
			v.add(l);
			while(rslt.next()){
				l=new ActivityLogItem((String) rslt.getObject(2),(String) rslt.getObject(3),
						(Long) rslt.getObject(4),(String)rslt.getObject(5),(Long)rslt.getObject(6),
						(Long)rslt.getObject(7),(String) rslt.getObject(8));
				v.add(l);
			}
			}
			// here I have all the employees in the list
			select = "select activitylog.id,activitylog.changetype," +
			"activitylog.changertype,activitylog.changedate,activitylog.oldvalue" +
			",activitylog.personid,activitylog.activityid,activitylog.oldType  from  activitylog," +
			"manager where activitylog." +
			"employeeid= manager.id" +
			" and activitylog.changeType='removeActivity' and manager.managerID=" +
			managerID+" and activitylog.changerType='manager'";
			if (!rslt.next())
				sw=true;
			else{
			l=new ActivityLogItem((String) rslt.getObject(2),(String) rslt.getObject(3),
					(Long) rslt.getObject(4),(String)rslt.getObject(5),(Long)rslt.getObject(6),
					(Long)rslt.getObject(7),(String) rslt.getObject(8));
			v.add(l);
			while(rslt.next()){
				l=new ActivityLogItem((String) rslt.getObject(2),(String) rslt.getObject(3),
						(Long) rslt.getObject(4),(String)rslt.getObject(5),(Long)rslt.getObject(6),
						(Long)rslt.getObject(7),(String) rslt.getObject(8));
				v.add(l);
			}
			}
			ActivityLogItem[] logList=new ActivityLogItem[v.size()];
			for (int i=0; i<v.size();i++)
				logList[i]=v.get(i);
			connection.close();
			return logList;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ActivityLogItem[] allChangesOfActivity(long activityID){
		try {
			MysqlConnector con = new MysqlConnector();
			Connection connection = con.getDbConnection(username, password,
					port, ip, DBName);
			String select = "select *  from  activitylog  where activityID=" +
					activityID;
			ResultSet rslt = con.runSqlQuery(select, connection, true);
			if (!rslt.next())
				return null;
			Vector<ActivityLogItem> v=new Vector<ActivityLogItem>();
			ActivityLogItem l=new ActivityLogItem((String) rslt.getObject(2),(String) rslt.getObject(3),
					(Long) rslt.getObject(4),(String)rslt.getObject(5),(Long)rslt.getObject(6),
					(Long)rslt.getObject(7),(String) rslt.getObject(8));
			v.add(l);
			while(rslt.next()){
				l=new ActivityLogItem((String) rslt.getObject(2),(String) rslt.getObject(3),
						(Long) rslt.getObject(4),(String)rslt.getObject(5),(Long)rslt.getObject(6),
						(Long)rslt.getObject(7),(String) rslt.getObject(8));
				v.add(l);
			}
			ActivityLogItem[] logList=new ActivityLogItem[v.size()];
			for (int i=0; i<v.size();i++)
				logList[i]=v.get(i);
			connection.close();
			return logList;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
}
