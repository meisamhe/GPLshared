package peer2me.network.bluetooth;

import java.io.IOException;
import java.util.Hashtable;
import java.util.Vector;

import javax.bluetooth.BluetoothStateException;
import javax.bluetooth.LocalDevice;
import javax.bluetooth.RemoteDevice;
import javax.bluetooth.ServiceRecord;
import javax.bluetooth.DataElement;
import javax.microedition.io.Connector;
import javax.microedition.io.StreamConnection;
import peer2me.util.ASCIIToHexConvert;
import peer2me.util.Log;
import peer2me.network.ConnectionListener;
import peer2me.network.Network;
import peer2me.network.NodeConnection;
import peer2me.domain.DataPackage;
import java.util.*;
import peer2me.framework.FrameworkFrontEnd;


/**
 * This class is a bluetooth specific sub class of the Network class
 * and implements all the abstract methods of it's parent class in a bluetooth
 * context. It uses the bluetooth Java API, JSR-82, to perform operations on 
 * the bluetooth hardware of the mobile device.
 *
 * @author Torbj�rn Vatn & Steinar A. Hestnes
 */
public class BluetoothNetwork extends Network implements BluetoothServiceDiscoveryListener{
	
    // The Log instance
    private Log log;

    // The UUID number generated using the tool found at http://kruithof.xs4all.nl/uuid/uuidgen
    //alternatives by meisam: fc7160e6-5551-4165-892c-bc7bf8df9edc, 6463ceef-ba8d-4f04-9330-ce1f1aa4394b,00cbd4f9-eac5-47a0-84e4-cab946296991
    private String generatedUuid = "0ade9c80bb2b11daa94d0800200c9a66";

    // A reference to BluetoothServiceDiscovery
    private BluetoothServiceDiscovery bluetoothServiceDiscovery;
    
    // A list containing addresses and serviceRecords of all found nodes (nodes who are running the same application but not connected yet)
    private Hashtable foundNodes;
    
    // This boolean decides whether or not this Node is connected to another node.
    private boolean isConnected;
    
    // A boolean indicating whether the serviceSearch is completed or not
    private boolean serviceSearchCompleted;
    
    // A boolean indicating whether the serviceSearch failed or not
    private boolean serviceSearchFailed;    
    
    
	/**
	 *  
	 * Constructor. Protected to ensure singleton pattern.
	 * 
	 */
	public BluetoothNetwork(){        
        // Fetches a instance of the Log
        log = Log.getInstance();
    }
	
	/**
	 * Initiates the network instance. 
	 * It is called from the FrameworkFrontEnd.initFramework()
	 * 
	 * @throws BluetoothStateException Failed to initiate the network
	 */
	public void init() throws BluetoothStateException{
		
		isConnected = false;
		serviceSearchCompleted = false;
		serviceSearchFailed = false;
		
		
		// Sets the connectionURL used by the ConnectionListener
        String localNodeName = getFrameworkFrontEnd().getLocalNode().getNodeName();
        // Meisam changed x+y+z to x=x+y, x=x+z
        connectionURL = new StringBuffer().append("btspp://localhost:").append(getUUIDString()).append(";authenticate=false;encrypt=false;name=").append(localNodeName).toString();
		
        // Have to set the local device discoverable
//        try {
//            LocalDevice.getLocalDevice().setDiscoverable(javax.bluetooth.DiscoveryAgent.GIAC);
//        } catch (BluetoothStateException bse) {
//           log.logException("ConnectionListener.ConnectionListener()",bse,false);
//           throw bse;
//        }  
        
        foundNodes = new Hashtable();
        // Creates the class that contains low level Bluetooth discovery operations.
        bluetoothServiceDiscovery = new BluetoothServiceDiscovery();
        
		/* The ConnectionListener instance that listens for incoming requests from
		 * other nodes in discovery mode. When this node is discovered the "discoverer"
		 * can choose to create a connection between the two, and the remote node is 
		 * represented by a node object localy on this node.
		 */
        setConnectionListener(new ConnectionListener(connectionURL));        
	}
    
     
    /**
     * 
     * This method is called from the ConnectionListener.run() when 
     * the acceptAndOpen() method in ConnectionListener.run() is done.
     *
     */
    public void connectionEstablished(){
        // Indicates that this node was connected (contacted) by another node
        isConnected = true;
    }
	
	/**
	 * Starts a search for devices running the same MIDlet
	 * 
	 * @throws IOException Error during the search
	 *  
	 */
	public void searchForNodes() throws IOException{
		// This initiates the discovery process        
        if(!isConnected) bluetoothServiceDiscovery.doDeviceDiscovery();
	}
	

	/**
	 * Called when the same MIDlet is found on a remote device.
     * It is called from BluetoothServiceDiscovery.serviceSearchCompleted().
	 * 
	 * @param input Either a ServiceRecord or a StreamConnection that describes the characteristics of the Bluetooth service found
	 */
	public void nodeFound(Object input){
		
        // Input type is object because superclass cannot relate to ServiceRecord which is a bluetooth specific class.
        ServiceRecord serviceRecord = (ServiceRecord)input;
        
        // Retrives the name of the found node
        String remoteNodeName = getRemoteNodeName(serviceRecord);
        
        // The bluetooth address of the node "I" "as owner" found
        String address = serviceRecord.getHostDevice().getBluetoothAddress();
        
        // If the node is not already connected, the MIDlet is notified via the frontEnd
        // and the user is asked whether he/she wants to connect to it or not. 
        if(getFrameworkFrontEnd().getGroup().getNode(address) == null){
            // Alerts the FrameworkFrontEnd about the found (participating) node                
            getFrameworkFrontEnd().notifyAboutFoundNode(address,remoteNodeName);
            
            // Saves the found node so a connection can be established later by running the connectToNodes() method.
            foundNodes.put(address,serviceRecord);
            
        }else{
            // This code is run if the node has been disconnected temporarily or lacks 
        	// a connection. This method (nodeFound) is then called as a result from a
        	// new serviceSearch on a given address (see BluetoothServiceDiscovery.startServiceSearch()). 
        	// It re-opens a connection to a node that has been disconnected temporarily.
        	StreamConnection connection = null;
            try{           
                // Re-opens a connection to a (participating) node.
            	connection = (StreamConnection) Connector.open(serviceRecord.getConnectionURL(ServiceRecord.NOAUTHENTICATE_NOENCRYPT,false));
            }catch(IOException ioe){
                // The connection could not be established
            	log.logException("BluetoothNetwork.nodeFound()", ioe, false);
            }                  
                
            getFrameworkFrontEnd().getGroup().getNode(address).setNodeConnection(connection);
            getFrameworkFrontEnd().getGroup().getNode(address).startNodeConnection();                            
        } 	
    }
    
    /**
     * 
     * This method fetches the name of the remote node. 
     *
     * @param input An object representing the connection to the found node.
     * @return The name of the remote node.
     */
    public String getRemoteNodeName(Object input){        
        DataElement data = ((ServiceRecord)input).getAttributeValue(0x0100);   
        return (String)data.getValue();
    }
    
    
    /**
     * 
     * This method establishes a connection to the chosen node.
     * It is run from the BluetoothNetwork.sendDataPackage().
     *
     * @param nodeAddress The address to the node to connect to
     * 
     */
    public void connectToNode(String nodeAddress){
      
    	// Connects to the recipient
        bluetoothServiceDiscovery.startServiceSearch(nodeAddress);
         
        serviceSearchCompleted = false;  
        while(!serviceSearchCompleted){
            // Waiting for the agent to set serviceSearchCompleted = true in the BluetoothNetwork.serviceSearchCompleted() method.
            // This because we dont want to send the package before the search is completed
         	try{
                Thread.sleep(300);
            }catch(InterruptedException ie){
                // Do nothing
            }                    
        }
        // Resets the value
        serviceSearchCompleted = false;
        
        if(!serviceSearchFailed) log.logConnection(new StringBuffer().append("Successfully connected to ").append(getFrameworkFrontEnd().getGroup().getNode(nodeAddress).getNodeName()).append("(").append(nodeAddress).append(")").toString());
    }    
    
	
	/**
	 * 
	 * Sets the boolean serviceSearchCompleted = true. 
	 * This value will interrupt the while-loop in sendDataPackage. 
	 * This because the serviceSearch must be completed before we 
	 * try to send a package.
	 * The method is called from 
	 * BluetoothServiceDiscovery.serviceSearchCompleted().
	 * 
	 */
	public void serviceSearchCompleted(){
        // Resets the serviceSearchFailed in case an earlier search has failed
		serviceSearchFailed = false;
		serviceSearchCompleted = true;
	}
	
		
	/**
	 * What to do when something went wrong during servicediscovery.
	 * The method is called from 
	 * BluetoothServiceDiscovery.serviceSearchCompleted().
	 * 
	 */
	public void serviceDiscoveryError(){
		// Stops the sending of the datapackage in sendDatapackage()
		serviceSearchFailed = true;
		serviceSearchCompleted = true;
	}    
    
    /**
     * 
     * This method returns the node address.
     *
     * @param input String "localNode" to retreive the address of the local device. 
     * A ServiceRecord or StreamConnection object to retreive the address of a 
     * remote device.
     * 
     * @return The node network address.
     * @throws IOException 
     */
    public String getNodeAddress(Object input) throws IOException{      
    		
		// Checks whether the input is a String and the String equals "localnode".
		// If so the address of the LocalDevice is returned.
		if(input.getClass().isInstance(new String())){
			String inputString = (String)input;
			// Make sure that we won't get any UPPER/lower case problems
			inputString.toLowerCase();
			if(inputString.equals("localnode"))return LocalDevice.getLocalDevice().getBluetoothAddress();
		}
    	
        // Input type is object because superclass cannot relate to ServiceRecord which is a bluetooth specific class.
        // This method is valid either the input type is ServiceRecord or StreamConnection.
        RemoteDevice remoteDevice = null;
        try{
            ServiceRecord serviceRecord = (ServiceRecord) input;
            remoteDevice = serviceRecord.getHostDevice();            
        }catch(ClassCastException cce1){
            // Could not cast the input object to ServiceRecord. Trying streamConnection instead ;-)
            try{
                StreamConnection streamConnection = (StreamConnection) input;            
                remoteDevice = RemoteDevice.getRemoteDevice(streamConnection);
            }catch(ClassCastException cce2){
                //This will only happen if the input object type is wrong
                log.logException("BluetoothNetwork.getNodeAddress()",cce2,false);
            }catch(IOException ioe){
                log.logException("BluetoothNetwork.getNodeAddress()",ioe,false);
                throw ioe;
            }            
        }
        return remoteDevice.getBluetoothAddress();
    }  
    
    /**
     * 
     * This method is used by the FrameworkFrontEnd to send a data package of 
     * any sort to a remote node.
     *  
     * @param dataPackage The data package to be sent
     * @param recipients A list containing addresses to the recipient nodes
     *
     */
    public void sendDataPackage(DataPackage dataPackage, String[] recipients){
   	
    	// A Vector containing the addresses to the nodes that could not be reached
    	Vector addressesToLostNodes = new Vector();
    	
    	for(int i=0; i<recipients.length; i++){       
    		// If the node has been removed/disconnected in the meantime
    		if(getFrameworkFrontEnd().getGroup().getNode(recipients[i])==null){
    			// do nothing
    		}else{
    		
	    		// Connects to the remote node if the connection never has been opened or if it has been closed
	    		NodeConnection nodeConnection = getFrameworkFrontEnd().getGroup().getNode(recipients[i]).getNodeConnection();    		
	    		if(nodeConnection!=null){	    			
	    			if(nodeConnection.getConnection()==null){
			    		// Establishes a connection to the recipient
			    		// This method waits until the new connection is ready (or not)    				
						connectToNode(recipients[i]);
	    			}else if(nodeConnection.getSendQueueSize() == 0){
	    				// If the que is empty, the connection has been closed, and we need a new one
			    		nodeConnection.setConnection(null);
	    				// Establishes a connection to the recipient
			    		// This method waits until the new connection is ready (or not)    				
						connectToNode(recipients[i]);
	    			}
	    		}else{
					// Establishes a connection to the recipient
		    		// This method waits until the new connection is ready (or not)
	    			connectToNode(recipients[i]);
	    		}
	    		    		
	    		// Sends the data package to the recipient
				if(!serviceSearchFailed)getFrameworkFrontEnd().getGroup().getNode(recipients[i]).getNodeConnection().sendDataPackage(dataPackage);
				else{    		   
					// If the serviceSearch failed, the node must be removed from the group, and groups become synchronized				
					addressesToLostNodes.addElement(recipients[i]);					
				}
    		}
		}
    	// Removes the nodes that could not be reached to remove these from the group by running a groupsync
    	for(int i=0; i<addressesToLostNodes.size();i++){
    		// Notifies only if the node is not already removed from the local group.
    		// This because a node could have been removed when sending the previous data package and this package is sent right after the first one (as in text first and then sync package)
    		if(getFrameworkFrontEnd().getGroup().getNode((String)addressesToLostNodes.elementAt(i))!=null){
    			getFrameworkFrontEnd().notifyAboutLostNode((String)addressesToLostNodes.elementAt(i));
    		}
    	}
    }

     public void sendDataPackage(DataPackage dataPackage, String recipient){

    	// A Vector containing the addresses to the nodes that could not be reached
         Vector addressesToLostNodes = new Vector();

    		// If the node has been removed/disconnected in the meantime
        if(getFrameworkFrontEnd().getGroup().getNode(recipient)==null){
            // do nothing
        }else{

            // Connects to the remote node if the connection never has been opened or if it has been closed
            NodeConnection nodeConnection = getFrameworkFrontEnd().getGroup().getNode(recipient).getNodeConnection();
            if(nodeConnection!=null){
                if(nodeConnection.getConnection()==null){
                    // Establishes a connection to the recipient
                    // This method waits until the new connection is ready (or not)
                    connectToNode(recipient);
                }else if(nodeConnection.getSendQueueSize() == 0){
                    // If the que is empty, the connection has been closed, and we need a new one
                    nodeConnection.setConnection(null);
                    // Establishes a connection to the recipient
                    // This method waits until the new connection is ready (or not)
                    connectToNode(recipient);
                }
            }else{
                // Establishes a connection to the recipient
                // This method waits until the new connection is ready (or not)
                connectToNode(recipient);
            }

            // Sends the data package to the recipient
            if(!serviceSearchFailed)
                getFrameworkFrontEnd().getGroup().getNode(recipient).getNodeConnection().sendDataPackage(dataPackage);
            else{
                // If the serviceSearch failed, the node must be removed from the group, and groups become synchronized
                addressesToLostNodes.addElement(recipient);
            }
        }
    	// Removes the nodes that could not be reached to remove these from the group by running a groupsync
    	for(int i=0; i<addressesToLostNodes.size();i++){
    		// Notifies only if the node is not already removed from the local group.
    		// This because a node could have been removed when sending the previous data package and this package is sent right after the first one (as in text first and then sync package)
    		if(getFrameworkFrontEnd().getGroup().getNode((String)addressesToLostNodes.elementAt(i))!=null){
    			getFrameworkFrontEnd().notifyAboutLostNode((String)addressesToLostNodes.elementAt(i));
    		}
    	}
    }
    
	
    /**
     * 
     * This method returns the UUID string used as an identifier in the discovery process. 
     * The UUID string is generated based on the application ID given by the application
     * running the framework. The UUID must be used to ensure that all nodes 
     * joining the network are running the same application.
     *
     * @return uuidString
     */
    public String getUUIDString(){
                    
    		// The ASCII to Hex converter
    		ASCIIToHexConvert convert = new ASCIIToHexConvert();
    		// The String to convert to hex
    		String toConvert = "";
    		// The UUID consists of 16 hex values so the String to be converted must not exceed 16 chartacters
    		if(super.getApplicationId().length() > 16){
    			toConvert = super.getApplicationId().substring(0, 15);
    		} else {
    			toConvert = super.getApplicationId();
    		}
    		// The converted hex String
    		String convertedString = convert.convertASCIIToHex(toConvert);
    		// The length of convertedString
    		int convertedLength = convertedString.length();
    		
    		// The String to return
    		String uuidString = "";
    		if(convertedLength < 32){
    			uuidString = new StringBuffer().append(generatedUuid.substring(0, (32 - convertedLength))).append(convertedString).toString();
    		} else if(convertedLength == 32){
    			uuidString = convertedString;
    		}    		
    		return uuidString;        
    }    
	
	
}
