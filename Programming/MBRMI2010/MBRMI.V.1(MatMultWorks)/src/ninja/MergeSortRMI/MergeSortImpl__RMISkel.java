/* Generated by RMICompiler.jc (mdw@cs.berkeley.edu) -- do not edit */

package ninja.MergeSortRMI;
import ninja.rmi.NinjaRemoteCall;
import ninja.rmi.NinjaObjectInputStream;
import ninja.rmi.NinjaObjectOutputStream;
import ninja.Domain.RemoteObject;

public class MergeSortImpl__RMISkel extends ninja.rmi.NinjaSkeleton {
  private static final long _hash = -6836606131178751744L;

  // Generated methods begin here

  public void dispatch(RemoteObject obj, ninja.rmi.NinjaRemoteCall remcall, int opnum, long hash) throws Exception {
    if (hash != _hash) throw new Exception("Skeleton hashvalue mismatch");
    ninja.MergeSortRMI.MergeSortImpl _realobj = (ninja.MergeSortRMI.MergeSortImpl)obj;
    switch (opnum) {

    case 0: {  // mergesort
      ninja.MatrixMultiplicationRMI.SerializableVector param0;
        NinjaObjectInputStream _in = remcall.getInputStream();
        param0 = (ninja.MatrixMultiplicationRMI.SerializableVector)_in.readObject((ninja.Domain.Serializable)Class.forName("ninja.MatrixMultiplicationRMI.SerializableVector" ).newInstance());
      ninja.MatrixMultiplicationRMI.SerializableVector _result = _realobj.mergesort(param0);
        NinjaObjectOutputStream _out = remcall.getResultStream(true);
        _out.writeObject(_result);
      break;
    }

    default: {
      throw new Exception("Method number "+opnum+" out of range");
    }

    }
  }

  // End of generated code
}
