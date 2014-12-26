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
 * A MethodDecomposer helps to generate code for methods within a class.
 */
public class MethodDecomposer {
	Member m;
	ParameterDecomposer params[];

	/**
	 * Create a new MethodDecomposer from the given Member (which must be a
	 * Constructor or a Method).
	 */
	public MethodDecomposer(Member member) {
		m = member;
		Class pt[] = null;

		if ((m instanceof Method) || (m instanceof Constructor)) {
			if (m instanceof Method) {
				pt = ((Method) m).getParameterTypes();
			} else if (m instanceof Constructor) {
				pt = ((Constructor) m).getParameterTypes();
			}
			params = new ParameterDecomposer[pt.length];

			int i;
			for (i = 0; i < pt.length; i++) {
				params[i] = new ParameterDecomposer(pt[i], "param" + i);
			}
		} else {
			params = null;
		}
	}

	/**
	 * Return the Constructor associated with this MethodDecomposer, if the
	 * method is a constructor. Else, returns null.
	 */
	public Constructor getConstructor() {
		if (m instanceof Constructor)
			return (Constructor) m;
		else
			return null;
	}

	/**
	 * Return the Method associated with this MethodDecomposer, unless the
	 * method is a constructor, in which case null is returned.
	 */
	public Method getMethod() {
		if (m instanceof Method)
			return (Method) m;
		else
			return null;
	}

	/**
	 * Return an array of ParameterDecomposers for the parameters of this
	 * method.
	 */
	public ParameterDecomposer[] getParams() {
		return params;
	}

	/**
	 * Return a string describing the method: The method's modifiers (<tt>public</tt>,
	 * <tt>protected</tt>, etc.), the return type of the method, and the name
	 * of the method.
	 */
	public String getMethodDesc() {
		String s = Modifier.toString(m.getModifiers());
		if (m instanceof Method) {
			TypeDecomposer td = new TypeDecomposer(((Method) m).getReturnType());
			s = s + " " + td.getName();
		}

		s = s + " " + m.getName();
		return s;
	}

	/**
	 * Return a parenthesized string representing the parameters to this method.
	 * Each parameter is comma-separated and includes both the parameter's type
	 * and a name for the parameter (which is automatically generated).
	 */
	public String getParamsDesc() {
		String s = "(";
		if (params != null) {
			int i;
			for (i = 0; i < params.length; i++) {
				s = s + params[i].getTypeName() + " " + params[i].getName();
				if (i != params.length - 1) {
					s = s + ", ";
				}
			}
		}
		s = s + ")";
		return s;
	}

	/**
	 * Return the string <tt>throws</tt> followed by the list of exceptions
	 * thrown by this method.
	 */
	public String getThrowsDesc() {
		String s = "";
		if ((m instanceof Method) || (m instanceof Constructor)) {

			Class ex[] = null;
			if (m instanceof Method) {
				ex = ((Method) m).getExceptionTypes();
			} else if (m instanceof Constructor) {
				ex = ((Constructor) m).getExceptionTypes();
			}

			if (ex.length != 0) {
				int i;
				s = s + " throws ";
				for (i = 0; i < ex.length; i++) {
					if (i != ex.length - 1) {
						s = s + ex[i].getName() + ", ";
					} else {
						s = s + ex[i].getName();
					}
				}
			}
		}
		return s;
	}

	/**
	 * Return the method descriptor, followed by the parameters and the throws
	 * clause.
	 */
	public String toString() {
		String s = getMethodDesc() + getParamsDesc() + getThrowsDesc();
		return s;
	}

	/**
	 * Returns true if two MethodDecomposers refer to methods with the same
	 * name, modifiers, return type, and parameter types.
	 */
	public boolean equals(MethodDecomposer md) {
		boolean con = false; // Is this a Constructor or Method?

		if (this.getMethod() == null) {
			con = true;
			if (md.getMethod() != null)
				return false;
		} else {
			if (md.getMethod() == null)
				return false;
		}

		if (con) {

			// Constructor
			if (md.getConstructor().getModifiers() != ((Constructor) m)
					.getModifiers())
				return false;
			if (!md.getConstructor().getName().equals(
					((Constructor) m).getName()))
				return false;
			if (!md.getThrowsDesc().equals(this.getThrowsDesc()))
				return false;

		} else {

			// Method
			if (md.getMethod().getModifiers() != ((Method) m).getModifiers())
				return false;
			if (!md.getMethod().getName().equals(((Method) m).getName()))
				return false;
			if (!md.getThrowsDesc().equals(this.getThrowsDesc()))
				return false;
			if (!md.getMethod().getReturnType().toString().equals(
					((Method) m).getReturnType().toString()))
				return false;

		}

		int n1, n2;
		n1 = md.getParams().length;
		n2 = this.getParams().length;
		if (n1 != n2)
			return false;

		int i;
		for (i = 0; i < n1; i++) {
			if (!md.getParams()[i].getTypeName().equals(
					this.getParams()[i].getTypeName()))
				return false;
		}

		return true;
	}

}
