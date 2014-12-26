package ninja.MergeSortRMI;// NinjaRMI, by Matt Welsh (mdw@cs.berkeley.edu)
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
import ninja.MatrixMultiplicationRMI.SerializableVector;
import ninja.MergeSortRMI.MergeSort;

import javax.microedition.midlet.MIDlet;

public class MergeSortImpl extends NinjaRemoteObject implements MergeSort {

    public MergeSortImpl(String nodeName, String serverServiceName, String preferredNetwork, MIDlet midlet) throws Exception {
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
    public  SerializableVector mergesort(SerializableVector data)
   {
      int n1; // Size of the first half of the array
      int n2; // Size of the second half of the array
      if (data.length > 1)
      {
         // Compute sizes of the two halves
         n1 = data.length / 2;
         n2 = data.length - n1;

         SerializableVector temp0 = new SerializableVector(data, 0, n1);
//                 mergesort(data, first, n1);      // Sort data[first] through data[first+n1-1]
         temp0=mergesort(temp0);
         SerializableVector temp1= new SerializableVector(data,  n1, n1+n2);
//                 mergesort(data, first + n1, n2); // Sort data[first+n1] to the end
         temp1=mergesort(temp1);
         // Merge the two sorted halves.
         return  merge (temp0,temp1);
//                 merge(temp0,temp1, first, n1, n2);
      }
      return data;
   }

//   private  SerializableVector merge(SerializableVector temp0, SerializableVector temp1, int first, int n1, int n2)
   private  SerializableVector merge(SerializableVector temp0, SerializableVector temp1)
   // Precondition: data has at least n1 + n2 components starting at data[first]. The first
   // n1 elements (from data[first] to data[first + n1 – 1] are sorted from smallest
   // to largest, and the last n2 (from data[first + n1] to data[first + n1 + n2 - 1]) are also
   // sorted from smallest to largest.
   // Postcondition: Starting at data[first], n1 + n2 elements of data
   // have been rearranged to be sorted from smallest to largest.
   // Note: An OutOfMemoryError can be thrown if there is insufficient
   // memory for an array of n1+n2 ints.
   {
      int n1=temp0.length;
      int n2=temp1.length;
      int[ ] temp = new int[n1+n2]; // Allocate the temporary array
      int copied  = 0; // Number of elements copied from data to temp
      int copied1 = 0; // Number copied from the first half of data
      int copied2 = 0; // Number copied from the second half of data
      int i;           // Array index to copy from temp back into data

      // Merge elements, copying from two halves of data to the temporary array.
      while ((copied1 < n1) && (copied2 < n2))
      {
         if (temp0.getElement(copied1) < temp1.getElement(copied2))
            temp[copied++] = temp0.getElement(copied1++);
         else
            temp[copied++] = temp1.getElement(copied2++);
      }

      // Copy any remaining entries in the left and right subarrays.
      while (copied1 < n1)
         temp[copied++] = temp0.getElement (copied1++);
      while (copied2 < n2)
         temp[copied++] = temp1.getElement (copied2++);

      // Copy from temp back to the data array.
//      for (i = 0; i < n1+n2; i++)
//         data[first + i] = temp[i];
       return new SerializableVector(temp);
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
