/**
 * MainServiceServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.actionTracking;

public class MainServiceServiceLocator extends org.apache.axis.client.Service implements com.actionTracking.MainServiceService {

    public MainServiceServiceLocator() {
    }


    public MainServiceServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public MainServiceServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for MainService
    private java.lang.String MainService_address = "http://localhost:8080/ActionTrackingSystem/services/MainService";

    public java.lang.String getMainServiceAddress() {
        return MainService_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String MainServiceWSDDServiceName = "MainService";

    public java.lang.String getMainServiceWSDDServiceName() {
        return MainServiceWSDDServiceName;
    }

    public void setMainServiceWSDDServiceName(java.lang.String name) {
        MainServiceWSDDServiceName = name;
    }

    public com.actionTracking.MainService getMainService() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(MainService_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getMainService(endpoint);
    }

    public com.actionTracking.MainService getMainService(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.actionTracking.MainServiceSoapBindingStub _stub = new com.actionTracking.MainServiceSoapBindingStub(portAddress, this);
            _stub.setPortName(getMainServiceWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setMainServiceEndpointAddress(java.lang.String address) {
        MainService_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.actionTracking.MainService.class.isAssignableFrom(serviceEndpointInterface)) {
                com.actionTracking.MainServiceSoapBindingStub _stub = new com.actionTracking.MainServiceSoapBindingStub(new java.net.URL(MainService_address), this);
                _stub.setPortName(getMainServiceWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("MainService".equals(inputPortName)) {
            return getMainService();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://actionTracking.com", "MainServiceService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://actionTracking.com", "MainService"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("MainService".equals(portName)) {
            setMainServiceEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
