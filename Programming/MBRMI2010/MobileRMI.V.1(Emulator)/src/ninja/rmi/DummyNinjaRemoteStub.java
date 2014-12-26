package ninja.rmi;

import peer2me.domain.Hashtable;

import java.io.IOException;

/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Sep 25, 2009
 * Time: 12:25:32 PM
 * To change this template use File | Settings | File Templates.
 */
public class DummyNinjaRemoteStub extends NinjaRemoteStub{
    public void remoteReferenceSet(NinjaRemoteRef ref) {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    public void notifyAboutException(String location, Exception exception) {
//To change body of implemented methods use File | Settings | File Templates.
    }

    public void notifyAboutFoundNode(String nodeAddress, String remoteNodeName) {
//To change body of implemented methods use File | Settings | File Templates.
    }

    public void notifyAboutReceivedTextPackage(String senderName, String textMessage) throws IOException, ClassNotFoundException, IllegalAccessException, InstantiationException {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    public void notifyAboutReceivedFilePackage(String senderName, String filePath) {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    public void notifyAboutParticipants(Hashtable participants) {
        //To change body of implemented methods use File | Settings | File Templates.
    }
}
