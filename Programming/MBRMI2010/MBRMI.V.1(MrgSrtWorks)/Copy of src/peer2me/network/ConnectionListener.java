package peer2me.network;

import peer2me.util.Log;
import peer2me.domain.Node;
import java.io.IOException;
import javax.microedition.io.Connector;
import javax.microedition.io.StreamConnection;
import javax.microedition.io.StreamConnectionNotifier;


/**
 * This class contains a ConnectionListener thread listening for 
 * incoming connection attempts from other devices running 
 * the same MIDlet built upon the framework. 
 * When a incomming connection is detected, a Node representation is created 
 * representing the connecting device.  
 * A ConnectionListener thread is created in Network.init().
 *
 * @author Torbj�rn Vatn & Steinar A. Hestnes
 */
public class ConnectionListener implements Runnable{
	
	// The Log instance
	private Log log;
	
	// The network instance related to this ConnectionService	
	private Network currentNetwork;
	// The ConnectionURL that the ConnectionService should listen to
	private String connectionURL;
	// The StreamConnectionNotifier that creates a StreamConnection that 
	// represents a server side socket connection
	private StreamConnectionNotifier connectionNotifier = null;
	// The StreamConnection representing the open connection
	private StreamConnection connection = null;
	// This ConnectionService thread
	private Thread localThread;
	// Whether or not the Thread should shut down
	private boolean shutdown = false;
	// Whether or not the connection has failed
	private boolean failed = false;
	
	/**
	 * Constructor. 
	 * A ConnectionListener is created in the Network.init() method.
	 * 
	 * @param connectionURL The ConnectionURL to listen to
	 */	
	public ConnectionListener(String connectionURL){
		        
		this.currentNetwork = Network.getInstance();        
		this.connectionURL = connectionURL;
		
		// Fetches a instance of the Log
		log = Log.getInstance();
		        
		// Starts a ConnectionListener thread listening for a connection
		localThread = new Thread(this);
		localThread.start();
	}	
	
	/**
	 * This method is called when the ConnectionListener thread is started in the 
     * constructor.
     * 
     * It continously listens for incoming connections matching the
     * serviceID of the peer2me framework. The listener is "passive" and opens a 
     * connection waiting for a device to take contact.
     * If an incoming connetion occurs, information is abstracted from the remote 
     * node, and a node object containing this connection is created and added 
     * to the group on the local node.
     * 
	 */	
	public void run(){
		try{
			// Opens the stream
			connectionNotifier = (StreamConnectionNotifier) Connector.open(connectionURL);
            
			while(true){//(!failed || !shutdown){
				              
               // Returns a StreamConnection that represents a server side socket connection.
			   connection = (StreamConnection)connectionNotifier.acceptAndOpen();
                              
				// If the connection is successful a representation of the remote node is created
				if(!failed || !shutdown){

				    // Creates the node who found "me" (as a participant) and opens a connection
                    String address = Network.getInstance().getNodeAddress(connection);

                    Node remoteNode = new Node(address,connection);

                    // Starts the InputThread in NodeConnection again since we have a connection
                    remoteNode.getNodeConnection().openInputStream();
                    
                    // Adds the node who found "me" to the group containing all found nodes
                    currentNetwork.getFrameworkFrontEnd().getGroup().addParticipant(remoteNode);
                    
                    // This Node is discovered and connected by another Node the currentNetwork is notified
                    currentNetwork.connectionEstablished();                    
                    
                    log.logConnection(new StringBuffer().append("Connected successfully to a node with address: ").append(address).toString());
				}
			}
		
		}catch(IOException ioe)	{
			log.logException("ConnectionListener.run()",ioe, true);
			failed = true;
		}catch(SecurityException se) {
			log.logException("ConnectionListener.run()",se, true);
			failed = true;
		}catch(IllegalArgumentException iae){
			log.logException("ConnectionListener.run()",iae, true);
			failed = true;
		}
	}
	
	/**
	 * 
	 * This method shuts down this thread and closes the connection to clean up.
	 * It is called from FrameworkFrontEnd.shutdownFramework(). 
	 *
	 */
	public void shutdown(){
		// Have to shut down
		shutdown = true;
		// Closes the connection to clean
		try{
			connectionNotifier.close();
		}catch (IOException ioe) {
			log.logException("ConnectionListener.shutdown()",ioe,false);			
		}
	}
	
	
}
