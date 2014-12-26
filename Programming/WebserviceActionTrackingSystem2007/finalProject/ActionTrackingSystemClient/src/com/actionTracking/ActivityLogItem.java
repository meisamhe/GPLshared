/**
 * ActivityLogItem.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.actionTracking;

public class ActivityLogItem  implements java.io.Serializable {
    private long activityID;

    private java.lang.String changeType;

    private java.lang.String changerType;

    private long date;

    private java.lang.String oldType;

    private java.lang.String oldValue;

    private long personID;

    public ActivityLogItem() {
    }

    public ActivityLogItem(
           long activityID,
           java.lang.String changeType,
           java.lang.String changerType,
           long date,
           java.lang.String oldType,
           java.lang.String oldValue,
           long personID) {
           this.activityID = activityID;
           this.changeType = changeType;
           this.changerType = changerType;
           this.date = date;
           this.oldType = oldType;
           this.oldValue = oldValue;
           this.personID = personID;
    }


    /**
     * Gets the activityID value for this ActivityLogItem.
     * 
     * @return activityID
     */
    public long getActivityID() {
        return activityID;
    }


    /**
     * Sets the activityID value for this ActivityLogItem.
     * 
     * @param activityID
     */
    public void setActivityID(long activityID) {
        this.activityID = activityID;
    }


    /**
     * Gets the changeType value for this ActivityLogItem.
     * 
     * @return changeType
     */
    public java.lang.String getChangeType() {
        return changeType;
    }


    /**
     * Sets the changeType value for this ActivityLogItem.
     * 
     * @param changeType
     */
    public void setChangeType(java.lang.String changeType) {
        this.changeType = changeType;
    }


    /**
     * Gets the changerType value for this ActivityLogItem.
     * 
     * @return changerType
     */
    public java.lang.String getChangerType() {
        return changerType;
    }


    /**
     * Sets the changerType value for this ActivityLogItem.
     * 
     * @param changerType
     */
    public void setChangerType(java.lang.String changerType) {
        this.changerType = changerType;
    }


    /**
     * Gets the date value for this ActivityLogItem.
     * 
     * @return date
     */
    public long getDate() {
        return date;
    }


    /**
     * Sets the date value for this ActivityLogItem.
     * 
     * @param date
     */
    public void setDate(long date) {
        this.date = date;
    }


    /**
     * Gets the oldType value for this ActivityLogItem.
     * 
     * @return oldType
     */
    public java.lang.String getOldType() {
        return oldType;
    }


    /**
     * Sets the oldType value for this ActivityLogItem.
     * 
     * @param oldType
     */
    public void setOldType(java.lang.String oldType) {
        this.oldType = oldType;
    }


    /**
     * Gets the oldValue value for this ActivityLogItem.
     * 
     * @return oldValue
     */
    public java.lang.String getOldValue() {
        return oldValue;
    }


    /**
     * Sets the oldValue value for this ActivityLogItem.
     * 
     * @param oldValue
     */
    public void setOldValue(java.lang.String oldValue) {
        this.oldValue = oldValue;
    }


    /**
     * Gets the personID value for this ActivityLogItem.
     * 
     * @return personID
     */
    public long getPersonID() {
        return personID;
    }


    /**
     * Sets the personID value for this ActivityLogItem.
     * 
     * @param personID
     */
    public void setPersonID(long personID) {
        this.personID = personID;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof ActivityLogItem)) return false;
        ActivityLogItem other = (ActivityLogItem) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            this.activityID == other.getActivityID() &&
            ((this.changeType==null && other.getChangeType()==null) || 
             (this.changeType!=null &&
              this.changeType.equals(other.getChangeType()))) &&
            ((this.changerType==null && other.getChangerType()==null) || 
             (this.changerType!=null &&
              this.changerType.equals(other.getChangerType()))) &&
            this.date == other.getDate() &&
            ((this.oldType==null && other.getOldType()==null) || 
             (this.oldType!=null &&
              this.oldType.equals(other.getOldType()))) &&
            ((this.oldValue==null && other.getOldValue()==null) || 
             (this.oldValue!=null &&
              this.oldValue.equals(other.getOldValue()))) &&
            this.personID == other.getPersonID();
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
        _hashCode += new Long(getActivityID()).hashCode();
        if (getChangeType() != null) {
            _hashCode += getChangeType().hashCode();
        }
        if (getChangerType() != null) {
            _hashCode += getChangerType().hashCode();
        }
        _hashCode += new Long(getDate()).hashCode();
        if (getOldType() != null) {
            _hashCode += getOldType().hashCode();
        }
        if (getOldValue() != null) {
            _hashCode += getOldValue().hashCode();
        }
        _hashCode += new Long(getPersonID()).hashCode();
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(ActivityLogItem.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://actionTracking.com", "ActivityLogItem"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("activityID");
        elemField.setXmlName(new javax.xml.namespace.QName("http://actionTracking.com", "activityID"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("changeType");
        elemField.setXmlName(new javax.xml.namespace.QName("http://actionTracking.com", "changeType"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("changerType");
        elemField.setXmlName(new javax.xml.namespace.QName("http://actionTracking.com", "changerType"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("date");
        elemField.setXmlName(new javax.xml.namespace.QName("http://actionTracking.com", "date"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("oldType");
        elemField.setXmlName(new javax.xml.namespace.QName("http://actionTracking.com", "oldType"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("oldValue");
        elemField.setXmlName(new javax.xml.namespace.QName("http://actionTracking.com", "oldValue"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("personID");
        elemField.setXmlName(new javax.xml.namespace.QName("http://actionTracking.com", "personID"));
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
