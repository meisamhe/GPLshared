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

import ninja.Domain.Serializable;
import ninja.Domain.DataOutputStream;
import ninja.Domain.DataInputStream;
import ninja.Domain.RemoteObject;
import databaseCore.Entity;
import RegistryClient.RegistryEntity;
//import org.garret.perst.IInputStream;
//import org.garret.perst.IOutputStream;
import peer2me.framework.Framework;
import peer2me.framework.FrameworkListener;
import peer2me.domain.Hashtable;
import peer2me.util.DataInputStreamWrapper;
import peer2me.util.DataOutputStreamWrapper;

import java.io.IOException;

//import java.rmi.UnmarshalException;

/**
 * NinjaRemoteStub is the superclass of client-side 'stub' objects.
 */
public abstract class NinjaRemoteStub extends Serializable implements RemoteObject, FrameworkListener {

	// The remote ref associated with this stub
	protected NinjaRemoteRef _ref;
    public Framework f;
    protected Hashtable participants;
    public String name="";

    public NinjaRemoteStub(){_ref= new NinjaRemoteRef();}

    protected NinjaRemoteStub(NinjaRemoteRef ref) {
		_ref = ref;
	}

	/**
	 * Returns the NinjaRemoteRef contained within the Stub. Made public so that
	 * client-side code can access the ref.
	 */
	public NinjaRemoteRef getNinjaRemoteRef() {
		return _ref;
	}

    public void setRemoteReference (NinjaRemoteRef ref) {
        _ref = ref;
    }

    public void remoteSetReference(NinjaRemoteRef ref){
          this.remoteReferenceSet(ref);
    }

    public abstract void remoteReferenceSet(NinjaRemoteRef ref);

    /**
	 * Used by object serialization
	 */
	public void writeObject(DataOutputStream objout){ //meisam
            //ObjectOutput out)
//			throws java.io.IOException, java.lang.ClassNotFoundException {
//		if (_ref == null) {
//			throw new java.rmi.MarshalException("Invalid stub - _ref is null");
//		} else {
//			out.writeUTF(_ref.getRefClass(out));
//            objout.writeUTF(_ref.getRefClass()) ;
//            _ref.writeExternal(out);
//             _ref.writeExternal();
//        }
        _ref.writeObject(objout) ;
    }    

	/**
	 * Used by object serialization
	 */
	public Serializable readObject(DataInputStream objin )
//            ObjectInput in)//meisam
//			throws java.io.IOException, java.lang.ClassNotFoundException
    {
//		try {
//			Class refClass = Class.forName(in.readUTF());
//            Class refClass = Class.forName(objin.readUTF());
//        try {
//            _ref = (NinjaRemoteRef) refClass.newInstance();
//            _ref.readExternal(in);
          this._ref=(NinjaRemoteRef) _ref.readObject(objin);
          return this;
//        } catch (InstantiationException e) {
//            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
//        } catch (IllegalAccessException e) {
//            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
//        }
//

//        } catch (InstantiationException e) {
//			throw new UnmarshalException(
//					"Unable to instantiate remote reference", e);
//		} catch (IllegalAccessException e) {
//			throw new UnmarshalException(
//					"Illegal access creating remote reference", e);
//		}
//        }

    }

//    public void clone(Entity e,long index)      // this will put all the the attributes and index in the entity e
//    {
//        ((NinjaRemoteStub)e)._ref=_ref;
//        e.setIndex(index);
//        setIndex(index);
//        //To change body of implemented methods use File | Settings | File Templates.
//    }

    public void readObject(DataInputStreamWrapper in) throws IOException      //for persistent this two methods should be implemented it somehow shows the   serializability order
    {
         name = in.readUTF();
        _ref.readObject(in);
        //To change body of implemented methods use File | Settings | File Templates.
    }

    public void writeObject(DataOutputStreamWrapper out) throws IOException {
        //To change body of implemented methods use File | Settings | File Templates.
        if (name =="")
            name = this.getClass().getName();
        out.writeUTF(name);
        _ref.writeObject(out) ;
    }

}
