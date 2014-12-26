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
import peer2me.framework.FrameworkListener;

//import java.rmi.ServerException;

//import java.io.*;
//import java.net.*;//meisam

// An OutputStream which replaces subclasses of java.rmi.Remote with their
// stubs during serialization - to be used on the server side of an RMI
// connection
public class NinjaObjectOutputStream extends DataOutputStream{

    Debug debug;
    DataOutputStream dos;

//	public NinjaObjectOutputStream(OutputStream os) throws IOException {
//		super(os);
//		debug = new Debug();
//
//		try {
//			enableReplaceObject(true);
//		} catch (SecurityException e) {
//			// XXX mdw: It looks like ObjectOutputStream doesn't let us
//			// enable object replacement if the NinjaObjectOutputStream has
//			// a non-null classloader (as it will for applets; what about
//			// other clients w/o access to the ninja.rmi package?)
//			// All this means is that applets can't return "Remote" objects
//			// as stubs, I hope...
//		}
//	}

    public NinjaObjectOutputStream(FrameworkListener f) {
        super(f);
        debug = new Debug();
        dos = new DataOutputStream(f);
    }

    public void writeObject(NinjaRemoteObject obj) {
//            throws IOException {
//        if (obj instanceof NinjaRemoteObject) {
//            // XXX If the object isn't a NinjaRemoteObject we technically
//            // shouldn't return anything - but - it might be a Ninja stub
//            // already (e.g., in the registry, or a client passing an object
//            // to another client).
        Serializable stub= replaceObjectWithStub(obj);
//        }
        dos.writeObject(stub);
	}
    public void writeObject(Serializable obj) {
         dos.writeObject(obj);
    }

    public void writeInt(int i){
        dos.writeLong(i);

    }

    public void writeLong(long l)  {
        dos.writeLong(l);
    }

    public void writeShort(short s) {
        dos.writeShort(s);
    }

    public void writeByte(byte b){
        dos.writeByte(b);
    }

    public void writeUTF(String u) {
        dos.writeUTF(u);
    }

    public void flush() {
        dos.flush();
    }

    private Serializable replaceObjectWithStub(NinjaRemoteObject remoteobj) {
		// DEBUG(System.out.println("NinjaObjectOutputStream:
		// replaceObjectWithStub called!"));
		debug.print("NinjaObjectOutputStream: replaceObjectWithStub called!");
		Serializable stub = remoteobj.getStub();
		if (stub == null) {
			// DEBUG(System.out.println("NinjaObjectOutputStream: stub is
			// null?"));
			debug.print("NinjaObjectOutputStream: stub is null?");
		}
		return stub;
	}
//    public void writeObject(ServerException obj) {
//        dos.writeUTF(obj.getMessage());
//    }


 /*   protected void annotateClass(Class theclass) throws IOException {
		String codebase = null;
		String cname = theclass.getName();
		// DEBUG(System.out.println("NinjaObjectOutputStream.annotateClass
		// called for "+cname));
		debug
				.print("NinjaObjectOutputStream.annotateClass called for "
						+ cname);
		// Assume we get these from local CLASSPATH
		if ((!cname.startsWith("sun.")) && (!cname.startsWith("java."))) {

			// If the class has its own classloader, it was passed to us from
			// another
			// RMI server and we're handing it off (that is, we're the
			// registry).
			ClassLoader CL = theclass.getClassLoader();
			if (CL != null) {

				// DEBUG(System.out.println("NinjaObjectOutputStream: Got CL,
				// type is "+CL.getClass().getName()));
				debug.print("NinjaObjectOutputStream: Got CL, type is "
						+ CL.getClass().getName());

				if (CL instanceof NinjaClassLoader) {
					NinjaClassLoader NCL = (NinjaClassLoader) CL;
					codebase = NCL.getCodeBase().toExternalForm();
					// DEBUG(System.out.println("NinjaObjectOutputStream:
					// NinjaClassLoader used, codebase is "+codebase));
					debug
							.print("NinjaObjectOutputStream: NinjaClassLoader used, codebase is "
									+ codebase);
				} else {
					// DEBUG(System.out.println("NinjaObjectOutputStream:
					// Warning: Classloader defined, but not a NinjaClassLoader
					// - no codebase defined for non-NinjaClassLoader CL's."));
					debug
							.print("NinjaObjectOutputStream: Warning: Classloader defined, but not a NinjaClassLoader - no codebase defined for non-NinjaClassLoader CL's.");
					codebase = null;
				}
			}
			if (codebase == null) {
				codebase = System.getProperty("java.rmi.server.codebase");
				if (codebase == null) {
					// DEBUG(System.out.println("NinjaObjectOutputStream:
					// Warning: No codebase defined for exporting non-Sun
					// classes!"));
					debug
							.print("NinjaObjectOutputStream: Warning: No codebase defined for exporting non-Sun classes!");
				}
			}
		}

		// DEBUG(System.out.println("NinjaObjectOutputStream: writing codebase
		// "+codebase));
		debug.print("NinjaObjectOutputStream: writing codebase " + codebase);
		writeObject(codebase);
	}    */

}
