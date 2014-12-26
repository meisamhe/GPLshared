package com.actionTracking;

public class ShamsiDate {
	int iYear;
	int iMonth;
	int iDay;

	public ShamsiDate() {

	}
	
	public ShamsiDate(int iYear,int iMonth,int iDay){
		setIYear(iYear);
		setIMonth(iMonth);
		setIDay(iDay);
	}

	public int getIYear() {
		return iYear;
	}

	public void setIYear(int iYear) {
		this.iYear = iYear;
	}

	public int getIMonth() {
		return iMonth;
	}

	public void setIMonth(int iMonth) {
		this.iMonth = iMonth;
	}

	public int getIDay() {
		return iDay;
	}

	public void setIDay(int iDay) {
		this.iDay = iDay;
	}

	// the function check a miladiyear is leap or not.


}
