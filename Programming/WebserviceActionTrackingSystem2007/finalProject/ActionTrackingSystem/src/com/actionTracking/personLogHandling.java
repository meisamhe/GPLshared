package com.actionTracking;

public class personLogHandling {
	String username;
	String password;
	String Ip;
	String port;
	String DBName;
	MysqlConnector con;

	personLogHandling(String username, String password, String Ip, String port,
			String DBName) {
		this.con = new MysqlConnector();
		this.username = username;
		this.password = password;
		this.Ip = Ip;
		this.port = port;
		this.DBName = DBName;

	}
}
