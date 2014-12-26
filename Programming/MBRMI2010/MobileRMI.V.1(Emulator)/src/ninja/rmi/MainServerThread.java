package ninja.rmi;

import ninja.Domain.DataInputStream;
import ninja.Domain.ServerRequestEntity;

/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Sep 26, 2009
 * Time: 9:37:21 PM
 * To change this template use File | Settings | File Templates.
 */
public class MainServerThread extends Thread{
    ServerRequestEntity sre;
    Reliable_ServerThread rst;
    public MainServerThread(ServerRequestEntity sre,Reliable_ServerThread rst){
       this.sre=sre;
       this.rst=rst;
    }
    public void run(){
        DataInputStream.flush(sre,rst);
    }
}
