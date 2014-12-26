package peer2me.network.bluetooth;



/**
 * This interface has to be implemented by classes that wants to do a
 * Bluetooth service discovery using the BluetoothServiceDiscovery class, 
 * and receive callbacks from this class. In this case, the class 
 * BluetoothNetwork implements this interface.
 * 
 * @author Torbjørn Vatn & Steinar A. Hestnes
 */
public interface BluetoothServiceDiscoveryListener {


	/**
	 * 
	 * What to do when serviceSearch is completed
	 *
	 */
	public void serviceSearchCompleted();
	
		
	/**
	 * What to do when something went wrong during servicediscovery
	 * 
	 */
	public void serviceDiscoveryError();
	
}
