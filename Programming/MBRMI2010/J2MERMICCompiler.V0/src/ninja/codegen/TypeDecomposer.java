// Ninja Codegen, by Matt Welsh (mdw@cs.berkeley.edu)
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

package ninja.codegen;

import java.lang.reflect.*;

/**
 * A convenience class to take a type and return a Java-source-code compatible
 * String describing it. for most classes, this is simple, however, for arrays,
 * a bit of syntax munging must be done.
 */
public class TypeDecomposer {
	Class cl;

	public TypeDecomposer(Class type) {
		cl = type;
	}

	/**
	 * Return the name for this TypeDecomposer's associated type. If the type is
	 * an array, rather than returning something like
	 * <tt>[Ljava/lang/String;</tt>, will return <tt>java.lang.String[]</tt>.
	 */
	public String getName() {
		if (cl.isArray() == false)
			return cl.getName();

		String tname = cl.getComponentType().getName();
		String aname = cl.getName();
		int i, index = 0;

		for (i = 0; i < aname.length(); i++) {
			if (aname.charAt(i) == '[')
				index++;
			else
				break;
		}
		for (i = 0; i < index; i++) {
			tname = tname + "[]";
		}
		return tname;
	}

	/**
	 * Same as getName().
	 */
	public String toString() {
		return this.getName();
	}

	/**
	 * Return the Class associated with this TypeDecomposer.
	 */
	public Class getType() {
		return cl;
	}

}
