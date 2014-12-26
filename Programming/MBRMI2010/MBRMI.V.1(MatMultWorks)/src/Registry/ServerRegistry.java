package Registry;

import ninja.Domain.RemoteObject;
import ninja.rmi.NinjaRemoteObject;
import ninja.rmi.NinjaRemoteRef;
import ninja.simpleRMI.TheServiceImpl;
import ninja.MergeSortRMI.MergeSortImpl;
import ninja.MatrixMultiplicationRMI.MatrixMultiplication;
import ninja.MatrixMultiplicationRMI.MatrixMultiplicationImpl;
import peer2me.framework.FrameworkListener;
import peer2me.framework.Framework;
import peer2me.framework.FrameworkFrontEnd;
import peer2me.domain.Hashtable;
import peer2me.util.DataInputStreamWrapper;

import javax.microedition.io.PushRegistry;
import javax.microedition.lcdui.Form;
import javax.microedition.midlet.MIDlet;
import java.io.IOException;

//import databaseCore.PerstDatabse;
import RegistryClient.RegistryEntity;
import RegistryClient.Registry;

/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Sep 15, 2009
 * Time: 10:19:51 AM
 * To change this template use File | Settings | File Templates.
 */
public class ServerRegistry implements FrameworkListener {
    // The preferred network of the MIDlet
	private final String preferredNetwork = "peer2me.network.bluetooth.BluetoothNetwork";

    // A hashtable containing the addresses and names to each connected node. The names is the keys, and the values is the addresses
//    private Hashtable participatingNodeNames;

    // The name of the MIDlet
	private String midletName;
    public Framework framework;
    MIDlet currentMIDlet;
    Thread mainThread;
    String serviceName;
    String recievedResponse;
    Hashtable participants;
    Form currentForm;
    String nodeName;

    public ServerRegistry(String nodeName, Form currentForm, MIDlet thisMIDlet){
        this.currentForm=currentForm;
        this.nodeName=nodeName;
        midletName = "RegistryService";
        framework = FrameworkFrontEnd.getInstance(this);
        try{
            framework.initFramework(nodeName, midletName, preferredNetwork);
//                    String ClassName=  this.getClass().getName();
//                    ClassName="Peer2MessengerMIDlet.Peer2Messenger" ;
            try {
                 String ConnectionUrl=((FrameworkFrontEnd)framework).currentNetwork.connectionURL;
                 PushRegistry.registerConnection(ConnectionUrl, thisMIDlet.getClass().getName(), "*");
            } catch (ClassNotFoundException e) {
                  currentForm.append(e.getMessage());//.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
             } catch (IOException e) {
                     currentForm.append(e.getMessage());
//                           e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
             }

        }catch(Exception e){
            currentForm.append("Error initiating the framework. Please try again."+ e.getMessage());
        }
    }

    public void notifyAboutException(String location, Exception exception) {
//To change body of implemented methods use File | Settings | File Templates.
    }

    public void notifyAboutFoundNode(String nodeAddress, String remoteNodeName) {
            framework.connectToNode(nodeAddress);
    }

    public void notifyAboutReceivedTextPackage(String senderName, String textMessage) throws IOException, ClassNotFoundException, IllegalAccessException, InstantiationException {
        framework.connectToNode((String)participants.get(senderName));
//        PerstDatabse pdb=new PerstDatabse("registry",currentMIDlet);
        DataInputStreamWrapper disw=  new DataInputStreamWrapper("Registry");
        if (disw.size!=0)
            for (long i=0;i<disw.size; i++){
                RegistryEntity e= new RegistryEntity("", new NinjaRemoteObject());
    //                    (RegistryEntity) pdb.getEntity(i);
                e.readObject(disw);
                if (e!=null){
                    String temp1= e.name.toUpperCase();
                    String temp2=  textMessage.toUpperCase();
                    if (temp1.compareTo(temp2)==0) {
                        NinjaRemoteRef ninjaRemoteRef=((NinjaRemoteObject)e.obj).getStub().getNinjaRemoteRef();
                        String remoteMessage= ninjaRemoteRef.get_server()+" "+  ninjaRemoteRef.get_objid().d+ " "
                                +ninjaRemoteRef.get_objid().t+" "
                                +((NinjaRemoteObject)e.obj).getStub().name+" ";
                        framework.sendTextPackage((String)participants.get(senderName),remoteMessage);
                        // place
                         //begin of server code to test
                        try {
                    //                        Class skelclass=  Class.forName("ninja.simpleRMI.TheServiceImpl__RMIStub");
                    //                        NinjaRemoteStub nsk=(NinjaRemoteStub) skelclass.newInstance();
//                                TheServiceImpl service;
//                                MergeSortImpl mergeSortservice;
                                MatrixMultiplicationImpl matrixMultiplicationService;
                                matrixMultiplicationService = new MatrixMultiplicationImpl(nodeName, "checkService",preferredNetwork,currentMIDlet);
                                System.out.println("RMISERVER: Created service\n");
                                Registry registry = new   Registry();
                                        //Registry(nodeName,preferredNetwork,this,thisMIDlet) ;
//                                registry.rebind("service",service);
//                             registry.rebind("mergeSort",mergeSortservice);
                                registry.rebind("MatrixMultiplication",matrixMultiplicationService);
                    //                                System.out.println("RMISERVER: Bound service");
                        } catch (Exception te) {
                            te.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
                            currentForm.append(te.getMessage());
                        }
                         // end of server code
                        return;
                    }
                }else
                    return;
            }
    }

    public void notifyAboutReceivedFilePackage(String senderName, String filePath) {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    public void notifyAboutParticipants(Hashtable participants) {
        this.participants = participants;
    }
}
