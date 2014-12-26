package peer2me.framework;

import peer2me.domain.Hashtable;

import java.io.IOException;

//import java.util.Hashtable;


/**
 * This interface must be implemented by all Peer2Me MIDlets.
 * It ensures that the Framework can access a set of methods in the MIDlet in order
 * to notify the MIDlet about various events.
 *
 * @author Torbj�rn Vatn & Steinar A. Hestnes
 */
public interface FrameworkListener {

	/**
	 * 
	 * This method is called by the framework whenever an exception notice is 
     * given by the log. This will be done in cases where exceptions occure 
     * in threads and cannot be thrown in the usual way. 
	 *
	 * @param location The location where the Exception occured
	 * @param exception The actual Exception
	 */
	public void notifyAboutException(String location, Exception exception);
	
    
	/**
	 * 
	 * This method is called by the framework when a node is found. 
	 * These nodes are not yet connected in a network. 
	 * To do this, use the Framework.connectToNodes() method.
	 *
     * @param nodeAddress The network address of the node
     * @param remoteNodeName The name of the found remote node
     */
    public void notifyAboutFoundNode(String nodeAddress, String remoteNodeName);
      
    
    /**
     * 
     * This method is called from the framework whenever a text package is 
     * received from a remote node.
     *
     * @param senderName The name of the sender
     * @param textMessage The received text message
     */
    public void notifyAboutReceivedTextPackage(String senderName, String textMessage) throws IOException, ClassNotFoundException, IllegalAccessException, InstantiationException;
     
    
    /**
     * 
     * This method is called from the framework whenever a file package is 
     * received from a remote node.
     *
     * @param senderName The name of the sender
     * @param filePath The path to the received file
     */
    public void notifyAboutReceivedFilePackage(String senderName, String filePath);

    
    /**
     * 
     * This method is called from from the framework to notify the midlet about
     * the participants of the ad hoc network.
     * 
     * @param participants A hashtable that contains the names of the participants as unique keys and
     * the network addresses as values.
     */
    public void notifyAboutParticipants(Hashtable participants);



}
