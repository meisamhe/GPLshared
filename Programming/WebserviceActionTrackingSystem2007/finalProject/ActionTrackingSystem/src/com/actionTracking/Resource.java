package com.actionTracking;

import java.io.Serializable;

public class Resource implements Serializable {
	
	String name;
	String place;
	long quantity;
	
	public Resource(){
		
	}
	
	public Resource(String name, String place,long quantity){
		setName(name);
		setPlace(place);
		setQuantity(quantity);
	}
	
	public void setName(String name){
		this.name=name;
	}
	public String getName(){
		return name;
	}
	public void setPlace(String place){
		this.place=place;
	}
	public String getPlace(){
		return place;
	}
	public void setQuantity(long quantity){
		this.quantity=quantity;
	}
	public long getQuantity(){
		return quantity;
	}

}
