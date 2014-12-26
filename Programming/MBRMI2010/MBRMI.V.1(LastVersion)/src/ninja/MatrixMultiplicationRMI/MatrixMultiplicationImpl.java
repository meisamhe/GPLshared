package ninja.MatrixMultiplicationRMI;
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

//import java.rmi.*;
//import java.io.*;
import ninja.rmi.NinjaRemoteObject;
import ninja.MatrixMultiplicationRMI.MatrixMultiplication;

import javax.microedition.midlet.MIDlet;

public class MatrixMultiplicationImpl extends NinjaRemoteObject implements MatrixMultiplication {

    public MatrixMultiplicationImpl(String nodeName, String serverServiceName, String preferredNetwork, MIDlet midlet) throws Exception {
//		super(null); // This prevents the object from being exported with
		// the defaults.
          super(nodeName,serverServiceName, preferredNetwork, midlet);
		// Create a NinjaExportData structure so we can specify the callbacks.
//		NinjaExportData data = new NinjaExportData();
//		data.callbacks = new MyCallbacks();   //meisam

		// OK, now export the object with this NinjaExportData structure.
        //by meisam: for I added exportObject in super() constructor
//		this.exportObject();

		System.out
				.println("This is the serviceclass constructor method being called\n");
	}

    public MatrixMultiplicationImpl(){}

    public SerializableMatrix Multiply(SerializableMatrix array0,SerializableMatrix array1) throws Exception {
        int l=  array0.length;
        int m=array1.length;
        int n=((SerializableVector)array1.v.elementAt(0)).length;
        int result[][] = new int[l][n];
        for(int i = 0; i < l; i++) {
          for(int j = 0; j < n; j++) {
            for(int k = 0; k < m; k++){
              result[i][j] += array0.getElement(i,k)*array1.getElement(k,j);
            }
          }
        }
        return new SerializableMatrix(result);  //To change body of implemented methods use File | Settings | File Templates.
    }
}

// This is a demonstration of how to register callbacks with the RMI server
// code - in this case we get callbacks whenever a client connects or
// disconnects from this code.
//meisam
//class MyCallbacks implements ninja.rmi.NinjaServerCallbacks {
//
//	public void socket_created(String hostname, int port) {
//		System.out.println("Socket created to TheService on " + hostname + ":"
//				+ port);
//	}
//
//	public void socket_destroyed(String hostname, int port) {
//		System.out.println("Socket destroyed at TheService on " + hostname
//				+ ":" + port);
//	}

//}
