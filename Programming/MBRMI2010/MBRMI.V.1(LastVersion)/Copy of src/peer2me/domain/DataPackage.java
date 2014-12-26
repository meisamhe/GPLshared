package peer2me.domain;

import peer2me.util.Log;


/**
 * 
 * This class is the super class of the different type of packages that can be
 * sent between nodes in the network. It contains the attributes that are common
 * for all types of data packages. These are the address of the sender and the 
 * address(es) to the recipiant(s) of the DataPackage. Currently, there exists
 * three types of data packages.
 *
 * @author Torbj�rn Vatn & Steinar A. Hestnes
 */
public abstract class DataPackage {
    
	// A Log instance
	public Log log = Log.getInstance();
	
    // The type of package
    private int type;    
	// The Node that sendt the data package
	private Node sender;
	// The addresses of the nodes that are the recipients of the data package
	private String[] recipients;
    
	/* The constants representing the different types of data packages used
    in node connection to determine the type of package recived */
    public final static int GROUP_SYNC_PACKAGE = 0;    
    public final static int TEXT_PACKAGE = 1;
    public final static int FILE_PACKAGE = 2;
	
	/**
	 * 
	 * Constructor
	 * 
	 * @param type The type specifying the type of data package
	 * @param sender A node object representing the sender node
	 * @param recipients The addresses to the recipients of the data package
	 * 
	 */
	public DataPackage(int type, Node sender, String[] recipients){
        this.type = type;
        this.sender = sender;
		this.recipients = recipients;
	}

    public DataPackage(int type, Node sender, String recipient){
        this.type = type;
        this.sender = sender;
        String[] temp=new String[1] ;
        temp[0]=recipient;
        this.recipients = temp;		
	}

    /**
	 * 
	 * Constructor used to create an empty DataPackage object to fill with the 
	 * parseBytes() method
	 * 
	 * @param type The type of the DataPackage
	 */
	public DataPackage(int type){
		this.type = type;
	}
	
    
    /**
     * 
     * This method returns an int indicating the type of data package
     *
     * @return type An int indicating the type of data package
     */
    public int getType(){
        return type;
    }
    
    
	/**
	 * 
	 * This method returns the sender of this data package
	 *
	 * @return sender The node that sends this package
	 */
	public Node getSender(){
		return sender;
	}
	
    
    /**
     * 
     * This method sets the sender of this data package
     *
     * @param sender The node that sends this package
     */
    public void setSender(Node sender){
        this.sender = sender;
    }
    
    
	
	/**
	 *
	 * This method returns all the recipients of this data package
	 *
	 * @return recipients The addresses to the recipients of this package
	 */
	public String[] getRecipients(){
		return recipients;
	}
	
    
    /**
     * 
     * This method sets the nodes to receive this package
     *
     * @param recipients The addresses to the nodes that shall receive this package
     */
    public void setRecipients(String[] recipients){
        this.recipients = recipients;
    }
	
	
	/*******************************************************************************/
	// The abstract methods inherited and overridden by the sub data package classes 
	/*******************************************************************************/
	
	/**
	 * 
	 * This method transforms this data package into a byte array (byte[]) that 
	 * is possible to send over a network stream
	 * 
	 * @return The byte[] representation of the data package
	 */
	public abstract byte[] toSendableFormat();
	
	/**
	 * 
	 * This method parses the content of the byte array (byte[]) back into a DataPackage object
	 * 
	 * @param data The byte[] containing the data representing the DataPackage object
	 *
	 */
	public abstract void parseBytes(byte[] data);

}
