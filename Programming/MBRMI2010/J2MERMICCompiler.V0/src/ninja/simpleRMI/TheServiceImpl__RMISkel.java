package ninja.simpleRMI;

import ninja.rmi.NinjaRemoteCall;
import ninja.rmi.NinjaObjectInputStream;
import ninja.rmi.NinjaObjectOutputStream;
import ninja.Domain.RemoteObject;


/* Generated by RMICompiler.jc (mdw@cs.berkeley.edu) -- do not edit */
public class TheServiceImpl__RMISkel extends ninja.rmi.NinjaSkeleton {
  private static final long _hash = -255684353965433088L;

  // Generated methods begin here

 public void dispatch(RemoteObject obj, NinjaRemoteCall remcall, int opnum, long hash) throws Exception {
    if (hash != _hash) throw new Exception("Skeleton hashvalue mismatch");
    TheServiceImpl _realobj = (TheServiceImpl)obj;
    switch (opnum) {

    case 0: {  // someFunction
        NinjaObjectInputStream _in = remcall.getInputStream();
//      try {
//
//      } catch (java.io.IOException _e) {
//        throw new UnmarshalException("Error unmarshaling arguments", _e);
//      } finally {
//        remcall.releaseInputStream();
//      }
      _realobj.someFunction();
        remcall.getResultStream(true);
     /* try {

      } catch (java.io.IOException _e) {
        throw new java.rmi.MarshalException("Error marshaling return value", _e);
      }*/
      break;
    }

    case 1: {  // addFunction
      int param0;
      int param1;
       NinjaObjectInputStream _in = remcall.getInputStream();
       param0 = (int)_in.readInt();
       param1 = (int)_in.readInt();
//      try {
//
//      } catch (java.io.IOException _e) {
//        throw new java.rmi.UnmarshalException("Error unmarshaling arguments", _e);
//      } finally {
//        remcall.releaseInputStream();
//      }
      int _result = _realobj.addFunction(param0, param1);
         NinjaObjectOutputStream _out = remcall.getResultStream(true);
        _out.writeInt(_result);
//      try {
//
//      } catch (java.io.IOException _e) {
//        throw new java.rmi.MarshalException("Error marshaling return value", _e);
//      }
      break;
    }

    default: {
      throw new Exception("Method number "+opnum+" out of range");
    }

    }
  }

  // End of generated code

    /*
    * Unmarshals arguments and calls the actual remote method.
*/

    /*
    * Unmarshals arguments and calls the actual remote method.
*/
}