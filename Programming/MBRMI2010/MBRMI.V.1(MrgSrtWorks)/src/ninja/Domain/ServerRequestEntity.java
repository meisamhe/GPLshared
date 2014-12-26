package ninja.Domain;

/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Sep 17, 2009
 * Time: 11:44:54 AM
 * To change this template use File | Settings | File Templates.
 */
public class ServerRequestEntity {
    private String reqest;
    private String address;
    public ServerRequestEntity(String request, String address){
        this.reqest=request;
        this.address= address;
    }
    public String getRequest(){
        return this.reqest;
    }

    public String getAddress(){
        return this.address;
    }
}
