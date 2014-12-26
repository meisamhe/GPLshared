package com.actionTracking;

public class MainServiceProxy implements com.actionTracking.MainService {
  private String _endpoint = null;
  private com.actionTracking.MainService mainService = null;
  
  public MainServiceProxy() {
    _initMainServiceProxy();
  }
  
  public MainServiceProxy(String endpoint) {
    _endpoint = endpoint;
    _initMainServiceProxy();
  }
  
  private void _initMainServiceProxy() {
    try {
      mainService = (new com.actionTracking.MainServiceServiceLocator()).getMainService();
      if (mainService != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)mainService)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)mainService)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (mainService != null)
      ((javax.xml.rpc.Stub)mainService)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.actionTracking.MainService getMainService() {
    if (mainService == null)
      _initMainServiceProxy();
    return mainService;
  }
  
  public java.lang.String[] getLocation() throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.getLocation();
  }
  
  public java.lang.String changeState(long activityID, java.lang.String personType, long state, java.lang.String personUser, long date) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.changeState(activityID, personType, state, personUser, date);
  }
  
  public java.lang.String getActivity(long activityID) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.getActivity(activityID);
  }
  
  public int[] intArray() throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.intArray();
  }
  
  public java.lang.String reassign(long activityID, java.lang.String changerUser, java.lang.String firstPersonUser, java.lang.String firstPersonType, java.lang.String secondPersonUser, java.lang.String secondPersonType, long date) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.reassign(activityID, changerUser, firstPersonUser, firstPersonType, secondPersonUser, secondPersonType, date);
  }
  
  public java.lang.String defineEmployee(java.lang.String name, java.lang.String family, java.lang.String user, java.lang.String password, java.lang.String department, java.lang.String location) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.defineEmployee(name, family, user, password, department, location);
  }
  
  public java.lang.String defineDepartment(java.lang.String name, java.lang.String location, java.lang.String upperDepartmentName, java.lang.String upperDepartmentLocation) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.defineDepartment(name, location, upperDepartmentName, upperDepartmentLocation);
  }
  
  public java.lang.String defineManager(java.lang.String name, java.lang.String family, java.lang.String user, java.lang.String password, java.lang.String department, java.lang.String location) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.defineManager(name, family, user, password, department, location);
  }
  
  public java.lang.String replaceEmployee(java.lang.String user, java.lang.String secondName, java.lang.String secondFamily, java.lang.String secondUser, java.lang.String secondPassword) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.replaceEmployee(user, secondName, secondFamily, secondUser, secondPassword);
  }
  
  public java.lang.String deleteEmployee(java.lang.String user) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.deleteEmployee(user);
  }
  
  public java.lang.String replaceManager(java.lang.String user, java.lang.String secondName, java.lang.String secondFamily, java.lang.String secondUser, java.lang.String secondPassword) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.replaceManager(user, secondName, secondFamily, secondUser, secondPassword);
  }
  
  public java.lang.String defineActivity(java.lang.String name, java.lang.String description, long deadline, long initializedDate, java.lang.String personUser, java.lang.String personType, java.lang.String assignedByUser, long upperActivityID) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.defineActivity(name, description, deadline, initializedDate, personUser, personType, assignedByUser, upperActivityID);
  }
  
  public java.lang.String preciseDescription(long activityID, java.lang.String personType, java.lang.String description, java.lang.String personUser) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.preciseDescription(activityID, personType, description, personUser);
  }
  
  public java.lang.String extendDeadline(long activityID, java.lang.String type, long deadline, java.lang.String assignedUser, long date, java.lang.String changerUser) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.extendDeadline(activityID, type, deadline, assignedUser, date, changerUser);
  }
  
  public java.lang.String unActivateActivity(long activityID, java.lang.String personType, java.lang.String personUser, java.lang.String changerUser, long date) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.unActivateActivity(activityID, personType, personUser, changerUser, date);
  }
  
  public java.lang.String addResourceToActivity(long activityID, java.lang.String type, java.lang.String resourceName, java.lang.String resourcePlace, long resourceQuantity, java.lang.String assignedUser) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.addResourceToActivity(activityID, type, resourceName, resourcePlace, resourceQuantity, assignedUser);
  }
  
  public java.lang.String defineResourceForOrganization(java.lang.String name, java.lang.String place, int inHand) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.defineResourceForOrganization(name, place, inHand);
  }
  
  public java.lang.String addReportToActivity(long activityID, java.lang.String type, java.lang.String title, java.lang.String reportpath, java.lang.String assignedUser, long date) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.addReportToActivity(activityID, type, title, reportpath, assignedUser, date);
  }
  
  public java.lang.String changeResourceQuantityOfActivity(long activityID, java.lang.String type, java.lang.String resourceName, java.lang.String resourcePlace, long resourceQuantity, java.lang.String assignedUser) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.changeResourceQuantityOfActivity(activityID, type, resourceName, resourcePlace, resourceQuantity, assignedUser);
  }
  
  public java.lang.String changeResourceQuantityOfOrganization(java.lang.String name, java.lang.String place, long inHand) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.changeResourceQuantityOfOrganization(name, place, inHand);
  }
  
  public com.actionTracking.Activity[] uncompletedActivityUntilDateOfSpecialPerson(java.lang.String type, long date, java.lang.String user) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.uncompletedActivityUntilDateOfSpecialPerson(type, date, user);
  }
  
  public com.actionTracking.Activity uncompleted(java.lang.String type, long date, java.lang.String user) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.uncompleted(type, date, user);
  }
  
  public com.actionTracking.Activity[] uncompletedActivityUntilDateOfsubsidary(long date, java.lang.String user) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.uncompletedActivityUntilDateOfsubsidary(date, user);
  }
  
  public com.actionTracking.Activity[] completedActivityBetweenDatesEmployee(java.lang.String user, java.lang.String type, long firstDate, long lastDate) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.completedActivityBetweenDatesEmployee(user, type, firstDate, lastDate);
  }
  
  public com.actionTracking.Activity[] completedActivityBetweenDatesSubsidary(java.lang.String user, long firstDate, long lastDate) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.completedActivityBetweenDatesSubsidary(user, firstDate, lastDate);
  }
  
  public com.actionTracking.Activity[] unCompletedActivityBetweenDatesEmployee(java.lang.String user, java.lang.String type, long firstDate, long lastDate) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.unCompletedActivityBetweenDatesEmployee(user, type, firstDate, lastDate);
  }
  
  public com.actionTracking.Activity[] unCompletedActivityBetweenDatesSubsidary(java.lang.String user, long firstDate, long lastDate) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.unCompletedActivityBetweenDatesSubsidary(user, firstDate, lastDate);
  }
  
  public com.actionTracking.Activity[] allActivityBetweenDatesEmployee(java.lang.String user, java.lang.String type, long firstDate, long lastDate) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.allActivityBetweenDatesEmployee(user, type, firstDate, lastDate);
  }
  
  public com.actionTracking.Activity[] allActivityBetweenDatesSubsidary(java.lang.String user, long firstDate, long lastDate) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.allActivityBetweenDatesSubsidary(user, firstDate, lastDate);
  }
  
  public com.actionTracking.Person[] getPersonel(java.lang.String type) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.getPersonel(type);
  }
  
  public com.actionTracking.Department[] getDepartments() throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.getDepartments();
  }
  
  public com.actionTracking.Person[] getPersonelWithName(java.lang.String type, java.lang.String name) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.getPersonelWithName(type, name);
  }
  
  public com.actionTracking.Department[] getDepartmentsWithName(java.lang.String name) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.getDepartmentsWithName(name);
  }
  
  public java.lang.String[] getLocationWithName(java.lang.String name) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.getLocationWithName(name);
  }
  
  public com.actionTracking.Report[] viewReportOfActivity(java.lang.String user, java.lang.String type, long activityID) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.viewReportOfActivity(user, type, activityID);
  }
  
  public int getReportCountOfActivity(java.lang.String user, java.lang.String type, long activityID) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.getReportCountOfActivity(user, type, activityID);
  }
  
  public com.actionTracking.Resource[] viewResourceOfOrganization() throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.viewResourceOfOrganization();
  }
  
  public com.actionTracking.Resource[] viewResourceOfActivity(java.lang.String user, java.lang.String type, long activityID) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.viewResourceOfActivity(user, type, activityID);
  }
  
  public int personAuthentication(java.lang.String user, java.lang.String password, java.lang.String type) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.personAuthentication(user, password, type);
  }
  
  public java.lang.String hello() throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.hello();
  }
  
  public int returnInteger() throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.returnInteger();
  }
  
  public java.lang.String[] intDynamicArray(int i) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.intDynamicArray(i);
  }
  
  public com.actionTracking.ShamsiDate miladiToShamsi(int iMiladiYear, int iMiladiMonth, int iMiladiDay) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.miladiToShamsi(iMiladiYear, iMiladiMonth, iMiladiDay);
  }
  
  public com.actionTracking.Person getPerson(long employeeID, java.lang.String type) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.getPerson(employeeID, type);
  }
  
  public com.actionTracking.Resource[] viewUsedResource(java.lang.String user) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.viewUsedResource(user);
  }
  
  public com.actionTracking.Resource[] viewAvailableResource(java.lang.String user) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.viewAvailableResource(user);
  }
  
  public com.actionTracking.Activity[] getSubsidaryActivity(long activityID, java.lang.String user, java.lang.String type) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.getSubsidaryActivity(activityID, user, type);
  }
  
  public com.actionTracking.ActivityLogItem[] stateAvoidedChangeOneEmployee(java.lang.String personUser, java.lang.String personType) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.stateAvoidedChangeOneEmployee(personUser, personType);
  }
  
  public com.actionTracking.ActivityLogItem[] stateAvoidedChangeAllEmployee(java.lang.String managerUser) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.stateAvoidedChangeAllEmployee(managerUser);
  }
  
  public com.actionTracking.ActivityLogItem[] removedActivityReport(java.lang.String managerUser) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.removedActivityReport(managerUser);
  }
  
  public com.actionTracking.ActivityLogItem[] refrenceChangeReport(java.lang.String managerUser) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.refrenceChangeReport(managerUser);
  }
  
  public com.actionTracking.ActivityLogItem[] deadLineChangeOfActivity(long activityID) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.deadLineChangeOfActivity(activityID);
  }
  
  public com.actionTracking.ActivityLogItem[] allChangesOfActivity(long activityID) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.allChangesOfActivity(activityID);
  }
  
  public java.lang.String defineUser(java.lang.String user, java.lang.String password, java.lang.String type) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.defineUser(user, password, type);
  }
  
  public java.lang.String changePassowrd(java.lang.String user, java.lang.String oldPassword, java.lang.String type, java.lang.String newPassword) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.changePassowrd(user, oldPassword, type, newPassword);
  }
  
  public com.actionTracking.Activity[] completedActivityTodaySubsidary(java.lang.String type, java.lang.String user, long date) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.completedActivityTodaySubsidary(type, user, date);
  }
  
  public com.actionTracking.Person[] getPersonelOfDepartment(java.lang.String type, java.lang.String user) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.getPersonelOfDepartment(type, user);
  }
  
  public com.actionTracking.Person[] getSubsidaryPersonel(java.lang.String type, java.lang.String user) throws java.rmi.RemoteException{
    if (mainService == null)
      _initMainServiceProxy();
    return mainService.getSubsidaryPersonel(type, user);
  }
  
  
}