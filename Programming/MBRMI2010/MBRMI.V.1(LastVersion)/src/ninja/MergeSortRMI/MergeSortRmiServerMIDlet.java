package ninja.MergeSortRMI;

import peer2me.util.Log;
import javax.microedition.midlet.MIDletStateChangeException;
import javax.microedition.midlet.MIDlet;
import javax.microedition.lcdui.*;
import javax.microedition.io.file.FileConnection;
import javax.microedition.io.file.FileSystemRegistry;
import javax.microedition.io.Connector;

import RegistryClient.Registry;

import ninja.rmi.NinjaRemoteRef;
import ninja.rmi.NinjaRemoteStub;
import ninja.rmi.NinjaRemoteObject;
import ninja.rmi.NinjaSkeleton;

/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Sep 17, 2009
 * Time: 6:41:55 PM
 * To change this template use File | Settings | File Templates.
 */
public class MergeSortRmiServerMIDlet extends MIDlet {
	// The Main GUI of the MIDlet
	Log log = Log.getInstance();
    private MainGui mainGui;
    private LogGui logGui;
    private String nodeName;
    private Displayable lastGui;
    private MergeSortImpl mergeSortservice;
    private  String preferredNetwork= "peer2me.network.bluetooth.BluetoothNetwork";
    private MIDlet thisMIDlet;
    protected void startApp() throws MIDletStateChangeException {
        thisMIDlet = this;
        mainGui = new MainGui();
        logGui = new LogGui();
        showGui(mainGui);
    }

    protected void pauseApp() {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    protected void destroyApp(boolean b) throws MIDletStateChangeException {
        if (mergeSortservice!=null)
            ((NinjaRemoteObject)mergeSortservice).destroy();
        notifyDestroyed();
    }
    private class MainGui extends Form implements CommandListener {


            // The OK Command
            private Command ok;
            private Command displayLog;
//            private Command search;
            private Command exit;


            // The text filed use to input a name
            TextField text;

            /**
             *
             * Constructor Extends Form to be able to display different GUI elements
             *
             */
            public MainGui(){
                super("ClientMIDlet");
                ok = new Command("Ok", Command.OK, 0);
                displayLog = new Command("View Log", Command.OK, 4);
//                search = new Command("Search", Command.OK, 1);
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
                    append(new StringBuffer().append("Your name is ").append(nodeName).append(". \n\nPress Search if you want to discover other devices.\n\n").toString());
                    //Code for RegistryUse
                    try {
                        // to delete before's registry file
                            FileConnection fileConnection;
                            String temp= FileSystemRegistry.listRoots().nextElement().toString();
                             temp = "e:/" ;// for sony erricson while it doesn't let to write in c:\
                            fileConnection = (FileConnection) Connector.open(new StringBuffer().append("file:///").append(temp).append("Registry").toString());
                            long size=fileConnection.fileSize();
                            if (size!=-1)
                                  fileConnection.delete();
                            // end of deleting
//                        Class skelclass=  Class.forName("ninja.simpleRMI.TheServiceImpl__RMIStub");
//                        NinjaRemoteStub nsk=(NinjaRemoteStub) skelclass.newInstance();
                        mergeSortservice = new MergeSortImpl(nodeName, "checkService",preferredNetwork,thisMIDlet);
                        System.out.println("RMISERVER: Created service\n");
                        append ("RMISERVER: Created service\n") ;
                        Registry registry = new   Registry();
                                //Registry(nodeName,preferredNetwork,this,thisMIDlet) ;
                        
                        registry.rebind("mergeSort",mergeSortservice);
                        System.out.println("RMISERVER: Bound service");
                        append ("RMISERVER: Bound service") ;
                    } catch (Exception e) {
                        e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
                        append(e.getMessage());
                    }
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

                    logGui.append("RMI log:\n");
                    logGui.append(log.getLog(Log.RMI_LOG));
                    logGui.append("\n***************\n");
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

                logGui.append("RMI log:\n");
                logGui.append(log.getLog(Log.RMI_LOG));
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
    public void showGui(Displayable gui){
        // Saves a reference to the last displayed gui
        lastGui = Display.getDisplay(this).getCurrent();
		// Sets the new gui
        Display.getDisplay(this).setCurrent(gui);
		gui.setCommandListener((CommandListener)gui);
	}
}

