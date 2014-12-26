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

import java.io.IOException;

import peer2me.framework.FrameworkListener;
//meisam
/*import java.rmi.server.RemoteRef;
import java.rmi.server.RemoteObject;
import java.rmi.server.RemoteCall;
import java.rmi.RemoteException;
import java.rmi.Remote;
import java.rmi.server.Operation;
import java.io.ObjectInput;
import java.io.ObjectOutput;
import java.io.IOException;
import java.lang.ClassNotFoundException;
import java.rmi.server.ObjID;
import java.rmi.server.UID;
import java.net.Socket;
import java.io.StreamCorruptedException;
import java.io.OutputStream;
import java.io.InputStream;
import java.io.DataOutputStream;
import java.io.DataInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedInputStream;
import java.io.ObjectOutputStream;
import java.io.ObjectInputStream;
import java.net.URL;
import java.net.MalformedURLException;*/

// A RemoteCall which deals with a reliable TCP connection
class Reliable_RemoteCall implements NinjaRemoteCall {
	Debug debug;
	NinjaObjectOutputStream objout;
	NinjaObjectInputStream objin;
	DataInputStream datais;
	DataOutputStream dataos;
    FrameworkListener frameworkListener;

    
// This is the client-side constructor
Reliable_RemoteCall(DataInputStream theis, DataOutputStream theos, ObjID objid,
        int i, long j,FrameworkListener frameworkListener) throws Exception {
    this.frameworkListener=frameworkListener;
    debug = new Debug();
    // DEBUG(System.out.println("NinjaRemoteCall client constructor
    // called!"));
    debug.print("NinjaRemoteCall client constructor called!");
    datais = theis;
    dataos = theos;

    // Write call header
    // DEBUG(System.out.println("NinjaRemoteCall: Getting
    // DataOutputStream"));
    debug.print("NinjaRemoteCall: Getting DataOutputStream");
//    DataOutputStream dataos = new DataOutputStream(os);
    // DEBUG(System.out.println("NinjaRemoteCall: Writing call msg 0x50"));
    debug.print("NinjaRemoteCall: Writing call msg 0x50");
    dataos.writeByte((byte)0x50);
    // DEBUG(System.out.println("NinjaRemoteCall: Getting
    // ObjectOutputStream"));
    debug.print("NinjaRemoteCall: Getting ObjectOutputStream");

    objout = new NinjaObjectOutputStream(frameworkListener);

    // DEBUG(System.out.println("NinjaRemoteCall: Writing objid"));
    debug.print("NinjaRemoteCall: Writing objid");
    objid.write(objout);

    // DEBUG(System.out.println("NinjaRemoteCall: Writing op: "+i));
    debug.print("NinjaRemoteCall: Writing op: " + i);
    objout.writeInt(i);
    // DEBUG(System.out.println("NinjaRemoteCall: Writing hash: "+j));
    debug.print("NinjaRemoteCall: Writing hash: " + j);
    objout.writeLong(j);
    // objout.flush();
}

// This is the server-side constructor
Reliable_RemoteCall(DataInputStream theis, DataOutputStream theos) {
    // DEBUG(System.out.println("NinjaRemoteCall server constructor
    // called!"));
    debug = new Debug();
    debug.print("NinjaRemoteCall server constructor called!");
    datais = theis;
    dataos = theos;
}

public NinjaObjectOutputStream getOutputStream() throws Exception {
    // DEBUG(System.out.println("NinjaRemoteCall getOutputStream called!"));
    debug.print("NinjaRemoteCall getOutputStream called!");
    if (objout == null) {
        objout = new NinjaObjectOutputStream(frameworkListener);
    }
    return objout;
}

public void releaseOutputStream() throws Exception {
    // DEBUG(System.out.println("NinjaRemoteCall releaseOutputStream
    // called!"));
    debug.print("NinjaRemoteCall releaseOutputStream called!");
    objout.flush(); // XXX need to close?
}

public NinjaObjectInputStream getInputStream() throws Exception {
    // DEBUG(System.out.println("NinjaRemoteCall getInputStream called!"));
    debug.print("NinjaRemoteCall getInputStream called!");

    if (objin == null) {
        objin = new NinjaObjectInputStream();
    }
    return objin;
}

public void releaseInputStream() throws Exception {
    // DEBUG(System.out.println("NinjaRemoteCall releaseInputStream
    // called!"));
    debug.print("NinjaRemoteCall releaseInputStream called!");
}

public NinjaObjectOutputStream getResultStream(boolean flag) throws Exception{
    // DEBUG(System.out.println("NinjaRemoteCall getResultStream called!"));
    debug.print("NinjaRemoteCall getResultStream called!");

    dataos.writeByte((byte)0x51);

    getOutputStream();
    if (flag) {
        objout.writeByte((byte)1); // Success
    } else {
        objout.writeByte((byte)2); // Failure
    }
    // Write ID
//    UID resultid = new UID();
//    resultid.write(objout);
    // objout.flush();
    return objout;
}

public void executeCall() throws Exception {
    // DEBUG(System.out.println("NinjaRemoteCall executeCall called!"));
//		debug.print("NinjaRemoteCall executeCall called!");

    objout.flush(); // Flush output

    byte code = datais.readByte();
    if (code != 0x51) {
        throw new IOException("NinjaRemoteCall read back bad return code "
                + code);
    }

    getInputStream();
    code = objin.readByte();
//    UID resultid = UID.read(objin);
    switch (code) {
    case 1:
        // Success, do nothing
        // DEBUG(System.out.println("NinjaRemoteCall.executeCall: Got
        // success"));
        debug.print("NinjaRemoteCall.executeCall: Got success");
        break;

    case 2:
        // Error
        // DEBUG(System.out.println("NinjaRemoteCall.executeCall: Got
        // error"));
        debug.print("NinjaRemoteCall.executeCall: Got error");
        // commented by meisam
//        Exception e = (Exception) objin.readObject();
//        throw new Exception("NinjaRemoteCall: RMI server sent exception: "
//                + e.getMessage());

    default:
        // Bad code
        // DEBUG(System.out.println("NinjaRemoteCall.executeCall: Got bad
        // code "+code));
        debug.print("NinjaRemoteCall.executeCall: Got bad code " + code);
        throw new IOException("NinjaRemoteCall read back bad code " + code);
    }
}

public void done() throws Exception {
    // DEBUG(System.out.println("NinjaRemoteCall done called!"));
    debug.print("NinjaRemoteCall done called!");
}

}
    