package com.actionTracking;

public class Department {
	
	String name;
	String location;
	
	public Department(){
	}
	
	public Department(String name,String location){
		setName(name);
		setLocation(location);
	}
	public void setName(String name){
		this.name=name;
	}
	public String getName(){
		return name;
	}
	public void setLocation(String location){
		this.location=location;
	}
	public String getLocation(){
		return location;
	}
}
