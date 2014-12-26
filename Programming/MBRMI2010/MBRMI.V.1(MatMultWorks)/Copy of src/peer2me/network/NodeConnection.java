package peer2me.network;

import peer2me.util.FileHandler;
import peer2me.util.Log;
import peer2me.domain.DataPackage;
import peer2me.domain.FilePackage;
import peer2me.domain.GroupSyncPackage;
import peer2me.domain.Node;
import peer2me.domain.TextPackage;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.EOFException;
import java.io.IOException;
import java.util.Date;
import java.util.Vector;
import javax.microedition.io.StreamConnection;


/**
 * 
 * This class contains a thread that runs on each connected node and listens for
 * incoming data packages and sends data packages out. 
 * It is created and started in NodeConnection.startNodeConnection().
 *
 * @author Torbj�rn Vatn & Steinar A. Hestnes
 */
public class NodeConnection{
    
    // The Log instance
    private Log log;
    
    // The Network instance of the preferred network
    private Network currentNetwork;   
    
    // The different variables concerning the in- and out streams
    private DataInputStream inputStream;
    private DataOutputStream outputStream;
    private StreamConnection connection;
    private Node node;
    
    // The queue holding the data packages to send
    private Vector sendQueue;
    
    // Boolean values that controls whether or not the Input- and OutputStreams are allowed to perform their tasks
    private boolean openInputStream;
    private boolean openOutputStream;
    
    // The threads running whenever a connection is open.
    private InputThread inputThread;
    private OutputThread outputThread;
    
    /**
     * 
     * Constructor. 
     * This constructor is called from the constructor in class Node.
     * 
     * @param connection The connection to the node
     * @param node The node that owns this NodeConnection
     */
    public NodeConnection(StreamConnection connection, Node node){
    	
        // Fetches a instance of the Log
        log = Log.getInstance();        
        // Sets the connection to connect to and fetches an instance of the currentNetwork
        this.connection = connection;
        this.node = node;
        currentNetwork = Network.getInstance();        
        // Creates the sendQue
        sendQueue = new Vector();

        // The Input- and OutputStreams shall not do anything before the node is connected
        // These values are toggled from ConnectionListener.run() and NodeConnection.sendDataPackage()
        openInputStream = false;
        openOutputStream = false;
        // Starts a thread that processes the sendQue        
        outputThread = new OutputThread();
        outputThread.setPriority(Thread.MAX_PRIORITY);
        outputThread.start();
        // Starts a thread constantly listening for incoming datapackages
        inputThread = new InputThread();
        inputThread.setPriority(Thread.MAX_PRIORITY);
        inputThread.start(); 
    }
    
    /**
     * 
     * This method return the size of the sendQue.
     * 
     * @return The size of the sendQue
     */
    public int getSendQueueSize(){
    	return sendQueue.size();
    }
    
    
    /**
     * 
     * This method receives incoming datapackages from remote nodes.
     * It is called in an infinite loop in the private class InputThread 
     * in this class.
     * 
     */
    public void processIncomingData(){
        if(connection != null){        	
        	boolean connectionFailed = false;
            try{            
                if(inputStream == null){                
                    inputStream = connection.openDataInputStream();
                }                                                    
            }catch(IOException ioe1){
                connectionFailed = true;
                log.logException("NodeConnection.processIncomingData()1",ioe1,true);
                // Opening of streams failed, ergo connection lost
                // Close connection and inform the NodeListener
                try {
                    connection.close();
                    // The connection must be set to null to stop the thread running 
                    // this method when the connection has closed
                    connection = null; 
                } catch (IOException ioe2){
                    log.logException("NodeConnection.processIncomingData()2",ioe2,true);
                }                
            }
            
            // If an inputstream and an outputstream was successfully opened, a infinite loop starts
            if(!connectionFailed){                
                try {
                    while(inputStream != null && connection != null && !connectionFailed){                    	
                        int type = -1;
                        try{                        	
                            // Reads the type of the data package                        	
                            type = inputStream.readInt();                            
                        }catch(IOException ioe){
                            connectionFailed = true;
                        }
                        // The type of the package determines what should be done with the package
                        switch(type){
                        
                        case(DataPackage.GROUP_SYNC_PACKAGE):
                            // Reads the length of the incoming package
                            int byteLength1 = inputStream.readInt();
                            byte[] bytes1 = new byte[byteLength1];           
                            // Reads the incoming bytes
                            for(int i=0;i<bytes1.length;i++){   
                           		bytes1[i] = inputStream.readByte();                           		
                            }                            
                            
                            // Checks if the sendQue on the sender side is empty                       
                            if(inputStream.readBoolean()){
                            	// Closes the connection if the remote node is finished sending all its datapackages    
                            	openInputStream = false;
                            }
                            
                            GroupSyncPackage groupSyncPackage = new GroupSyncPackage();
                            
                            // Interprets the content and sets the variables in the groupSyncPackage object                        
                            groupSyncPackage.parseBytes(bytes1);
                            
                            // Notifies the midlet via the frontEnd about the received message.                        
                            currentNetwork.getFrameworkFrontEnd().notifyAboutReceivedGroupSyncPackage(groupSyncPackage);
                            break;
                        
                        case(DataPackage.TEXT_PACKAGE):
                            // Reads the length of the incoming package
                            int byteLength2 = inputStream.readInt();  
                            byte[] bytes2 = new byte[byteLength2];  

                            // Reads the incoming bytes in blocks
                            // Reading blocks increases the transfer rate considerably
                            boolean finishedReading = false;
        	    			int blockSize = 200;
        	    			int totalRead = 0;
        	    			while(!finishedReading){       	    				
        	    				// If whats left is less than one blockSize
        	    				if(byteLength2 - totalRead < blockSize) blockSize = byteLength2-totalRead;
        	    				byte[] block = new byte[blockSize];
        	    				int numberRead = inputStream.read(block,0,blockSize);
        	    				// Stores whats read in an array large enough for the whole package
        	    				for(int i=0; i<numberRead; i++){
        	    					bytes2[totalRead] = block[i];        	    					
        	    					totalRead++;
        	    				}      	    				
        	    				if(totalRead == byteLength2) finishedReading = true;
        	    			}                            
                                                        
                            // Checks if the sendQue on the sender side is empty                            
                            if(inputStream.readBoolean()){	
                            	// Closes the connection if the remote node is finished sending all its datapackages
                            	openInputStream = false;
                            }                           
                            
                            // Notifies the midlet via the frontEnd about the received message.                        
                            TextPackage textPackage = new TextPackage();
                            textPackage.parseBytes(bytes2);
                            
                            currentNetwork.getFrameworkFrontEnd().notifyAboutReceivedTextPackage(textPackage);
                            break;
                        
                        case(DataPackage.FILE_PACKAGE):
                        	// Reads the length of the incoming package
                            int byteLength3 = inputStream.readInt();  
                            byte[] bytes3 = new byte[byteLength3];
                            // Reads the incoming bytes                            
                            for(int i=0;i<bytes3.length;i++){
                                bytes3[i] = inputStream.readByte();                                
                            }
                            
                            // Creates a filePackage based on the received data                       
                            FilePackage filePackage = new FilePackage();
                            filePackage.parseBytes(bytes3);
                            // Reads the file and writes it to the filesystem
                            FileHandler fileHandler = new FileHandler(filePackage.getFilePath());
                            // Fetches the size of the file and sets it in the fileHandler
                            fileHandler.setFileSize(filePackage.getFileSize());
                            
                            // Checks if the sendQue on the sender side is empty
                            if(inputStream.readBoolean()){	
                            	// Closes the connection if the remote node is finished sending all its datapackages
                            	openInputStream = false;
                            }
                            
                            boolean endOfFile= false;
                            while(!endOfFile){
                            	try{  
                            		byte[] theBytes = new byte[fileHandler.getBlockSize()];
                            		// Reads data from the inputStream into a byte table
                            		int numberOfBytesRead = inputStream.read(theBytes, 0, fileHandler.getBlockSize());                            		
                            		// Writes the bytes to file
	                        		fileHandler.writeFile(theBytes, numberOfBytesRead);	                        			                        		
	                        		
                            	}catch(EOFException eofe){                            		
                            		endOfFile = true;
                            		fileHandler.closeFile();
                            	}                            	                            	
                            }
                            
                            currentNetwork.getFrameworkFrontEnd().notifyAboutReceivedFilePackage(filePackage);
                            break;
                        
                        default:
                            break;
                        }                    
                    }
                    
                }catch(IOException ioe) {
                    log.logException("NodeConnection.processIncomingData()3", ioe, true);                   
                }
            }
        }
    }
    
  
    
    /**
     * 
     * This method sends datapackages to remote nodes. 
     * It processes the que of unsent datapackages.
     * It is called in an infinite loop in the private class OutputThread 
     * in this class.
     * 
     */
    public synchronized void processSendQueue(){
        if(connection != null){
    		if(sendQueue.size() > 0){
    			// Retriving the data packages to send from the sendQue
    			DataPackage dataPackage = (DataPackage)sendQueue.firstElement();                
    			sendQueue.removeElement(dataPackage);                
    			// A byte table holding the data to send
    			byte[] data = dataPackage.toSendableFormat();                
    			
    			try{
	    			// Opening the output stream if it is not allready open
	    			if(outputStream == null){
                        outputStream = connection.openDataOutputStream();
                    }
	    			
	    			// Saves a timestamp used to estimate the transfer rate  
	    			long startTime = new Date().getTime();
	    			
	    			// Sending the type of the data package over the steam 
                    outputStream.writeInt(dataPackage.getType());
                                        
                    // Sending the length of the data package over the steam
	    			outputStream.writeInt(data.length);	    			

	    			// Sends the data package in blocks over the stream
                    // Sending blocks instead of single bytes increases the transfer rate considerably
	    			boolean finishedWriting = false;
	    			int blockSize = 200;	    			
	    			int totalWritten = 0;
	    			while(!finishedWriting){
	    				// If whats left is less than one blockSize
	    				if(data.length - totalWritten < blockSize) blockSize = data.length-totalWritten;
	    				byte[] block = new byte[blockSize];
	    				// Fills the byte array to be sent
	    				for(int i=0; i<blockSize; i++){
	    					block[i] = data[totalWritten];
	    					totalWritten++;
	    				}
	    				outputStream.write(block);

	    				if(totalWritten == data.length) finishedWriting = true;
	    			}
                    
                    // If the datapackage is a FilePackage we have to send the content
                    // of the file                                     
                    long fileSize = 0;
                    if(dataPackage.getType() == DataPackage.FILE_PACKAGE){                      	
                    	// Opens the file handler
                    	FileHandler fileHandler = new FileHandler(((FilePackage)dataPackage).getFilePath());
                    	
                    	// Flushes the output stream
                        outputStream.flush();
                        
                    	boolean endOfFile = false;
                    	while(!endOfFile){
                    		try{
                    			byte[] theBytes = fileHandler.readFile();
                    			outputStream.write(theBytes);
                    		}catch(EOFException eofe){
                    			endOfFile = true;  
                    			fileHandler.closeFile();
                    		}
                    	}                        
                    	fileSize = ((FilePackage)dataPackage).getFileSize();
                    }                    
                    
                    
                    // Logs a message if the text package was sent successfully 
                    if(dataPackage.getType() == DataPackage.TEXT_PACKAGE || dataPackage.getType() == DataPackage.FILE_PACKAGE){
                    	 // Estimates the transfer rate of the file
                        long endTime = new Date().getTime();                  
                        long transferTime = (endTime-startTime)/1000;
                        if(transferTime==0) transferTime = 1;
                        double kBps = ((double)(data.length+fileSize)/1024)/(double)transferTime;
                        
                        //the code below calculates and rounds off the transfer rate with three decimals 
                        String rate = Double.toString(kBps);
                        int commaIndex = rate.indexOf(".");
                        int decimal3 = Integer.parseInt(new StringBuffer().append("").append(rate.charAt(commaIndex + 3)).append("").toString());            
                        int decimal4 = Integer.parseInt(new StringBuffer().append("").append(rate.charAt(commaIndex + 4)).append("").toString());            
                        rate = rate.substring(0,commaIndex+4);
                        if(decimal4>=5){
                            if(decimal3 == 9){                    
                                decimal3 = decimal3+1;
                                rate = rate.substring(0,commaIndex+2);
                                rate = new StringBuffer().append(rate).append(decimal3).toString();
                            }
                            else{                    
                                decimal3 = decimal3+1;
                                rate = rate.substring(0,commaIndex+3);
                                rate = new StringBuffer().append(rate).append(decimal3).toString();
                            }
                        }
                        
                    	log.logDataPackage(new StringBuffer().append("Finished transfering data to ").append(node.getNodeName()).append(". (Transfer rate was ").append(rate).append("kB/s)").toString());
                    }
                    
    			}catch(IOException ioe){
    				// Because this method is called from within a run() the log has to noitfy the MIDLet of the exception
    				log.logException("NodeConnection.processSendQue()",ioe,true);
    				closeConnection();
    				// Tries to send the datapackage once more
    				currentNetwork.sendDataPackage(dataPackage,dataPackage.getRecipients());
				}
    		}

    		
    		// If the queue is not empty, the processing continues
    		try {
    			Thread.sleep(500);
			} catch (InterruptedException ie) {
				// do nothing
			}    		
    		try{
    			// Closes the outputstream if the sendQueue is empty
                // The connections are re-established when a new datapackage is sent
                if(sendQueue.size() == 0){
                   // Notifies the remote recipient that we are closing the stream
                   outputStream.writeBoolean(true);
                   openOutputStream = false;
                   // Flushes the output stream
                   outputStream.flush();
                }else{
                    outputStream.writeBoolean(false);
                    // Flushes the output stream
                    outputStream.flush();
                    // Must process the next package
                	processSendQueue();
                }
			}catch(IOException ioe){
    				// Because this method is called from within a run() the log has to noitfy the MIDLet of the exception
    				log.logException("NodeConnection.processSendQue()2",ioe,true);
    				closeConnection();    			
    		}
        }
    }
    
    
    /**
     * 
     * This method is called by the sendMessage() method in the Network class 
     * when a data package is sent to the Node associated with this 
     * NodeConnection.
     *
     * @param dataPackage The DataPackage to send
     */
    public synchronized void sendDataPackage(DataPackage dataPackage){
    	sendQueue.addElement(dataPackage);
        // Continues to run the Input- and OutputStreams on the 
        // representation of the remote recipient node        
        openOutputStream();        
    }    

    
    /**
     * 
     * This method returns the connection object.
     *
     * @return An object representing the connection to the remote node
     */
    public StreamConnection getConnection(){
        return connection;
    }
    
    /**
     * 
     * This method updates the connection object. It is used when the existing
     * connection is closed and a new open connection is needed.
     *
     * @param connection The connection to the remote node
     */
    public void setConnection(StreamConnection connection){
        this.connection = connection;
    }
    
    /**
     * 
     * This method sets a boolean that controls whether or not the InputStream 
     * are allowed to listen for incoming data.
     * The value is toggled from ConnectionListener.run().
     * 
     */
    public void openInputStream(){
    	this.openInputStream = true;
    	// Starts the steams again
    	inputThread.restartThread();    	
    }
    
    /**
     * 
     * This method sets a boolean that controls whether or not the OutputStream 
     * are allowed to send data.
     * The value is toggled from NodeConnection.sendDataPackage()    
     * 
     */
    public void openOutputStream(){
    	this.openOutputStream = true;
    	// Starts the steams again
    	outputThread.restartThread();    	
    }
    
    /**
     * 
     * This method closes the input- and output streams and the connection.
     * It is called from Group.shutdownGroup() to clean up during shutdown.
     *
     */
    public void closeConnection(){
	    try{	    	
	    	if(outputStream != null) this.outputStream.close();
	        this.outputStream = null;
	        if(inputStream != null) this.inputStream.close();
	        this.inputStream = null;
	        if(connection != null) this.connection.close();
	        this.connection = null;
		}catch(IOException ioe){
			// Because this method is called from within a run() the log has to noitfy the MIDLet of the exception
			log.logException("NodeConnection.closeConnection()",ioe,true);
		}
    }
    
    
    /**
     * 
     * This class is a thread listening for incoming datapackages from remote nodes.
     * The thread is started from the constructor in class NodeConnection.
     * 
     * @author Torbj�rn Vatn & Steinar A. Hestnes
     */
    private class InputThread extends Thread{
        
        /**
         * Constantly running. It is run from the constructor in class NodeConnection.
         * Constantly listening for incoming datapackages.
         * 
         */    	
        public void run(){        	
            while(true){
                if(openInputStream){                	
                	try{
 	                	// Sleeps the thread to ensure that the connection is open  
 	                    sleep(500);
 	                }catch(InterruptedException ie){
 	                    // This exception is irrelevant for the excecution
 	                }
 	             	// Calls the processIncomingData() method to receive data packages from remote nodes
	                processIncomingData();
	                
	                if(!openInputStream){
		                try{
	            			// Sleeps the thread to ensure that the connection is ready to be closed  
	            			sleep(500);
		                }catch(InterruptedException ie){
		                    // This exception is irrelevant for the excecution
		                }
		                closeConnection();
	                }
                }
                // Pauses the thread until it is notified again
                this.pauseThread();
            }
        }
        
        /**
         * This method pauses this thread
         *
         */
        private synchronized void pauseThread(){
        	try{        		
        		this.wait();
        	}catch(InterruptedException ie){
        		// This exception is irrelevant for the excecution        		
        	}
        }
        
        /**
         * This method notifies this thread
         *
         */
        public synchronized void restartThread(){        	
        	this.notify();
        }
    }
    
    
    /**
     * 
     * This class is a thread sending datapackages to remote nodes.
     * The thread is started from the constructor in class NodeConnection.
     *
     * @author Torbj�rn Vatn & Steinar A. Hestnes
     */
    private class OutputThread extends Thread{
        
        /**
         * Constantly running. It is run from the constructor in class NodeConnection.
         * Processes the sendQue.
         * 
         */
        public void run(){  
            while(true){            	
            	if(openOutputStream){
            		try{
            			// Sleeps the thread to ensure that the connection is open  
            			sleep(500);
	                }catch(InterruptedException ie){
	                    // This exception is irrelevant for the excecution
	                }
	                // Calls the processSendQue() method to send any unsendt data packages
	                processSendQueue();

	                if(!openOutputStream){
		                try{
	            			// Sleeps the thread to ensure that the connection is ready to be closed  
	            			sleep(10000);
		                }catch(InterruptedException ie){
		                    // This exception is irrelevant for the excecution
		                }		                
		                closeConnection();
	                }
            	}
            	// Pauses the thread until it is notified again
                this.pauseThread();	
            }
        }
        
        
        /**
         * This method pauses this thread
         *
         */
        private synchronized void pauseThread(){
        	try{        		
        		this.wait();
        	}catch(InterruptedException ie){
        		// This exception is irrelevant for the excecution        		
        	}
        }
        
        /**
         * This method notifies this thread
         *
         */
        public synchronized void restartThread(){        	
        	this.notify();
        }
    }    
    
    
}