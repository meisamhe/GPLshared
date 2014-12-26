package peer2me.domain;

import peer2me.network.NodeConnection;
import javax.microedition.io.StreamConnection;


/**
 * This class represents a node in the network.
 * It contains information like the name of the node and its network address.
 * A node also owns a nodeConnection object listening for- and processing 
 * incoming and outgoing data packages.
 *
 * @author Torbjørn Vatn & Steinar A. Hestnes
 */
public class Node {

    // Object variables relevant for a node
    private String nodeName;
    private String address;
    // The connection to the remote node
    private StreamConnection connection;
    // The NodeConnection holding the connection to the remote node
    private NodeConnection nodeConnection;

 
    /**
     * 
     * Constructor. Creates a new Node. 
     * This constructor is used when a node is created to represent the LOCAL 
     * device. In this case, nodeName and address are known. 
     * The constructor is called from FrameworkFrontEnd.initFramework().
     * 
     * @param nodeName The name of the node
     * @param address The node network address
     */
    public Node(String nodeName, String address){
        this.nodeName = nodeName;
        this.address = address;           
    }
    
    
    /**
     * 
     * Constructor. Creates a new Node.
     * This constructor is used when a node is created to represent a remote 
     * device on the node which INITIATED the search. 
     * In this case, name and address is known. In addition, a 
     * StreamConnection object containing a connection to this remote device 
     * exists. 
     * The constructor is called from the nodeFound() method in the Network subclass.
     *
     * @param nodeName The name of the node
     * @param address The node network address
     * @param connection The connection to this remote node  
     *
     */    
    public Node(String nodeName, String address, StreamConnection connection){
        this.nodeName = nodeName;
        this.address = address;
        this.connection = connection;
        // Starts the connection thread on the remote node
        startNodeConnection();
    }
    
    
    /**
     * 
     * Constructor. Creates a new Node.
     * This constructor is used when a node is created to represent a remote 
     * device on the node which was DISCOVERED during a search. 
     * In this case, only the address is known. In addition, a 
     * StreamConnection object containing a connection to this remote device 
     * exists. 
     * The constructor is called from the run() method in ConnectionListener.
     * 
     * @param address The node network address
     * @param connection The connection to this remote node  
     */
    public Node(String address, StreamConnection connection){
        this.address = address;
        this.connection = connection;
        // Starts the connection thread on the remote node
        startNodeConnection();
    }
     
    
    /**
     * 
     * This method creates a nodeConnection running two threads. 
     * One of the threads listens for incoming data packages, and the other
     * processes outgoing data packages. 
     * It is only used when this node object represents a remote node.
     *
     */
    public void startNodeConnection(){    	
    	// Starts a thread that listens for incoming and outgoing messages from/to this node
    	if(nodeConnection == null) nodeConnection = new NodeConnection(connection, this); 
    }
    
    /**
     * 
     * This method returns the NodeConnection owned by this node
     *
     * @return nodeConnection This nodes NodeConnection
     */
    public NodeConnection getNodeConnection(){
    		return nodeConnection;
    }    
    
    /**
     * This method sets the connection to this remote node. 
     * It is called from Network.nodeFound().
     * 
     * @param connection The connection to this remote node  
     */
    public void setNodeConnection(StreamConnection connection){
        this.connection = connection;
        if(nodeConnection != null) nodeConnection.setConnection(connection);
    }
     
   /**
    * 
    * This method returns the name of the node
    *
    * @return The nodeName
    */
    public String getNodeName() {
        return nodeName;
    }

    
    /**
     * 
     * This method sets the name of the node
     *
     * @param nodeName The name of the node
     */
    public void setNodeName(String nodeName){
        this.nodeName = nodeName;
    }
    
   
    /**
     * 
     * This method returns the node address
     *
     * @return The node network address
     */
    public String getAddress() {
        return address;
    }
    
     
    /**
     * 
     * This method restores a node with the properties specified in the given input string.   
     * 
     * @param nodeString A string containing node properties (name:address)
     *
     */
    public static Node restoreNode(String nodeString){
        int separator = nodeString.indexOf(":");
        return new Node(nodeString.substring(0, separator),nodeString.substring(separator+1, nodeString.length()));
    }    

    
}
