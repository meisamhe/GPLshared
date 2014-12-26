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


import java.io.IOException;
//import java.io.StreamCorruptedException;
//import java.io.ObjectOutput;
//import java.io.ObjectInput;

/**
 * NinjaRemoteCall is an interface implemented by each of the remote call
 * objects (such as Reliable_RemoteCall).
 */
public interface NinjaRemoteCall {

	NinjaObjectOutputStream getOutputStream() throws Exception;

	void releaseOutputStream() throws Exception;

	NinjaObjectInputStream getInputStream() throws Exception;

	void releaseInputStream() throws Exception;

	NinjaObjectOutputStream getResultStream(boolean success) throws Exception;
//    void getResultStream(boolean success);

    void executeCall() throws Exception;

	void done() throws IOException, Exception;

}
