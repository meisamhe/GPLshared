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

//import java.io.*;
//import java.net.*;  //meisam

// An InputStream which gets the "codebase" URL from the opposite side
// for non-Sun classes - used on client side of RMI connection

public class NinjaObjectInputStream extends DataInputStream{  

    Debug debug;
    DataInputStream dis;

//     public NinjaObjectInputStream(InputStream is) throws IOException,
//            StreamCorruptedException {
//		debug = new Debug();
//	}

    public NinjaObjectInputStream(){
           debug = new Debug();
           dis= new DataInputStream() ;
    }

    public int readInt(){
         return dis.readInt();
    }

    public long readLong()  {
          return dis.readLong();
    }

    public byte readByte(){
        return dis.readByte();
    }

    public short readShort(){
       return dis.readShort();
    }

    public String readUTF(){
        return dis.readUTF();
    }

    public Serializable readObject (Serializable s) throws ClassNotFoundException, IllegalAccessException, InstantiationException {
        return dis.readObject(s);
    }

//    public void flush() {
//          dis.flush();
//    }



    //meisam

/* public NinjaObjectInputStream(InputStream is) throws IOException,
            StreamCorruptedException {
		super(is);
		debug = new Debug();
	}     */

/*	protected Class resolveClass(ObjectStreamClass osClass) throws IOException,
			ClassNotFoundException {

		// DEBUG(System.out.println("NinjaObjectInputStream.resolveClass called
		// for "+osClass.getName()));
		debug.print("NinjaObjectInputStream.resolveClass called for "
				+ osClass.getName());

		Object obj = readObject();

		// try {
		// return super.resolveClass(osClass);
		// } catch (Exception e) {
		// System.out.println("NinjaObjectInputStream.resolveClass: got
		// exception "+e.getMessage());
		// Do nothing?
		// }

		String cname = osClass.getName();
		// DEBUG(System.out.println("NinjaObjectInputStream.resolveClass getting
		// codebase."));
		debug.print("NinjaObjectInputStream.resolveClass getting codebase.");
		try {
			// If we read a string at first, treat it as a URL
			if (obj != null && obj instanceof String) {
				String codebase = (String) obj;
				// DEBUG(System.out.println("NinjaObjectInputStream: Codebase is
				// "+codebase));
				debug.print("NinjaObjectInputStream: Codebase is " + codebase);
				// URL codebaseURL = new URL("file:/" + codebase);
				URL codebaseURL = new URL(codebase);
				// DEBUG(System.out.println("NinjaObjectInputStream: Codebase
				// URL is "+codebaseURL.toExternalForm()));
				debug.print("NinjaObjectInputStream: Codebase URL is "
						+ codebaseURL.toExternalForm());
				NinjaClassLoader ncl = new NinjaClassLoader(codebaseURL);
				Class theclass = ncl.loadClass(cname);
				// DEBUG(System.out.println("NinjaObjectInputStream: Loaded
				// class "+cname));
				debug.print("NinjaObjectInputStream: Loaded class " + cname);
				// DEBUG(System.out.println("NinjaObjectInputStream: Class
				// classloader is "+theclass.getClassLoader()));
				debug.print("NinjaObjectInputStream: Class classloader is "
						+ theclass.getClassLoader());

				// DEBUG(if (theclass.getClassLoader() != null)
				// System.out.println("NinjaObjectInputStream: Loaded class
				// "+cname+" from RMICL, type of CL is
				// "+theclass.getClassLoader().getClass().getName()));
				debug.print("NinjaObjectInputStream: Class classloader is "
						+ theclass.getClassLoader());
				if (theclass.getClassLoader() != null)
					System.out.println("NinjaObjectInputStream: Loaded class "
							+ cname + " from RMICL, type of CL is "
							+ theclass.getClassLoader().getClass().getName());

				return theclass;
			} else {

				if (obj == null) {
					// DEBUG(System.out.println("NinjaObjectInputStream: Read
					// codebase back as null"));
					debug
							.print("NinjaObjectInputStream: Read codebase back as null");
				} else {
					// DEBUG(System.out.println("NinjaObjectInputStream: Read
					// codebase back as non-string"));
					debug
							.print("NinjaObjectInputStream: Read codebase back as non-string");
				}
				// DEBUG(System.out.println("NinjaObjectInputStream: Trying to
				// resolve class directly..."));
				debug
						.print("NinjaObjectInputStream: Trying to resolve class directly...");

				try {
					return super.resolveClass(osClass);
				} catch (Exception e) {
					throw new IOException(
							"NinjaObjectInputStream: Object was null or not a string");
				}
			}
		} catch (Exception e) {
			throw new IOException("NinjaObjectInputStream can't resolve class "
					+ cname + ": " + e.getMessage());
		}
	}    */
}
