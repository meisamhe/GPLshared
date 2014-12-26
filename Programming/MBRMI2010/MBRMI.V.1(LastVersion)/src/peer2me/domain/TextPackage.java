package peer2me.domain;

import java.util.Vector;

/**
 *
 * This class represents a data package containing text that should be
 * sent over the network.
 *
 * @author Torbj�rn Vatn & Steinar A. Hestnes
 */
public class TextPackage extends DataPackage {
	
	// The String content of this TextPackage
	private String content;
	
	
	/**
	 * 
	 * Constructor
	 * 
	 * @param sender A node object representing the sender node
	 * @param recipients The addresses to the recipients of the text package
	 * @param content The String to be sent
	 */
	public TextPackage(Node sender, String[] recipients, String content){
		super(TEXT_PACKAGE, sender, recipients);
		this.content = content;
	}

    public TextPackage(Node sender, String recipient, String content){
		super(TEXT_PACKAGE, sender, recipient);        
		this.content = content;
	}

    /**
	 * 
	 * Constructor used to create an empty TextPackage object to fill with the 
	 * parseBytes() method
	 */
	public TextPackage(){
		super(TEXT_PACKAGE);
	}
	
	/**
	 * 
	 * This method returns the text content of this TextPackage
	 *
	 * @return The content
	 */
	public String getContent(){
		return content;
	}
	
	/**
	 * 
	 * This method transforms this text package into a byte array (byte[]) that 
	 * is possible to send over a network stream
	 * 
	 * @return The byte[] representation of the text package
	 * 
	 */
	public byte[] toSendableFormat() {
        
		// The String to send
        String sendableFormat = "";
		
		// Setting the sender in the sendableFormat String
		// The format of the String is:
		// -> from:"address-of-the-sender":"name-of-the-sender"
		//		
        sendableFormat = new StringBuffer().append(sendableFormat).append("from:").append(getSender().getNodeName()).append(":").append(getSender().getAddress()).append("\n").toString();
		
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
		// -> content:"content"
		//
        sendableFormat = new StringBuffer().append(sendableFormat).append("content:").append(content).append("\n").toString();   
        
		return sendableFormat.getBytes();        
	}
	
	
	/**
	 * 
	 * This method parses the content of the byte array (byte[]) back into a TextPackage object
	 * 
	 * @param data The byte[] containing the data representing the TextPackage object
	 */
	public void parseBytes(byte[] data){
		// Counter that keeps track of how many bytes are converted
		int processed = 0;
		// The node addresses found in the "to" section of the String
		Vector recipients = new Vector();
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
			
			// Retrives the sender, marked by "from"
			if(buffer.toString().startsWith("from")){
				int fromStart = buffer.toString().indexOf(":")+1;
				try{
					Node from = Node.restoreNode(buffer.toString().substring(fromStart));
					setSender(from);
				}catch(Exception e){
					log.logException("TextPackage.parseBytes()",e,false);
				}
			}else
				
			if(buffer.toString().startsWith("to")){
				int toStart = buffer.toString().indexOf(":")+1;
				try{
					recipients.addElement(buffer.toString().substring(toStart));
				}catch(Exception e){
					log.logException("TextPackage.parseBytes()",e,false);
				}
			}else 
			if(buffer.toString().startsWith("content")){
				int contentStart = buffer.toString().indexOf(":")+1;
				content = buffer.toString().substring(contentStart);
			}
			// Adds 1 to the counter that keeps track of the bytes processed,
            // this is added due to the \n
			processed++;
			
			// Sets the recipients in the super class DataPackage
			String[] recipientAddreses = new String[recipients.size()];
            	recipients.copyInto(recipientAddreses);
			setRecipients(recipientAddreses);	
			
		}
	}

}
