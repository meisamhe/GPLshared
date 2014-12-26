package Registry;


import javax.microedition.midlet.MIDlet;
import javax.microedition.midlet.MIDletStateChangeException;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Form;
import javax.microedition.lcdui.TextField;
import javax.microedition.lcdui.ChoiceGroup;
import javax.microedition.lcdui.Choice;
import javax.microedition.io.PushRegistry;

import java.util.Enumeration;
import java.util.Vector;
//import java.util.Hashtable;
import java.io.IOException;

import peer2me.framework.*;
import peer2me.util.Log;
import peer2me.domain.Hashtable;
//import databaseCore.PerstDatabse;
import RegistryClient.RegistryEntity;


/**
 *
 * This class contains a MIDlet built upon Peer2Me v2.0.
 * The MIDlet is a basic chat application.
 *
 * @author Torbj�rn Vatn & Steinar A. Hestnes
 */

public class RegistryMIDlet1 extends MIDlet implements FrameworkListener{

	// A Log instance
	Log log = Log.getInstance();

	// The Main GUI of the MIDlet
	private MainGui mainGui;

	// The Log GUI of the MIDlet
	private LogGui logGui;

	// The Connect GUI of the MIDlet
//	private ConnectGui connectGui;

	// The Send GUI of the MIDlet
//	private SendGui sendGui;

    // A reference to the last displayed gui. Is used to go back.
    private Displayable lastGui;

	// The Framework instance
	Framework framework;

	// The variables retrived from the input fields of the GUI
	private String nodeName;

	// The preferred network of the MIDlet
	private final String preferredNetwork = "peer2me.network.bluetooth.BluetoothNetwork";

	// The name of the MIDlet
	private String midletName;

    // A list containing the addresses to the nodes added in the ConnectGui choicegroup
    private Hashtable nodeAddressList;

    // A hashtable containing the addresses and names to each connected node. The names is the keys, and the values is the addresses
    private Hashtable participatingNodeNames;

    private String thisClass;

    private MIDlet thisMIDlet;

    /**
	 *
	 * Constructor
	 */
	public RegistryMIDlet1(){}

	protected void startApp() throws MIDletStateChangeException{
		mainGui = new MainGui();
		logGui = new LogGui();
//		connectGui = new ConnectGui();
//		sendGui = new SendGui();
		// Sets the main gui as the current Displayable
		showGui(mainGui);
		// Gets an instance of the Framework
		framework = FrameworkFrontEnd.getInstance(this);
		// Setting the name of the MIDlet
		midletName = "Registry";
        thisClass=this.getClass().getName();
        thisMIDlet = this;

    }

	protected void pauseApp() {}

	/**
	 *
	 * This method is called when the MIDLet is shut down
	 *
	 */
	protected void destroyApp(boolean arg0) throws MIDletStateChangeException{
		// Shuts down the framework
		framework.shutdownFramework();

		notifyDestroyed();
	}

	public void notifyAboutException(String location, Exception exception){}

	/**
	 *
	 * This method displays the desired GUI class
	 *
	 * @param gui
	 */
	public void showGui(Displayable gui){
        // Saves a reference to the last displayed gui
        lastGui = Display.getDisplay(this).getCurrent();
		// Sets the new gui
        Display.getDisplay(this).setCurrent(gui);
		gui.setCommandListener((CommandListener)gui);
	}


    /**
     *
     * This method is called by the framework when a node is found. These nodes
     * are not yet connected in a network. To do this, use the
     * Framework.connectToNodes() method.
     *
     * @param nodeAddress The network adress of the node
     * @param remoteNodeName The name of the found remote name
     */
    public void notifyAboutFoundNode(String nodeAddress, String remoteNodeName){
        framework.connectToNode(nodeAddress);
    }
//    {
//    		connectGui.addNode(nodeAddress,remoteNodeName);
//            showGui(connectGui);
// 	}



    /**
     *
     * This method is called from from the framework to notify the midlet about
     * the participating devices.
     *
     * @param participants A hashtable that contains the names of the participants as unique keys and
     * the network addresses as values.
     *
     */
    public void notifyAboutParticipants(Hashtable participants){
          this.participatingNodeNames = participants;
//        sendGui.removeParticipants();
//        sendGui.addParticipants();

        // Shows the gui where we can send datapackages
//        if(participatingNodeNames.size()>0)showGui(sendGui);
    }


    /**
     *
     * This method is called from the framework whenever a text package is
     * received from a remote node.
     *
     * @param senderName The name of the sender
     * @param textMessage The received text message.
     */
    public void notifyAboutReceivedTextPackage(String senderName, String textMessage){
//    	String message = new StringBuffer().append("\n").append(senderName).append(" says: \n").append(textMessage).toString();
//        sendGui.append(message);;
        framework.connectToNode((String)participatingNodeNames.get(senderName));
//        PerstDatabse pdb=new PerstDatabse("registry",thisMIDlet);
        for (long i=0;; i++){
////            RegistryEntity e= (RegistryEntity) pdb.getEntity(i);
//            if (e!=null){
//                String temp1= e.name.toUpperCase();
//                String temp2=  textMessage.toUpperCase();
//                if (temp1.compareTo(temp2)==0) {
////                     framework.sendTextPackage((String)participatingNodeNames.get(senderName),e.port);
//                    return;
//                }
//            }else
//                return;
        }
    }

    /**
     *
     * This method is called from the framework whenever a file package is
     * received from a remote node.
     *
     * @param senderName The name of the sender
     * @param fileName The path to the received file
     */
    public void notifyAboutReceivedFilePackage(String senderName, String fileName){}

	/**
	 *
	 * This class is a private GUI class used to display GUI elements for this
	 * MIDlet
	 *
	 * @author Torbj�rn Vatn & Steinar A. Hestnes
	 */
	private class MainGui extends Form implements CommandListener{


		// The OK Command
		private Command ok;
		private Command displayLog;
//		private Command search;
		private Command exit;


		// The text filed use to input a name
		TextField text;

		/**
		 *
		 * Constructor Extends Form to be able to display different GUI elements
		 *
		 */
		public MainGui(){
			super(midletName);
			ok = new Command("Ok", Command.OK, 0);
    		displayLog = new Command("View Log", Command.OK, 4);
//    		search = new Command("Search", Command.OK, 1);
			exit = new Command("Exit", Command.EXIT,0);
			text = new TextField("Name", "Per Tome", 30, TextField.ANY);

			append(text);

			addCommand(ok);
            	addCommand(displayLog);
            	addCommand(exit);
		}


		/**
		 * This method is called when the CommandListener detects the use of a Command
		 *
		 * @param command The command used
		 * @param disp The displayable
		 *
		 */
		public void commandAction(Command command, Displayable disp){

			if(command == ok){
				// Fetches the input from the gui
				nodeName = text.getString();
				deleteAll();
                	removeCommand(ok);
                	append(new StringBuffer().append("Your name is ").append(nodeName).toString());
                
//                            .append(". \n\nPress Search if you want to discover other devices.\n\n").toString());
//				addCommand(search);

                try{
                    framework.initFramework(nodeName, midletName, preferredNetwork);
//                    String ClassName=  this.getClass().getName();
//                    ClassName="Peer2MessengerMIDlet.Peer2Messenger" ;
                    try {
                         String ConnectionUrl=((FrameworkFrontEnd)framework).currentNetwork.connectionURL;
                         PushRegistry.registerConnection(ConnectionUrl, thisClass, "*");
                    } catch (ClassNotFoundException e) {
                           append(e.getMessage());//.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
                     } catch (IOException e) {
                             append(e.getMessage());
//                           e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
                     }

                }catch(Exception e){
                    append("Error initiating the framework. Please try again."+ e.getMessage());
                }


//            	}else if(command == search){
//			    try{
//                    framework.startNodeSearch();
//                    append("Searching for devices running Peer2Messenger\n");
//                }catch(Exception e){
//                    append(new StringBuffer().append("Could not start a search for other devices. Please try again.").append(e).toString());
//                }

			}else if(command == displayLog){
                logGui.append("Exception log:\n");
                logGui.append(log.getLog(Log.EXCEPTION_LOG));
                logGui.append("\n***************\n");

                logGui.append("Data package log:\n");
                logGui.append(log.getLog(Log.DATA_PACKAGE_LOG));
                logGui.append("\n***************\n");

                logGui.append("Connection log:\n");
                logGui.append(log.getLog(Log.CONNECTION_LOG));
                logGui.append("\n***************\n");

                logGui.append("Debug log:\n");
                logGui.append(log.getLog(Log.DEBUG_LOG));
                logGui.append("\n***************\n");
                showGui(logGui);
            }

			else if(command == exit){
				try{
					destroyApp(true);
				}catch (MIDletStateChangeException msce) {
                    append(msce.getMessage());
                    // This exception is ignored because the unconditional attribute of the
					// destroyApp() method is true.
				}
			}

		}

	}

	/**
	 *
	 * This class is a private GUI class to display Log elements for this MIDlet
	 *
	 * @author Torbj�rn Vatn & Steinar A. Hestnes
	 */
	private class LogGui extends Form implements CommandListener{

		// The log menu Commands
		private Command showExceptionLog;
		private Command showConnectionLog;
		private Command showDataPackageLog;
		private Command showDebugLog;
		private Command displayLog;
		private Command hide;
		private Command exit;


		public LogGui(){
			super("Log");
			// The log menu Commands
			showExceptionLog = new Command("Exception log", Command.ITEM, 4);
			showConnectionLog = new Command("Connection log", Command.ITEM, 4);
			showDataPackageLog = new Command("Data package log", Command.ITEM, 4);
			showDebugLog = new Command("Debug log", Command.ITEM, 4);
			displayLog = new Command("Full log", Command.ITEM, 1);
			hide = new Command("Hide log", Command.OK, 0);
			exit = new Command("Exit", Command.EXIT,0);

			addCommand(showExceptionLog);
			addCommand(showDataPackageLog);
			addCommand(showConnectionLog);
			addCommand(showDebugLog);
        	addCommand(displayLog);
			addCommand(hide);
			addCommand(exit);
		}

		/**
		 * This method is called when the CommandListener detects the use of a Command
		 *
		 * @param command The command used
		 * @param disp The displayable
		 *
		 */
		public void commandAction(Command command, Displayable disp){
			if(command == showExceptionLog){
				this.deleteAll();
				append(log.getLog(Log.EXCEPTION_LOG));
			}

			else if(command == showConnectionLog){
	            	deleteAll();
				append(log.getLog(Log.CONNECTION_LOG));
			}

			else if(command == showDataPackageLog){
	            	deleteAll();
	            	append(log.getLog(Log.DATA_PACKAGE_LOG));
			}

			else if(command == showDebugLog){
	            	deleteAll();
	            	append(log.getLog(Log.DEBUG_LOG));
			}

			else if(command == displayLog){
                deleteAll();
                logGui.append("Exception log:\n");
                logGui.append(log.getLog(Log.EXCEPTION_LOG));
                logGui.append("\n***************\n");

                logGui.append("Data package log:\n");
                logGui.append(log.getLog(Log.DATA_PACKAGE_LOG));
                logGui.append("\n***************\n");

                logGui.append("Connection log:\n");
                logGui.append(log.getLog(Log.CONNECTION_LOG));
                logGui.append("\n***************\n");

                logGui.append("Debug log:\n");
                logGui.append(log.getLog(Log.DEBUG_LOG));
                logGui.append("\n***************\n");
			}

			else if(command == hide){
				deleteAll();
				showGui(lastGui);
			}

			else if(command == exit){
				try{
					destroyApp(true);
				}catch (MIDletStateChangeException msce) {
                      append(msce.getMessage());
                    // This exception is ignored because the unconditional attribute of the
					// destroyApp() method is true.
				}
			}
		}
	}
	/**
	 *
	 * This class is a private GUI class to display Connect elements for this MIDlet
	 *
	 * @author Torbj�rn Vatn & Steinar A. Hestnes
	 */
//	private class ConnectGui extends Form implements CommandListener{
//
//		// The commands
//		private Command back;
//		private Command displayLog;
//		private Command connect;
//		private Command exit;
//
//		//The ChoiceGroup of
//		private ChoiceGroup nodes;
//
//
//        /**
//         *
//         * Constructor
//         */
//		public ConnectGui(){
//			super("Nodes");
//
//			// The ChoiceGroup
//			nodes = new ChoiceGroup("Choose the node(s) to connect to",Choice.MULTIPLE);
//
//            	nodeAddressList = new Hashtable();
//
//			// The Commands
//			back = new Command("Back",Command.BACK,1);
//			displayLog = new Command("Display log",Command.ITEM,4);
//			connect = new Command("Connect",Command.ITEM,0);
//			exit = new Command("Exit", Command.EXIT,0);
//
//			addCommand(back);
//            addCommand(connect);
//			addCommand(displayLog);
//			addCommand(exit);
//			// Adds the ChoiceGroup
//			append(nodes);
//
//		}
//
//		/**
//		 *
//		 * This method adds a node name to the ChoiceGroup
//		 *
//		 * @param nodeAddress The address of the remote node
//         * @param remoteNodeName The name of the remote node
//		 */
//		public void addNode(String nodeAddress, String remoteNodeName){
//            nodeAddressList.put(remoteNodeName,nodeAddress);
//            nodes.append(remoteNodeName,null);
//		}
//
//		/**
//		 * This method is called when the CommandListener detects the use of a Command
//		 *
//		 * @param command The command used
//		 * @param disp The displayable
//		 *
//		 */
//		public void commandAction(Command command, Displayable disp) {
//
//			if(command == back){
//				showGui(lastGui);
//			}
//
//            else if(command == displayLog){
//                logGui.append("Exception log:\n");
//                logGui.append(log.getLog(Log.EXCEPTION_LOG));
//                logGui.append("\n***************\n");
//
//                logGui.append("Data package log:\n");
//                logGui.append(log.getLog(Log.DATA_PACKAGE_LOG));
//                logGui.append("\n***************\n");
//
//                logGui.append("Connection log:\n");
//                logGui.append(log.getLog(Log.CONNECTION_LOG));
//                logGui.append("\n***************\n");
//
//                logGui.append("Debug log:\n");
//                logGui.append(log.getLog(Log.DEBUG_LOG));
//                logGui.append("\n***************\n");
//                showGui(logGui);
//			}
//
//            	else if(command == connect){
//				// Fetches all the selected elements in the ChoiceGroup
//            	Vector addressVector = new Vector();
//				for(int i=0; i<nodes.size(); i++){
//                    if(nodes.isSelected(i)){
//                    	addressVector.addElement((String)nodeAddressList.get(nodes.getString(i)));
//                   	}
//				}
//				String[] addresses = new String[addressVector.size()];
//				addressVector.copyInto(addresses);
//				if(addresses.length == 0) append("Please chose a recipient!");
//				else framework.connectToNodes(addresses);
//			}
//
//            	else if(command == exit){
//    				try{
//    					destroyApp(true);
//    				}catch (MIDletStateChangeException msce) {
//                          append(msce.getMessage());
//                        // This exception is ignored because the unconditional attribute of the
//    					// destroyApp() method is true.
//    				}
//    			}
//
//		}
//
//	}
	/**
	 *
	 * This class is a private GUI class to display Send elements for this MIDlet
	 *
	 * @author Torbj�rn Vatn & Steinar A. Hestnes
	 */
//	private class SendGui extends Form implements CommandListener{
//
//		// The commands
//		private Command displayLog;
//		private Command sendTextPackage;
//        private Command search;
//        private Command exit;
//
//		// The ChoiceGroup
//		private ChoiceGroup connectedNodes;
//
//		private TextField input;
//
//		/**
//		 *
//		 * Constructor
//		 */
//		public SendGui(){
//			super("Write a message");
//
//			// Creating  the Commands
//			sendTextPackage = new Command("Send",Command.ITEM,1);
//			displayLog = new Command("View log",Command.ITEM,4);
//			exit = new Command("Exit", Command.EXIT,0);
//            search = new Command("Search", Command.OK, 1);
//            input = new TextField("Message","",200,TextField.ANY);
//
//			// The ChoiceGroup containing the connected Nodes
//			connectedNodes = new ChoiceGroup("Choose recipients", Choice.MULTIPLE);
//
//			// Adding the elements
//            addCommand(sendTextPackage);
//			addCommand(displayLog);
//			addCommand(exit);
//            addCommand (search)  ;
//            append(connectedNodes);
//			append(input);
//		}
//
//        /**
//         *
//         * This method add the connected participants to the connected ChoiceGroup
//         *
//         */
//        public void addParticipants(){
//            Enumeration names = participatingNodeNames.keys();
//            while(names.hasMoreElements()){
//                connectedNodes.append((String)names.nextElement(),null);
//            }
//        }
//
//        /**
//         *
//         * This method removes all connected participants to the connected ChoiceGroup
//         *
//         */
//        public void removeParticipants(){
//            connectedNodes.deleteAll();
//        }
//
//		/**
//		 * This method is called when the CommandListener detects the use of a Command
//		 *
//		 * @param command The command used
//		 * @param disp The displayable
//		 *
//		 */
//		public void commandAction(Command command, Displayable disp){
//
//			if(command == sendTextPackage){
//                Vector recipientNodes = new Vector();
//                for(int i=0; i<connectedNodes.size(); i++){
//                    if(connectedNodes.isSelected(i)){
//                        // Gets the address to the recipient node
//                        recipientNodes.addElement((String)participatingNodeNames.get(connectedNodes.getString(i)));
//                    }
//                }
//                String[] recipientAddresses = new String[recipientNodes.size()];
//                recipientNodes.copyInto(recipientAddresses);
//
//                if(recipientAddresses.length!=0)framework.sendTextPackage(recipientAddresses,input.getString());
//                else append("Please choose a recipient!\n");
//
//
//            }else if(command == search){
//			    try{
//                    framework.startNodeSearch();
//                    append("Searching for devices running Peer2Messenger\n");
//                }catch(Exception e){
//                    append(new StringBuffer().append("Could not start a search for other devices. Please try again.").append(e).toString());
//                }
//
//			}else if(command == displayLog){
//                logGui.append("Exception log:\n");
//                logGui.append(log.getLog(Log.EXCEPTION_LOG));
//                logGui.append("\n***************\n");
//
//                logGui.append("Data package log:\n");
//                logGui.append(log.getLog(Log.DATA_PACKAGE_LOG));
//                logGui.append("\n***************\n");
//
//                logGui.append("Connection log:\n");
//                logGui.append(log.getLog(Log.CONNECTION_LOG));
//                logGui.append("\n***************\n");
//
//                logGui.append("Debug log:\n");
//                logGui.append(log.getLog(Log.DEBUG_LOG));
//                logGui.append("\n***************\n");
//                showGui(logGui);
//            }
//
//            else if(command == exit){
//				try{
//                    destroyApp(true);
//                }catch (MIDletStateChangeException msce) {
//                      append(msce.getMessage());
//                    // This exception is ignored because the unconditional attribute of the
//					// destroyApp() method is true.
//				}
//			}
//		}
//	}
}
