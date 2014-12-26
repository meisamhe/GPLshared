package ninja.MergeSortRMI;

import peer2me.util.Log;
import peer2me.framework.FrameworkFrontEnd;

import javax.microedition.midlet.MIDletStateChangeException;
import javax.microedition.midlet.MIDlet;
import javax.microedition.lcdui.*;
import javax.microedition.io.file.FileSystemRegistry;
import javax.microedition.io.file.FileConnection;
import javax.microedition.io.Connector;

import RegistryClient.Registry;

import ninja.rmi.NinjaRemoteRef;
import ninja.rmi.NinjaRemoteStub;
import ninja.rmi.NinjaRemoteObject;

import java.io.IOException;
import java.io.OutputStream;
import java.io.DataOutputStream;

/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Sep 17, 2009
 * Time: 6:41:55 PM
 * To change this template use File | Settings | File Templates.
 */
public class MergeSortRmiClientMIDlet extends MIDlet {
	// The Main GUI of the MIDlet
	Log log = Log.getInstance();
    private MainGui mainGui;
    private LogGui logGui;
    private String nodeName;
    private Displayable lastGui;
    private  String preferredNetwork= "peer2me.network.bluetooth.BluetoothNetwork";
    MergeSort service;
    MIDlet currentMIDlet;
    protected void startApp() throws MIDletStateChangeException {
        currentMIDlet = this;
        mainGui = new MainGui();
        logGui = new LogGui();
        showGui(mainGui);
    }

    protected void pauseApp() {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    protected void destroyApp(boolean b) throws MIDletStateChangeException {
        if (service!=null)
            ((NinjaRemoteObject)service).destroy();
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
//                        Registry reg;
//                         reg = new  Registry(nodeName,preferredNetwork,this,currentMIDlet) ;

                        System.out.println("Got registry stub");
//                    try {
//                       service = (TheService) reg.lookup("service");
                         MergeSortclientThread ct = new MergeSortclientThread(this,currentMIDlet,nodeName,preferredNetwork,service) ;
                         ct.start();
//                        try {
////                            System.out.println("Got service, server is " + ref.get_remotehost()
////                                    + ":" + ref.get_remoteport());
//                               int NUM_TIMES = 20;
//                                long t1, t2;
//                                int i;
//                                t1 = System.currentTimeMillis();
//                                FrameworkFrontEnd.getInstance(null).startNodeSearch();
//                            // Result into file Logger
//                                int tempResult;
//                                String filePath;
//	                            DataOutputStream dos;
//                                String temp= FileSystemRegistry.listRoots().nextElement().toString();
////                                temp = "e:/" ;// for sony erricson while it doesn't let to write in c:\
//                                String url= new StringBuffer().append("file:///").append(temp).append("ResultLogger.txt").toString();
//                                FileConnection fileConnection = (FileConnection) Connector.open(url, Connector.READ_WRITE);
//                                long size=fileConnection.fileSize();
//                               if (size==-1)
//                                  fileConnection.create();
//                               OutputStream outputStream =    //fileConnection.openOutputStream();
//                                      fileConnection.openOutputStream();
//                                dos= new DataOutputStream(outputStream);
//                                for (i = 0; i < NUM_TIMES; i++) {
//                                    tempResult=service.addFunction(i, i*i);
//                                    dos.writeUTF("The result "+i+"plus"+i+ " power 2 is:"+tempResult+"\n");
//                                    t2 = System.currentTimeMillis();
//                                    dos.writeUTF("passed time is: "+(t2 - t1) + "ms, or\n ");
//                                    System.out.println("The result "+i+"plus"+i+ " power 2 is:"+tempResult);
//                        //                sleep(200);
//                                }
//                                t2 = System.currentTimeMillis();
//                                dos.writeUTF(NUM_TIMES + " RMIs in " + (t2 - t1) + "ms, or "
//                                        + ((t2 - t1) / (NUM_TIMES * 1.0)) + " ms/RMI.");
//                                System.out.println(NUM_TIMES + " RMIs in " + (t2 - t1) + "ms, or "
//                                        + ((t2 - t1) / (NUM_TIMES * 1.0)) + " ms/RMI.");
//
//                            } catch (Exception e) {
//                                System.out.println("RmiClient exception: " + e.getMessage());
//                                e.printStackTrace();
//                                            }
//                    } catch (InterruptedException e) {
//                        e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
//                    } catch (ClassNotFoundException e) {
//                        e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
//                    } catch (IllegalAccessException e) {
//                        e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
//                    } catch (InstantiationException e) {
//                        e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
//                    } catch (IOException e) {
//                        e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
//                    }

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
    public void showGui(Displayable gui){
        // Saves a reference to the last displayed gui
        lastGui = Display.getDisplay(this).getCurrent();
		// Sets the new gui
        Display.getDisplay(this).setCurrent(gui);
		gui.setCommandListener((CommandListener)gui);
	}
}

