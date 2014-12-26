package peer2me.domain;

import java.util.Vector;

/**
 * 
 * A GroupSyncPackage is a package used internally in the
 * framework to synchronize the groups containing the participants. The participant performing
 * the groupsync uses its own group as content of the package. All the receivers synchronizes
 * their groups based on the information found in the GroupSyncPackage.
 *
 * @author Torbj�rn Vatn & Steinar A. Hestnes
 */
public class GroupSyncPackage extends DataPackage {
    	
    // The participating nodes
    private Node[] participatingNodes;
		
	
	/**
	 * 
	 * Constructor
	 * 
	 * @param sender A node object representing the sender node
	 * @param recipients The addresses to the recipients of the groupsync package
	 * @param participatingNodes A hashtable with node addresses as keys and names as values 
	 * 
	 */
	public GroupSyncPackage(Node sender, String[] recipients, Node[] participatingNodes){
		super(GROUP_SYNC_PACKAGE, sender, recipients);		
		this.participatingNodes = participatingNodes;
	}
    
 	
	/**
	 * 
	 * Constructor used to create an empty GroupSyncPackage object to fill 
	 * with the parseBytes() method
	 */
	public GroupSyncPackage(){
		super(GROUP_SYNC_PACKAGE);
	}
    
    
    /**
     * 
     * This method returns a list of the nodes that are participating in the network (group)
     *
     * @return A list of participating nodes
     */
    public Node[] getParticipants(){
        return participatingNodes;
    }

	/**
	 * 
	 * This method transforms this groupsync package into a byte array (byte[]) 
	 * that is possible to send over a network stream
	 * 
	 * @return The byte[] representation of the groupsync package
	 * 
	 */
	public byte[] toSendableFormat() {
		
		// The String to send
		String sendableFormat = "";					
        
		// Setting the sender in the sendableFormat String
		// The format of the String is:
		// -> from:"address-of-the-sender":"name-of-the-sender"
		//
		Node sender = getSender();
		sendableFormat = new StringBuffer().append(sendableFormat).append("from:").append(sender.getNodeName()).append(":").append(sender.getAddress()).append("\n").toString();
		
		// Setting the recipients in the sendableFormat String
		// The format of the String is:
		// -> to:"address-of-the-recipient"
		//
		String[] recipients = getRecipients();
		for(int i=0; i<recipients.length; i++){
		    sendableFormat = new StringBuffer().append(sendableFormat).append("to:").append(recipients[i]).append("\n").toString();
		}
		
		// Setting the content in the sendableFormat String
		// The format of the String is:
		// -> participant:"name-of-a-participant":"address-of-a-participant"
		//		
		for(int i=0; i<participatingNodes.length; i++){
		    sendableFormat = new StringBuffer().append(sendableFormat).append("participant:").append(participatingNodes[i].getNodeName()).append(":").append(participatingNodes[i].getAddress()).append("\n").toString();
        }	
		
		return sendableFormat.getBytes();
	}

	/**
	 * 
	 * This method parses the content of the byte array (byte[]) back into a 
	 * GroupSyncPackage object
	 * 
	 * @param data The byte[] containing the data representing the GroupSyncPackage object
	 */
	public void parseBytes(byte[] data) {
		// Counter that keeps track of how many bytes are converted
		int processed = 0;
		// The node addresses used in the "to" section of the package
        Vector recipients = new Vector();
        // The node addresses used in the "participant" section of the package
        Vector participants = new Vector();      

        char newLine = '\n';
		// The loop processing the bytes
		while(processed < data.length){            
			// The StringBuffer temporary holding the content of the byte[]
			StringBuffer buffer = new StringBuffer();
			// Fetches the content of the byte[], stops for every new line (marked with a "\n")
			while(data[processed] != newLine){                
				buffer.append((char)data[processed]);
				processed++;
			}            
            
            // Adds 1 to the counter that keeps track of the bytes processed,
            // this is added due to the \n (new line)
            processed++;
			
            // Runs the toString() on the buffer
            String line = buffer.toString();
            
			// Retrives the sender, marked by "from"
            if(line.startsWith("from")){
				int fromStart = line.indexOf(":")+1;
				try{
					Node from = Node.restoreNode(line.substring(fromStart));
					setSender(from);                    
				}catch(Exception e){
					log.logException("NetworkPackage.parseBytes()1",e,false);					
				}
			}else
			
                 // Retrives the recipients, marked by "to"
                if(line.startsWith("to")){                
    				int toStart = line.indexOf(":")+1;
    				try{
    					recipients.addElement(line.substring(toStart));                    
    				}catch(Exception e){
    					log.logException("NetworkPackage.parseBytes()2",e,false);    					
    				}
    				// Sets the recipients in the super class DataPackage
    				String[] recipientAddresses = new String[recipients.size()];
    	            recipients.copyInto(recipientAddresses);
    				setRecipients(recipientAddresses);                
			}else

    			// Retrives the participants, marked by "participant" on each line
    			if(line.startsWith("participant")){
                    int participantStart = line.indexOf(":")+1;                    
                    try{
                        Node participant = Node.restoreNode(line.substring(participantStart));
                        participants.addElement(participant); 
                    }catch(Exception e){
                        log.logException("NetworkPackage.parseBytes()3",e,false);                        
                    }  			
            }
		}
        // End of package (while-loop). Adds the found participants to a list that can be read from the package object
        participatingNodes = new Node[participants.size()];
        participants.copyInto(participatingNodes);
	}
}
