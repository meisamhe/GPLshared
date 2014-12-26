/**
 * MainService.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.actionTracking;

public interface MainService extends java.rmi.Remote {
    public java.lang.String[] getLocation() throws java.rmi.RemoteException;
    public java.lang.String changeState(long activityID, java.lang.String personType, long state, java.lang.String personUser, long date) throws java.rmi.RemoteException;
    public java.lang.String getActivity(long activityID) throws java.rmi.RemoteException;
    public int[] intArray() throws java.rmi.RemoteException;
    public java.lang.String reassign(long activityID, java.lang.String changerUser, java.lang.String firstPersonUser, java.lang.String firstPersonType, java.lang.String secondPersonUser, java.lang.String secondPersonType, long date) throws java.rmi.RemoteException;
    public java.lang.String defineEmployee(java.lang.String name, java.lang.String family, java.lang.String user, java.lang.String password, java.lang.String department, java.lang.String location) throws java.rmi.RemoteException;
    public java.lang.String defineDepartment(java.lang.String name, java.lang.String location, java.lang.String upperDepartmentName, java.lang.String upperDepartmentLocation) throws java.rmi.RemoteException;
    public java.lang.String defineManager(java.lang.String name, java.lang.String family, java.lang.String user, java.lang.String password, java.lang.String department, java.lang.String location) throws java.rmi.RemoteException;
    public java.lang.String replaceEmployee(java.lang.String user, java.lang.String secondName, java.lang.String secondFamily, java.lang.String secondUser, java.lang.String secondPassword) throws java.rmi.RemoteException;
    public java.lang.String deleteEmployee(java.lang.String user) throws java.rmi.RemoteException;
    public java.lang.String replaceManager(java.lang.String user, java.lang.String secondName, java.lang.String secondFamily, java.lang.String secondUser, java.lang.String secondPassword) throws java.rmi.RemoteException;
    public java.lang.String defineActivity(java.lang.String name, java.lang.String description, long deadline, long initializedDate, java.lang.String personUser, java.lang.String personType, java.lang.String assignedByUser, long upperActivityID) throws java.rmi.RemoteException;
    public java.lang.String preciseDescription(long activityID, java.lang.String personType, java.lang.String description, java.lang.String personUser) throws java.rmi.RemoteException;
    public java.lang.String extendDeadline(long activityID, java.lang.String type, long deadline, java.lang.String assignedUser, long date, java.lang.String changerUser) throws java.rmi.RemoteException;
    public java.lang.String unActivateActivity(long activityID, java.lang.String personType, java.lang.String personUser, java.lang.String changerUser, long date) throws java.rmi.RemoteException;
    public java.lang.String addResourceToActivity(long activityID, java.lang.String type, java.lang.String resourceName, java.lang.String resourcePlace, long resourceQuantity, java.lang.String assignedUser) throws java.rmi.RemoteException;
    public java.lang.String defineResourceForOrganization(java.lang.String name, java.lang.String place, int inHand) throws java.rmi.RemoteException;
    public java.lang.String addReportToActivity(long activityID, java.lang.String type, java.lang.String title, java.lang.String reportpath, java.lang.String assignedUser, long date) throws java.rmi.RemoteException;
    public java.lang.String changeResourceQuantityOfActivity(long activityID, java.lang.String type, java.lang.String resourceName, java.lang.String resourcePlace, long resourceQuantity, java.lang.String assignedUser) throws java.rmi.RemoteException;
    public java.lang.String changeResourceQuantityOfOrganization(java.lang.String name, java.lang.String place, long inHand) throws java.rmi.RemoteException;
    public com.actionTracking.Activity[] uncompletedActivityUntilDateOfSpecialPerson(java.lang.String type, long date, java.lang.String user) throws java.rmi.RemoteException;
    public com.actionTracking.Activity uncompleted(java.lang.String type, long date, java.lang.String user) throws java.rmi.RemoteException;
    public com.actionTracking.Activity[] uncompletedActivityUntilDateOfsubsidary(long date, java.lang.String user) throws java.rmi.RemoteException;
    public com.actionTracking.Activity[] completedActivityBetweenDatesEmployee(java.lang.String user, java.lang.String type, long firstDate, long lastDate) throws java.rmi.RemoteException;
    public com.actionTracking.Activity[] completedActivityBetweenDatesSubsidary(java.lang.String user, long firstDate, long lastDate) throws java.rmi.RemoteException;
    public com.actionTracking.Activity[] unCompletedActivityBetweenDatesEmployee(java.lang.String user, java.lang.String type, long firstDate, long lastDate) throws java.rmi.RemoteException;
    public com.actionTracking.Activity[] unCompletedActivityBetweenDatesSubsidary(java.lang.String user, long firstDate, long lastDate) throws java.rmi.RemoteException;
    public com.actionTracking.Activity[] allActivityBetweenDatesEmployee(java.lang.String user, java.lang.String type, long firstDate, long lastDate) throws java.rmi.RemoteException;
    public com.actionTracking.Activity[] allActivityBetweenDatesSubsidary(java.lang.String user, long firstDate, long lastDate) throws java.rmi.RemoteException;
    public com.actionTracking.Person[] getPersonel(java.lang.String type) throws java.rmi.RemoteException;
    public com.actionTracking.Department[] getDepartments() throws java.rmi.RemoteException;
    public com.actionTracking.Person[] getPersonelWithName(java.lang.String type, java.lang.String name) throws java.rmi.RemoteException;
    public com.actionTracking.Department[] getDepartmentsWithName(java.lang.String name) throws java.rmi.RemoteException;
    public java.lang.String[] getLocationWithName(java.lang.String name) throws java.rmi.RemoteException;
    public com.actionTracking.Report[] viewReportOfActivity(java.lang.String user, java.lang.String type, long activityID) throws java.rmi.RemoteException;
    public int getReportCountOfActivity(java.lang.String user, java.lang.String type, long activityID) throws java.rmi.RemoteException;
    public com.actionTracking.Resource[] viewResourceOfOrganization() throws java.rmi.RemoteException;
    public com.actionTracking.Resource[] viewResourceOfActivity(java.lang.String user, java.lang.String type, long activityID) throws java.rmi.RemoteException;
    public int personAuthentication(java.lang.String user, java.lang.String password, java.lang.String type) throws java.rmi.RemoteException;
    public java.lang.String hello() throws java.rmi.RemoteException;
    public int returnInteger() throws java.rmi.RemoteException;
    public java.lang.String[] intDynamicArray(int i) throws java.rmi.RemoteException;
    public com.actionTracking.ShamsiDate miladiToShamsi(int iMiladiYear, int iMiladiMonth, int iMiladiDay) throws java.rmi.RemoteException;
    public com.actionTracking.Person[] getPersonelOfDepartment(java.lang.String type, java.lang.String user) throws java.rmi.RemoteException;
    public com.actionTracking.Person[] getSubsidaryPersonel(java.lang.String type, java.lang.String user) throws java.rmi.RemoteException;
    public com.actionTracking.Person getPerson(long employeeID, java.lang.String type) throws java.rmi.RemoteException;
    public com.actionTracking.Resource[] viewUsedResource(java.lang.String user) throws java.rmi.RemoteException;
    public com.actionTracking.Resource[] viewAvailableResource(java.lang.String user) throws java.rmi.RemoteException;
    public com.actionTracking.Activity[] getSubsidaryActivity(long activityID, java.lang.String user, java.lang.String type) throws java.rmi.RemoteException;
    public com.actionTracking.ActivityLogItem[] stateAvoidedChangeOneEmployee(java.lang.String personUser, java.lang.String personType) throws java.rmi.RemoteException;
    public com.actionTracking.ActivityLogItem[] stateAvoidedChangeAllEmployee(java.lang.String managerUser) throws java.rmi.RemoteException;
    public com.actionTracking.ActivityLogItem[] removedActivityReport(java.lang.String managerUser) throws java.rmi.RemoteException;
    public com.actionTracking.ActivityLogItem[] refrenceChangeReport(java.lang.String managerUser) throws java.rmi.RemoteException;
    public com.actionTracking.ActivityLogItem[] deadLineChangeOfActivity(long activityID) throws java.rmi.RemoteException;
    public com.actionTracking.ActivityLogItem[] allChangesOfActivity(long activityID) throws java.rmi.RemoteException;
    public java.lang.String defineUser(java.lang.String user, java.lang.String password, java.lang.String type) throws java.rmi.RemoteException;
    public java.lang.String changePassowrd(java.lang.String user, java.lang.String oldPassword, java.lang.String type, java.lang.String newPassword) throws java.rmi.RemoteException;
    public com.actionTracking.Activity[] completedActivityTodaySubsidary(java.lang.String type, java.lang.String user, long date) throws java.rmi.RemoteException;
}
