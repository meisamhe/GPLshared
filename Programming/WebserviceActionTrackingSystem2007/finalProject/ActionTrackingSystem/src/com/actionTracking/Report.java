package com.actionTracking;

import java.io.Serializable;

public class Report implements Serializable {
	String title;
	String path;
	long version;
	long date;
	
	public Report(){
		
	}
	public Report(String title,String path,long version,long date){
		setTitle(title);
		setPath(path);
		setVersion(version);
		setDate(date);
	}
	public void setDate(long date){
		this.date=date;
	}
	public long getDate(){
		return date;
	}
	public void setTitle(String title){
		this.title=title;
	}
	public String getTitle(){
		return title;
	}
	public void setPath(String path){
		this.path=path;
	}
	public String getPath(){
		return path;
	}
	public void setVersion(long version){
		this.version=version;
	}
	public long getVersion(){
		return version;
	}

}
