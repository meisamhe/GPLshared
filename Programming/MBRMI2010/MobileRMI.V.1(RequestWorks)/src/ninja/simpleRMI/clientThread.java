package ninja.simpleRMI;

import ninja.simpleRMI.TheServiceImpl;
import RegistryClient.Registry;
import peer2me.framework.Framework;
import peer2me.framework.FrameworkFrontEnd;

import javax.microedition.lcdui.Form;
import javax.microedition.midlet.MIDlet;
import javax.microedition.io.file.FileSystemRegistry;
import javax.microedition.io.file.FileConnection;
import javax.microedition.io.Connector;
import java.io.DataOutputStream;
import java.io.OutputStream;

/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Sep 26, 2009
 * Time: 8:34:22 PM
 * To change this template use File | Settings | File Templates.
 */
public class clientThread extends Thread {
    MIDlet currentMIDlet;
    Form currentForm;
    String nodeName;
    String preferredNetwork;
    TheService service;

    clientThread (Form currentForm, MIDlet currentMIDlet,String nodeName, String preferredNetwork,TheService service){
        this.currentMIDlet=currentMIDlet;
        this.currentForm=currentForm;
        this.nodeName=nodeName;
        this.preferredNetwork=preferredNetwork;
        this.service=service;
    }
    public void run(){
//        try {
////                            System.out.println("Got service, server is " + ref.get_remotehost()
////                                    + ":" + ref.get_remoteport());
//           int NUM_TIMES = 100;
//            long t1, t2;
//            int i;
//            t1 = System.currentTimeMillis();
//            FrameworkFrontEnd.getInstance(null).startNodeSearch();
//            for (i = 0; i < NUM_TIMES; i++) {
//                System.out.println("The result "+i+"multiply 2 is:"+service.addFunction(i, i*i));
////                sleep(200);
//            }
//            t2 = System.currentTimeMillis();
//
//            System.out.println(NUM_TIMES + " RMIs in " + (t2 - t1) + "ms, or "
//                    + ((t2 - t1) / (NUM_TIMES * 1.0)) + " ms/RMI.");
//
//        } catch (Exception e) {
//            System.out.println("RmiClient exception: " + e.getMessage());
//            e.printStackTrace();
//                        }

                                try {
//                            System.out.println("Got service, server is " + ref.get_remotehost()
//                                    + ":" + ref.get_remoteport());
                                Registry reg;
                                reg = new  Registry(nodeName,preferredNetwork,currentForm,currentMIDlet) ;
                                service = (TheService) reg.lookup("service");
                               int NUM_TIMES = 20;
                                long t1, t2;
                                int i;
                                t1 = System.currentTimeMillis();
                                currentForm.append("going to calling remote method")   ;
                            // Result into file Logger
                                int tempResult;
                                String filePath;
	                            DataOutputStream dos;
                                String temp= FileSystemRegistry.listRoots().nextElement().toString();
                                temp = "e:/" ;// for sony erricson while it doesn't let to write in c:\
                                String url= new StringBuffer().append("file:///").append(temp).append("ResultLogger.txt").toString();
                                FileConnection fileConnection = (FileConnection) Connector.open(url, Connector.READ_WRITE);
                                long size=fileConnection.fileSize();
                               if (size==-1)
                                  fileConnection.create();
                               OutputStream outputStream =    //fileConnection.openOutputStream();
                                      fileConnection.openOutputStream();
                                dos= new DataOutputStream(outputStream);
                                 sleep (500) ;
                                 FrameworkFrontEnd.getInstance(null).startNodeSearch();
                                currentForm.append("going to call...");
                                try{
                                        for (i = 0; i < NUM_TIMES; i++) {
                                            tempResult=service.addFunction(i, i*i);
                                            dos.writeUTF("The result "+i+"plus"+i+ " power 2 is:"+tempResult+"\n");
                                            t2 = System.currentTimeMillis();
                                            dos.writeUTF("passed time is: "+(t2 - t1) + "ms, or\n ");
                                            System.out.println("The result "+i+"plus"+i+ " power 2 is:"+tempResult);
                                //                sleep(200);
                                        }
                                }catch (Exception e) {
                                    currentForm.append("Exception occured:"+e.getMessage()) ;
                                }
                                t2 = System.currentTimeMillis();
                                dos.writeUTF(NUM_TIMES + " RMIs in " + (t2 - t1) + "ms, or "
                                        + ((t2 - t1) / (NUM_TIMES * 1.0)) + " ms/RMI.");
                                System.out.println(NUM_TIMES + " RMIs in " + (t2 - t1) + "ms, or "
                                        + ((t2 - t1) / (NUM_TIMES * 1.0)) + " ms/RMI.");

                            } catch (Exception e) {
                                System.out.println("RmiClient exception: " + e.getMessage());
                                e.printStackTrace();
                                            }
    }
}
