package ninja.MatrixMultiplicationRMI;

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
import java.util.Random;

/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Sep 26, 2009
 * Time: 8:34:22 PM
 * To change this template use File | Settings | File Templates.
 */
public class MatrixMultiplicationClientThread extends Thread {
    MIDlet currentMIDlet;
    Form currentForm;
    String nodeName;
    String preferredNetwork;
    MatrixMultiplication service;

    MatrixMultiplicationClientThread (Form currentForm, MIDlet currentMIDlet,String nodeName, String preferredNetwork,MatrixMultiplication service){
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
                                service = (MatrixMultiplication) reg.lookup("MatrixMultiplication");
                               int NUM_TIMES = 20;
                                long t1=0;
                                 long t2;
                                int i;
                                currentForm.append("going to calling remote method")   ;
                            // Result into file Logger
                                int tempResult;
                                String filePath;
	                            DataOutputStream dos;
                                String temp= FileSystemRegistry.listRoots().nextElement().toString();
//                                temp = "e:/" ;// for sony erricson while it doesn't let to write in c:\
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
                                    i=20;
//                                        for (i = 2; i < NUM_TIMES; i++) {
                                        SerializableMatrix result,tempMatrix0,tempMatrix1;
                                        Random random = new Random();
                                        int[][] tempArray0= new int[10][200];
                                        int[][] tempArray1= new int[200][10];
                                         dos.writeUTF("The first Matrix is: (");
                                         System.out.print("The first Matrix is: (");
                                        for (int j=0; j<10;j++){
                                            for (int k=0;k<200;k++) {
                                                int nro = Math.abs(random.nextInt());//This creates the random number...
                                                tempArray0[j][k] = 500 + nro % 700;//This is how you can use it.
                                                dos.writeInt( tempArray0[j][k]);
                                                dos.writeUTF(", ");
                                                System.out.print( tempArray0[j][k]);
                                                System.out.print (", ");
                                            }
                                            System.out.println();
                                        }
                                        dos.writeUTF(")\n");
                                        System.out.println(")");
                                         dos.writeUTF("The second Matrix is: (");
                                         System.out.print("The second Matrix is: (");
                                        for (int j=0; j<200;j++){
                                            for (int k=0;k<10;k++) {
                                                int nro = Math.abs(random.nextInt());//This creates the random number...
                                                tempArray1[j][k] = 500 + nro % 900;//This is how you can use it.
                                                dos.writeInt( tempArray1[j][k]);
                                                dos.writeUTF(", ");
                                                System.out.print( tempArray1[j][k]);
                                                System.out.print (", ");
                                            }
                                            System.out.println();
                                        }
                                        dos.writeUTF(")\n");
                                        System.out.println(")");
                                        tempMatrix0 = new SerializableMatrix(tempArray0);
                                        tempMatrix1= new SerializableMatrix(tempArray1);
                                        MatrixMultiplicationImpl local=  new MatrixMultiplicationImpl();
                                        t1 = System.currentTimeMillis();
                                        result = local.Multiply(tempMatrix0,tempMatrix1) ;
                                        t2 = System.currentTimeMillis();
                                        System.out.println("local call tooks" + (t2 - t1));
                                        dos.writeUTF("local call tooks" + (t2 - t1));
                                        t1 = System.currentTimeMillis();
                                        result = service.Multiply(tempMatrix0,tempMatrix1) ;
//                                        tempResult=service.addFunction(i, i*i);
//                                        dos.writeUTF("The result "+i+"plus"+i+ " power 2 is:"+tempResult+"\n");
                                        t2 = System.currentTimeMillis();
                                         dos.writeUTF("The Multiplied Matrix is: (");
                                        System.out.print("The Multiplied Matrix is: (");
                                         for (int j=0; j<10;j++) {
                                             for (int k=0; k<10; k++) {
                                                 dos.writeInt(result.getElement(j,k));
                                                 dos.writeUTF(", ");
                                                 System.out.print(result.getElement(j,k)+", ");
                                             }
                                             System.out.println();
                                         }
                                         dos.writeUTF(")\n");
                                        System.out.print(")\n");
                                        dos.writeUTF("passed time is: "+(t2 - t1) + "ms \n ");
                                //                sleep(200);
//                                        }
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
