package RegistryClient;

import ninja.Domain.RemoteObject;
import ninja.Domain.ObjID;
import ninja.rmi.NinjaRemoteObject;
import ninja.rmi.NinjaRemoteRef;
import ninja.rmi.NinjaRemoteStub;
import peer2me.framework.FrameworkListener;
import peer2me.framework.Framework;
import peer2me.framework.FrameworkFrontEnd;
import peer2me.domain.Hashtable;
import peer2me.util.DataOutputStreamWrapper;

import javax.microedition.io.PushRegistry;
import javax.microedition.lcdui.Form;
import javax.microedition.midlet.MIDlet;
import java.io.IOException;

//import databaseCore.PerstDatabse;
import RegistryClient.RegistryEntity;

/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Sep 15, 2009
 * Time: 10:19:51 AM
 * To change this template use File | Settings | File Templates.
 */
public class Registry implements FrameworkListener {

    // The preferred network of the MIDlet
	private  String preferredNetwork; //= "peer2me.network.bluetooth.BluetoothNetwork";

    // A hashtable containing the addresses and names to each connected node. The names is the keys, and the values is the addresses
//    private Hashtable participatingNodeNames;

    // The name of the MIDlet
	private String midletName;
    Framework framework;
    MIDlet currentMIDlet;
  //  Thread mainThread;
    String serviceName;
    String recievedResponse;
    String nodeName;
    Form currentForm;
    Hashtable participants;
    boolean wake;

    public Registry(){}

    public Registry(String nodeName, String preferredNetowork, Form currentForm, MIDlet currentMIDlet){
        this.preferredNetwork=preferredNetowork;
        this.nodeName= nodeName;
        this.currentMIDlet=currentMIDlet;
        this.currentForm=currentForm;
        framework = FrameworkFrontEnd.getInstance(this);
    }
    public void rebind (String serviceName, RemoteObject obj) throws InterruptedException, ClassNotFoundException, IllegalAccessException, InstantiationException, IOException {
        DataOutputStreamWrapper dosw = new DataOutputStreamWrapper("Registry");
        (new RegistryEntity(serviceName,obj)).writeObject(dosw);
//        ((NinjaRemoteObject)obj).writeObject(dosw);
        dosw.close();
//        PerstDatabse pdb=new PerstDatabse("registry",currentMIDlet);
//        pdb.insert(new RegistryEntity(serviceName,obj));
//        pdb.closeDB();

    } 
    public RemoteObject lookup(String name) throws InterruptedException, ClassNotFoundException, IllegalAccessException, InstantiationException, IOException {
        currentForm.append("doing lookup") ;
        midletName = "RegistryService";
        Searcher t= new Searcher(framework, currentForm);
        try{
            framework.initFramework(nodeName, midletName, preferredNetwork);
//                    String ClassName=  this.getClass().getName();
//                    ClassName="Peer2MessengerMIDlet.Peer2Messenger" ;
            try {
                 String ConnectionUrl=((FrameworkFrontEnd)framework).currentNetwork.connectionURL;
                 PushRegistry.registerConnection(ConnectionUrl, currentMIDlet.getClass().getName(), "*");
            } catch (ClassNotFoundException e) {
                   currentForm.append(e.getMessage());//.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
             } catch (IOException e) {
                     currentForm.append(e.getMessage());
//                           e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
             }

        }catch(Exception e){
            currentForm.append("Error initiating the framework. Please try again."+ e.getMessage());
        }
        t.start();
        serviceName=name;
        //mainThread=Thread.currentThread();
//        mainThread.wait();
        wake = false;
        while (!wake)  {}
        currentForm.append("Result Recieved");
        t.finishThread();
        t= null;
        String server = recievedResponse.substring(0, recievedResponse.indexOf(" "));
        recievedResponse=recievedResponse.substring(recievedResponse.indexOf(" ")+1,recievedResponse.length());
        long objidd=Long.parseLong(recievedResponse.substring(0, recievedResponse.indexOf(" ")));
        recievedResponse=recievedResponse.substring(recievedResponse.indexOf(" ")+1,recievedResponse.length());
        long objidt=Long.parseLong(recievedResponse.substring(0, recievedResponse.indexOf(" ")));
        recievedResponse=recievedResponse.substring(recievedResponse.indexOf(" ")+1,recievedResponse.length());
        String stubName = recievedResponse.substring(0, recievedResponse.indexOf(" "));
        Class tempClass = Class.forName(stubName);
        NinjaRemoteStub remoteStub= (NinjaRemoteStub) tempClass.newInstance();
        remoteStub.setRemoteReference(new NinjaRemoteRef(new ObjID(objidd,objidt),server));
        remoteStub.f = framework;
        try{
            framework.initFramework(nodeName, server, preferredNetwork);
            framework.setFrameworkListener(remoteStub);
         }catch(Exception e){
            currentForm.append("Error initiating the framework. Please try again."+ e.getMessage());
        }
        String ConnectionUrl=((FrameworkFrontEnd)framework).currentNetwork.connectionURL;
//        PushRegistry.registerConnection(ConnectionUrl, currentMIDlet.getClass().getName(), "*");
        return remoteStub;
    }

    public void notifyAboutException(String location, Exception exception) {
//To change body of implemented methods use File | Settings | File Templates.
    }

    public void notifyAboutFoundNode(String nodeAddress, String remoteNodeName) {
        framework.connectToNode(nodeAddress);
        framework.sendTextPackage(nodeAddress,serviceName); // I just send the service and I should recive assigned port
    }

    public void notifyAboutReceivedTextPackage(String senderName, String textMessage) {
//        mainGui.append(senderName+" announced the port:"+textMessage);
        ((FrameworkFrontEnd)framework).participatingNodeAddress = (String)participants.get(senderName);   // just connect to the node that answers
        recievedResponse=textMessage;
//        mainThread.notify();
        wake = true;
    }

    public void notifyAboutReceivedFilePackage(String senderName, String filePath) {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    public void notifyAboutParticipants(Hashtable participants) {
        this.participants = participants;
    }
}
