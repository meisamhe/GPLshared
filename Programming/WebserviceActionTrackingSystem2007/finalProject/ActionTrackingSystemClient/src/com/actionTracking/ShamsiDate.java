/**
 * ShamsiDate.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.actionTracking;

public class ShamsiDate  implements java.io.Serializable {
    private int IDay;

    private int IMonth;

    private int IYear;

    public ShamsiDate() {
    }

    public ShamsiDate(
           int IDay,
           int IMonth,
           int IYear) {
           this.IDay = IDay;
           this.IMonth = IMonth;
           this.IYear = IYear;
    }


    /**
     * Gets the IDay value for this ShamsiDate.
     * 
     * @return IDay
     */
    public int getIDay() {
        return IDay;
    }


    /**
     * Sets the IDay value for this ShamsiDate.
     * 
     * @param IDay
     */
    public void setIDay(int IDay) {
        this.IDay = IDay;
    }


    /**
     * Gets the IMonth value for this ShamsiDate.
     * 
     * @return IMonth
     */
    public int getIMonth() {
        return IMonth;
    }


    /**
     * Sets the IMonth value for this ShamsiDate.
     * 
     * @param IMonth
     */
    public void setIMonth(int IMonth) {
        this.IMonth = IMonth;
    }


    /**
     * Gets the IYear value for this ShamsiDate.
     * 
     * @return IYear
     */
    public int getIYear() {
        return IYear;
    }


    /**
     * Sets the IYear value for this ShamsiDate.
     * 
     * @param IYear
     */
    public void setIYear(int IYear) {
        this.IYear = IYear;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof ShamsiDate)) return false;
        ShamsiDate other = (ShamsiDate) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            this.IDay == other.getIDay() &&
            this.IMonth == other.getIMonth() &&
            this.IYear == other.getIYear();
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
        _hashCode += getIDay();
        _hashCode += getIMonth();
        _hashCode += getIYear();
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(ShamsiDate.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://actionTracking.com", "ShamsiDate"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("IDay");
        elemField.setXmlName(new javax.xml.namespace.QName("http://actionTracking.com", "IDay"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("IMonth");
        elemField.setXmlName(new javax.xml.namespace.QName("http://actionTracking.com", "IMonth"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("IYear");
        elemField.setXmlName(new javax.xml.namespace.QName("http://actionTracking.com", "IYear"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
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
