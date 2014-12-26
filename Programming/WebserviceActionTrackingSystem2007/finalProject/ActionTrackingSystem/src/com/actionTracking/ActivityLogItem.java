package com.actionTracking;

public class ActivityLogItem {
	String changeType;
	String changerType;
	long date;
	String oldValue;
	long personID;
	long activityID;
	String oldType;
	
	public ActivityLogItem(){
		
	}

	public ActivityLogItem(String changeType,String changerType,long date,String oldValue,long personID,
			long activityID,String oldType){
		setChangeType(changeType);
		setChangerType(changerType);
		setDate(date);
		setOldValue(oldValue);
		setPersonID(personID);
		setActivityID(activityID);
		setOldType(oldType);
	}
	
	public void setOldType(String oldType){
		this.oldType=oldType;
	}
	
	public String getOldType(){
		return oldType;
	}
	public void setActivityID(long activityID){
		this.activityID=activityID;
	}
	
	public long getActivityID(){
		return activityID;
	}
	
	public void setChangeType(String changeType){
		this.changeType=changeType;
	}
	public String getChangeType(){
		return changeType;
	}
	
	public void setPersonID(long personID){
		this.personID=personID;
	}
	
	public long getPersonID(){
		return personID;
	}
	
	public void setChangerType(String changerType){
		this.changerType=changerType;
	}
	public String getChangerType(){
		return changerType;
	}
	public void setDate(long date){
		this.date=date;
	}
	public long getDate(){
		return date;
	}
	public void setOldValue(String oldValue){
		this.oldValue=oldValue;
	}
	public String getOldValue(){
		return oldValue;
	}	
}
