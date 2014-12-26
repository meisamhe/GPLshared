package peer2me.util;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.EOFException;
import java.io.IOException;
import java.util.Enumeration;
import javax.microedition.io.Connector;
import javax.microedition.io.file.FileConnection;

/**
 * This class contains functionality for reading and writing all kinds of
 * files to and from the device file system.
 *
 * @author Torbj�rn Vatn & Steinar A. Hestnes
 */
public class FileHandler{
	
	// The path to the file
	private String filePath;
	
	// The streams related to the file
	private DataInputStream inputStream;
	private DataOutputStream outputStream;

    // The connection to the file
	private FileConnection fileConnection;
	
	// How long to sleep from opening the stream to start reading/writing
	private final int sleepTime = 20;
	
	// The size of the blocks to read and write
	private int blockSize = 1024*50;
	
	// The total size of the file
	private long fileSize;
	
	// The number of written and read bytes
	private int readBytes;
	private int writtenBytes;
	
	// The byte[] temporary holding the bytes read and written to the file
	private byte[] readByteBlock;
	private byte[] writeByteBlock;

	
	/**
	 * 
	 * Constructor.
	 * 
	 * @param filePath The path to the file to be handled
	 */
	public FileHandler(String filePath){
		this.filePath = filePath;
		this.readBytes = 0;
		this.writtenBytes = 0;
		this.fileSize = 0;
	}

	
	/**
     * 
     * This method returns a list of the files in the given file path on the device
     * 
     * @return A Enumeration containing the names of the files in the root directory
     */
	public Enumeration getFileList(){
		Enumeration list = null;

		try{
			// Connects to the file	
			if(fileConnection == null){
				fileConnection = (FileConnection) Connector.open(new StringBuffer().append("file:///").append(filePath).toString());
				// Pauses the Thread for a while before using the fileConnection
				try {
					Thread.sleep(sleepTime);
				} catch (InterruptedException ie) {
					//This exception is irrelevant for the excecution
				}
			}
			// Fetches the file list
			list =  fileConnection.list();
			try {
				// Pauses the Thread for a while before using the fileConnection
				Thread.sleep(sleepTime);
			} catch (InterruptedException ie) {
				//This exception is irrelevant for the excecution
			}

		}catch(IOException ioe){
			Log.getInstance().logException("FileHandler.getFileList()",ioe,false);			
		}
		
		// Returns the list
		return list;

	}
	
	
	/**
     * 
     * This method returns the size of the this file
     * 
     * @return The size as a long
     */
	public long getFileSize(){
		
		try{
			// Connects to the file	
			if(fileConnection == null){
				fileConnection = (FileConnection) Connector.open(new StringBuffer().append("file:///").append(filePath).toString());
				// Pauses the Thread for a while before using the fileConnection
				try {
					Thread.sleep(sleepTime);
				} catch (InterruptedException ie) {
					//This exception is irrelevant for the excecution
				}
			}
			// Fetches the file size
			fileSize =  fileConnection.fileSize();
			// Pauses the Thread for a while before using the fileConnection
			try {
				Thread.sleep(sleepTime);
			} catch (InterruptedException ie) {
				//This exception is irrelevant for the excecution
			}
		}catch(IOException ioe){
			Log.getInstance().logException("FileHandler.FileHandler()",ioe,false);
		}
		
		// Returns the file size
		return fileSize;
	}
	
	/**
	 * 
	 * This method fetches the size of the blocks to read and write
	 * 
	 * @return The blocksize
	 */
	public int getBlockSize(){
		return blockSize;
	}
	
	/**
     * 
     * This method sets the size of the this file
     * 
     * @param fileSize The size to set
     */
	public void setFileSize(long fileSize){
		this.fileSize = fileSize;
	}
	
	/**
	 * 
	 * This method reads the next byte in the file and returns it
	 * 
	 * @return The next block of bytes
	 * @throws IOException This exception is thrown when the reading has failed
	 */
	public synchronized byte[] readFile() throws IOException{
		
		try{
			// Connects to the file	
			if(fileConnection == null){
				fileConnection = (FileConnection) Connector.open(new StringBuffer().append("file:///").append(filePath).toString());
				// Pauses the Thread for a while before using the fileConnection
				try {
					Thread.sleep(sleepTime);
				} catch (InterruptedException ie) {
					//This exception is irrelevant for the excecution
				}
			}
		}catch(IOException ioe){
			Log.getInstance().logException("FileHandler.FileHandler()",ioe,false);
		}
		
		// Checks if the end of the file is reached
		if(readBytes == fileConnection.fileSize())throw new EOFException();

		try{			
			if(inputStream == null){
				inputStream = fileConnection.openDataInputStream();
				// Pauses the Thread for a while before using the inputStream
				try {
					Thread.sleep(sleepTime);
				} catch (InterruptedException ie) {
					//This exception is irrelevant for the excecution
				}
			}
			// Reads the next block of bytes from the stream
			
			// Checks if the file is smaller than the block size
			if(fileSize == 0)fileSize = fileConnection.fileSize();
			if(fileSize < blockSize) blockSize = (int)fileSize;
			
			// Checks if the remaining unread bytes are less than block size
			if(fileSize - readBytes < blockSize){
				blockSize = (int)(fileSize - readBytes);
			}
			
			readByteBlock = new byte[blockSize];
			inputStream.read(readByteBlock, 0, blockSize);
			readBytes += blockSize;
			return readByteBlock;	

		}catch(IOException ioe){			
			closeFile();
			throw ioe;
		}
		
	}
	
	
	/**
	 * 
	 * This method writes the incoming byte block to the file
	 * 
	 * @param theBytes The next byte block to write
	 * @param numberOfBytesRead The number of bytes in the theBytes[] array
	 * @throws IOException This exception is thrown when the writing has failed
	 * 
	 */
	public synchronized void writeFile(byte[] theBytes, int numberOfBytesRead) throws IOException{
		
		// If input numberOfBytesRead == -1, the end of the file is reached
		if(numberOfBytesRead == -1){
			closeFile();
			throw new EOFException();
		}
		
		try{			
			// Connects to the file			
			if(fileConnection == null){
				fileConnection = (FileConnection) Connector.open(new StringBuffer().append("file:///").append(filePath).toString());
				// Pauses the Thread for a while before using the fileConnection
				try {
					Thread.sleep(sleepTime);
				} catch (InterruptedException ie) {
					//This exception is irrelevant for the excecution
				}
				
				// Checks whether or not the file exists, if not create else delete and create
				if(fileConnection.exists()){
					// Deletes the existing file
					fileConnection.delete();
					// Creates a new file to write to
					fileConnection.create();
				}else{
					// Creates a new file to write to
					fileConnection.create();
				}
			}
			
		}catch(IOException ioe){ 
			Log.getInstance().logException("FileHandler.FileHandler()",ioe,false);
		}
		
		try{
			if(outputStream == null){
				outputStream = fileConnection.openDataOutputStream();
				// Pauses the Thread for a while before using the outpuStream
				try {
					Thread.sleep(sleepTime);
				} catch (InterruptedException ie) {
					//This exception is irrelevant for the excecution
				}
			}
			
			// Trims the last block of bytes
			byte[] bytesToWrite = new byte[numberOfBytesRead];
			// Copies the remaining bytes into a temporary byte[]
			for(int i=0; i<numberOfBytesRead; i++){
				bytesToWrite[i] = theBytes[i];
			}
			outputStream.write(bytesToWrite);
			
		}catch(IOException ioe){			
			closeFile();
			throw ioe;
		}

	}
	
	/**
	 * 
	 * This method writes the incoming byte to the file
	 * 
	 * @param theByte The next byte to write
	 * @throws IOException This exception is thrown when the writing has failed
	 * 
	 * @deprecated The method is substituted by writeFile(byte[] theBytes, int numberOfBytesRead)  
	 */
	public synchronized void writeFile(byte theByte) throws IOException{
		try{
			// Connects to the file			
			if(fileConnection == null){
				fileConnection = (FileConnection) Connector.open(new StringBuffer().append("file:///").append(filePath).toString());
				// Pauses the Thread for a while before using the fileConnection
				try {
					Thread.sleep(sleepTime);
				} catch (InterruptedException ie) {
					//This exception is irrelevant for the excecution
				}
				
				// Checks whether or not the file exists, if not create else delete and create
				if(fileConnection.exists()){
					// Deletes the existing file
					fileConnection.delete();
					// Creates a new file to write to
					fileConnection.create();
				}else{
					// Creates a new file to write to
					fileConnection.create();
				}
			}
			
		}catch(IOException ioe){ 
			Log.getInstance().logException("FileHandler.FileHandler()",ioe,false);
		}
		
		try{
			if(outputStream == null){
				outputStream = fileConnection.openDataOutputStream();
				// Pauses the Thread for a while before using the outpuStream
				try {
					Thread.sleep(sleepTime);
				} catch (InterruptedException ie) {
					//This exception is irrelevant for the excecution
				}
			}
			
			// Checks if the file size is less than the block size
			if(fileSize < blockSize) blockSize = (int)fileSize;
			
			// Calculates the index to write the byte to
			double numberOfBlocksWrittenDouble = (double)writtenBytes/(double)blockSize;
			int numberOfBlocksWrittenInt = (int)(writtenBytes/blockSize);
			int index = (int)((numberOfBlocksWrittenDouble-numberOfBlocksWrittenInt)*blockSize);
			
			
			
			// Have to create a new writeByteBlock every time it is empty
			if(writeByteBlock == null)writeByteBlock = new byte[blockSize];
			
			writeByteBlock[index] = theByte;
			writtenBytes++;
			
			// Every time writeByteBlock is full it is written to file
			if(index==(writeByteBlock.length-1) || writtenBytes == fileSize){
				outputStream.write(writeByteBlock);
				writeByteBlock = null;	
				// Checks if the remaining unread bytes are less than block size
				if(fileSize - writtenBytes < blockSize){
					writeByteBlock = new byte[((int)(fileSize - writtenBytes))];
				}
				if(writtenBytes == fileSize) throw new EOFException();
			}			
			
		}catch(IOException ioe){			
			closeFile();
			throw ioe;
		}
	}
	
	/**
	 * 
	 * This method closes and nullifies the input- and ouput streams, 
	 * and the file connection
	 *
	 */
	public void closeFile(){
		try{			
			// Pauses the Thread for a while before closing the streams and fileConnection
			try {
				Thread.sleep(sleepTime);
			} catch (InterruptedException ie) {
				//This exception is irrelevant for the excecution
			}
			
			if(inputStream != null)inputStream.close();
			inputStream = null;
			if(outputStream != null) outputStream.close();
			outputStream = null;
			if(fileConnection != null) fileConnection.close();
			fileConnection = null;
		}catch (IOException ioe) {
			Log.getInstance().logException("FileHandler.closeFile()",ioe,false);
		}
	}
	

}
