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

import ninja.Domain.ObjID;
//import ninja.Domain.ReflectionInputStream;
import ninja.Domain.RemoteObject;
import ninja.Domain.Debug;
import databaseCore.Entity;
//import org.garret.perst.IInputStream;
//import org.garret.perst.IOutputStream;

import javax.microedition.io.PushRegistry;
import javax.microedition.midlet.MIDlet;

import peer2me.framework.FrameworkFrontEnd;
import peer2me.util.DataInputStreamWrapper;
import peer2me.util.DataOutputStreamWrapper;

import java.io.IOException;

//import java.rmi.RemoteException;

/*import java.rmi.Remote;
import java.rmi.RemoteException; */
//meisam
//import java.rmi.StubNotFoundException;
//import java.rmi.server.*;
//import java.net.*;
//import java.lang.reflect.Constructor;

// The server-side handle for a remote object
public class NinjaServerRef extends Entity {
        ObjID objid;
        RemoteObject remote;
        NinjaSkeleton skeleton;
        NinjaRemoteStub stub;
        NinjaServerThread serverThread;
        NinjaRemoteRef clientRef;
//        NinjaExportData exportData = null;
        Debug debug;

        NinjaServerRef() {
            debug = new Debug();
            stub = new DummyNinjaRemoteStub();
        }

        public NinjaServerThread getServerThread(){
            return serverThread;
        }

        NinjaRemoteStub exportObject(RemoteObject theremote, String nodeName,String serverServiceName, String preferredNetwork, MIDlet midlet

//                , NinjaExportData data
        )
        // export data identifies how RMI-Comm is: Reliabal, Oneway, multicast
                throws Exception {

            debug = new Debug();
            Class theclass;
            String skelname, stubname;

            // DEBUG(System.out.println("NinjaServerRef: exportObject called"));
            debug.print("NinjaServerRef: exportObject called");

//            if (data == null)
//                throw new Exception(
//                        "exportObject: Can't export object will null exportData!");

//            exportData = data;

            remote = theremote;
            objid = new ObjID();

            // Get skeleton from class

//            try {
                //meisam
//                theclass = getRemoteClass(remote);  // now the class contains superClass of remote which extends remoteObject
                theclass= remote.getClass();
//                skelname = new StringBuffer(String.valueOf(theclass.getName()))
                skelname = new StringBuffer(String.valueOf(theclass.getName()))
                        .append("__RMISkel").toString();
//            } catch (ClassNotFoundException e) {
//                throw new RemoteException(new StringBuffer(
//                        "Can't find skeleton for object: ").append(
//                        remote.getClass().getName()).toString());
//            }

            try {// it will get the generate skeleton class for the given class
                // DEBUG(System.out.println("Getting skeleton class..."));
                debug.print("Getting skeleton class...");
                Class skelclass =  Class.forName(skelname);
//                        loadClassUsingLoader(skelname, theclass);      //meisam

                // DEBUG(System.out.println("Got skeleton class-class"));
                debug.print("Got skeleton class-class");
                skeleton = (NinjaSkeleton) skelclass.newInstance();
                skeleton.setRemoteObject((NinjaRemoteObject) remote);
//                skeleton.f = FrameworkFrontEnd.getInstance(skeleton);//moved to down
//                skeleton.f.setFrameworkListener(skeleton);

                // DEBUG(System.out.println("Got skeleton class " + skelname));
                debug.print("Got skeleton class " + skelname);

            } catch (Exception e) {
                throw new Exception(new StringBuffer(
                        "Can't create skeleton for object: ").append(
                        remote.getClass().getName()).toString()
                        + e);
            }

            // Now, before we can get the stub we need to create the
            // NinjaServerThread
            // to listen for this object, so we can initialize the client-side
            // NinjaRemoteRef which will point back to this object when it's pushed
            // to the client. This is because we need to call the stub's constructor
            // with the NinjaRemoteRef as an argument to get it set in the stub
            // (as the other ways to set the remoteRef later are protected methods
            // of RemoteStub).

            // XXX mdw: The below code uses the RMISocketFactory; I've axed it for
            // now
            //
            // RMISocketFactory factory = RMISocketFactory.getSocketFactory();
            // // XXX mdw Don't like having to use Sun's stuff.
            // if (factory == null) factory = new
            // sun.rmi.transport.proxy.RMIMasterSocketFactory();
            // ServerSocket serverSock =
            // factory.createServerSocket(exportData.port);

            // DEBUG(System.out.println("NinjaServerRef: comm_type is
            // "+exportData.comm_type));
//            debug.print("NinjaServerRef: comm_type is " + exportData.comm_type);

            // produce related thread according to export data
//            if (exportData.comm_type == NinjaExportData.RMI_COMM_TYPE_RELIABLE) {

                try {
                    serverThread = Reliable_ServerThread.getInstance(this, nodeName, serverServiceName, preferredNetwork, midlet);
//                    ,skeleton.f.getFrameworkListener() );
//                    skeleton.f = FrameworkFrontEnd.getInstance(serverThread);  //moved to serverThread
                    //while framework is created the first time any skeleton serverthread is set
                    // the next time just the instance is got, and nothing changed
//                    skeleton.f.initFramework(nodeName, serverServiceName, preferredNetwork);   //moved to serverThread
//                    String ConnectionUrl=((FrameworkFrontEnd)skeleton.f).currentNetwork.connectionURL;//moved to server
//                    PushRegistry.registerConnection(ConnectionUrl, skeleton.getClass().getName(), "*"); //moved to server


                    //meisam
//                            , exportData.port);
//                    int port = ((Reliable_ServerThread) serverThread)
//                            .getServerPort();
                    clientRef = new NinjaRemoteRef(
//                            InetAddress.getLocalHost()
//                            .getHostName(), port,
                            objid , serverServiceName);
//                            , exportData.comm_type
//                   , skeleton.getClass().getName() );  //created by meisam and commented by meisam
                } catch (Exception e) {
                    throw new Exception(
                            "Can't create Reliable_ServerThread: " + e.getMessage());
//                            e);
                }

    /*        } else if (exportData.comm_type == NinjaExportData.RMI_COMM_TYPE_UNRELIABLE_ONEWAY) {

                try {
                    serverThread = new UnrelOw_ServerThread(this, exportData.port);
                    int port = ((UnrelOw_ServerThread) serverThread)
                            .getServerPort();
                    clientRef = new NinjaRemoteRef(InetAddress.getLocalHost()
                            .getHostName(), port, objid, exportData.comm_type);
                } catch (Exception e) {
                    throw new RemoteException("Can't create UnrelOw_ServerThread: "
                            + e.getMessage(), e);
                }

            } else if (exportData.comm_type == NinjaExportData.RMI_COMM_TYPE_MULTICAST_ONEWAY) {

                try {
                    serverThread = new McastOw_ServerThread(this,
                            exportData.ipaddr, exportData.port);
                    int port = ((McastOw_ServerThread) serverThread)
                            .getServerPort();
                    clientRef = new NinjaRemoteRef(exportData.ipaddr
                            .getHostAddress(), port, objid, exportData.comm_type);
                } catch (Exception e) {
                    throw new RemoteException("Can't create McastOw_ServerThread: "
                            + e.getMessage(), e);
                }

                // #if USESECURE
                // } else if (exportData.comm_type ==
                // NinjaExportData.RMI_COMM_TYPE_AUTH_ENCRYPT_RELIABLE) {
                //
                // try {
                // serverThread = new AuthRel_ServerThread(this, exportData.port,
                // exportData.serverAuthenticator, exportData.predicate);
                // int port = ((AuthRel_ServerThread)serverThread).getServerPort();
                // // XXX: is this really secure???
                // clientRef = new
                // NinjaRemoteRef(InetAddress.getLocalHost().getHostName(), port,
                // objid, exportData.comm_type);
                // } catch (Exception e) {
                // throw new RemoteException("Can't create AuthRel_ServerThread: " +
                // e.getMessage(), e);
                // }
                // #endif /* USESECURE */

//            } else {
//
//                throw new Exception("NinjaServerRef: Invalid comm_type "
//                        + exportData.comm_type);
//
//            }

            // Get stub from class
            stubname = new StringBuffer(String.valueOf(theclass.getName())).append(
                    "__RMIStub").toString();

            // Now find the one-arg 'RemoteRef' constructor for this object

            try {
                int c, p;
                boolean found_constructor = false;
//                Class stubclass = loadClassUsingLoader(stubname, theclass);
                Class stubclass= Class.forName(stubname);
                //commented by meisam
//                Constructor constarr[] = stubclass.getConstructors();
//                for (c = 0; (c < constarr.length) && !found_constructor; c++) {
//                    Class paramarr[] = constarr[c].getParameterTypes();
//                    // DEBUG(System.out.println("Stub constructor:
//                    // "+constarr[c].toString()));
//                    debug.print("Stub constructor: " + constarr[c].toString());
//                    if ((paramarr.length == 1)
//                            && (paramarr[0].getName()
//                                    .equals("ninja.rmi.NinjaRemoteRef"))) {
//                        // DEBUG(System.out.println("OK, found the right
//                        // constructor"));
//                        debug.print("OK, found the right constructor");
//                        Object inargs[] = new Object[1];
//                        inargs[0] = (ninja.rmi.NinjaRemoteRef) clientRef;
//                        stub = (NinjaRemoteStub) constarr[c].newInstance(inargs);
//                        found_constructor = true;
//                    }
//                }
                stub= (NinjaRemoteStub)stubclass.newInstance();
                for (float i=0;i<1000;i+=0.0001) {}
                stub.setRemoteReference(clientRef);
//                if (!found_constructor) {
//                    throw new RemoteException(
//                            new StringBuffer(
//                                    "Can't create stub for object (no NinjaRemoteRef constructor??): ")
//                                    .append(remote.getClass().getName()).toString());
//                }

                // DEBUG(System.out.println("Got stub class " + stubname));
                debug.print("Got stub class " + stubname);

            } catch (Exception e) {
                throw new Exception(new StringBuffer(
                        "Can't create stub for object: ").append(
                        remote.getClass().getName()).toString()+ e.getMessage());
            }

//            serverThread.start();

            return stub;

        }
	

	void unexportObject() {
        try {
            serverThread.wait();
        } catch (InterruptedException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
//                stop();
	}

	NinjaRemoteStub getStub() {
		return stub;
	}
   //meisam
	// Loads a class using the named 'theclass' ClassLoader (in case this
	// is being passed along using an RMIClassLoader)
//	private Class loadClassUsingLoader(String string, Class theclass)
//			throws ClassNotFoundException {
//		ClassLoader classLoader = null;
//		if (theclass != null)
//			classLoader = theclass.getClassLoader();
//		if (classLoader != null) {
//			return classLoader.loadClass(string);
//		} else {
//			return Class.forName(string);
//		}
//	}

	// Traverse superclasses until we get the one which extends Remote
//	private Class getRemoteClass(RemoteObject theremote)
//			throws ClassNotFoundException {
//		/*Class theclass;
//		for (theclass = theremote.getClass(); theclass != null; theclass = theclass
//				.getSuperclass()) {
//			if (classExtendsRemote(theclass))
//				return theclass;
//		}
//		throw new ClassNotFoundException("java.rmi.Remote"); */ // this part is moved to compiler.
//        ReflectionInputStream ris=new ReflectionInputStream();     // will retrieve the superclass that is extended Remote
//        String rc=ris.readRemoteClass();
//        return Class.forName(rc) ;
//    }

/*	// Recursively check all interfaces for this class to see if they
	// extend java.rmi.Remote
    private boolean classExtendsRemote(Class theclass)
			throws ClassNotFoundException {
		Class remClass = Class.forName("java.rmi.Remote");
		Class interfaces[] = theclass.getInterfaces();
		int i;
		for (i = 0; i < interfaces.length; i++) {
			if (interfaces[i].equals(remClass))
				return true;
			if (classExtendsRemote(interfaces[i]))
				return true;
		}
		return false;
	} */ //this part is moved to compiler

//    public void clone(Entity e, long index)       // this will put all the the attributes and index in the entity e
//    {
////        ((NinjaServerRef)e).objid = objid;
////        ((NinjaServerRef)e).remote = remote;
////        ((NinjaServerRef)e).skeleton = skeleton;
//        ((NinjaServerRef)e).stub = stub;
////        ((NinjaServerRef)e).clientRef = clientRef;
//        e.setIndex(index);
//        setIndex(index);
//    }

    public void readObject(DataInputStreamWrapper in) throws ClassNotFoundException, IllegalAccessException, InstantiationException, IOException      //for persistent this two methods should be implemented it somehow shows the   serializability order
    {
//        this.objid= new ObjID();
//        this.objid = this.objid.read(in);
//        remote=(RemoteObject)in.readObject();
//        skeleton=(NinjaSkeleton)in.readObject();
//        stub= (NinjaRemoteStub)
         stub.readObject(in);
//        clientRef=(NinjaRemoteRef)in.readObject();
    }

    public void writeObject(DataOutputStreamWrapper out) throws IOException {
//        this.objid.write(out);
//        out.writeObject(remote);
//        out.writeObject(skeleton);
        out.writeObject(stub);
//        out.writeObject(clientRef);
    }
}
