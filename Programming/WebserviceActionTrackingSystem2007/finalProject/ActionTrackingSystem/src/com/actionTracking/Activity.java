package com.actionTracking;

import java.io.Serializable;

public class Activity implements Serializable {
	long activityId;
	String name;
	String type;
	String description;
	long state;
	long deadline;
	long lastUpdate;
	long initializedDate;
	Person employee;
	long employeeID;
	Person assignedBy;
	long upperActivity;
	public Activity(){
		
	}
	public Activity(long activityId,String name,String type,String description,long state,long deadline,
			long lastUpdate,long initializedDate,long employeeID,EmployeeAffairs emp,long assignedBy,
			long upperActivity){
		setActivityId(activityId);
		setName(name);
		setType(type);
		setDescription(description);
		setState(state);
		setDeadline(deadline);
		setLastUpdate(lastUpdate);
		setInitializedDate(initializedDate);
		setEmployeeID(employeeID);
		setEmployee(emp.getEmployee(employeeID, type));
		setAssignedBy(emp.getEmployee(assignedBy, "manager"));
		setUpperActivity(upperActivity);
	}
	public void setActivityId(long activityId){
		this.activityId=activityId;
	}
	public long getActivityId(){
		return activityId;
	}
	public void setType(String type){
		this.type=type;
	}
	public String getType(){
		return type;
	}
	public void setName(String name){
		this.name=name;
	}
	public String getName(){
		return name;
	}
	public void setDescription(String description){
		this.description=description;
	}
	public String getDescription(){
		return description;
	}
	public void setState(long state){
		this.state=state;
	}
	public long getState(){
		return state;
	}
	public void setDeadline(long deadline){
		this.deadline=deadline;
	}
	public long getDeadline(){
		return deadline;
	}
	public void setLastUpdate(long lastUpdate){
		this.lastUpdate=lastUpdate;
	}
	public long getLastUpdate(){
		return lastUpdate;
	}
	public void setInitializedDate(long initializedDate){
		this.initializedDate=initializedDate;
	}
	public long getInitializedDate(){
		return initializedDate;
	}
	public void setEmployeeID(long employeeID){
		this.employeeID=employeeID;
	}
	public long getEmployeeID(){
		return employeeID;
	}
	public Person getEmployee(){
		return employee;
	}
	public void setEmployee(Person employee){
		this.employee=employee;
	}
	public void setAssignedBy(Person assignedBy){
		this.assignedBy=assignedBy;
	}
	public Person getAssignedBy(){
		return assignedBy;
	}
	public void setUpperActivity(long upperActivity){
		this.upperActivity=upperActivity;
	}
	public long getUpperActivity(){
		return upperActivity;
	}
}
