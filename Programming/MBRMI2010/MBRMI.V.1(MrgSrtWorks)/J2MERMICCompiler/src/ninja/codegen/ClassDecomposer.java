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
 * The ClassDecomposer is meant to aid the automated generation of Java
 * sourcecode based on other classes. It provides a number of convenience
 * mechanisms (built nicely on top of the Java Reflection interfaces) for
 * generating code.
 * 
 * @see MethodDecomposer, ParameterDecomposer, TypeDecomposer
 */
public class ClassDecomposer {
	private Class cl = null;
	private int modifiers;

	private int curr_method, curr_constructor, num_methods, num_constructors;

	private Method methods[];
	private Constructor constructors[];

	/**
	 * Create a ClassDecomposer for the given class.
	 */
	public ClassDecomposer(Class theclass) {
		cl = theclass;
		modifiers = cl.getModifiers();
	}

	/**
	 * Return a string describing the class's modifiers (e.g.,
	 * <tt>public abstract</tt>).
	 */
	public String getModifierDesc() {
		return Modifier.toString(modifiers);
	}

	/**
	 * Return a string describing the class - the class modifiers, followed by
	 * the word <tt>class</tt> or <tt>interface</tt>, followed by the class
	 * name, an <tt>extends</tt> clause, and an <tt>implements</tt> clause.
	 */
	public String getClassDesc() {
		String s = getModifierDesc();
		if (!cl.isInterface()) {
			s = s + " class";
		}
		s = s + " " + cl.getName();
		s = s + " " + getExtendsDesc();
		s = s + " " + getImplementsDesc();
		return s;
	}

	/**
	 * Return the string <tt>extends</tt> followed by the superclass name of
	 * this class (or a list of superinterfaces, if this is an interface).
	 */
	public String getExtendsDesc() {
		Class sup = cl.getSuperclass();
		if (sup != null) {
			return "extends " + sup.getName();
		} else
			return "";
	}

	/**
	 * Returns the string <tt>implements</tt> followed by the list of
	 * interfaces implemented by this class.
	 */
	public String getImplementsDesc() {
		Class ifs[] = cl.getInterfaces();
		if (ifs.length == 0)
			return "";

		int i;
		String s = "implements ";
		for (i = 0; i < ifs.length; i++) {
			s = s + ifs[i].getName();
			if (i != ifs.length - 1) {
				s = s + ", ";
			}
		}
		return s;
	}

	/**
	 * Return a MethodDecomposer associated with the next constructor in this
	 * class.
	 */
	public MethodDecomposer getNextConstructor() {
		if (constructors == null) {
			curr_constructor = 0;
			constructors = cl.getDeclaredConstructors();
			if (constructors == null) {
				num_constructors = 0;
				return null;
			} else {
				num_constructors = constructors.length;
			}
		}
		if (curr_constructor < num_constructors) {
			Constructor c = constructors[curr_constructor];
			curr_constructor++;
			return new MethodDecomposer(c);
		} else {
			return null;
		}
	}

	/**
	 * Return a MethodDecomposer assosciated with the next method in this class.
	 */
	public MethodDecomposer getNextMethod() {
		if (methods == null) {
			curr_method = 0;
			methods = cl.getDeclaredMethods();
			if (methods == null)
				num_methods = 0;
			else
				num_methods = methods.length;
		}
		if (curr_method < num_methods) {
			Method m = methods[curr_method];
			curr_method++;
			return new MethodDecomposer(m);
		} else {
			return null;
		}
	}

}
