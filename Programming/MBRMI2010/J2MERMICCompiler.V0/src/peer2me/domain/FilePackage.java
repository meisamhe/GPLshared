package peer2me.domain;

import java.util.Vector;
import peer2me.util.FileHandler;

/**
 * This class represents a data package containing metadata about a file of some
 * sort that should be sent over the network. The package contains the file path 
 * and length of the file to transfer, so that the receiver can handle the incoming 
 * stream of data and transform it back into a copy of the file.
 *
 * @author Torbj�rn Vatn & Steinar A. Hestnes
 */
public class FilePackage extends DataPackage {
	
	// The file path of the file to transfer
	private String filePath;
	
	// The size of the file
	private long fileSize;

	
	/**
	 * 
	 * Constructor
	 * 
	 * @param sender A node object representing the sender node
	 * @param recipients The addresses to the recipients of the file package
	 * @param filePath The path of the file to be sent
	 */
	public FilePackage(Node sender, String[] recipients, String filePath){
		super(FILE_PACKAGE,sender,recipients);
		this.filePath = filePath;
		this.fileSize = new FileHandler(filePath).getFileSize();
	}
	
	/**
	 * 
	 * Constructor used to create an empty FilePackage object to fill with the 
	 * parseBytes() method
	 *
	 */
	public FilePackage(){
		super(FILE_PACKAGE);
	}
	
	/**
	 * 
	 * This method returns the file path of this FilePackage
	 *
	 * @return The file path
	 */
	public String getFilePath(){
		return filePath;
	}
	
	/**
	 * 
	 * This method returns the file size of this FilePackage
	 * 
	 * @return The file size
	 */
	public long getFileSize(){
		return fileSize;
	}
	
	
	
	/**
	 * 
	 * This method transforms this file package into a byte array (byte[]) that 
	 * is possible to send over a network stream
	 * 
	 * @return The byte[] representation of the file package
	 * 
	 */
	public byte[] toSendableFormat() {
		
		// The String to send
		String sendableFormat = "";
			
		// Seting the sender in the sendableFormat String
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
		
		// Setting the filePath in the sendableFormat String
		// The format of the String is:
		// -> filePath:"filePath"
		//		
        sendableFormat = new StringBuffer().append(sendableFormat).append("filePath:").append(filePath).append("\n").toString();
		
		// Setting the fileSize in the sendableFormat String
		// The format of the String is:
		// -> fileSize:"fileSize"
		//		
        sendableFormat = new StringBuffer().append(sendableFormat).append("fileSize:").append(fileSize).append("\n").toString();
		
		return sendableFormat.getBytes();
	}

	/**
	 * 
	 * This method parses the content of the byte array (byte[]) back into a FilePackage object
	 * 
	 * @param data The byte[] containing the data representing the FilePackage object
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
					log.logException("FilePackage.parseBytes()",e,false);
				}
			}else
				
			if(buffer.toString().startsWith("to")){
				int toStart = buffer.toString().indexOf(":")+1;
				try{
					recipients.addElement(buffer.toString().substring(toStart));
				}catch(Exception e){
					log.logException("FilePackage.parseBytes()",e,false);
				}
			}else 
				
			if(buffer.toString().startsWith("filePath")){
				int contentStart = buffer.toString().indexOf(":")+1;
				filePath = buffer.toString().substring(contentStart);
			}else
				
			if(buffer.toString().startsWith("fileSize")){
				int contentStart = buffer.toString().indexOf(":")+1;
				fileSize = Long.parseLong(buffer.toString().substring(contentStart));
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
