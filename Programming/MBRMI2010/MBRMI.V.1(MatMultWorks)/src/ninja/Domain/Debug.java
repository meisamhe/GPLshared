package ninja.Domain;

import peer2me.util.Log;

public class Debug {
    Log log;
    public Debug(){
        log = Log.getInstance();
    }
    public void print(String s) {
        this.log.LogRmiInfo(s);
//		System.out.println(s);
	}
}
