package peer2me.domain;

import java.util.Enumeration;
import java.util.Vector;

import peer2me.framework.FrameworkFrontEnd;
import peer2me.network.NodeConnection;


/**
 * This class represents a group of nodes running the same service (MIDlet).
 * All connected nodes in the ad hoc network are participants in the group.
 * Participants can be added and removed, and a list of all the 
 * participants can be retreived.
 *
 * @author Torbjørn Vatn & Steinar A. Hestnes
 */

public class Group {

    // A list containing participating nodes
    private Hashtable participatingNodes;


    /**
     *
     * Constructor.
     *
     * Creates a new Group.
     * A group is created in FrameworkFrontEnd.initFramework().
     */
    public Group(){
        participatingNodes = new Hashtable();
    }

    /**
     *
     * This method closes the NodeConnection of all the participating nodes, and
     * removes all nodes from the group.
     * It is called from the MIDlet via FrameworkFrontEnd.shutdownFramework()
     * when all network connections should be closed.
     *
     */
    public void shutdownGroup(){
//    	Enumeration nodes = participatingNodes.elements();
        Vector nodes= participatingNodes.getVector();
        for (int i=0; i< nodes.size(); i++){
    		Node node = (Node)nodes.elementAt(i);
    		// Closes the connection
    		NodeConnection connection = node.getNodeConnection();
    		if(connection != null)connection.closeConnection();
    		// Removes the node from the Group
        	participatingNodes.remove(node.getAddress());
    	}
    }


    /**
     *
     * This method adds a node to the group as a participant.
     *
     * @param node The node to add as a participant.
     */
    public void addParticipant(Node node){
        // Adds the node only if it is not added already.

        // This test is necessary during groupsync
        if(!participatingNodes.containsKey(node.getAddress())){
        	participatingNodes.put(node.getAddress(),node);
        }else{
            // If the node already exists in the participant list, this is the node that
            // initially discovered this node and was saved only with address and connection
            // Name is still missing and we have to add it
            if(node.getNodeName() != null){
            	((Node)participatingNodes.get(node.getAddress())).setNodeName(node.getNodeName());
            }

            if(node.getNodeConnection() != null){
                if(node.getNodeConnection().getConnection() != null){
                	((Node)participatingNodes.get(node.getAddress())).startNodeConnection(); // Important to start the connection!
                	((Node)participatingNodes.get(node.getAddress())).getNodeConnection().setConnection(node.getNodeConnection().getConnection());
                }
            }
        }
    }


    /**
     *
     * This method removes a participating node.
     *
     * @param address The address of the node to remove from this group
     */
    public void removeParticipant(String address){
        participatingNodes.remove(address);
    }


    /**
     * This method removes all participating nodes.
     * It is used to clear the group before it is updated by a
     * groupSyncPackage received from a remote node.
     *
     */
    public void removeAllParticipants(){
    	participatingNodes.clear();
    }


    /**
     *
     * This method returns a list containing the nodes participating in this group.
     * The address is the key to find the Node.
     *
     * @return A list containing the nodes participating in this group. The address is
     * the key and the node name is the value
     */
    public Hashtable getParticipatingNodes(){
        return participatingNodes;
    }

    /**
     *
     * This method returns a list containg the names (as keys) of the nodes participating in this group.
     * The addresses are stored as values.
     * It is called from FrameworkFrontEnd.notifyAboutParticipants().
     *
     * @return A list containing the nodes participating in this group. The node name is
     * the key and the address is the value
     */
    public Hashtable getParticipatingNodeNames(FrameworkFrontEnd frameworkFrontEnd){

    	// An enum containing the node addresses
        Enumeration addresses = participatingNodes.keys();

        // Makes a hashtable with names as keys and addresses as values
        Hashtable names = new Hashtable();

        while(addresses.hasMoreElements()){
            String address = (String)addresses.nextElement();
            // The local node should not be added because a user should not send datapackages to him/her-self
            if(!address.equals(frameworkFrontEnd.getLocalNode().getAddress())){
                Node node = (Node)participatingNodes.get(address);
                String name = node.getNodeName();
                names.put(name,address);
            }
        }
        return names;
    }


    /**
     *
     * This method returns a node with the address specified as input
     *
     * @param address The address of the node to get
     * @return A node with the address specified as input
     */
    public Node getNode(String address){
        Object node = participatingNodes.get(address);
        if(node != null) return (Node)participatingNodes.get(address);
        else return null;
    }


}
