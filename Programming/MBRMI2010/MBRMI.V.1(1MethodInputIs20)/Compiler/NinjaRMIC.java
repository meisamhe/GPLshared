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

package ninja.rmi.compiler;

import java.io.*;

/**
 * NinjaRMIC is a front-end to RMICompiler, the Ninja RMI stub compiler. It's
 * meant to be run from the commandline as:
 * 
 * <pre>
 *    java ninja.rmi.compiler.NinjaRMIC [options] [classname]
 * </pre>
 * 
 * <p>
 * The NinjaRMIC options are:
 * 
 * <pre>
 * -d dir     Specifies the directory where compiled code should be placed.
 * -dstub dir Specifies the directory for compiled stubs.
 * -dskel dir Specifies the directory for compiled skeletons.
 * -classpath path Use this classpath for code compilation.
 * -keepgenerated  Retain the generated .java sourcefiles.
 * -g  Enable debugging support in the generated code.
 * </pre>
 * 
 * <p>
 * The <tt>classname</tt> passed into NinjaRMIC is the name of a class which
 * must implement one (or more) interfaces which extend <tt>java.rmi.Remote</tt>.
 * The idea here is that a <em>single</em> stub/skeleton class pair is
 * generated for each RMI service implementation - the stub/skeleton pair in
 * turn implements each of the service's <tt>Remote</tt> interfaces, and can
 * be cast between them.
 */
public class NinjaRMIC {

	public static void main(String args[]) {

		String stubname = null;
		String skelname = null;

		int i;
		boolean ignorenext = false;
		boolean debugon = false;
		boolean keepgenerated = false;
		String dir = null, stubdir = null, skeldir = null, classpath = null;
		String stubsrc = null, skelsrc = null,reflectionsrc=null;
		String cname = null;
		RMICompiler rmic = null;

		for (i = 0; i < args.length; i++) {
			if (!ignorenext) {
				if (args[i].equals("-d")) {
					dir = args[i + 1];
					ignorenext = true;
				} else if (args[i].equals("-g")) {
					debugon = true;
				} else if (args[i].equals("-dstub")) {
					stubdir = args[i + 1];
					ignorenext = true;
				} else if (args[i].equals("-dskel")) {
					skeldir = args[i + 1];
					ignorenext = true;
				} else if (args[i].equals("-classpath")) {
					classpath = args[i + 1];
					ignorenext = true;
				} else if (args[i].equals("-keepgenerated")) {
					keepgenerated = true;
				} else if (args[i].startsWith("-")) {
					System.out.println("ninjarmic: Unknown option: " + args[i]);
					System.exit(-1);
				} else {
					cname = args[i];
				} // XXX mdw - only one class right now

			} else {
				ignorenext = false;
			}
		}
		//Meisam
		cname="TheServiceImpl";
		// Do setup, create directories etc.
		try {
			rmic = new RMICompiler(cname);

			stubname = rmic.getStubname();
			skelname = rmic.getSkelname();

			if ((stubdir == null) && (dir != null))
				stubdir = dir;
			if ((skeldir == null) && (dir != null))
				skeldir = dir;

			// OK, now we need to create directories for the package path
			String pkg = rmic.getPackagename();
			if (pkg != null) {
				pkg = pkg.replace('.', '/');

				if (stubdir != null)
					stubdir = stubdir + "/" + pkg;
				if (skeldir != null)
					skeldir = skeldir + "/" + pkg;
			}
			if (stubdir != null) {
				File d = new File(stubdir);
				d.mkdirs();
			}
			if (skeldir != null) {
				File d = new File(skeldir);
				d.mkdirs();
			}

			if (stubdir != null)
				stubsrc = stubdir + "/" + stubname + ".java";
			else
				stubsrc = stubname + ".java";
			if (skeldir != null){
				skelsrc = skeldir + "/" + skelname + ".java";
                reflectionsrc=skeldir+"/reflection.txt";
            } else
				skelsrc = skelname + ".java";

		} catch (ClassNotFoundException e1) {
			System.out
					.println("NinjaRMIC: Class not found: " + e1.getMessage());
			System.exit(-1);

		} catch (Exception e) {
			System.out.println("NinjaRMIC: Got exception during setup: ");
			e.printStackTrace();
			System.out
					.println("\nContact mdw@cs.berkeley.edu about this bug!\n");
			System.exit(-1);
		}

		// Generate the code
		try {

			PrintWriter pw = new PrintWriter(new FileOutputStream(stubsrc));
			rmic.writeStubOutput(pw);
			pw.flush();
			pw.close();

			pw = new PrintWriter(new FileOutputStream(skelsrc));
			rmic.writeSkelOutput(pw);
			pw.flush();
			pw.close();
            // by meisam created and commented : writing writeReflectionOutput into the file reflection.txt
//            pw = new PrintWriter(new FileOutputStream(reflectionsrc));
//			rmic.writeReflectionOutput(Class.forName(cname),pw);
//			pw.flush();
//			pw.close();

        } catch (Exception e) {
			System.out.println("NinjaRMIC: Got exception generating code: "
					+ e.getMessage());
			e.printStackTrace();
			System.out
					.println("\nContact mdw@cs.berkeley.edu about this bug!\n");
			System.exit(-1);
		}

		try {
			// Compile the stub
			Runtime r = Runtime.getRuntime();
			Process p1 = r.exec("javac " + stubsrc);
			int retval = p1.waitFor();
			if (retval != 0) {
				System.out.println("NinjaRMIC: Got errors compiling " + stubsrc
						+ ":");
				InputStream is = p1.getErrorStream();
				int c;
				while ((c = is.read()) != -1)
					System.out.write(c);
				System.out
						.println("\nContact mdw@cs.berkeley.edu about this bug!\n");
				System.exit(-1);
			}
		} catch (Exception e) {
			System.out.println("NinjaRMIC: Got exception compiling " + stubsrc
					+ ":" + e.getMessage());
			e.printStackTrace();
			System.out
					.println("\nContact mdw@cs.berkeley.edu about this bug!\n");
			System.exit(-1);
		}

		try {
			// Compile the skel
			Runtime r = Runtime.getRuntime();
			Process p1 = r.exec("javac " + skelsrc);
			int retval = p1.waitFor();
			if (retval != 0) {
				System.out.println("NinjaRMIC: Got errors compiling " + skelsrc
						+ ":");
				InputStream is = p1.getErrorStream();
				int c;
				while ((c = is.read()) != -1)
					System.out.write(c);
				System.out
						.println("\nContact mdw@cs.berkeley.edu about this bug!\n");
				System.exit(-1);
			}
		} catch (Exception e) {
			System.out.println("NinjaRMIC: Got exception compiling " + skelsrc
					+ ":" + e.getMessage());
			e.printStackTrace();
			System.out
					.println("\nContact mdw@cs.berkeley.edu about this bug!\n");
			System.exit(-1);
		}

		// Delete the source files
		if (!keepgenerated) {
			try {
				File f = new File(stubsrc);
				f.delete();
				f = new File(skelsrc);
				f.delete();
			} catch (Exception e) {
				System.out
						.println("NinjaRMIC: Got exception removing temporary files.");
				e.printStackTrace();
				System.out
						.println("\nContact mdw@cs.berkeley.edu about this bug!\n");
				System.exit(-1);
			}
		}

	}
}
