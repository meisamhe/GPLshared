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

import ninja.Domain.Debug;
import peer2me.framework.FrameworkListener;

import java.util.Vector;

/*import java.rmi.*;
import java.rmi.server.*;  */         //meisam

/**
 * NinjaServerThread is a Thread which is forked to listen for remote
 * invocations on a NinjaRemoteObject. It is an abstract class which should be
 * implemented to handle the particular kind of communication semantics required
 * by the underlying remote object. All incoming RMI calls by a client are
 * invoked in the context of a NinjaServerThread.
 * 
 * Users should not create or manage NinjaServerThreads directly; they are
 * created by the server-side Ninja RMI code.
 * 
// * @see Reliable_ServerThread
// * @see UnrelOw_ServerThread
// * @see McastOw_ServerThread
// */
public abstract class NinjaServerThread implements FrameworkListener {// extends Thread {

	private static int _tnum = 0;

//	NinjaServerRef servref;
//    public static Vector Servref;

    Debug debug;

	NinjaServerThread(NinjaServerRef serverref) throws Exception {
		debug = new Debug();
		debug.print("NinjaServerThread: Superclass constructor called, ref is "
				+ serverref);
		// DEBUG(System.out.println("NinjaServerThread: Superclass constructor
		// called, ref is "+serverref));

//		servref = serverref;
//        Servref.addElement(serverref);
		debug
				.print("NinjaServerThread: Superclass constructor called, ref is set to "
						+ serverref);
		// DEBUG(System.out.println("NinjaServerThread: Superclass constructor
		// called, ref is set to "+servref));
	}

    public  void addElement(NinjaServerRef serverref){
//         Servref.addElement(serverref);
    }

    /**
	 * The run() method of the Thread; is invoked by doing thread.start().
	 */
	public  abstract void run();

}
