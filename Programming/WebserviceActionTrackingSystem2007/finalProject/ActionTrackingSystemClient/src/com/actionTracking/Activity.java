/**
 * Activity.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.actionTracking;

public class Activity  implements java.io.Serializable {
    private long activityId;

    private com.actionTracking.Person assignedBy;

    private long deadline;

    private java.lang.String description;

    private com.actionTracking.Person employee;

    private long employeeID;

    private long initializedDate;

    private long lastUpdate;

    private java.lang.String name;

    private long state;

    private java.lang.String type;

    private long upperActivity;

    public Activity() {
    }

    public Activity(
           long activityId,
           com.actionTracking.Person assignedBy,
           long deadline,
           java.lang.String description,
           com.actionTracking.Person employee,
           long employeeID,
           long initializedDate,
           long lastUpdate,
           java.lang.String name,
           long state,
           java.lang.String type,
           long upperActivity) {
           this.activityId = activityId;
           this.assignedBy = assignedBy;
           this.deadline = deadline;
           this.description = description;
           this.employee = employee;
           this.employeeID = employeeID;
           this.initializedDate = initializedDate;
           this.lastUpdate = lastUpdate;
           this.name = name;
           this.state = state;
           this.type = type;
           this.upperActivity = upperActivity;
    }


    /**
     * Gets the activityId value for this Activity.
     * 
     * @return activityId
     */
    public long getActivityId() {
        return activityId;
    }


    /**
     * Sets the activityId value for this Activity.
     * 
     * @param activityId
     */
    public void setActivityId(long activityId) {
        this.activityId = activityId;
    }


    /**
     * Gets the assignedBy value for this Activity.
     * 
     * @return assignedBy
     */
    public com.actionTracking.Person getAssignedBy() {
        return assignedBy;
    }


    /**
     * Sets the assignedBy value for this Activity.
     * 
     * @param assignedBy
     */
    public void setAssignedBy(com.actionTracking.Person assignedBy) {
        this.assignedBy = assignedBy;
    }


    /**
     * Gets the deadline value for this Activity.
     * 
     * @return deadline
     */
    public long getDeadline() {
        return deadline;
    }


    /**
     * Sets the deadline value for this Activity.
     * 
     * @param deadline
     */
    public void setDeadline(long deadline) {
        this.deadline = deadline;
    }


    /**
     * Gets the description value for this Activity.
     * 
     * @return description
     */
    public java.lang.String getDescription() {
        return description;
    }


    /**
     * Sets the description value for this Activity.
     * 
     * @param description
     */
    public void setDescription(java.lang.String description) {
        this.description = description;
    }


    /**
     * Gets the employee value for this Activity.
     * 
     * @return employee
     */
    public com.actionTracking.Person getEmployee() {
        return employee;
    }


    /**
     * Sets the employee value for this Activity.
     * 
     * @param employee
     */
    public void setEmployee(com.actionTracking.Person employee) {
        this.employee = employee;
    }


    /**
     * Gets the employeeID value for this Activity.
     * 
     * @return employeeID
     */
    public long getEmployeeID() {
        return employeeID;
    }


    /**
     * Sets the employeeID value for this Activity.
     * 
     * @param employeeID
     */
    public void setEmployeeID(long employeeID) {
        this.employeeID = employeeID;
    }


    /**
     * Gets the initializedDate value for this Activity.
     * 
     * @return initializedDate
     */
    public long getInitializedDate() {
        return initializedDate;
    }


    /**
     * Sets the initializedDate value for this Activity.
     * 
     * @param initializedDate
     */
    public void setInitializedDate(long initializedDate) {
        this.initializedDate = initializedDate;
    }


    /**
     * Gets the lastUpdate value for this Activity.
     * 
     * @return lastUpdate
     */
    public long getLastUpdate() {
        return lastUpdate;
    }


    /**
     * Sets the lastUpdate value for this Activity.
     * 
     * @param lastUpdate
     */
    public void setLastUpdate(long lastUpdate) {
        this.lastUpdate = lastUpdate;
    }


    /**
     * Gets the name value for this Activity.
     * 
     * @return name
     */
    public java.lang.String getName() {
        return name;
    }


    /**
     * Sets the name value for this Activity.
     * 
     * @param name
     */
    public void setName(java.lang.String name) {
        this.name = name;
    }


    /**
     * Gets the state value for this Activity.
     * 
     * @return state
     */
    public long getState() {
        return state;
    }


    /**
     * Sets the state value for this Activity.
     * 
     * @param state
     */
    public void setState(long state) {
        this.state = state;
    }


    /**
     * Gets the type value for this Activity.
     * 
     * @return type
     */
    public java.lang.String getType() {
        return type;
    }


    /**
     * Sets the type value for this Activity.
     * 
     * @param type
     */
    public void setType(java.lang.String type) {
        this.type = type;
    }


    /**
     * Gets the upperActivity value for this Activity.
     * 
     * @return upperActivity
     */
    public long getUpperActivity() {
        return upperActivity;
    }


    /**
     * Sets the upperActivity value for this Activity.
     * 
     * @param upperActivity
     */
    public void setUpperActivity(long upperActivity) {
        this.upperActivity = upperActivity;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof Activity)) return false;
        Activity other = (Activity) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            this.activityId == other.getActivityId() &&
            ((this.assignedBy==null && other.getAssignedBy()==null) || 
             (this.assignedBy!=null &&
              this.assignedBy.equals(other.getAssignedBy()))) &&
            this.deadline == other.getDeadline() &&
            ((this.description==null && other.getDescription()==null) || 
             (this.description!=null &&
              this.description.equals(other.getDescription()))) &&
            ((this.employee==null && other.getEmployee()==null) || 
             (this.employee!=null &&
              this.employee.equals(other.getEmployee()))) &&
            this.employeeID == other.getEmployeeID() &&
            this.initializedDate == other.getInitializedDate() &&
            this.lastUpdate == other.getLastUpdate() &&
            ((this.name==null && other.getName()==null) || 
             (this.name!=null &&
              this.name.equals(other.getName()))) &&
            this.state == other.getState() &&
            ((this.type==null && other.getType()==null) || 
             (this.type!=null &&
              this.type.equals(other.getType()))) &&
            this.upperActivity == other.getUpperActivity();
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = 1;
        _hashCode += new Long(getActivityId()).hashCode();
        if (getAssignedBy() != null) {
            _hashCode += getAssignedBy().hashCode();
        }
        _hashCode += new Long(getDeadline()).hashCode();
        if (getDescription() != null) {
            _hashCode += getDescription().hashCode();
        }
        if (getEmployee() != null) {
            _hashCode += getEmployee().hashCode();
        }
        _hashCode += new Long(getEmployeeID()).hashCode();
        _hashCode += new Long(getInitializedDate()).hashCode();
        _hashCode += new Long(getLastUpdate()).hashCode();
        if (getName() != null) {
            _hashCode += getName().hashCode();
        }
        _hashCode += new Long(getState()).hashCode();
        if (getType() != null) {
            _hashCode += getType().hashCode();
        }
        _hashCode += new Long(getUpperActivity()).hashCode();
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(Activity.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://actionTracking.com", "Activity"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("activityId");
        elemField.setXmlName(new javax.xml.namespace.QName("http://actionTracking.com", "activityId"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("assignedBy");
        elemField.setXmlName(new javax.xml.namespace.QName("http://actionTracking.com", "assignedBy"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://actionTracking.com", "Person"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("deadline");
        elemField.setXmlName(new javax.xml.namespace.QName("http://actionTracking.com", "deadline"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("description");
        elemField.setXmlName(new javax.xml.namespace.QName("http://actionTracking.com", "description"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("employee");
        elemField.setXmlName(new javax.xml.namespace.QName("http://actionTracking.com", "employee"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://actionTracking.com", "Person"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("employeeID");
        elemField.setXmlName(new javax.xml.namespace.QName("http://actionTracking.com", "employeeID"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("initializedDate");
        elemField.setXmlName(new javax.xml.namespace.QName("http://actionTracking.com", "initializedDate"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("lastUpdate");
        elemField.setXmlName(new javax.xml.namespace.QName("http://actionTracking.com", "lastUpdate"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("name");
        elemField.setXmlName(new javax.xml.namespace.QName("http://actionTracking.com", "name"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("state");
        elemField.setXmlName(new javax.xml.namespace.QName("http://actionTracking.com", "state"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("type");
        elemField.setXmlName(new javax.xml.namespace.QName("http://actionTracking.com", "type"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("upperActivity");
        elemField.setXmlName(new javax.xml.namespace.QName("http://actionTracking.com", "upperActivity"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
    }

    /**
     * Return type metadata object
     */
    public static org.apache.axis.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

    /**
     * Get Custom Serializer
     */
    public static org.apache.axis.encoding.Serializer getSerializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanSerializer(
            _javaType, _xmlType, typeDesc);
    }

    /**
     * Get Custom Deserializer
     */
    public static org.apache.axis.encoding.Deserializer getDeserializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanDeserializer(
            _javaType, _xmlType, typeDesc);
    }

}
