package peer2me.framework;

import java.io.IOException;
import java.util.Enumeration;

/**
 * 
 * This interface acts as a "facade" for the entire Peer2Me framework as the
 * methods in this interface is the only methods the MIDlets running the 
 * framework needs access to. To use the Peer2Me framework, the MIDlets should
 * run the FrameworkFrontEnd.getInstance() which returns a
 * reference of type Framework. All framework services is then available
 * through this reference.
 * 
 * @author Torbj�rn Vatn & Steinar A. Hestnes
 */
public interface Framework{

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
	public void initFramework(String nodeName, String midletName, String preferredNetwork) throws ClassNotFoundException, IllegalAccessException, InstantiationException, IOException, Exception;

	 public void setFrameworkListener(FrameworkListener midlet);
     public FrameworkListener getFrameworkListener();
    /**
	 * 
	 * This method shuts down the framework and closes all the open network connections and streams.
	 * It should be called before closing the MIDlet to clean up the network connections. 
	 *
	 */
	public void shutdownFramework();
	
	
	/**
	 * 
	 * This method starts a search for devices running the same MIDlet.
	 * When such a device is found, the notifyAboutFoundNode() method 
	 * specified by the FrameworkListener interface is called.
	 *
	 * @throws IOException Thrown if the search crashes
	 */
	public void startNodeSearch() throws IOException;
	    
    
    /**
     * 
     * This method connects multiple devices in a network. 
     * When a connection is established, the notifyAboutParticipants() 
     * method specified by the FrameworkListener interface is called.
     * 
     * @param addresses The addresses of the devices to connect to.
     */
    public void connectToNodes(String[] addresses);

     public void connectToNode(String address);
    
    
    /**
     * 
     * This method sends a text package over the network. When the package
     * terminates to the recipients, they are alerted by the 
     * notifyAboutReceivedTextPackage() method specified by the 
     * FrameworkListener interface.  
     *    
     * @param recipients A list containing the addresses of the recipient nodes
     * @param textMessage The text message to be sent
     *
     */
    public void sendTextPackage(String[] recipients, String textMessage);
    public void sendTextPackage(String recipient, String textMessage);
    
         
    /**
     * 
     * This method sends a file package over the network. When the package
     * terminates to the recipients, they are alerted by the 
     * notifyAboutReceivedFilePackage() method specified by the 
     * FrameworkListener interface.   
     *     
     * @param recipients A list containing the addresses of the recipient nodes
     * @param filePath The path of the file to be sent
     *
     */
    public void sendFilePackage(String[] recipients, String filePath);     
    
    
    /**
     * 
     * This method returns a list of the files in the given root directory on the device
     * 
     * @param root The path to the root directory
     * @return An enumeration containing the names of the files in the root directory
     */
    public Enumeration getFileList(String root);
	
	
    
}
