package peer2me.network.bluetooth;

import java.util.Vector;
import javax.bluetooth.BluetoothStateException;
import javax.bluetooth.DeviceClass;
import javax.bluetooth.DiscoveryAgent;
import javax.bluetooth.DiscoveryListener;
import javax.bluetooth.LocalDevice;
import javax.bluetooth.RemoteDevice;
import javax.bluetooth.ServiceRecord;
import javax.bluetooth.UUID;

import peer2me.network.Network;
import peer2me.util.Log;

/**
 * This class is responsible for doing the low level Bluetooth discovery operations.
 * The class initializes seqential device discovery, and searches for services 
 * (the same MIDlet built upon the Peer2Me framework) on each of the found devices. 
 *
 * @author Torbj�rn Vatn & Steinar A. Hestnes
 */
public class BluetoothServiceDiscovery implements DiscoveryListener{
	
	// A Log instance
	Log log = Log.getInstance();
	
	// The current network
	private BluetoothNetwork currentNetwork;
	
	// A table containing the UUIDs (Universally Unique Identifier) use to perform the discovery process
	private UUID[] uuids = new UUID[1];
	// The UUID String fetched from currentNetwork
	private String uuidString;
	
	// Vector containing the devices found during discovery
	private Vector devicesFound = null;
	// Vector containing the services (read; running the Peer2Me framework) found on the discovered devices
	private Vector servicesFound = null;

	// An instance representing the local bluetooth device
	private LocalDevice localDevice;
	// The discovery agent of the local device
	private DiscoveryAgent agent;
	
	// An identifier used on mobile phone bluetooth devices
    private int mobileDeviceClassCode = 0x200;
    // The attributes to include in the agent.searchServices() method
    private int[] attributes = {0x100,0x101,0x102};	
	
	
	/**
	 * 
	 * Constructor. 
	 * Called from BluetoothNetwork.init().
	 *
	 */
	public BluetoothServiceDiscovery(){
		this.currentNetwork =(BluetoothNetwork)Network.getInstance();
		// Fetches the UUID string from currentNetwork
		this.uuidString = currentNetwork.getUUIDString();
	}
	
	/**
	 * 
	 * This method starts the discovery process. 
	 * It is called from BluetoothNetwork.searchForNodes().
	 *
	 * @throws BluetoothStateException Error getting reference to LocalDevice
	 */
    public void doDeviceDiscovery() throws BluetoothStateException{

    	uuids[0] = new UUID(uuidString, false);
    	servicesFound = new Vector();
    	devicesFound = new Vector();
    	
        try{
            localDevice = LocalDevice.getLocalDevice();            
        }catch(BluetoothStateException bse) {
            log.logException("BluetoothServiceDiscovery.doDeviceDiscovery()",bse, false);
            throw bse;
        }
        
        //Fetches the discovery agent of the local device
        agent = localDevice.getDiscoveryAgent();
        
        try {
        	// The discovery agent starts the inquiry for other devices
            agent.startInquiry(DiscoveryAgent.GIAC,this);
        }
        catch(BluetoothStateException bse) {
	        log.logException("BluetoothServiceDiscovery.doDeviceDiscovery()",bse, false);
	    	throw bse;
        }
    }

    /**
     * 
     * This method is called by the javax.bluetooth.DiscoveryAgent (agent) whenever a bluetooth device is discovered
     * 
     * @param remoteDevice The device discovered
     * @param deviceClass The device class of the discovered device
     * 
     */
    public void deviceDiscovered(RemoteDevice remoteDevice,DeviceClass deviceClass){
		
		// The device class of the discovered device
		int deviceclass = deviceClass.getMajorDeviceClass();
			
		if(deviceclass==mobileDeviceClassCode){
			// Adds the discovered device to the devicesFound Vector
			devicesFound.addElement(remoteDevice);
		}
    }
    
    /**
     * 
     * This method is called by the javax.bluetooth.DiscoveryAgent (agent) whenever one or more services (read: Peer2Me framework) 
     * are found on a remote device
     * 
     * @param transId The transaction ID of the service search that is posting the result
     * @param serviceRecord A list of services found during the search request
     * 
     */
    public void servicesDiscovered(int transId, ServiceRecord[] serviceRecord) {
        
        // Checks whether the service already exists in servicesFound. This because the 
        // DiscoveryAgent sometimes finds the same service several times :-( STUPID!!!
        boolean alreadyAdded = false;
        
		for(int i=0;i<serviceRecord.length;i++){
            if(servicesFound.size()==0){
                // Adds the retrived ServiceRecord to the servicesFound Vector
                servicesFound.addElement(serviceRecord[i]);
                log.logDebugInfo("BluetoothServiceDiscovery.servicesDiscovered()", new StringBuffer().append("Found a node with address: ").append(serviceRecord[i].getHostDevice().getBluetoothAddress()).append(" running the same application").toString());
            }else{                
                for(int j=0;j<servicesFound.size();j++){
                    // Must compare the addresses of the devices to avoid adding the same service on the same device twice or more :-P 
                    String addressServiceFound = ((ServiceRecord) servicesFound.elementAt(j)).getHostDevice().getBluetoothAddress();
                    String addressServiceRecord = serviceRecord[i].getHostDevice().getBluetoothAddress();
                    
                    if(addressServiceFound.equals(addressServiceRecord)){
                        alreadyAdded = true;
                    }
                }
                if(!alreadyAdded){
                    // Adds the retrived ServiceRecord to the servicesFound Vector
                    servicesFound.addElement(serviceRecord[i]);
                    log.logDebugInfo("BluetoothServiceDiscovery.servicesDiscovered()", new StringBuffer().append("Found a node with address: ").append(serviceRecord[i].getHostDevice().getBluetoothAddress()).append(" running the same application").toString());
                }
            }
    	}        
    }
    

    /**
     * 
     * This method is called by the javax.bluetooth.DiscoveryAgent (agent) when the search for services (read: Peer2Me framework) is completed
     * 
     * @param transID The transaction ID of the service search that is posting the result
     * @param respCode The response code that indicates the status of the transaction
     * 
     */
    public void serviceSearchCompleted(int transID, int respCode){
    	        
    	switch(respCode) {
    		
    		case DiscoveryListener.SERVICE_SEARCH_COMPLETED:
	    		log.logDebugInfo("BluetoothServiceDiscovery.serviceSearchCompleted()","Service search completed");
    	    break;
                    
    		case DiscoveryListener.SERVICE_SEARCH_DEVICE_NOT_REACHABLE:        	
    			log.logDebugInfo("BluetoothServiceDiscovery.serviceSearchCompleted()","Service search device not reachable");
    			// If a searchServices() call is made on a specific device, the devices found table will contain no devices
	    		// In this case the network must be notified about the error.
	    		// In the initial doDeviceDiscovery() these errors are ignored because devices not running the framework can interfere the discovery process.
	    		if(devicesFound.size()==0) currentNetwork.serviceDiscoveryError();
        	break;
                    
    		case DiscoveryListener.SERVICE_SEARCH_ERROR:
    			log.logDebugInfo("BluetoothServiceDiscovery.serviceSearchCompleted()","Service search error");
	    		if(devicesFound.size()==0) currentNetwork.serviceDiscoveryError();
    		break;
                    
    		case DiscoveryListener.SERVICE_SEARCH_NO_RECORDS:
    			log.logDebugInfo("BluetoothServiceDiscovery.serviceSearchCompleted()","No bluetooth devices running the same service (application) found");
	    		if(devicesFound.size()==0) currentNetwork.serviceDiscoveryError();
        	break;
                    
            case DiscoveryListener.SERVICE_SEARCH_TERMINATED:
            	log.logDebugInfo("BluetoothServiceDiscovery.serviceSearchCompleted()","Service search terminated");
	    		if(devicesFound.size()==0) currentNetwork.serviceDiscoveryError();
    		break;
    	}

    	// Searches further on the next device
    	if(devicesFound.size()>0){                        
    		try {
    			// The discovery agent searches for services on the next device stored in the devicesFound Vector
    			agent.searchServices(attributes,uuids,(RemoteDevice)devicesFound.firstElement(),this);
    			devicesFound.removeElementAt(0);
    		} catch (BluetoothStateException bse) {
    			log.logException("BluetoothServiceDiscovery.serviceSearchCompleted", bse, true);
    			currentNetwork.serviceDiscoveryError();
    		}	    	    		
    	}
    	
    	else{	    	    		
    		if(servicesFound.size()==0){
    			log.logDebugInfo("BluetoothServiceDiscovery.serviceSearchCompleted()","No services found");	    	    			
    		}else{
                log.logDebugInfo("BluetoothServiceDiscovery.serviceSearchCompleted()","Found the desired service running on one or more nodes");
    			// For each element in servicesFound the serviceFound method is called on currentNetwork     
                for(int i=0;i<servicesFound.size();i++){
                	currentNetwork.nodeFound((ServiceRecord)servicesFound.elementAt(i));
    			}
    			currentNetwork.serviceSearchCompleted();
    		}                        
    	}

    }

    /**
     * 
     * This method is called by the javax.bluetooth.DiscoveryAgent (agent) when the discovery process is completed
     * 
     * @param discType The type of request that was completed; either INQUIRY_COMPLETED, INQUIRY_TERMINATED, or INQUIRY_ERROR 
     * 
     */
    public void inquiryCompleted(int discType) {
        
    	switch (discType) {
		
		case DiscoveryListener.INQUIRY_COMPLETED:
			if(devicesFound.size()==0){
				log.logDebugInfo("BluetoothServiceDiscovery.inquiryCompleted()","No devices found");
                // Send a message to the midlet
				currentNetwork.serviceSearchCompleted();
			}else{	
				try {
                    log.logDebugInfo("BluetoothServiceDiscovery.inquiryCompleted()","Found one or more devices");
					// The discovery agent searches for services on the first device stored in the devicesFound Vector
					agent.searchServices(attributes,uuids,(RemoteDevice)devicesFound.firstElement(),this);
					devicesFound.removeElementAt(0);
				} catch (BluetoothStateException bse) {
				    log.logException("BluetoothServiceDiscovery.serviceSearchCompleted", bse, true);
				}
			}    	
		log.logDebugInfo("BluetoothServiceDiscovery.inquiryCompleted()","Device inquiry completed");
		break;
		
		case DiscoveryListener.INQUIRY_ERROR:
		
		log.logDebugInfo("BluetoothServiceDiscovery.inquiryCompleted()","Device inquiry error");
		break;
		
		case DiscoveryListener.INQUIRY_TERMINATED:
		
		log.logDebugInfo("BluetoothServiceDiscovery.inquiryCompleted()","Device inquiry terminated");
		break;
		}
    }
    
    
    /**
     * 
     * This method is used to re-establish a connection to a device when we have the address.  
     *
     * @param address The address to the device
     */
    public void startServiceSearch(String address){
        // Connects to a remote device with the given address     
        RemoteDeviceInstance remoteDevice = new RemoteDeviceInstance(address);
        try{
            localDevice = LocalDevice.getLocalDevice();   
            agent = localDevice.getDiscoveryAgent();
            uuids[0] = new UUID(uuidString, false);
            servicesFound = new Vector();
            devicesFound = new Vector();
            agent.searchServices(attributes,uuids,remoteDevice,this);
        }catch(BluetoothStateException bse) {
            log.logException("BluetoothServiceDiscovery.startServiceSearch()",bse, false);
            // throw bse;
        }
    }
    
    
    /**
     * 
     * This private class creates a RemoteDevice based on the address. 
     * It is used during the re-establishment of a connection to a device in
     * the startServiceSearch() method in this class.
     *
     * @author Torbj�rn Vatn & Steinar A. Hestnes
     */
    private class RemoteDeviceInstance extends RemoteDevice{
        
        /**
         * 
         * Constructor. Forwarding the address to the superclass.
         * 
         * @param address The address of the device
         */
        public RemoteDeviceInstance(String address){
            super(address);
        }
    }
    
    
}
