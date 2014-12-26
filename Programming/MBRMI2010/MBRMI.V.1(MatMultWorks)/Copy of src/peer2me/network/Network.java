package peer2me.network;

import java.io.IOException;

import peer2me.util.Log;
import peer2me.domain.DataPackage;
import peer2me.framework.FrameworkFrontEnd;

/**
 * This is the super class of the technology specific network classes. Methods
 * that are equal for all the sub classes are located in this super class, and there are
 * abstact methods that the sub classes have to implement. The getInstance() method
 * in this class returns a reference to the preferred network sub class.
 * 
 * @author Torbj�rn Vatn & Steinar A. Hestnes
 */
public abstract class Network{
	
    // The connectionURL used by the ConnectionService created in the init() methood
	public String connectionURL;

    // The Log instance
    private static Log log;
    
	// The Network instance returned by the getInstance() method
	private static Network singleton;
    
    // A reference to the FrameworkFrontEnd
    private FrameworkFrontEnd frameworkFrontEnd;
    
    // The applicationId of the MIDlet
    private String applicationID;
    
    // The ConnectionListener of the Network
    private ConnectionListener connectionListener;
    
	/**
	 * 
	 * This method returns an instance of the preferred network.
	 * It is called from FrameworkFrontEnd.initFramework().
	 *
	 * @param preferredNetwork Indicating which network implementation to use.	
	 * @throws ClassNotFoundException The input preferredNetwork is invalid
	 * @throws IllegalAccessException The input preferredNetwork is invalid
	 * @throws InstantiationException The input preferredNetwork is invalid
	 * @return The Network instance
	 */
	public static synchronized Network getInstance(String preferredNetwork) throws ClassNotFoundException, IllegalAccessException, InstantiationException{
		
		// A log instance
		log = Log.getInstance();
		
		if(singleton != null){
			return singleton;
		}else{            
			try{
				// Fetching a instance of the preferred network class
				singleton = (Network)Class.forName(preferredNetwork).newInstance();                		

			}catch(ClassNotFoundException cnfe){
				log.logException("Network.getInstance()",cnfe, false);
				throw cnfe;
			}catch(IllegalAccessException iae){
				log.logException("Network.getInstance()",iae, false);
				throw iae;
			}catch(InstantiationException ie){
				log.logException("Network.getInstance()",ie, false);
				throw ie;
			}
			
			// Returning the singleton instance
			return singleton;
		}
	}    
    
    /**
     * 
     * This method returns a reference to the instance of the preferred network.
     * It is used when an instance already is created and a reference to 
     * this instance is needed.
	 * 
	 * @throws ClassNotFoundException The input preferredNetwork is invalid
	 * @throws IllegalAccessException The input preferredNetwork is invalid
	 * @throws InstantiationException The input preferredNetwork is invalid
	 * @return The Network instance
     */
    public static synchronized Network getInstance(){
        // Checks whether the other getInstance method has already been run
        if(singleton==null){
            log.logDebugInfo("Network.getInstance()","No Network instance found!");
            return null;
        }
        return singleton;
    }
    
  	
	/**
	 * 
	 * This method sets a reference to the ConnectionListener
	 * 
	 * @param connectionListener A reference to the ConnectionListener
	 */
	public void setConnectionListener(ConnectionListener connectionListener){
		this.connectionListener = connectionListener;
	}
	
    /**
     * 
     * This method returns the ConnectionListener reference
     *
     * @return connectionListener A reference to the ConnectionListener
     */
    public ConnectionListener getConnectionListener(){
    	return connectionListener;
    }
    
    /**
     * 
     * This method sets a reference to the FrameworkFrontEnd
     *
     * @param frameworkFrontEnd A reference to the FrameworkFrontEnd
     */
    public void setFrameworkFrontEnd(FrameworkFrontEnd frameworkFrontEnd){
        this.frameworkFrontEnd = frameworkFrontEnd;
    }
    
    /**
     * 
     * This method returns the FrameworkFrontEnd reference
     *
     * @return frameworkFrontEnd A reference to the FrameworkFrontEnd
     */
    public FrameworkFrontEnd getFrameworkFrontEnd(){
    		return frameworkFrontEnd;
    }
    
    /**
     * 
     * This method sets the applicationID. 
     * The application ID must be used to ensure that all nodes joining
     * the network are running the same MIDlet.
     *
     * @param applicationID The ID of the MIDlet (e.g. the MIDlet name)
     */
	public void setApplicationId(String applicationID){
		this.applicationID = applicationID;
	}	
    	
	/**
	 * 
	 * This method returns the applicationId
	 *
	 * @return applicationID The ID of the MIDlet 
	 */
	public String getApplicationId(){
		return applicationID;
	}
    
	
	/*************************************************************************/
	// The abstract methods inherited and overridden by the sub network classes 
	/*************************************************************************/
	
	/**
	 * Initiates the network instance. 
	 * It is called from the FrameworkFrontEnd.initFramework()
	 * 
	 * @throws Exception Failed to initiate the network
	 */
	public abstract void init() throws Exception;
	
	/**
	 * Starts a search for devices running the same MIDlet
	 * 
	 * @throws IOException Error during the search
	 */
	public abstract void searchForNodes() throws IOException;	
    
    /**
     * 
     * Called when the same MIDlet is found on a remote device
     * 
     * @param input An object representing the connection to the found node.
     */
    public abstract void nodeFound(Object input) throws IOException;
    
    /**
     * 
     * This method fetches the name of the remote node. 
     *
     * @param input An object representing the connection to the found node.
     * @return The name of the remote node.
     */
    public abstract String getRemoteNodeName(Object input);
    
    /**
     * 
     * This method establishes a connection to the chosen node.
     * It could e.g. be run from the Network.sendDataPackage() to connect
     * before sending a package.
     *
     * @param nodeAddress The address to the node to connect to
     * 
     */
    public abstract void connectToNode(String nodeAddress);
    
    /**
     * 
     * This method is called from the ConnectionListener.run() when 
     * the acceptAndOpen() method in ConnectionListener.run() is done.
     * 
     */
    public abstract void connectionEstablished();
    
    /**
     * 
     * This method returns the node address.
     *
     * @param input String "localNode" to retreive the address of the local device. 
     * A object representing the connection to the remote node to retreive the 
     * address of a remote device.
     * 
     * @return The node network address.
     * @throws IOException 
     * 
     */    
    public abstract String getNodeAddress(Object input) throws IOException;
    
    
    /**
     * 
     * This method is used by the FrameworkFrontEnd to send a data package of 
     * any sort to a remote node.
     *  
     * @param dataPackage The data package to be sent
     * @param recipients A list containing addresses to the recipient nodes
     *
     */
    public abstract void sendDataPackage(DataPackage dataPackage, String[] recipients);

    public abstract void sendDataPackage(DataPackage dataPackage, String recipients);
    
	
}
