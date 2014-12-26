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

//import java.rmi.RemoteException;

import databaseCore.Entity;
//import org.garret.perst.IInputStream;
//import org.garret.perst.IOutputStream;
import RegistryClient.RegistryEntity;
import peer2me.framework.FrameworkListener;
import peer2me.util.DataInputStreamWrapper;
import peer2me.util.DataOutputStreamWrapper;

import java.io.IOException;

/*import java.rmi.server.RemoteObject;
import java.rmi.server.RemoteCall;
import java.rmi.RemoteException;
import java.rmi.Remote;
import java.rmi.server.Operation;
import java.rmi.server.ObjID;
import java.io.ObjectInput;
import java.io.ObjectOutput;
import java.io.IOException;
import java.lang.ClassNotFoundException;
import java.rmi.server.RMISocketFactory;
import java.net.Socket;
import java.net.InetAddress;
import java.net.DatagramPacket;
import java.io.DataOutputStream;
import java.net.DatagramSocket;
import java.net.MulticastSocket;
import java.io.BufferedOutputStream;
import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.ByteArrayInputStream;
import java.io.Serializable;   */

//#if USESECURE
//import ninja.rmi.auth.*;
//#endif /* USESECURE */

/**
 * NinjaRemoteRef is the client-side reference to a remote object. The
 * NinjaRemoteRef is contained within the client-side stub (which has been
 * obtained from the registry). Users shouldn't need to deal with the
 * NinjaRemoteRef at all; it is made public simply so that the generated stubs
 * can access it.
 *
 * <p>
 * The idea is that the RMI server-side code instantiates the stub and creates a
 * NinjaRemoteRef and shoves it into the stub. The stub is then handed to the
 * registry, which passes it along to clients. Therefore, the methods in
 * NinjaRemoteRef need to be accessible to the stub (to make remote calls) and
 * to the Ninja RMI server code (to create the NinjaRemoteRef when exporting a
 * NinjaRemoteObject).
 */
public class NinjaRemoteRef extends Serializable {

//	protected String remotehost;
//	protected int remoteport; // The port to call on for this object
	protected ObjID objid;
//	protected int commtype;
    protected String server;
//	private Socket sock = null;
	private DataInputStream bis = null;
	private DataOutputStream bos = null;
    private FrameworkListener currentListener;
//	private ByteArrayOutputStream baos = null;
	Debug debug;

	// #if USESECURE
	// // next two only meaningful for RMI_COMMTYPE_AUTH_ENCRYPT_RELIABLE
	// private Authenticator clientAuthenticator = null; // client's private key
	// private CertPredicate predicate = null; // who do you want to talk to
	// today?
	// #endif /* USESECURE */
    public NinjaRemoteRef(){}
	public NinjaRemoteRef(FrameworkListener currentListenr) {
        this.currentListener=currentListenr;
        debug = new Debug();
        this.currentListener=currentListener;
        // DEBUG(System.out.println("NinjaRemoteRef constructor called with no
		// args"));
		debug.print("NinjaRemoteRef constructor called with no args");
	}

	/**
	 * Creates a NinjaRemoteRef which points to the object on the given hostname
	 * and port with the given object ID. Used to manually bootstrap a
	 * client-side reference to a remote object (that is, without going through
	 * the registry).
	 *
//	 * @param host
	 *            The hostname to contact to call on this remote object.
//	 * @param port
	 *            The port to contact to call on this remote object.
	 * @param oid
	 *            The ObjID corresponding to the remote object.
//	 * @param comm_type
	 *            One of NinjaExportData.RMI_COMM_TYPE_* values, specifying the
	 *            communication semantics for the call.
	 */
	public NinjaRemoteRef(
//                            String host,
//                          int port,
                          ObjID oid, String server){
//                          int comm_type) {
		// DEBUG(System.out.println("NinjaRemoteRef constructor called with:
		// "+host+":"+port+" objid "+oid));
		debug = new Debug();
		debug.print("NinjaRemoteRef constructor called with: "
//                + host + ":"
//				+ port
                + " objid " + oid);
//		remotehost = host;
//		remoteport = port;
		objid = oid;
        this.server=server;
//		commtype = comm_type;
	}

	// #if USESECURE
	// /**
	// * Sets the authenticator object which will be used to prove to the server
	// * that the client is authentic.
	// * Should be a Authenticator object which has already been initialized
	// * for signing.
	// * (Only meaningful for RMI_COMM_TYPE_AUTH_ENCRYPT_RELIABLE.)
	// *
	// * <p>There is no <tt>getAuthenticator()</tt> call. This is a feature.</p>
	// */
	// // XXX: FIX: need to double-check to make sure it's ok that this is
	// public
	// public void setClientAuthenticator(Authenticator auth) {
	// clientAuthenticator = auth;
	// }
	//
	// public void setPredicate(CertPredicate pred) {
	// predicate = pred;
	// }
	//
	// public NinjaCert getServerCertificate() {
	// if (sock == null || !(sock instanceof AuthSocket))
	// return null;
	// return ((AuthSocket)sock).getCertificate();
	// }
	// #endif /* USESECURE */

	/**
	 * Invokes the given method with the given params on the remote object.
	 * Called by the client-side stub.
	 */
//	public Object invoke(NinjaRemoteObject obj, java.lang.reflect.Method method,
//			Object[] params, long opnum) throws Exception {
//		// DEBUG(System.out.println("NinjaRemoteRef invoke called..."));
//		debug.print("NinjaRemoteRef invoke called...");
//		return null;
//	}

	/**
	 * Returns a NinjaRemoteCall, used by the stub to make method calls on the
	 * remote object.
	 */
	public NinjaRemoteCall newCall(int opnum, long hash) throws Exception {

		// DEBUG(System.out.println("NinjaRemoteRef (port "+remoteport+")
		// newCall called..."));
		debug.print("NinjaRemoteRef (port "
//                + remoteport
				+ ") newCall called...");

		// XXX mdw Cleanup: Should have NinjaRemoteRef 'remember' the current
		// call, have the call create sockets etc. if necessary...yuk.

//		if (commtype == NinjaExportData.RMI_COMM_TYPE_RELIABLE) {

			// Need to create a new socket to the server?
	/*		if (sock == null) {

				try {
					sock = new Socket(remotehost, remoteport);
				} catch (Exception e) {
					throw new RemoteException(
							"NinjaRemoteRef: Can't get socket to " + remotehost
									+ ":" + remoteport, e);
				}

				// Socket has been created, let's push the protocol header on
				// down
				try {
					bis = new BufferedInputStream(sock.getInputStream());
					bos = new BufferedOutputStream(sock.getOutputStream());
					DataOutputStream dataos = new DataOutputStream(bos);
					dataos.writeInt(0x4e524d49); // Header "NRMI"
					dataos.writeShort(0x0001); // Version
					dataos.writeByte(0x4b); // Protocol: Stream
					// dataos.flush();
					// XXX XXX mdw: Need to get back 'protocol OK' and endpt ID
				} catch (Exception e) {
					throw new RemoteException(
							"NinjaRemoteRef: Can't push header", e);
				}
			}   */

            if  (bis == null)
                    bis = new DataInputStream();
            if  (bos == null)
                    bos= new DataOutputStream(currentListener);

            bos.writeInt(0x4e524d49); // Header "NRMI"
			bos.writeShort((short)0x0001); // Version
			bos.writeByte((byte)0x4b); // Protocol: Stream

            // This will send the call header
			// Stub picks up by writing arguments
			try {
				return new Reliable_RemoteCall(bis, bos, objid, opnum, hash, currentListener);
			} catch (Exception e) {
				debug.print("NinjaRemoteRef: Can't create new NinjaRemoteCall"+ e.getMessage());
                return null;
            }

		/*} else if (commtype == NinjaExportData.RMI_COMM_TYPE_UNRELIABLE_ONEWAY) {

//			baos = new ByteArrayOutputStream();
//			DataOutputStream dataos = new DataOutputStream(baos);
			try {
				bos.writeInt(0x4e524d49); // Header "NRMI"
				bos.writeShort((byte)0x0002); // Version
				// dataos.flush();
				return null;
			} catch (Exception e) {
				throw new RemoteException(
						"NinjaRemoteRef.newCall(): Can't create unreliable call",
						e);
			}

		} else if (commtype == NinjaExportData.RMI_COMM_TYPE_MULTICAST_ONEWAY) {

			baos = new ByteArrayOutputStream();
			DataOutputStream dataos = new DataOutputStream(baos);
			try {
				dataos.writeInt(0x4e524d49); // Header "NRMI"
				dataos.writeShort(0x0002); // Version
				// dataos.flush();
				return new McastOw_RemoteCall(baos, objid, opnum, hash);
			} catch (Exception e) {
				throw new RemoteException(
						"NinjaRemoteRef.newCall(): Can't create multicast call",
						e);
			}

			// #if USESECURE
			// } else if (commtype ==
			// NinjaExportData.RMI_COMM_TYPE_AUTH_ENCRYPT_RELIABLE) {
			//
			// // Need to create a new socket to the server?
			// if (sock == null) {
			//
			// try {
			// sock = new AuthSocket(remotehost, remoteport,
			// clientAuthenticator,
			// predicate);
			// } catch (Exception e) {
			// throw new RemoteException("NinjaRemoteRef: Can't get auth socket
			// to "+remotehost+":"+remoteport, e);
			// }
			//
			// // Socket has been created, let's push the protocol header on
			// down
			// DEBUG(System.out.println("daw NinjaRemoteRef: sending hdr"));
			// try {
			// bis = new BufferedInputStream(sock.getInputStream());
			// DEBUG(System.out.println("daw NinjaRemoteRef: got buffered in"));
			// bos = new BufferedOutputStream(sock.getOutputStream());
			// DEBUG(System.out.println("daw NinjaRemoteRef: got buffered
			// out"));
			// DataOutputStream dataos = new DataOutputStream(bos);
			// DEBUG(System.out.println("daw NinjaRemoteRef: got data out"));
			// dataos.writeInt(0x4e524d49); // Header "NRMI"
			// DEBUG(System.out.println("daw NinjaRemoteRef: wrote NRMI"));
			// dataos.writeShort(0x0001); // Version
			// DEBUG(System.out.println("daw NinjaRemoteRef: wrote version"));
			// dataos.writeByte(0x4b); // Protocol: Stream
			// DEBUG(System.out.println("daw NinjaRemoteRef: wrote protocol"));
			// //dataos.flush();
			// // XXX XXX mdw: Need to get back 'protocol OK' and endpt ID
			// } catch (Exception e) {
			// throw new RemoteException("NinjaRemoteRef: Can't push header",
			// e);
			// }
			// DEBUG(System.out.println("daw NinjaRemoteRef: sent hdr"));
			// }
			//
			// // This will send the call header
			// // Stub picks up by writing arguments
			// try {
			// return new AuthRel_RemoteCall(bis, bos, objid, opnum, hash);
			// } catch (Exception e) {
			// throw new RemoteException("NinjaRemoteRef: Can't create new
			// NinjaRemoteCall", e);
			// }
			// #endif /* USESECURE */

//		}  else {
//			debug.print(
//					"NinjaRemoteRef.newCall(): invalid commtype " + commtype);
//            return null;
//        }

	}

	/**
	 * Invokes the method on the remote object for the given RemoteCall. Used by
	 * the stub.
	 */
	public void invoke(NinjaRemoteCall call) throws Exception {
		// DEBUG(System.out.println("NinjaRemoteRef invoke.noargs called
		// ("+remotehost+":"+remoteport+")..."));
		debug.print("NinjaRemoteRef invoke.noargs called ("
//                + remotehost + ":"
//				+ remoteport
                + ")...");
		call.executeCall();

		// XXX Cleanup: This should be part of the RemoteCall...
	/*	if (commtype == NinjaExportData.RMI_COMM_TYPE_UNRELIABLE_ONEWAY) {
			// Wrap the data up in a datagram packet and send it
			baos.flush();
			byte[] ba = baos.toByteArray();
			DatagramPacket dp = new DatagramPacket(ba, ba.length, InetAddress
					.getByName(remotehost), remoteport);
			DatagramSocket ds = new DatagramSocket();
			ds.send(dp);

		} else if (commtype == NinjaExportData.RMI_COMM_TYPE_MULTICAST_ONEWAY) {
			// Wrap the data up in a datagram packet and send it
			baos.flush();
			byte[] ba = baos.toByteArray();
			DatagramPacket dp = new DatagramPacket(ba, ba.length, InetAddress
					.getByName(remotehost), remoteport);
			MulticastSocket ds = new MulticastSocket();
			ds.joinGroup(InetAddress.getByName(remotehost));
			ds.send(dp);
		}     */
	}

	/**
	 * Finishes the remote method invocation. Used by the stub.
	 */
	public void done(NinjaRemoteCall call) throws Exception {
		// DEBUG(System.out.println("NinjaRemoteRef done called
		// ("+remotehost+":"+remoteport+")..."));
		debug.print("NinjaRemoteRef done called ("
//                + remotehost + ":"
//				+ remoteport
                + ")...");
		try {
			call.done();
		} catch (Exception e) {
            debug.print(e.getMessage());
//            throw new RemoteException(e.getMessage());
		}
	}

	/**
	 * Returns a hashcode on the remote reference. Used by the stub.
	 */
	public int remoteHashCode() {
		// DEBUG(System.out.println("NinjaRemoteRef remoteHashCode called..."));
		debug.print("NinjaRemoteRef remoteHashCode called...");
		return objid.hashCode();
	}

	/**
	 * Determines if two NinjaRemoteRef's are equal - used by the stub.
	 */
	public boolean remoteEquals(NinjaRemoteRef obj) {
		// DEBUG(System.out.println("NinjaRemoteRef remoteEquals called..."));
		debug.print("NinjaRemoteRef remoteEquals called...");

		if (obj instanceof NinjaRemoteRef)
			return objid.equals(((NinjaRemoteRef) obj).objid);
		else
			return false;
	}

	/**
	 * Returns a string representing this remote reference. Used by the stub.
	 */
	public String remoteToString() {
		// DEBUG(System.out.println("NinjaRemoteRef remotetoString called..."));
		debug.print("NinjaRemoteRef remotetoString called...");
		return new String("NinjaRemoteRef at "
//                + remotehost + ":"
//                + remoteport
        );
	}

	/**
	 * writeExternal is called on the NinjaRemoteRef when the stub is serialized
	 * over the network.
	 */
	public void writeExternal(NinjaObjectOutputStream out) throws Exception {
		// DEBUG(System.out.println("NinjaRemoteRef
		// ("+remotehost+":"+remoteport+") writeExternal called!"));
		debug.print("NinjaRemoteRef ("
//                + remotehost + ":"
//                + remoteport
				+ ") writeExternal called!");
//		out.writeUTF(this.remotehost);
//		out.writeInt(this.remoteport);
		this.objid.write(out);
//		out.writeInt(this.commtype);
        out.writeUTF(this.server);
        return;
	}

	/**
	 * readExternal is called on the NinjaRemoteRef when the stub is serialized
	 * over the network.
	 */
	public void readExternal(NinjaObjectInputStream in) throws Exception{
		// DEBUG(System.out.println("NinjaRemoteRef readExternal called!"));
		debug.print("NinjaRemoteRef readExternal called!");
//		this.remotehost = in.readUTF();
//		this.remoteport = in.readInt();
        this.objid= new ObjID();
        this.objid = this.objid.read(in);
        //commented by meisam
//        this.objid = ObjID.read(in);
//		this.commtype = in.readInt();
        this.server=in.readUTF();
        return;
	}

	/*
	 * The following methods are used by the client, which can extract the
	 * NinjaRemoteRef from a Stub using the 'getNinjaRemoteRef' method added to
	 * the stub by ninjarmic.
	 */

	/**
	 * Returns the fully-qualified hostname of the machine which this
	 * NinjaRemoteRef connects to.
	 */
//	public String get_remotehost() {
//		return remotehost;
//	}

	/**
	 * Returns the port number of the machine which this NinjaRemoteRef connects
	 * to. This could be a TCP or a UDP port, depending on the value of
	 * get_commtype().
	 */
//	public int get_remoteport() {
//		return remoteport;
//	}

	/**
	 * Returns the object ID which this NinjaRemoteRef refers to. The object ID
	 * is a unique identifier for the remote object, and is checked on each
	 * remote method invocation to ensure that the correct client-side stub is
	 * being used to make remote calls. Some remote objects do not require the
	 * object ID to match.
	 */
	public ObjID get_objid() {
		return objid;
	}

	/**
	 * Returns the communications type of the connection used by this
	 * NinjaRemoteRef. The commtype fields are defined in NinjaExportData.
	 *
//	 * @see NinjaExportData
	 */
	public String get_server() {
		return server;
	}

    public void writeObject(DataOutputStream dos) {
        this.objid.write((NinjaObjectOutputStream)dos);
	    dos.writeUTF(this.server);
		return;
    }

    public Serializable readObject(DataInputStream dis) {
        this.objid= new ObjID();
        this.objid = this.objid.read((NinjaObjectInputStream)dis);
        //commented  by meisam
//        this.objid = ObjID.read((NinjaObjectInputStream)dis);
		this.server = dis.readUTF();
		return this;
    }

//    public void clone(Entity e, long index)       // this will put all the the attributes and index in the entity e
//    {
//        ((NinjaRemoteRef)e).objid=objid;
//        ((NinjaRemoteRef)e).server = server;
//        e.setIndex(index);
//        setIndex(index);
//    }

    public void readObject(DataInputStreamWrapper in) throws IOException      //for persistent this two methods should be implemented it somehow shows the   serializability order
    {
        this.objid= new ObjID();
//        this.objid =
        this.objid.read(in);
        //commented  by meisam
//        this.objid = ObjID.read((NinjaObjectInputStream)dis);
		this.server =
//                in.readString();
        in.readUTF();
    }

    public void writeObject(DataOutputStreamWrapper out) throws IOException {
       //To change body of implemented methods use File | Settings | File Templates.
        this.objid.write(out);
//        out.writeString(this.server);
        out.writeUTF(this.server);
    }
}
