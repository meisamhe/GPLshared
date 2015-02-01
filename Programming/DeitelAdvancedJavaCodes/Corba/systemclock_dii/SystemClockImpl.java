// File: SystemClockImpl.java
// SystemClock service implementation

import dii.*;

// OMG CORBA packages
import org.omg.CORBA.ORB;
import org.omg.CosNaming.*;
import org.omg.CosNaming.NamingContextPackage.*;

public class SystemClockImpl extends _SystemClockImplBase {
    
    // return computer's current time in milliseconds
    public long currentTimeMillis()
    {
        return System.currentTimeMillis();
    }
    
    // initialize SystemClockImpl object by calling method register
    public SystemClockImpl( String [] params ) throws Exception
    {
        register( "TimeServer", params );
    }
    
    // Register SystemClockImpl object with the Naming Service
    private void register( String corbaName, String [] params )
       throws org.omg.CORBA.ORBPackage.InvalidName,
          org.omg.CosNaming.NamingContextPackage.InvalidName,
          CannotProceed, NotFound
    {
       // Check the name of the service.  If the name is null or blank
       // do not attempt to bind to the Naming service
       if ( (corbaName == null) || (corbaName.trim().length() == 0) )
          throw new IllegalArgumentException(
             "Registration name cannot be null or blank." );
        
       // Create and initialize the ORB
       ORB orb = ORB.init( params, null );
            
       // Register this object with ORB
       orb.connect( this );

       // Find Naming Service
       org.omg.CORBA.Object corbaObject = orb.resolve_initial_references( "NameService" );
       NamingContext naming = NamingContextHelper.narrow( corbaObject );

       // create NameComponent array with path information to
       // find this object.
       NameComponent namingComponent =
          new NameComponent( corbaName, "" );
       NameComponent path[] = { namingComponent };

       // bind SystemClockImpl object with ORB
       naming.rebind( path, this );
       System.out.println( "Rebind complete" );
   }
    
   public static void main( String[] args ) throws Exception
   {
      // Create the SystemClock CORBA object.
      SystemClock timeServer =   new SystemClockImpl( args );
 
      // Wait for requests from the outside.
      java.lang.Object sync = new java.lang.Object();
      
      // keep server alive
      synchronized(sync) {
         sync.wait();
      }
   }
}   // end of class SystemClockImpl
