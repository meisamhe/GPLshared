package com.actionTracking;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

public class MainService {
	EmployeeAffairs emp;
	ActivityHandler activity;
	reportGenerator report;
	ActivityLogHandling log;

	public MainService() {
		emp = new EmployeeAffairs("root", "123456", "localhost", "3306",
				"actionTracking");
		activity = new ActivityHandler("root", "123456", "localhost", "3306",
				"actionTracking");
		report = new reportGenerator("root", "123456", "localhost", "3306",
				"actionTracking");
		log = new ActivityLogHandling("root", "123456", "localhost", "3306",
				"actionTracking");
	}

	public String defineEmployee(String name, String family, String user,
			String password, String department, String location) {
		if (falseInput(name)||falseInput(family)||falseInput(user)||
				falseInput(password)||falseInput(department)||falseInput(location))
			return null;
		return emp.defineEmployee(name, family, user, password, department,
				location);
	}

	public String defineDepartment(String name, String location,
			String upperDepartmentName,String upperDepartmentLocation) {
		if (falseInput(name)||falseInput(location)||falseInput(upperDepartmentLocation)||
				falseInput(upperDepartmentName))
			return null;
		return emp.defineDepartment(name, location, upperDepartmentName,upperDepartmentLocation);
	}

	public String defineManager(String name, String family, String user,
			String password 
			, String department,String location) {
		if (falseInput(name)||falseInput(family)||falseInput(user)||falseInput(password)||
				falseInput(location)|| falseInput(department) )
			return null;
		return emp.defineManager(name, family, user, password,
				department,location);
	}

	public String replaceEmployee(String user,
			String secondName, String secondFamily, String secondUser,
			String secondPassword) {
		if (falseInput(user)||falseInput(secondName)||falseInput(secondFamily)||
				falseInput(secondUser)||falseInput(secondPassword))
			return null;
		return emp.replaceEmployee(user, secondName, secondFamily,
				secondUser, secondPassword);
	}

	public String deleteEmployee(String user) {
		return emp.deleteEmployee(user);
	}

	public String replaceManager(String user,
			String secondName, String secondFamily, String secondUser,
			String secondPassword) {
		if (falseInput(user)||falseInput(secondName)||falseInput(secondFamily)||
				falseInput(secondUser)|| falseInput(secondPassword))
			return null;
		return emp.replaceManager(user, secondName, secondFamily,
				secondUser, secondPassword);
	}

	public String defineActivity(String name, String description,
			long deadline, long initializedDate,
			String personUser, String personType, String assignedByUser,
			long upperActivityID) {
		if (falseInput(name)||falseInput(description)||falseInput(Long.toString(deadline))||
				falseInput(Long.toString(initializedDate))||falseInput(personType)||
				falseInput(personUser)||falseInput(assignedByUser))
			return null;
		long personID = emp.getIDOfPerson(personUser, personType);
		if (personID == -1)
			return "Creation failes because the employee was not defined before";
		return activity.defineActivity(name, personType, description, 0,
				deadline, initializedDate, initializedDate, personID, emp
						.getIDOfManager(assignedByUser),
						upperActivityID);
	}

	public String reassign(long activityID, String changerUser,
			String firstPersonUser, String firstPersonType,
			String secondPersonUser, String secondPersonType, long date) {// only
																			// manager
																			// could
																			// use
																			// this
																			// service
		if (falseInput(changerUser)||falseInput(firstPersonUser)
				|| falseInput(firstPersonType) || falseInput(secondPersonUser)|| falseInput(secondPersonType)||
				falseInput(Long.toString(date)))
			return null;
		long firstPersonID = emp.getID(changerUser, firstPersonUser,
				firstPersonType);
		long changerID = emp.getIDOfManager(changerUser);
		if (firstPersonID == -1)
			return "Creation failes because the employee was not defined before";
		long secondPersonID = emp.getID(changerUser, secondPersonUser,
				secondPersonType);
		if (secondPersonID == -1)
			return "Creation failes because the second employee was not defined before";
		return activity.reassign(activityID, firstPersonID, firstPersonType,
				secondPersonID, secondPersonType, date, changerID);
	}

	public String changeState(long activityID, String personType,
			long state, String personUser, long date) {// only each employee
														// could change state of
														// activity
		if (falseInput(personType)||falseInput(Long.toString(state))||
				falseInput(personUser)||falseInput(Long.toString(date)))
			return null;
		long personID = emp.getIDOfPerson(personUser, personType);
		if (personID == -1)
			return "Creation failes because the employee was not defined before";
		return activity.changeState(activityID, personType, personID,
				personID, state, date);

	}

	public String preciseDescription(long activityID, String personType,
			String description, String personUser) {
		if (falseInput(personType)||falseInput(description)||
				falseInput(personUser))
			return null;
		long personID = emp.getIDOfPerson(personUser, personType);
		if (personID == -1)
			return "Creation failes because the employee was not defined before";
		return activity.preciseDescription(activityID, personType, personID,
				description);
	}

	public String extendDeadline(long activityID, String type,
			long deadline, String assignedUser, long date, String changerUser) {
		if (falseInput(Long.toString(deadline))||falseInput(type)
				|| falseInput(assignedUser) || falseInput(Long.toString(date)) ||
				falseInput(changerUser))
			return null;
		long personID = emp.getIDOfPerson(assignedUser, type);
		long changerID = emp.getIDOfManager(changerUser);
		if (personID == -1)
			return "Creation failes because the employee was not defined before";
		return activity.extendDeadline(activityID, type, personID, changerID,
				deadline, date);

	}

	public String unActivateActivity(long activityID, String personType,
			String personUser, String changerUser, long date) {
		if (falseInput(personType)||falseInput(personUser)||
				falseInput(changerUser)||falseInput(Long.toString(date)))
			return null;
		long personID = emp.getIDOfPerson(personUser, personType);
		long changerID = emp.getIDOfManager(changerUser);
		if (personID == -1)
			return "Creation failes because the employee was not defined before";
		return activity.unActivateActivity(activityID, personType, personID,
				changerID, date);
	}

	public String addResourceToActivity(long activityID, String type,
			String resourceName, String resourcePlace, long resourceQuantity,
			String assignedUser) {
		if (falseInput(resourceName)||falseInput(type)||
				falseInput(resourcePlace)||falseInput(Long.toString(resourceQuantity))||
				falseInput(assignedUser))
			return null;
		long personID = emp.getIDOfPerson(assignedUser, type);
		if (personID == -1)
			return "adding resource failes because the employee was not defined before";
		return activity.addResourceToActivity(activityID, type, personID,
				resourceName, resourcePlace, resourceQuantity);
	}

	public String defineResourceForOrganization(String name, String place,
			int inHand) {
		if (falseInput(name)||falseInput(place)||falseInput(Integer.toString(inHand)))
			return null;
		return activity.defineResourceForOrganization(name, place, inHand);
	}

	public String addReportToActivity(long activityID, String type,
			String title, String reportpath,
			String assignedUser, long date) {
		if (falseInput(title)||falseInput(type)||falseInput(reportpath)
				|| falseInput(assignedUser) || falseInput(Long.toString(date)))
			return null;
		long personID = emp.getIDOfPerson(assignedUser, type);
		if (personID == -1)
			return "adding report failes because the employee was not defined before";
		return activity.addReportToActivity(activityID, type, title,
				personID, reportpath, date);
	}

	public String changeResourceQuantityOfActivity(long activityID,
			String type, String resourceName, String resourcePlace,
			long resourceQuantity, String assignedUser) {
		if (falseInput(resourceName)||falseInput(type)|| falseInput(resourcePlace)||
				falseInput(Long.toString(resourceQuantity))|| falseInput(assignedUser))
			return null;
		long personID = emp.getIDOfPerson(assignedUser, type);
		if (personID == -1)
			return "adding report failes because the employee was not defined before";
		return activity.changeResourceQuantityOfActivity(activityID, type,
				personID, resourceName, resourcePlace, resourceQuantity);
	}

	public String changeResourceQuantityOfOrganization(String name,
			String place, long inHand) {
		if (falseInput(place)||falseInput(name)||falseInput(Long.toString(inHand)))
			return null;
		return activity.changeResourceQuantityOfOrganization(name, place,
				inHand);
	}

	public Activity[] uncompletedActivityUntilDateOfSpecialPerson(String type,
			long date, String user) {
		if (falseInput(user)||falseInput(Long.toString(date))||falseInput(type))
			return null;
		long personID = emp.getIDOfPerson(user, type);
		return report.uncompletedActivityUntilDateOfSpecialPerson(personID,
				type, date);
	}

	public Activity uncompleted(String type, long date, String user) {
		if (falseInput(user)||falseInput(Long.toString(date))||falseInput(type))
			return null;
		long personID = emp.getIDOfPerson(user, type);
		return report.uncompletedActivityUntilDateOfSpecialPerson(personID,
				type, date)[0];
	}

	public Activity[] uncompletedActivityUntilDateOfsubsidary(long date,
			String user) {
		if (falseInput(user)||falseInput(Long.toString(date)))
			return null;
		long managerID = emp.getIDOfPerson(user, "manager");
		return report.uncompletedActivityUntilDateOfsubsidary(managerID, date);
	}

	public Activity[] completedActivityBetweenDatesEmployee(String user,
			String type, long firstDate, long lastDate) {
		if (falseInput(user)||falseInput(Long.toString(firstDate))||falseInput(type)||
				falseInput(Long.toString(lastDate)))
			return null;
		long personID = emp.getIDOfPerson(user, type);
		return report.completedActivityBetweenDatesEmployee(personID, type,
				firstDate, lastDate);
	}

	public Activity[] completedActivityBetweenDatesSubsidary(String user,
			long firstDate, long lastDate) {
		if (falseInput(user)||falseInput(Long.toString(firstDate))||falseInput(Long.toString(lastDate)))
			return null;
		long managerID = emp.getIDOfPerson(user, "manager");
		return report.completedActivityBetweenDatesSubsidary(managerID,
				firstDate, lastDate);
	}

	public Activity[] unCompletedActivityBetweenDatesEmployee(String user,
			String type, long firstDate, long lastDate) {
		if (falseInput(user)||falseInput(Long.toString(firstDate))||falseInput(type)||
				falseInput(Long.toString(lastDate)))
			return null;
		long personID = emp.getIDOfPerson(user, type);
		return report.unCompletedActivityBetweenDatesEmployee(personID, type,
				firstDate, lastDate);
	}

	public Activity[] unCompletedActivityBetweenDatesSubsidary(String user,
			long firstDate, long lastDate) {
		if (falseInput(user)||falseInput(Long.toString(firstDate))||falseInput(Long.toString(lastDate)))
			return null;
		long managerID = emp.getIDOfPerson(user, "manager");
		return report.unCompletedActivityBetweenDatesSubsidary(managerID,
				firstDate, lastDate);
	}

	public Activity[] allActivityBetweenDatesEmployee(String user, String type,
			long firstDate, long lastDate) {
		if (falseInput(user)||falseInput(Long.toString(firstDate))||falseInput(type)||
				falseInput(Long.toString(lastDate)))
			return null;
		long personID = emp.getIDOfPerson(user, type);
		return report.allActivityBetweenDatesEmployee(personID, type,
				firstDate, lastDate);
	}

	public Activity[] allActivityBetweenDatesSubsidary(String user,
			long firstDate, long lastDate) {
		if (falseInput(user)||falseInput(Long.toString(firstDate))
				||falseInput(Long.toString(lastDate)))
			return null;
		long managerID = emp.getIDOfPerson(user, "manager");
		return report.allActivityBetweenDatesSubsidary(managerID, firstDate,
				lastDate);
	}

	public Person[] getPersonel(String type) {
		if (falseInput(type))
			return null;
		return report.getPersonel(type);
	}

	public Department[] getDepartments() {
		return report.getDepartments();
	}

	public Person[] getPersonelWithName(String type, String name) {
		if (falseInput(name)||falseInput(type))
			return null;
		return report.getPersonelWithName(type, name);
	}

	public Department[] getDepartmentsWithName(String name) {
		if (falseInput(name))
			return null;
		return report.getDepartmentsWithName(name);
	}

	public String[] getLocation() {
		return report.getLocation();
	}

	public String[] getLocationWithName(String name) {
		if (falseInput(name))
			return null;
		return report.getLocationWithName(name);
	}

	public Report[] viewReportOfActivity(String user, String type, long ActivityID) {
		if (falseInput(user)||falseInput(type))
			return null;
		long personID = emp.getIDOfPerson(user, type);
		return report.viewReportOfActivity(ActivityID);
	}

	public int getReportCountOfActivity(String user, String type,
			 long ActivityID) {
		if (falseInput(user)||falseInput(type))
			return -1;
		long personID = emp.getIDOfPerson(user, type);
		return report.getReportCountOfActivity(ActivityID);
	}

	public Resource[] viewResourceOfOrganization() {
		return report.viewResourceOfOrganization();
	}

	public Resource[] viewResourceOfActivity(String user, String type,
			long ActivityID) {
		if (falseInput(user)||falseInput(type))
			return null;
		long personID = emp.getIDOfPerson(user, type);
		return report.viewResourceOfActivity(ActivityID);
	}

	// public boolean AuthenticatePerson(String user, String password, String
	// type) {
	// if (type.compareTo("employee") == 0)
	// return emp.authenticateEmployee(user, password);
	// else
	// return emp.authenticateManager(user, password);
	// }
	public int personAuthentication(String user, String password, String type) {
		if (falseInput(user)||falseInput(password)||falseInput(type))
			return 0;
		if (type.compareTo("employee") == 0) {
			if (emp.authenticateEmployee(user, password))
				return 1;
			else
				return 0;
		} else if (type.compareTo("manager")==0){
			if (emp.authenticateManager(user, password))
				return 1;
			else
				return 0;

		}else {
			if (emp.authenticateUser(user, password)){
				return 1;
			}else
				return 0;
		}
	}

	public String hello() {
		return "hello";
	}

	public int[] intArray() {
		int[] i = new int[3];
		i[0] = 0;
		i[1] = 1;
		i[2] = 2;
		return i;
	}

	public int returnInteger() {
		return 2;
	}

	public String[] intDynamicArray(int i) {
		if (falseInput(Integer.toBinaryString(i)))
			return null;
		String[] l = new String[i];
		for (int j = 0; j < i; j++) {
			l[j] = Integer.toString(j);
		}
		return l;
	}

	public ShamsiDate miladiToShamsi(int iMiladiYear, int iMiladiMonth,
			int iMiladiDay) {
		if (falseInput(Integer.toString(iMiladiDay))||falseInput(Integer.toString(iMiladiMonth))
				||falseInput(Integer.toString(iMiladiYear)))
			return null;
		ShamsiDate s = report.MiladiToShamsi(iMiladiYear, iMiladiMonth,
				iMiladiDay);
		return s;
	}

	public Person[] getPersonelOfDepartment(String type, String user) {
		if (falseInput(type))
			return null;
		Person p=emp.getEmployee(emp.getIDOfPerson(user, "manager"), "manager");
		long departmentID =emp.getDepartmentID(p.getDepartment(), p.getLocation());
		return report.getPersonel(type, departmentID);
	}

	public Person[] getSubsidaryPersonel(String type, String user) {
		if (falseInput(type))
			return null;
		Person p=emp.getEmployee(emp.getIDOfPerson(user, "manager"), "manager");
		long departmentID = emp.getDepartmentID(p.getDepartment(), p.getLocation());
		return report.getSubsidaryPersonel(type, departmentID);
	}

	public Person getPerson(long employeeID, String type) {
		if (falseInput(Long.toString(employeeID)) ||falseInput(type))
			return null;
		return emp.getEmployee(employeeID, type);
	}

	public Resource[] viewUsedResource(String user) {// service for checking
														// how much resource is
		if (falseInput(user))
			return null;												// allocated until now
		return report.viewUsedResource(user);
	}

	public Resource[] viewAvailableResource(String user) {// service for
		if (falseInput(user))
			return null;													// checking
		return report.viewAvailableResource(user);
	}

	public Activity[] getSubsidaryActivity( long activityID,String user, String type) {
		if (falseInput(user)||falseInput(type))
			return null;
		return report.getSubsidaryActivity(activityID);
	}

	public ActivityLogItem[] stateAvoidedChangeOneEmployee(String personUser,
			String personType) {
		if (falseInput(personUser)||falseInput(personType))
			return null;
		long personID = emp.getIDOfPerson(personUser, personType);
		return log.stateAvoidedChangeOneEmployee(personID, personType);
	}

	public ActivityLogItem[] stateAvoidedChangeAllEmployee(String managerUser) {
		if (falseInput(managerUser))
			return null;
		long managerID = emp.getIDOfPerson(managerUser, "manager");
		return log.stateAvoidedChangeAllEmployee(managerID);
	}

	public ActivityLogItem[] removedActivityReport(String managerUser) {
		if (falseInput(managerUser))
			return null;
		long managerID = emp.getIDOfPerson(managerUser, "manager");
		return log.removedActivityReport(managerID);
	}

	public ActivityLogItem[] refrenceChangeReport(String managerUser) {
		if (falseInput(managerUser))
			return null;
		long managerID = emp.getIDOfPerson(managerUser, "manager");
		return log.refrenceChangeReport(managerID);
	}

	public ActivityLogItem[] deadLineChangeOfActivity(long activityID) {
		if (falseInput(Long.toString(activityID)))
			return null;
		return log.deadLineChangeOfActivity(activityID);
	}

	public ActivityLogItem[] allChangesOfActivity(long activityID) {
		if (falseInput(Long.toString(activityID)))
			return null;
		return log.allChangesOfActivity(activityID);
	}
	public String defineUser(String user, String password, String type) {
		if (falseInput(type)||falseInput(user)||falseInput(password))
			return null;
		return emp.defineUser(user, password, type);
	}
	public String changePassowrd(String user,String oldPassword,String type,String newPassword) {
		if (falseInput(type)||falseInput(user)||falseInput(oldPassword)||falseInput(newPassword))
			return null;
		if (personAuthentication(user,oldPassword,type)==0)
			return "authentication failed";
		else
			return emp.changePassowrd(user, type,newPassword);
	}
	public Activity[] completedActivityTodaySubsidary(String  type,String user,
			long date){
		if (falseInput(type)||falseInput(user)||falseInput(Long.toString(date)))
			return null;
		long managerID = emp.getIDOfPerson(user, "manager");
		return report.completedActivityTodaySubsidary(managerID, date);
	}
	private boolean falseInput(String input){
		if (input.indexOf(';')==-1 && input.indexOf('\'')==-1)
			return false;
		else 
			return true;
	}
	public String getActivity(long activityID){
		return activity.getActivityName(activityID);
	}
}
