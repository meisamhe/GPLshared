package peer2me.util;

import peer2me.framework.FrameworkFrontEnd;
import java.util.Vector;



/**
 * This class contains functionality to create and maintain a log of events
 * and exceptions. 
 * The Log contains four differnet kinds of logs, an exception log, a connection
 * log, a data package log and a debug log. They can be used to log events from anywhere in
 * the framework, and the logs can be retreived later to get information about the execution
 * of the MIDlet. 
 *
 * @author Torbj�rn Vatn & Steinar A. Hestnes
 */
public class Log {
	
	// The singleton instance of this class
	private static Log singleton;
	// This FrameworkFrontEnd instance enables the Log to notify the Framework of exceptions
	FrameworkFrontEnd framework;
	
	
	// These Vectors are used to store the different elements we want to log
	/**********************************************************************/
	// The Vector containing the logged Exceptions
	private Vector exceptionLog = new Vector();
	// The Vector containing the opened Connections
	private Vector connectionLog = new Vector();
    // The Vector containing information about exchanged data packages
    private Vector dataPackageLog = new Vector();
    // The Vector containing debug information
    private Vector debugLog = new Vector();
    // The Vector containing debug information
    private Vector rmiLog = new Vector();
	
    // These static variables represent the different Log Vectors
	/***********************************************************/
	public static final int EXCEPTION_LOG = 1;
	public static final int CONNECTION_LOG = 2;
    public static final int DATA_PACKAGE_LOG = 3;
    public static final int DEBUG_LOG = 4;
    public static final int RMI_LOG=5;


    /**
	 * 
	 * This method returns the only existing instance of the Log class
	 *
	 * @return The singleton instance of the Log class
	 */
	public static synchronized Log getInstance(){
		if(singleton == null){
			singleton = new Log();
		}
		return singleton;
	}
	
	/**
	 * 
	 * Constructor. Made private to ensure singleton pattern.
	 *
	 */
	private Log(){};
	
	/**
	 * 
	 * This method is called by the FrameworkFrontEnd to reveal itself to the Log
	 *
	 * @param framework The FrameworkFrontEnd refrence sent by the FrameworkFrontEnd itself
	 */
	public void setFramework(FrameworkFrontEnd framework){
		this.framework = framework;
	}
	
	/**
	 * 
	 * This method adds an Exception entry to the Exception log
	 *
	 * @param location The location (class and method) where the Exception occured
	 * @param exception The actual Exception
	 * @param notify This boolean decides whether or not to notify the Framework about the Exception that occured
	 */
	public void logException(String location, Exception exception, boolean notify){
				
		// The actual String stored in the log
		String logString = new StringBuffer().append(exception.getMessage()).append(" @ ").append(location).toString();
        

        // Adding the exception message to the log
		exceptionLog.addElement(logString);
		
		// Notifying the Framework of the Exception if requested
		if(notify) framework.notifyAboutException(location, exception);
	}
    
    
    /**
     * 
     * This method adds a Connection entry to the Connection log
     *
     * @param connectionStatus A textual description of the connection status
     */
    public void logConnection(String connectionStatus){        
        connectionLog.addElement(connectionStatus);        
    }
    
    
    /**
     * 
     * This method adds a data package entry to the data package log
     *
     * @param packageStatus A textual description of the data package status
     */
    public void logDataPackage(String packageStatus){
    	dataPackageLog.addElement(packageStatus);        
    }

    /**
     * 
     * This method adds a Debug entry to the Debug log
     *
     * @param location The location (class and method) where the debuginfo was logged
     * @param debugInfo A textual description of the debug information
     */
    public void logDebugInfo(String location, String debugInfo){
        
        // The actual String stored in the log
        String logString = new StringBuffer().append(debugInfo).append(" @ ").append(location).toString();               
        
        debugLog.addElement(logString);        
    }

    public void LogRmiInfo(String logString){
        rmiLog.addElement(logString);
    }
		
    /**
	 * 
	 * This method returns the desired log in a displayable format.
	 * It must be called by activating a soft button in the application. 
	 * Due to multithreading and interuptions there can be some delay in the creation of the log. 
	 *
	 * @param log The Log.FIELD representing the desired log
	 * @return The desired log as a String
	 */
	public String getLog(int log){
		
		switch(log){
		
		case EXCEPTION_LOG: return formatLog(exceptionLog);
		
		case CONNECTION_LOG: return formatLog(connectionLog);
        
        case DATA_PACKAGE_LOG: return formatLog(dataPackageLog);
        
        case DEBUG_LOG: return formatLog(debugLog);

        case RMI_LOG: return formatLog(rmiLog);
               
        default: return "No such log";
		
		}
	}
	
	/**
	 * 
	 * This method extract the elements from the vector parameter
	 *
	 * @param log The Vector to extract elements from
	 * @return The contents of the Vector presented as a String
	 */
	private String formatLog(Vector log){
		String returnString = "";
		
		// Runs through the vector and adds the elements to the returnString
		for(int i = 0; i<log.size(); i++){
			String element = (String)log.elementAt(i);
			if(element != null) returnString = new StringBuffer().append(returnString).append(element).append(" \n----------\n ").toString();
			// = ""+element;
		}
		return returnString;
	}	
	
	
}
