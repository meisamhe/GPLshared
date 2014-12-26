// NinjaRMI, by Matt Welsh (mdw@cs.berkeley.edu)
// See http://www.cs.berkeley.edu/~mdw/proj/ninja for details

/*
 * "Copyright (c) 1998 by The Regents of the University of California
 *  All rights reserved."
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose, without fee, and without written agreement is
 * hereby granted, provided that the above copyright notice and the following
 * two paragraphs appear in all copies of this software.
 * 
 * IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY PARTY FOR
 * DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT
 * OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE UNIVERSITY OF
 * CALIFORNIA HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * THE UNIVERSITY OF CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
 * ON AN "AS IS" BASIS, AND THE UNIVERSITY OF CALIFORNIA HAS NO OBLIGATION TO
 * PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
 *
 */

//#include "debug.jh"
package ninja.rmi;

import ninja.Domain.*;
import ninja.Domain.Debug;
import peer2me.framework.FrameworkListener;
import peer2me.framework.Framework;
import peer2me.framework.FrameworkFrontEnd;
import peer2me.domain.Hashtable;
import peer2me.util.Log;

import javax.microedition.io.PushRegistry;
import javax.microedition.midlet.MIDlet;
import java.util.Vector;

//import java.rmi.ServerException;

//import java.io.IOException;

/*import java.rmi.*;
import java.rmi.server.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.OutputStream;
import java.io.InputStream;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectOutput;
import java.net.InetAddress;    */

/**
 * Reliable_ServerThread is a NinjaServerThread which deals with reliable
 * connections using TCP sockets. The getClientHost()/getClientPort() methods
 * are provided to allow threads to identify the client of an RMI call in their
 * thread.
 */
public class Reliable_ServerThread extends NinjaServerThread {
/*	private ServerSocket serverSocket;
	private Socket connSocket;
	private int port;    */
	private  boolean singleOp = false;
	private  boolean is_server;
    private  Framework fl;
     Debug debug;
     Hashtable participants ;
    public  boolean runActive=false;
    private static Reliable_ServerThread singleton;
    static Vector Servref;

    Reliable_ServerThread(NinjaServerRef serverref,String nodeName,String serverServiceName, String preferredNetwork, MIDlet midlet) //, FrameworkListener fl)
//            , int theport)
			throws Exception {
		super(serverref);
        if (Servref== null)
            Servref= new Vector();
        Servref.addElement(serverref);
        debug = new Debug();
		is_server = true;
        fl = FrameworkFrontEnd.getInstance(this);
        fl.setFrameworkListener(this); // this is added for debuging whin we add the server to registry
        fl.initFramework(nodeName, serverServiceName, preferredNetwork);
        String ConnectionUrl=((FrameworkFrontEnd)fl).currentNetwork.connectionURL;
//        PushRegistry.registerConnection(ConnectionUrl, midlet.getClass().getName(), "*");
        //meisam
    /*	serverSocket = new ServerSocket(theport);
		port = serverSocket.getLocalPort();
		this.setName("Reliable_ServerThread (toplevel) on port " + port);    */
	}
    public static  Reliable_ServerThread getInstance(NinjaServerRef serverref,String nodeName,String serverServiceName, String preferredNetwork, MIDlet midlet)
//            , int theport)
			throws Exception {
		if(singleton == null){
			singleton = new Reliable_ServerThread(serverref,nodeName, serverServiceName, preferredNetwork, midlet);
            singleton.runActive=false;
//            singleton.run();
            singleton.start();
        }else {
            Servref.addElement(serverref);
        }
		Reliable_ServerThread framework = singleton;
        return framework;
	}
      //meisam
/*	// Constructor used to fork thread to deal with new incoming connection
	private Reliable_ServerThread(NinjaServerRef serverref, Socket theconnsock)
			throws Exception {
		super(serverref);
		debug = new Debug();
		is_server = false;
		connSocket = theconnsock;
		port = theconnsock.getPort();
		this.setName("Reliable_ServerThread for connection on port " + port);
	}
          */
	/**
	 * Returns the hostname of the client making the RMI call within this
	 * thread.
	 */
    //meisam
/*	public String getClientHost() throws ServerNotActiveException {
		if (connSocket == null)
			throw new ServerNotActiveException(
					"Thread has no active client connection");
		return connSocket.getInetAddress().getHostName();
	} */

	/**
	 * Returns the remote port number of the client making the RMI call within
	 * this thread.
	 */
    //meisam
/*    public int getClientPort() throws ServerNotActiveException {
		if (connSocket == null)
			throw new ServerNotActiveException(
					"Thread has no active client connection");
		return connSocket.getPort();
	} */

	/**
	 * Returns the port that the server is listening on for new connections.
	 */
    //meisam
  /*  public int getServerPort() throws ServerNotActiveException {
		if (serverSocket == null)
			throw new ServerNotActiveException(
					"Thread has no active server socket");
		return port;
	}   */

	// Fork new thread to handle this connection
    //meisam
/*	private void relisten(Socket sock) throws Exception {
		Reliable_ServerThread thethread = new Reliable_ServerThread(servref,
				sock);
		// DEBUG(System.out.println("NinjaServerThread: New call on port "
		// +thethread.port+ "..."));
		debug.print("NinjaServerThread: New call on port " + thethread.port
				+ "...");
		thethread.start();
	}  */

	// Listen on serverSocket for connections
	public  void run() {
        // DEBUG(System.out.println("NinjaServerThread thread on port " +port+ "
		// running."));
        try {
            sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        debug.print("NinjaServerThread thread on port " +
//                port +
                " running.");

    //    if (!is_server)  {
        while (1==1) {
          if (runActive==true){
               runActive=false;
            // Handle a connection
//			Thread.currentThread().yield();         //commented by meisam
			DataInputStream datais;
			DataOutputStream dataos;
//			int i;   //commented by meisam
//			short s;
			byte b;

			try {
				datais = new DataInputStream();
//				dataos = new DataOutputStream(fl.getFrameworkListener());
                dataos = DataOutputStream.getInstance(fl.getFrameworkListener());
//				i = datais.readInt();
//				s = datais.readShort();//commented by meisam
//				b = datais.readByte();

			} catch (Exception e) {
				// DEBUG(System.out.println("NinjaServerThread["+port+"]: Can't
				// get socket streams"));
				debug.print("NinjaServerThread[" +
//                        port+
                        "]: Can't get socket streams");
				return;
			}
           //commented by meisam
//			if (i != 0x4e524d49 || s != 0x01) {
//				// DEBUG(System.out.println("NinjaServerThread["+port+"]: Got
//				// bad header " +i+ " version "+s));
//				debug.print("NinjaServerThread[" +
////                        port +
//                        "]: Got bad header "
//						+ i + " version " + s);
//			}

//			if ((b != 0x4b) && (b != 0x4c)) {
//				// DEBUG(System.out.println("NinjaServerThread["+port+"]: Got
//				// bad protocol "+b));
//				debug.print("NinjaServerThread[" +
////                        port +
//                        "]: Got bad protocol " + b);
//			}

//			if (b == 0x4c) {
//				this.singleOp = true;
//			}

           boolean sw=true;
			while (sw == true) {
                b = datais.readByte();
                msg_switch: {
                    switch (b) {
                        case 0x50: // Call

                            // DEBUG(System.out.println("NinjaServerThread["+port+"]:
                            // Got Call"));
                            debug
                                    .print("NinjaServerThread["
            //                                        + port
                                            + "]: Got Call");

                            NinjaRemoteCall call = new Reliable_RemoteCall(datais, dataos);
                            NinjaObjectInputStream callis;
                            ObjID theobj;

                            try {
                                callis = call.getInputStream();
                                // DEBUG(System.out.println("NinjaServerThread["+port+"]:
                                // Reading objid..."));
                                debug.print("NinjaServerThread["
            //                                    + port
                                        + "]: Reading objid...");
                                theobj= new ObjID();
                                theobj= theobj.read(callis);
                                //commented and changed by meisam
            //                            theobj = ObjID.read(callis);
                                // DEBUG(System.out.println("NinjaServerThread["+port+"]:
                                // Got objid"));
                                debug.print("NinjaServerThread["
            //                                    + port
                                        + "]: Got objid");
                            } catch (Exception e) {
                                // DEBUG(System.out.println("NinjaServerThread["+port+"]:
                                // Can't read objid: "+e.getMessage()));
                                debug.print("NinjaServerThread["
            //                                    + port
                                        + "]: Can't read objid: " + e.getMessage());
                                return;
                            }
                            int i;
                            for (i=0; i < Servref.size(); i++){
                                if (((NinjaServerRef)Servref.elementAt(i)).objid.equals(theobj))
                                    break;
                            }
                            if (i<Servref.size()){
                                // XXX If anything goes wrong at this point (except for
                                // sockets
                                // closing) need to shove an exception down the wire
                                int op;
                                long hash;
                                op = callis.readInt();
                                hash = callis.readLong();

                                // DEBUG(System.out.println("NinjaServerThread["+port+"]:
                                // Dispatching with op "+op+", hash "+hash));
                                debug.print("NinjaServerThread["
                //                                + port
                                        + "]: Dispatching with op " + op + ", hash "
                                        + hash);
                                try {
//                                    servref.skeleton.dispatch(servref.remote, call, op,
//                                            hash);
                                    ((NinjaServerRef)Servref.elementAt(i)).skeleton.dispatch(
                                            ((NinjaServerRef)Servref.elementAt(i)).remote,
                                            call,op,hash);
//                                    dataos.flush();
                                } catch (Exception e) {
                                    // DEBUG(System.out.println("NinjaServerThread["+port+"]:
                                    // Dispatch returned exception: "+e.getMessage()));
                                    debug.print("NinjaServerThread["
                //                                    + port
                                            + "]: Dispatch returned exception: "
                                            + e.getMessage());

                                    // OK, the server object threw an exception; we have
                                    // to
                                    // push it down the wire
                                    NinjaObjectOutputStream resultos;
                                    try {
                                        resultos = call.getResultStream(false);
                                        resultos
                                                .writeUTF(//new ServerException(
                                                        "NinjaRMI Server threw exception: "+e.getMessage());
                                        //												,e));
                                    } catch (Exception e2) {
                                        // DEBUG(System.out.println("NinjaServerThread["+port+"]:
                                        // Got exception when pushing exception down
                                        // wire: "+e2.getMessage()));
                                        debug
                                                .print("NinjaServerThread["
                //												+ port
                                                        + "]: Got exception when pushing exception down wire: "
                                                        + e2.getMessage());
                                        }
                                    }

                                    try {
                                        // DEBUG(System.out.println("NinjaServerThread["+port+"]:
                                        // releasing output stream"));
                                        debug.print("NinjaServerThread["
                    //                                    + port
                                                + "]: releasing output stream");
                                        call.releaseOutputStream();
                                    } catch (Exception e) {
                                        // DEBUG(System.out.println("NinjaServerThread["+port+"]:
                                        // Release exception: "+e.getMessage()));
                                        debug
                                                .print("NinjaServerThread["
                    //                                            + port
                                                        + "]: Release exception: "
                                                        + e.getMessage());
                                    }

                                    break;
                        }else{
//                                if (!servref.objid.equals(theobj)) {
                                    // Do we care if the ObjID doesn't match?
                //							if (servref.exportData.check_objid == true) {
                            System.out.println("NinjaServerThread["
    //                                        + port
                                    + "]: ObjID doesn't match");
                            NinjaObjectOutputStream resultos;
                            try {
                                resultos = call.getResultStream(false);
                                resultos
                                        .writeUTF(//new ServerException(
                                                "NinjaRMI Server execption: Object ID on incoming call does not match that of server.");
    //                                    );
                            } catch (Exception e) {
                                // DEBUG(System.out.println("NinjaServerThread["+port+"]:
                                // Got exception trying to push bad object
                                // id exception down wire:
                                // "+e.getMessage()));
                                debug
                                        .print("NinjaServerThread["
    //													+ port
                                                + "]: Got exception trying to push bad object id exception down wire: "
                                                + e.getMessage());
    //								}
                        }
//                               } 
                            }
                        case 0x52: // Ping
                            // DEBUG(System.out.println("NinjaServerThread["+port+"]:
                            // Got Ping"));
                            debug
                                    .print("NinjaServerThread["
            //                                        + port
                                            + "]: Got Ping");
                            try {
                                dataos.writeByte((byte)0x53); // Ping ack
                                dataos.flush();
                            } catch (Exception e) {
                                // Do nothing
                            }
                            break;

                        case 0x54: // DgcAck
                            // XXX Don't know what to do with this
                            // DEBUG(System.out.println("NinjaServerThread["+port+"]:
                            // Got DgcAck"));
                            debug.print("NinjaServerThread["
            //                                + port
                                    + "]: Got DgcAck");
                            break;

                        default:
                            // DEBUG(System.out.println("NinjaServerThread["+port+"]:
                            // Got unknown msgtype "+b));
                            debug.print("NinjaServerThread["
            //                                + port
                                    + "]: Got unknown msgtype " + b);
                            break;

                        }
                    }
                if (DataInputStream.checkQueue())
                    DataInputStream.flushQueue();
                else sw=false;
            }

	//}
           
           }
        }
    }
    public  void  notifyAboutException(String location, Exception exception){}

    public  void notifyAboutFoundNode(String nodeAddress, String remoteNodeName) {}

    public  void notifyAboutReceivedTextPackage(String senderName, String textMessage) {
        ServerRequestEntity sre= new ServerRequestEntity(textMessage,(String)participants.get(senderName));
//        MainServerThread mst = new MainServerThread(sre, this);
//        mst.run();
        DataInputStream.flush(sre,this);
    }
    //        if (DataInputStream.IsEmpty())
//            this.getRemoteObject().getServerRef().getServerThread().run();

    public  void notifyAboutReceivedFilePackage(String senderName, String filePath) { }

    public  void notifyAboutParticipants(Hashtable participants)  {
         this.participants = participants;
    }

}
