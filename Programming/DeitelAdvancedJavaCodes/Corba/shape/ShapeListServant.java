import org.omg.CosNaming.*;
import org.omg.CORBA.*;
import org.omg.PortableServer.POA;

class ShapeListServant extends ShapeListPOA 
{
    private Shape theList[];
    private int version;
    private static int n=0;

    POA theRootpoa;
    
    public ShapeListServant(POA rootpoa){
    	theList = new Shape[100];
        version = 0;
        theRootpoa = rootpoa;
    }
        
        // don't need connect (so use POA instead)
  	public Shape newShape(GraphicalObject g) throws ShapeListPackage.FullException {
  	    version++;
  	    Shape s = null;
       	ShapeServant shapeRef = new ShapeServant( g, version);
 
       	try {
       		org.omg.CORBA.Object ref = theRootpoa.servant_to_reference(shapeRef);
        	s = ShapeHelper.narrow(ref);
        } catch (Exception e) {
            System.err.println("ERROR: " + e);
            e.printStackTrace(System.out);
        }
     	if(n >=100) throw new ShapeListPackage.FullException();
    	theList[n++] = s;
        return s;
    }

   public  Shape[] allShapes(){
        return theList;
    }

    public int getVersion() {
        return version;
    }
}
