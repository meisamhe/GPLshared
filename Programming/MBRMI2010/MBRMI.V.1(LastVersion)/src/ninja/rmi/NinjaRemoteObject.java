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

import ninja.Domain.RemoteObject;
import ninja.Domain.Debug;
import databaseCore.Entity;
//import org.garret.perst.IInputStream;
//import org.garret.perst.IOutputStream;
import peer2me.framework.FrameworkFrontEnd;
import peer2me.framework.Framework;
import peer2me.util.DataInputStreamWrapper;
import peer2me.util.DataOutputStreamWrapper;

import javax.microedition.io.PushRegistry;
import javax.microedition.midlet.MIDlet;
import java.io.IOException;

//import java.rmi.RemoteException;

/*import java.rmi.Remote;
import java.rmi.RemoteException;
import java.rmi.server.RemoteStub;
import java.rmi.server.ServerNotActiveException; */


// XXX Technically this should extend java.rmi.server.RemoteServer,
// but I see no point.

/**
 * NinjaRemoteObject is the class which all remotely-accessible objects using
 * NinjaRMI must extend. By subclassing NinjaRemoteObject, the object is
 * automatically "exported" for remote access. Clients wishing to access the
 * remote object must obtain a stub - this is generally done only through the
 * registry.
 * 
 * Various methods of NinjaRemoteObject are provided to allow the server-side
 * object to obtain information on the clients accessing it.
 * 
// * @see ninja.rmi.registry.NinjaRegistryImpl
 */
public class NinjaRemoteObject extends  Entity implements RemoteObject{
	private NinjaServerRef servref; // The server-side reference for this object
	Debug debug;

	/**
	 * The constructor for a NinjaRemoteObject, when called with no arguments,
	 * exports the object for remote access using the default settings.
	 */
    public NinjaRemoteObject(){
        servref= new NinjaServerRef();
    }
    protected NinjaRemoteObject(String nodeName,String serverServiceName, String preferredNetwork, MIDlet midlet) throws Exception {
		debug = new Debug();
		servref = null;
		exportObject(nodeName,serverServiceName, preferredNetwork,midlet);// added by meisam
//                new NinjaExportData());
	}

    public NinjaServerRef getServerRef(){
        return servref;
    }

    /**
	 * When a NinjaExportData is passed into the NinjaRemoteObject constructor,
	 * the behavior of the remote object can be modified (for example, the TCP
	 * port on which the object is exported can be specified). If <tt>null</tt>
	 * is passed in, then the NinjaRemoteObject will not be exported; the user
	 * must call exportObject() directly.
	 * 
//	 * @see NinjaExportData
	 */
//	protected NinjaRemoteObject(
//            NinjaExportData exportData)
//			throws Exception {
//		// If 'null' is passed in, we don't export the object: Rather we expect
//		// the subclass will do it directly (after constructing the exportData
//		// itself).
//		servref = null;
//		debug = new Debug();
//		if (exportData != null)
//			exportObject(exportData);
//	}

	/**
	 * exportObject exports the NinjaRemoteObject for remote access. Only call
	 * this function if you call the NinjaRemoteObject constructor with an
	 * argument of <tt>null</tt>. The intent here is that the user can
	 * construct a NinjaExportData structure before calling exportObject -
	 * because superclass constructors must be the first thing called in a
	 * constructor.
	 * 
//	 * @param exportData
	 *            The NinjaExportData structure specifying how the object should
	 *            be exported.
	 */
	public void exportObject(String nodeName,String serverServiceName, String preferredNetwork, MIDlet midlet
//            NinjaExportData exportData
    ) throws Exception {
		// DEBUG(System.out.println("NinjaRemoteObject exportObject called"));
		debug.print("NinjaRemoteObject exportObject called");
		servref = new NinjaServerRef();

//		if (exportData == null)
//			throw new Exception(
//					"exportObject: Can't export object without exportData defined!");

		try {
			// DEBUG(System.out.println("Exporting ref..."));
			debug.print("Exporting ref...");
			servref.exportObject( this, nodeName, serverServiceName, preferredNetwork, midlet);
//                    , exportData);
		} catch (Exception e) {
			throw new Exception("Can't export remote object"+ e.getMessage());
		}
		// DEBUG(System.out.println("Exported object!"));
		debug.print("Exported object!");
	}

	/**
	 * Calling 'unexportObject' on a NinjaRemoteObject will cause the object to
	 * be unexported for future incoming calls. Currently, any calls in progress
	 * (i.e., any existing client sockets connecting to the remote object) are
	 * not destroyed; only future calls are made impossible.
	 */
	public void unexportObject() throws Exception {
		if (servref != null) {
			servref.unexportObject();
		} else {
			throw new Exception(
					"unexportObject: Can't unexport until you have exported!");
		}
	}

	// Obtain stub for this remote object - used by server-side code only
	public NinjaRemoteStub getStub() {
		NinjaRemoteStub stub = servref.getStub();
		if (stub == null) {
			// DEBUG(System.out.println("NinjaRemoteObject.getStub: stub is
			// null?"));
			debug.print("NinjaRemoteObject.getStub: stub is null?");
		}
		return stub;
	}

    public void destroy(){
        Framework f=FrameworkFrontEnd.getInstance(null);
        if (f!= null) {
            f.shutdownFramework();
            try {
                // unregisterConnection returns false if it was
                // unsuccessful and true if successful.
                String ConnectionUrl=((FrameworkFrontEnd)f).currentNetwork.connectionURL;
                PushRegistry.unregisterConnection(ConnectionUrl);
            }
            catch(SecurityException e) {
                e.printStackTrace();
            }
        }
    }

//    public void clone(Entity e, long index)       // this will put all the the attributes and index in the entity e
//    {
//        ((NinjaRemoteObject)e).servref = servref;
//        e.setIndex(index);
//        setIndex(index);
//    }

    public void readObject(DataInputStreamWrapper in) throws ClassNotFoundException, IllegalAccessException, InstantiationException, IOException      //for persistent this two methods should be implemented it somehow shows the   serializability order
    {
//        servref=
//                (NinjaServerRef)
        in.readObject(servref);
    }

    public void writeObject(DataOutputStreamWrapper out) throws IOException {
        out.writeObject(servref);
    }
}
