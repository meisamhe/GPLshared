package com.actionTracking;

import java.io.Serializable;

public class Person implements Serializable {
	
	String name;
	String family;
	String department;
	String location;
	String type;
	String user;
	
	public Person(){}
	
	public Person(String name,String family,String department,String location,String type,String user){
		setName(name);
		setFamily(family);
		setDepartment(department);
		setType(type);
		setLocation(location);
		setUser(user);
	}
	
	public void setLocation(String location){
		this.location=location;
	}
	public String getLocation(){
		return location;
	}
	public void setDepartment(String department){
		this.department=department;
	}
	
	public String getDepartment(){
		return department;
	}
	
	public void setName(String name){
		this.name=name;
	}
	
	public String getName(){
		return name;
	}
	
	public void setFamily(String family){
		this.family=family;
	}
	
	public String getFamily(){
		return family;
	}
	public void setType(String type){
		this.type=type;
	}
	public String getType(){
		return type;
	}
	public void setUser(String user){
		this.user=user;
	}
	public String getUser(){
		return user;
	}

}
