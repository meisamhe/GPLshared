package peer2me.framework;

import peer2me.network.Network;
import peer2me.util.FileHandler;
import peer2me.util.Log;
import peer2me.domain.*;

import java.io.IOException;
import java.util.Enumeration;
//import java.util.Hashtable;


/**
 *
 * This is the main class of the Peer2Me framework. It manages
 * and connects the resources and functions of the framework. 
 * It also handles all communication and interaction with the 
 * MIDlets running the framework.
 * 
 * @author Torbj�rn Vatn & Steinar A. Hestnes
 */
public class FrameworkFrontEnd implements Framework{

    public String participatingNodeAddress;

    // The instance of the FrameworkFrontEnd returned by the getInstance() method, will be casted to Framework upon return
	private static FrameworkFrontEnd singleton;
	// The midlet that initiated the framework represented by a FrameworkListener instance
	private FrameworkListener midlet;
	// The Network instance of the preferred network
	public Network currentNetwork;
    // The group containing all connected nodes running the same application
    private Group group;
    // The local node
    private Node localNode;
    // A Hastable containing the addresses(key) and names(value) of the nodes found in the discovery process
    private Hashtable foundNodes;
	
	// A Log instance
	private Log log = Log.getInstance();	


	/**
	 * 
	 * This method creates an instance of FrameworkFrontEnd and returns it as
	 * a reference of type Framework. This is the only method that can 
	 * be called directly from the MIDlet on the FrameworkFrontEnd. 
	 * The MIDlet is restricted to only use the methods specified in the 
	 * Framework interface.  
	 *
	 * @param midlet A reference to the MIDlet (The MIDlet must implement the FrameworkListener interface).
	 * @return A reference to the Framework
	 */
	public static synchronized Framework getInstance(FrameworkListener midlet){
		if(singleton == null){
			singleton = new FrameworkFrontEnd();
			
			// Creates a instance of the Log class and set self as framework
			Log.getInstance().setFramework(singleton);
			
			// Sets the midlet variable
			singleton.midlet = midlet;
		}
		
		// The FrameworkFrontEnd instance are casted to Framework to avoid access to unwanted methods
		Framework framework = singleton;
		return framework;
	}

    public void setFrameworkListener(FrameworkListener midlet){
            if(singleton == null){
                singleton = new FrameworkFrontEnd();

                // Creates a instance of the Log class and set self as framework
                Log.getInstance().setFramework(singleton);
            }
           singleton.midlet = midlet;
    }

     public FrameworkListener getFrameworkListener(){
         return singleton.midlet;
     }


    /**
	 * Constructor. Made private to ensure singleton pattern.
	 */
	private FrameworkFrontEnd(){}
	
	

	/**
	 * 
	 * This method initiates the framework, and is the first method that should 
	 * be run after getting a instance of the framework. It initiates the
	 * fundamental services offered by the framework.
	 *
	 * @param nodeName The name of the user of the MIDlet.
	 * @param midletName The name of the MIDlet, eventually translated into a ServiceID used to find other devices running the same MIDlet.
	 * @param preferredNetwork Deciding which network implementation to use.
	 * 
	 * @throws ClassNotFoundException The input preferredNetwork is invalid
	 * @throws IllegalAccessException The input preferredNetwork is invalid
	 * @throws InstantiationException The input preferredNetwork is invalid
	 * @throws IOException Error initiating framework
	 * @throws Exception Error initiating framework
	 */
	public void initFramework(String nodeName, String midletName, String preferredNetwork) throws ClassNotFoundException, IllegalAccessException, InstantiationException, IOException, Exception{
		
		// Creates a Network instance
		currentNetwork = Network.getInstance(preferredNetwork);	
    	// Sets a reference to this class to be used in the Network class
    	currentNetwork.setFrameworkFrontEnd(this);  
    	// Sets the applicationId to be used by the Network class
    	currentNetwork.setApplicationId(midletName);    	
    	// Creates a group that will be filled with nodes running the same application
    	group = new Group();
        // Adds a representation of this (the local) node to the group.
        localNode = new Node(nodeName,currentNetwork.getNodeAddress("localnode"));        
        group.addParticipant(localNode);
        // Initiates the currentNetwork
        currentNetwork.init();
        // Creates the foundNodes Hashtable
        foundNodes = new Hashtable();     
	}
	
	
	/**
	 * 
	 * This method shuts down the framework and closes all the open network connections and streams.
	 * It should be called from the MIDlet before closing, to clean up the network connections. 
	 *
	 */
	public void shutdownFramework(){
		// Shuts down and closes the Group
		group.shutdownGroup();
		// Shuts down the ConnectionListener
		currentNetwork.getConnectionListener().shutdown();
	}
    
    
    /**
     * 
     * This method returns the local representation of the group. It is called from
     * ConnectionListener.run() or Network.nodeFound() when a remote node is found
     * and should be added to the group. 
     *
     * @return The local representation of the group
     */
    public Group getGroup(){
        return group;
    }
	
	/**
	 * 
	 * This method starts a search for devices running the same MIDlet.
	 * When such a device is found, the notifyAboutFoundNode() method 
	 * in this class is called.
	 *
	 * @throws IOException Thrown if the search crashes
	 */
	public void startNodeSearch() throws IOException{
		currentNetwork.searchForNodes();	
	}
    
    
     /**
     * 
     * This method establishes a connection to the chosen nodes.
     * After updating the local group, it synchronizes the groups on
     * all other participating nodes.
     * The method should be called from the MIDlet.
     *
     * @param addresses The addresses to the nodes to connect to.
     */    
    public void connectToNodes(String[] addresses){
    	// Creates Node objects based on the Vectors nodeNames and nodeAddresses
    	for(int i=0; i<addresses.length; i++){
    		getGroup().addParticipant(new Node((String)foundNodes.get(addresses[i]),addresses[i]));
    	}    	
    	// Synchronizes the groups on all connected nodes
    	synchronizeGroups();
    }

    public void connectToNode(String address){
        getGroup().addParticipant(new Node((String)foundNodes.get(address),address));
        synchronizeGroups();
    }
  
   
    /**
     * 
     * This method is used to make the Framework syncronize the Groups on all the 
     * connected nodes. The result of running this method is that the method 
     * notifyAboutParticipants() is called on the MIDlet.
     * It is called from the methods connectToNodes() and
     * notifyAboutLostNode() in this class.
     *
     */
    private synchronized void synchronizeGroups(){        
       
        // Creates a string table with the recipient addresses
        Hashtable participatingNodes = group.getParticipatingNodes();

        String[] recipients = new String[0];
        // Only do this if there is more than this node in the group
        if(participatingNodes.size()>1){
	    	recipients = new String[participatingNodes.size()-1];
	        // Need a list of nodes to run a groupsync
	        Node[] nodes = new Node[participatingNodes.size()];
	        // Adds the local Node to the nodes[]
	        nodes[0] = localNode;
	        // Removes the local Node from the participatingNodes[]
	        participatingNodes.remove(localNode.getAddress());

	        Enumeration addresses = participatingNodes.keys();
	        int counter = 0;

	        while(addresses.hasMoreElements()){
	             String address = (String)addresses.nextElement();
	             // Does not add the local node
	             recipients[counter] = address;
	             // Fetches the Node objects from participatingNodes
	             nodes[counter+1] = (Node)participatingNodes.get(address);
	             counter++;
	        }

	        // Sends a networkpackage to all participants to synchronize the group on all nodes
	        if(recipients.length!=0) currentNetwork.sendDataPackage(new GroupSyncPackage(localNode,recipients,nodes),recipients);
	        // Adds the local Node to the group again
	        participatingNodes.put(localNode.getAddress(),localNode);
    	}

        // Notifies the MIDlet about the participants of the group
        notifyAboutParticipants();

        // Logs the sending of the data package
        String recipientNames = "";
        for(int i=0; i<recipients.length; i++){          // (Meisam)I changed    x+= to x=x+
        	if(group.getNode(recipients[i])!=null) recipientNames= new StringBuffer().append(recipientNames).append("- ").append(group.getNode(recipients[i]).getNodeName()).append(" (").append(recipients[i]).append(") \n").toString();
        }

        if(recipients.length>0)log.logDataPackage(new StringBuffer().append("Sent a group sync package to:\n ").append(recipientNames).toString());
    }
    
    
    /**
     * 
     * This method returns a reference to the local node.
     *
     * @return An object representing the local node
     */
    public Node getLocalNode(){
        return localNode;
    }
    
     /**
     * 
     * This method is used by the MIDlet to send a text package over the network. 
     * When the package terminates to the recipients, the  
     * notifyAboutReceivedTextPackage() method in this class is run.
     *     
     * @param recipients A list containing the addresses of the recipient nodes
     * @param textMessage The text to be sent
     *
     */
    public void sendTextPackage(String[] recipients, String textMessage){        
    	
    	// Logs the sending of the text package
        String recipientNames = "";        
        for(int i=0; i<recipients.length; i++){
            recipientNames = new StringBuffer().append(recipientNames).append("- ").append(group.getNode(recipients[i]).getNodeName()).append(" (").append(recipients[i]).append(") \n").toString();            
        }               
        log.logDataPackage(new StringBuffer().append("Sending textpackage to:\n").append(recipientNames).toString());
    	
        TextPackage textPackage = new TextPackage(localNode,recipients,textMessage);
		// Passes the task of sending the data package over to the network        
		if(recipients.length!=0)currentNetwork.sendDataPackage(textPackage, recipients);
    }

    public void sendTextPackage(String recipient, String textMessage){

    	// Logs the sending of the text package
        String recipientNames = "";
        recipientNames = new StringBuffer().append(recipientNames).append("- ").append(group.getNode(recipient).getNodeName()).append(" (").append(recipient).append(") \n").toString();
        log.logDataPackage(new StringBuffer().append("Sending textpackage to:\n").append(recipientNames).toString());

        TextPackage textPackage = new TextPackage(localNode,recipient,textMessage);
		// Passes the task of sending the data package over to the network
		currentNetwork.sendDataPackage(textPackage, recipient);
    }
    
    
    /**
     * 
     * This method is used by the MIDlet to send a file package over the network. 
     * When the package terminates to the recipients, the  
     * notifyAboutReceivedFilePackage() method in this class is run.
     *    
     * @param recipients A list containing the addresses of the recipient nodes
     * @param filePath The path of the file to send
     *
     */
    public void sendFilePackage(String[] recipients, String filePath){        
        FilePackage filePackage = new FilePackage(localNode,recipients,filePath);
		// Passes the task of sending the data package over to the network        
		if(recipients.length!=0)currentNetwork.sendDataPackage(filePackage, recipients); 
        
        // Logs the sending of the file package
        String recipientNames = "";        
        for(int i=0; i<recipients.length; i++){
            recipientNames = new StringBuffer().append(recipientNames).append(group.getNode(recipients[i]).getNodeName()).append(" (").append(recipients[i]).append(") \n").toString();            
        }        
        log.logDataPackage(new StringBuffer().append("Sending file to: ").append(recipientNames).toString());
    }
    
    
    /**
     * 
     * This method returns a list of the files in the given root directory on the device
     * 
     * @param root The path to the root directory
     * @return A Enumeration containing the names of the files in the root directory
     */
    public Enumeration getFileList(String root){
    	// Creates a FileHandler representing the root
    	FileHandler fileHandler = new FileHandler(root);
    	// Returns the file list of the root
    	Enumeration	list = fileHandler.getFileList();
    	return list;    	
    }
    
	
	/*******************************************************************/
	// The notify methods used to notify the midlet about various events
    /*******************************************************************/
	
	/**
	 * 
	 * This method is called from the nodeFound() method in the Network class whenever a node is found
	 *
	 * @param address The network address of the node
     * @param remoteNodeName The name of the found remote node
	 */
	public void notifyAboutFoundNode(String address, String remoteNodeName){
		
		// Here we add a number after equal node names to make them unique
    	// We do this so we can set the node names as keys and the node addresses as values
    	// The reason for doing this is that the node names will be displayed in the midlet 
    	// and after selecting a node name, the address should be sent to the framework.
    	if(foundNodes.contains(remoteNodeName) || remoteNodeName.equals(localNode.getNodeName())){
        	for(int i=-1;i<foundNodes.size();i++){
        		if(!foundNodes.contains(new StringBuffer().append(remoteNodeName).append(" ").append(i + 2).toString())){
        			remoteNodeName = new StringBuffer().append(remoteNodeName).append(" ").append(i + 2).toString();
        			i = foundNodes.size();
        		}        		
        	}
    	}        
					
		// Stores the address and the name of the node in the foundnodes table
		foundNodes.put(address, remoteNodeName);
		midlet.notifyAboutFoundNode(address,remoteNodeName);
	}
    
	
	/**
	 * This method removes a lost node from the group.
	 * It is called from Network.sendDataPackage() if a node is unreachable.
	 * After removing the node, the groups on all other nodes become 
	 * synchronized.
	 * 
	 * @param address The address to the lost node
	 */
	public synchronized void notifyAboutLostNode(String address){					
	    log.logDataPackage(new StringBuffer().append(getGroup().getNode(address).getNodeName()).append(" (").append(address).append(") not reachable").toString());
		log.logConnection(new StringBuffer().append("Disconnected ").append(getGroup().getNode(address).getNodeName()).append(" (").append(address).append(")").toString());
		getGroup().removeParticipant(address);		
		// Synchronizes the groups on the connected devices		
		synchronizeGroups();		
	}
     
	/**
	 * 
	 * This method passes on the Exception notice from the Log to the MIDlet.
     * This will be done in cases where exceptions occure in threads and 
     * cannot be thrown in the usual way. 
	 *
	 * @param location The location (class and method) where the Exception occured
	 * @param exception The actual Exception
	 */
	public void notifyAboutException(String location, Exception exception){
		midlet.notifyAboutException(location, exception);
	}
    
    /**
     * 
     * This method is called from NodeConnection.processIncomingData() 
     * whenever a groupSyncPackage is received from a remote node.
     * The method processes the package, logs the event, and updates the group.
     *
     * @param groupSyncPackage The received groupSyncPackage.
     */
    public void notifyAboutReceivedGroupSyncPackage(GroupSyncPackage groupSyncPackage){

        // Resets the group before synch
        group.removeAllParticipants();
    	
        // Uses the content of the package to update the group on this device
        Node[] participants = groupSyncPackage.getParticipants();        
        
        for(int i=0; i<participants.length; i++){            
            group.addParticipant(participants[i]);
        }        
        notifyAboutParticipants();
        
        String sender = groupSyncPackage.getSender().getAddress();
        log.logDataPackage(new StringBuffer().append("Received group sync package from ").append(sender).toString());        
    }
    
    
    /**
     * 
     * This method is called from NodeConnection.processIncomingData() 
     * whenever a text package is received from a remote node.
     * It processes the package, logs the event, and notifies the midlet.
     *
     * @param textPackage The received text package.
     */
    public void notifyAboutReceivedTextPackage(TextPackage textPackage){
    	log.logDataPackage(new StringBuffer().append("Received text package from ").append(textPackage.getSender().getNodeName()).append(".").toString());
        try {
            midlet.notifyAboutReceivedTextPackage(textPackage.getSender().getNodeName(), textPackage.getContent());
        } catch (IOException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        } catch (ClassNotFoundException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        } catch (IllegalAccessException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        } catch (InstantiationException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
    }
    
    /**
     * 
     * This method is called from NodeConnection.processIncomingData() 
     * whenever a file package is received from a remote node.
     * It processes the package, logs the event, and notifies the midlet.
     *
     * @param filePackage The received file package.
     */
    public void notifyAboutReceivedFilePackage(FilePackage filePackage){
    	log.logDataPackage(new StringBuffer().append("Received file (").append(filePackage.getFilePath()).append(") from ").append(filePackage.getSender().getNodeName()).toString());
    	midlet.notifyAboutReceivedFilePackage(filePackage.getSender().getNodeName(), filePackage.getFilePath());           
    }
    
    /**
     * 
     * This method notifies the midlet about the current group by running the 
     * notifyAboutParticipants method. It is e.g. called from 
     * FrameworkFrontEnd.synchronizeGroups().
     *
     */
    private void notifyAboutParticipants(){
        // Fetches all the participating Nodes        
        midlet.notifyAboutParticipants(getGroup().getParticipatingNodeNames(this));        
    }    
   
}


