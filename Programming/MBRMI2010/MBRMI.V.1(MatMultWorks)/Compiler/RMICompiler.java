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

package ninja.Compiler;

import java.lang.reflect.*;
import java.util.Vector;
import java.util.StringTokenizer;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import ninja.codegen.*;
import ninja.Domain.RemoteObject;
import ninja.rmi.NinjaRemoteStub;

/**
 * RMICompiler is a class which generates Java sourcecode implementing RMI stubs
 * and skeletons, given a class which implements interfaces extending
 * <tt>java.rmi.Remote</tt>. I've left the methods public here in case you
 * come up with a cunning way to use RMICompiler within another program. The
 * usual way to use this class is to invoke
 * <tt>ninja.rmi.compiler.NinjaRMIC</tt> which is a <tt>main</tt> front-end
 * to it.
 */
public class RMICompiler {
	Class cl;
	ClassDecomposer cldc;
	int mods;
	String stubname, skelname;
	// is produced like this:
	// stubname = class_shortname + "__RMIStub";
	// this.skelname = class_shortname + "__RMISkel";
	Vector allmethods, allintfs;
	// all intintfs: contains all interface of current class, and it is
	// distilled from it
	String class_shortname = null, packagename = null;
	// class_shortName contains the name of the class that is remote( should be
	// registered)
	// package name contains the name of the package and is distilled from class
	// name in RMI compiler
	private long hashval = 0;

	/**
	 * Create an RMICompiler for the given class.
	 */
	RMICompiler(String classname) throws IllegalArgumentException,
			ClassNotFoundException {
		StringTokenizer st = new StringTokenizer(classname, ".");// it
		// separates
		// the
		// classes names and produces related interfaces
		boolean first = true;
		while (st.hasMoreTokens()) {// separating package name and put calls
			// name in class_short name variable
			String t = st.nextToken();
			if (st.hasMoreTokens()) {
				if (!first) {
					packagename = packagename + "." + t;
				} else {
					packagename = t;
					first = false;
				}
			} else {
				class_shortname = t;
			}
		}

		// XXX mdw: This causes the static initializers for the class to be
		// executed; would like to load the classfile by hand and get its list
		// of interfaces.
		cl = Class.forName(classname);// producing class with the recieved
		// name
		allmethods = new Vector();
		allintfs = new Vector();

		Class intfs[] = cl.getInterfaces();// get class interfaces
		int i;
		boolean somefound = false;// to check whether one of the interfaces is
									// Remote
		for (i = 0; i < intfs.length; i++) {
			Class theints[] = intfs[i].getInterfaces();// methods and other
														// interfaces of this
														// interface is used
			boolean found = false;// for checking whether it extends
									// java.rmi.Remote
			if (theints != null) {
				int j;
				for (j = 0; j < theints.length; j++) {
					if (theints[j].getName().equals("java.rmi.Remote")) {
						found = true;
						break;
					}
				}
			}
			if (found) {
				// This interface extends Remote
				allintfs.addElement(intfs[i]);
				somefound = true;// means one of the interfaces were Remote
				ClassDecomposer decomp = new ClassDecomposer(intfs[i]);
				MethodDecomposer md;
				while ((md = decomp.getNextMethod()) != null) {
					int methmods = md.getMethod().getModifiers();
					if (!Modifier.isPublic(methmods))
						continue;

					// OK, do we already have a matching method identifier?
					int k;
					boolean methodfound = false;
					for (k = 0; k < allmethods.size(); k++) {
						if (methodsEqual(((MethodDecomposer) allmethods
								.elementAt(k)), md))
							methodfound = true;
					}
					if (!methodfound)
						allmethods.addElement(md);
				}
			}
		}
		if (!somefound)
			throw new IllegalArgumentException(
					"Class "
							+ classname
							+ " does not implement any interfaces which extend java.rmi.Remote.");

		this.stubname = class_shortname + "__RMIStub";
		this.skelname = class_shortname + "__RMISkel";
	}

	/**
	 * Returns the name of the generated stub class.
	 */
	public String getStubname() {
		return stubname;
	}

	/**
	 * Returns the name of the generated skeleton class.
	 */
	public String getSkelname() {
		return skelname;
	}

	/**
	 * Returns the name of the package which the class used by RMICompiler is
	 * in.
	 */
	public String getPackagename() {
		return packagename;
	}

	/**
	 * Returns the name of the class, without the package prefix, used by the
	 * RMICompiler.
	 */
	public String getClassShortname() {
		return class_shortname;
	}

	// Stub methods ************************************************************

	/**
	 * Writes the Java sourcecode for the generated stub to the given
	 * PrintWriter.
	 */
	public void writeStubOutput(PrintWriter os) throws IllegalArgumentException {
		writeStubHeader(os);
		writeStubClassDesc(os);
		writeStubMethods(os);
		writeStubClosing(os);
	}

	/**
	 * Writes the Header (who generated it, and package) for the generated stub
	 * to given PrintWriter.
	 */
	private void writeStubHeader(PrintWriter os) {
		os
				.println("/* Generated by RMICompiler.jc (mdw@cs.berkeley.edu) -- do not edit */");
		if (packagename != null) {
			os.println("\npackage " + packagename + ";");
		}
        os.println ("import ninja.rmi.NinjaObjectOutputStream;\n" +
                "import ninja.rmi.NinjaObjectInputStream;\n" +
                "import ninja.Domain.DataOutputStream;\n" +
                "import ninja.Domain.Serializable;\n" +
                "import ninja.Domain.DataInputStream;\n" +
                "import peer2me.domain.Hashtable;\n" +
                "import ninja.Domain.ServerRequestEntity;"+
                "import peer2me.framework.FrameworkFrontEnd;") ;
    }

	/**
	 * Writes the Java class name, interfaces, hashvalue (for differentiating
	 * the class (while name is stubname) ,constructor for the generated stub to
	 * the given PrintWriter.
	 */
	private void writeStubClassDesc(PrintWriter os) {
		os.print("public class " + stubname
				+ " extends ninja.rmi.NinjaRemoteStub implements ");
		int i;
		for (i = 0; i < allintfs.size(); i++) {
			os.print(((Class) allintfs.elementAt(i)).getName());
			if (i != allintfs.size() - 1) {
				os.print(", ");
			}
		}
		os.println(" {");
     //   os.println ("Thread mainThread;");

        os.println("  private static long _hash = " + genHashval()
				+ "L;\n");
		os.println ("boolean wake;\n");
		os.println( "public "+stubname+"(){}");
		os.println("  public " + stubname + "(ninja.rmi.NinjaRemoteRef ref) {");
		os.println("    super(ref);");
		os.println("  }");
        os. println ("  public void remoteReferenceSet (ninja.rmi.NinjaRemoteRef ref){\n" +
                "       setRemoteReference(ref) ;\n" +
                "    }");
        os.println ("   public void writeObject(DataOutputStream dos) {\n" +
                "       dos.writeLong(_hash);\n" +
                "       super.writeObject(dos);\n" +
                "     }\n" +
                "    public Serializable readObject(DataInputStream dis) {\n" +
                "        _hash = dis.readLong();\n" +
                "        super.readObject(dis);\n" +
                "        return this;  //To change body of implemented methods use File | Settings | File Templates.\n" +
                "    }");
        
    }

	/**
	 * Writes the Java stubmethods for the generated stub to the given
	 * PrintWriter.
	 */
	private void writeStubMethods(PrintWriter os)
			throws IllegalArgumentException {

		MethodDecomposer md;

		os.println("");
		os.println("  // Generated methods begin here\n");

		int methodnum;
		int i;

		for (methodnum = 0; methodnum < allmethods.size(); methodnum++) {
			md = (MethodDecomposer) allmethods.elementAt(methodnum);// method
																	// decomposer
																	// object

			Method m = md.getMethod();// get current method
			int methmods = m.getModifiers();
			if (!Modifier.isPublic(methmods))
				continue;

			// Check that method throws RemoteException
			if (!throwsRemoteException(m))
				throw new IllegalArgumentException("Method " + m.getName()
						+ " must throw Exception.");

			TypeDecomposer td = new TypeDecomposer(m.getReturnType());
			os.print("  public synchronized " + td.toString() + " "
					+ m.getName());
			os.println(md.getParamsDesc() + md.getThrowsDesc() + " {");

			ParameterDecomposer params[] = md.getParams();// put parameters of
															// method in it

			// Body

			os.println("    int _opnum = " + methodnum + ";");
			os // use ninjaRmoteCall for do the job
					.println("    ninja.rmi.NinjaRemoteCall _remcall = _ref.newCall(_opnum, _hash);");

			if (params != null) {
				// Method has arguments
				os.println("    try {");// use objectOut to write (do
										// marshaling)
				os
						.println("      NinjaObjectOutputStream _objout = _remcall.getOutputStream();");
				for (i = 0; i < params.length; i++) {
					os.println("      _objout."
							+ objoutwrite(params[i].getType()) + "("
							+ params[i].getName() + ");");
				}
				os.println ( " _objout.flush();");
				os.println("    } catch (Exception _e) {");
				os
			//			.println("      throw new java.rmi.MarshalException(\"Error marshaling arguments\", _e);");
						.println (" _e.printStackTrace(); ");
				os.println("    }");
			}

			os.println("    try {" +
                    //    "      mainThread=Thread.currentThread();\n" +
                    //    "      mainThread.wait();\n");
					"wake = false;\n"+
				     "while (!wake)  {}\n");
			os.println("      _ref.invoke(_remcall);");
			// os.println(" } catch (java.rmi.AlreadyBoundException _e) {");
			// os.println(" throw _e;");
		//	os.println("    } catch (RemoteException _e) {");
		//	os.println("      throw _e;");
		//	os.println("    } catch (java.lang.Exception _e) {");
			os.println ("} catch (Exception e) {");
			os
			//		.println("      throw new java.rmi.UnexpectedException(\"Unexpected RMI exception\", _e);");
					.println("      e.printStackTrace();");
			os.println("    }\n");

			if (!m.getReturnType().getName().equals("void")) {// Method has
																// return
				td = new TypeDecomposer(m.getReturnType());
				os.println("    " + td.toString() + " _result;");// define
																	// return
																	// value
				os.println("    try {\n" );
				os
						.println("      NinjaObjectInputStream _in = _remcall.getInputStream();");

				os.println("      _result = (" + td.toString() + ")_in." // td
																			// is
																			// required
																			// type
																			// for
																			// casting
						+ objinread(m.getReturnType()));
				os.println("    } catch (Exception _e) {");
				os
				//		.println("      throw new java.rmi.UnmarshalException(\"Error unmarshaling return\", _e);");
						.println (" _e.printStackTrace(); ");
				if (!m.getReturnType().isPrimitive()) {
					os
							.println("    } catch (java.lang.ClassNotFoundException _e) {");
					os
						//	.println("      throw new java.rmi.UnmarshalException(\"Return value class not found\", _e);");
							.println (" _e.printStackTrace(); ");
				}
				os.println("    } catch (java.lang.Exception _e) {");
				os
					//	.println("      throw new java.rmi.UnexpectedException(\"Unexpected RMI exception\", _e);");
					.println("      _e.printStackTrace();");
				os.println("    } finally {");
				os.println("      _ref.done(_remcall);");
				os.println("    }");
				os.println("    return _result;");
			} else {
				// No return value
				os.println("    _ref.done(_remcall);");
				os.println("    return;");
			}
			os.println("  }\n");
		}
	}

	/**
	 * Writes the Java stubClosing for the generated stub to the given
	 * PrintWriter.
	 */
	private void writeStubClosing(PrintWriter os) {
		os.println("  // End of generated code");
        os.println("public void notifyAboutException(String location, Exception exception) {}\n" +
                "\n" +
                "    public void notifyAboutFoundNode(String nodeAddress, String remoteNodeName) {}\n" +
                "\n" +
                "    public void notifyAboutReceivedTextPackage(String senderName, String textMessage) {\n" +
                "        DataInputStream.flush(new ServerRequestEntity(textMessage,((FrameworkFrontEnd)f).participatingNodeAddress),null);\n" +
             //   "        mainThread.notify();\n" +
				" wake = true;\n"+
                "    }\n" +
                "\n" +
                "    public void notifyAboutReceivedFilePackage(String senderName, String filePath) {}\n" +
                "\n" +
                "    public void notifyAboutParticipants(Hashtable participants) {\n" +
             //   "         this.participants = participants;\n" +
                "    }")  ;
        os.println("}");
	}

	// Skeleton methods *******************************************************

	/**
	 * Writes the Java sourcecode for the generated skeleton to the given
	 * PrintWriter.
	 */
	public void writeSkelOutput(PrintWriter os) throws IllegalArgumentException {
		writeSkelHeader(os);
		writeSkelClassDesc(os);
		writeSkelMethods(os);
		writeSkelClosing(os);
	}

    public void writereflectionOutput(RemoteObject theremote,PrintWriter os) throws IllegalArgumentException, ClassNotFoundException {
		os.println (getRemoteClass(theremote)) ;
        os.println (findConstructor()) ;
    }

    /**
	 * Writes the Java header(who generated this), package for the generated
	 * skeleton to the given PrintWriter.
	 */
	private void writeSkelHeader(PrintWriter os) {
		os
				.println("/* Generated by RMICompiler.jc (mdw@cs.berkeley.edu) -- do not edit */");
		if (packagename != null) {
			os.println("\npackage " + packagename + ";");
		}
        os.println("import ninja.rmi.NinjaRemoteCall;\n" +
                "import ninja.rmi.NinjaObjectInputStream;\n" +
                "import ninja.rmi.NinjaObjectOutputStream;\n" +
                "import ninja.Domain.RemoteObject;\n";
    }

	/**
	 * Writes the Java class name(without any interfaces except ninjaskeleton, ,
	 * _hash (to differentiate the name sklname from others) for the generated
	 * skeleton to the given PrintWriter.
	 */
	private void writeSkelClassDesc(PrintWriter os) {
		os.println("public class " + skelname
				+ " implements ninja.rmi.NinjaSkeleton {");
		os
				.println("  private static final long _hash = " + genHashval()
						+ "L;");
	}

	private void writeSkelMethods(PrintWriter os)
			throws IllegalArgumentException {

		os.println("");
		os.println("  // Generated methods begin here\n");

		os
				.println("  public void dispatch(RemoteObject obj, ninja.rmi.NinjaRemoteCall remcall, int opnum, long hash) throws Exception {");
		os // check whether class hash of stub is related to the hash of this
			// skeleton
				.println("    if (hash != _hash) throw new Exception(\"Skeleton hashvalue mismatch\");");
		// set real object of this class by casting Remote obj
		if (packagename != null) { // if it has package use it in code
			os.println("    " + packagename + "." + class_shortname
					+ " _realobj = (" + packagename + "." + class_shortname
					+ ")obj;");
		} else {
			os.println("    " + class_shortname + " _realobj = ("
					+ class_shortname + ")obj;");
		}

		os.println("    switch (opnum) {\n");

		int methodnum;
		MethodDecomposer md;

		for (methodnum = 0; methodnum < allmethods.size(); methodnum++) {
			md = (MethodDecomposer) allmethods.elementAt(methodnum);

			Method m = md.getMethod();
			int methmods = m.getModifiers();
			if (!Modifier.isPublic(methmods))
				continue;

			if (!throwsRemoteException(m))
				throw new IllegalArgumentException("Method " + m.getName()
						+ " of interface must throw Exception.");

			os.println("    case " + methodnum + ": {  // " + m.getName());

			int i;
			ParameterDecomposer params[] = md.getParams();
			if (params != null) {
				// Method has arguments
				for (i = 0; i < params.length; i++) {// define parameter of
														// this method.
					os.println("      " + params[i].getTypeName() + " "
							+ params[i].getName() + ";");
				}
			//	os.println("      try {");
				os
						.println("        NinjaObjectInputStream _in = remcall.getInputStream();");
				for (i = 0; i < params.length; i++) {
					// (unmarshalling)read, cast and put in appropriate
					// parameter.
					os.println("        " + params[i].getName() + " = ("
							+ params[i].getTypeName() + ")_in."
							+ objinread(params[i].getType()));
				}
			//	os.println("      } catch (java.io.IOException _e) {");
			//	os
			//			.println("        throw new java.rmi.UnmarshalException(\"Error unmarshaling arguments\", _e);");
			//	os.println("      } finally {");
			//	os.println("        remcall.releaseInputStream();");
			//	os.println("      }");
			} else {
				// No arguments
				os.println("      remcall.releaseInputStream();");
			}

			// Issue the call
			if (!m.getReturnType().getName().equals("void")) { // Method has
																// return value
				TypeDecomposer td = new TypeDecomposer(m.getReturnType());
				os.print("      " + td.toString() + " _result = _realobj."
						+ m.getName() + "(");
			} else {
				// Method has no return value
				os.print("      _realobj." + m.getName() + "(");
			}

			if (params != null) {// put parameters in the parameter of method
									// to be called
				for (i = 0; i < params.length; i++) {
					os.print(params[i].getName());
					if (i != params.length - 1)
						os.print(", ");
				}
			}
			os.println(");");

		//	os.println("      try {");
			if (!m.getReturnType().getName().equals("void")) {
				os
						.println("        NinjaObjectOutputStream _out = remcall.getResultStream(true);");
				os.println("        _out." + objoutwrite(m.getReturnType())
						+ "(_result);");
			} else {
				os.println("        remcall.getResultStream(true);");
			}
	//		os.println("      } catch (java.io.IOException _e) {");
	//		os
	//				.println("        throw new java.rmi.MarshalException(\"Error marshaling return value\", _e);");
	//		os.println("      }");
			os.println("      break;");
			os.println("    }\n");
		}

		os.println("    default: {");
		os
				.println("      throw new Excpetion(\"Method number \"+opnum+\" out of range\");");
		os.println("    }\n");

		os.println("    }");
		os.println("  }\n");

	}

	/**
	 * Writes the Java skelClosing for the generated skeleton to the given
	 * PrintWriter.
	 */
	private void writeSkelClosing(PrintWriter os) {
		os.println("  // End of generated code");
        os.println("}");

    }

	// Check that method throws RemoteException
	private boolean throwsRemoteException(Method m) {
		Class ex[] = m.getExceptionTypes();
		int i;
		boolean found = false;
		for (i = 0; i < ex.length; i++) {// check all exception to see
											// whether it throws RemoteException
			if (ex[i].getName().equals("Exception")) {
				found = true;
				break;
			}
		}
		return found;
	}

	// Return true if methods have same name and signature
	private boolean methodsEqual(MethodDecomposer m1, MethodDecomposer m2) {
		return m1.equals(m2);
	}

	// Given a class, determine the appropriate method of ObjectInput to
	// call to read it
	private String objinread(Class type) {
		if (!type.isPrimitive())
			return "readObject(Class.forname(+"+ type.getName() + " ).newInstance());";
		if (type.isAssignableFrom(Boolean.TYPE))
			return "readBoolean();";
		if (type.isAssignableFrom(Byte.TYPE))
			return "readByte();";
		if (type.isAssignableFrom(Character.TYPE))
			return "readChar();";
		if (type.isAssignableFrom(Double.TYPE))
			return "readDouble();";
		if (type.isAssignableFrom(Float.TYPE))
			return "readFloat();";
		if (type.isAssignableFrom(Integer.TYPE))
			return "readInt();";
		if (type.isAssignableFrom(Long.TYPE))
			return "readLong();";
		if (type.isAssignableFrom(Short.TYPE))
			return "readShort();";

		else
			return "readObject(Class.forname(+"+ type.getName() + " ).newInstance());"; // XXX mdw probably not the right thing
	}

	// Given a class, determine the appropriate method of ObjectOutput to
	// call to write it
	private String objoutwrite(Class type) {
		if (!type.isPrimitive())
			return "writeObject";

		if (type.isAssignableFrom(Boolean.TYPE))
			return "writeBoolean";
		if (type.isAssignableFrom(Byte.TYPE))
			return "writeByte";
		if (type.isAssignableFrom(Character.TYPE))
			return "writeChar";
		if (type.isAssignableFrom(Double.TYPE))
			return "writeDouble";
		if (type.isAssignableFrom(Float.TYPE))
			return "writeFloat";
		if (type.isAssignableFrom(Integer.TYPE))
			return "writeInt";
		if (type.isAssignableFrom(Long.TYPE))
			return "writeLong";
		if (type.isAssignableFrom(Short.TYPE))
			return "writeShort";

		else
			return "writeObject()"; // XXX mdw probably not the right thing
	}

	private long genHashval() {
		if (hashval != 0)
			return hashval;
		MessageDigest sha;
		try {
			sha = MessageDigest.getInstance("SHA");
		} catch (NoSuchAlgorithmException e) {
			System.out
					.println("RMICompiler: Warning: No SHA MessageDigest algorithm found (using bogus hashvalue).");
			return 0x42;
		}
		if (packagename != null)
			sha.update(packagename.getBytes());
		sha.update(class_shortname.getBytes());

		int methodnum;
		MethodDecomposer md;

		for (methodnum = 0; methodnum < allmethods.size(); methodnum++) {
			md = (MethodDecomposer) allmethods.elementAt(methodnum);
			Method m = md.getMethod();
			sha.update(m.getName().getBytes());
			TypeDecomposer td = new TypeDecomposer(m.getReturnType());
			sha.update(td.toString().getBytes());
			sha.update(md.getParamsDesc().getBytes());
			sha.update(md.getThrowsDesc().getBytes());
		}

		byte hashbytes[] = sha.digest();
		long hashlong = 0;
		int i;
		for (i = 0; i < 8; i++) {
			hashlong = hashlong | (hashbytes[i] & 0xff);
			hashlong <<= 8;
		}
		hashval = hashlong;
		return hashlong;
	}
    private String getRemoteClass(RemoteObject theremote)
			throws ClassNotFoundException {
		Class theclass;
		for (theclass = theremote.getClass(); theclass != null; theclass = theclass
				.getSuperclass()) {
			if (classExtendsRemote(theclass))
				return theclass.getName();
		}
		throw new ClassNotFoundException("ninja.Domain.RemoteObject");
	}

	// Recursively check all interfaces for this class to see if they
	// extend java.rmi.Remote
    private boolean classExtendsRemote(Class theclass)
			throws ClassNotFoundException {
		Class remClass = Class.forName("ninja.Domain.RemoteObject");
		Class interfaces[] = theclass.getInterfaces();
		int i;
		for (i = 0; i < interfaces.length; i++) {
			if (interfaces[i].equals(remClass))
				return true;
			if (classExtendsRemote(interfaces[i]))
				return true;
		}
		return false;
	}

    private boolean  findConstructor() throws ClassNotFoundException {
        int c;
		Class stubclass = Class.forName(stubname);
		Constructor constarr[] = stubclass.getConstructors();
		for (c = 0; (c < constarr.length); c++) {
			Class paramarr[] = constarr[c].getParameterTypes();
			if ((paramarr.length == 1)
					&& (paramarr[0].getName()
							.equals("ninja.rmi.NinjaRemoteRef"))) {
        					Object inargs[] = new Object[1];
				inargs[0] = (ninja.rmi.NinjaRemoteRef) clientRef;
				stub = (NinjaRemoteStub) constarr[c].newInstance(inargs);
				return true;
			}
		}
        return false;
    }
}
