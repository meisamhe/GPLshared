package RegistryClient;

import peer2me.framework.Framework;

import javax.microedition.lcdui.Form;
import java.io.IOException;

/**
 * Created by IntelliJ IDEA.
 * User: Engineer
 * Date: Sep 17, 2009
 * Time: 3:08:02 PM
 * To change this template use File | Settings | File Templates.
 */
class Searcher extends Thread {
    boolean finish = false;

    Framework framework;
    Form currentForm;

    Searcher (Framework framework, Form currentForm){
        this.framework=framework;
        this.currentForm=currentForm;
    }
    public void run() {
        while (!finish){
            try {
                framework.startNodeSearch();//To change body of implemented methods use File | Settings | File Templates.
                sleep(50000) ;
            } catch (IOException e) {
                currentForm.append("Error initiating the framework. Please try again."+ e.getMessage());
            } catch (InterruptedException e) {
                e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
            }
        }
    }
    public void finishThread(){
     this.finish = true;
    }
}
