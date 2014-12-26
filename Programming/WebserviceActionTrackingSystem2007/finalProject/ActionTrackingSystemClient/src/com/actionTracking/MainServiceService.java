/**
 * MainServiceService.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.actionTracking;

public interface MainServiceService extends javax.xml.rpc.Service {
    public java.lang.String getMainServiceAddress();

    public com.actionTracking.MainService getMainService() throws javax.xml.rpc.ServiceException;

    public com.actionTracking.MainService getMainService(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
}
