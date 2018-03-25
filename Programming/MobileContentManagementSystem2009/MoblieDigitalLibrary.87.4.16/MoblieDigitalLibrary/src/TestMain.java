/**
 *                                      In the name of Allah
 *                                       The best will come
 */

import entities.ASynchChapter;
import entities.Chapter;
import entities.Image;
import entities.Text;
import viewer.ASynchContentViewerMediator;
import viewer.conceptualModel.primitive;

import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Displayable;
import javax.microedition.midlet.MIDlet;
import javax.microedition.midlet.MIDletStateChangeException;
import java.util.Vector;

public class TestMain extends MIDlet implements CommandListener  {

  //   private Command levelCommand = new Command("Change Level", Command.SCREEN,24);
        primitive convas;
    private static Chapter createDummyASynchChapter() {
        ASynchChapter retValue = new ASynchChapter();
        retValue.setTitle("Sample1");
        Vector datas = new Vector();
        Text t = new Text();
        t.setContent("This is the first line of DigitalLibrary data.");
        datas.addElement(t);

        t = new Text();
        t.setContent("این دومین محتوایی است که در صفحه قرار می‌گیرد و باید نمایش داده شود");
        datas.addElement(t);

        Image image = new Image();
        image.setPath("/images/Sunset1.jpg");
        datas.addElement(image);

        t = new Text();
        t.setContent("And the third segment of text data is longer than first one!.");
        datas.addElement(t);

        image = new Image();
        image.setPath("/images/Sunset2.jpg");
        datas.addElement(image);

        image = new Image();
        image.setPath("/images/Sunset3.jpg");
        datas.addElement(image);

        t = new Text();
        t.setContent("چهارمین محتوا خیلی کوچک است!");
        datas.addElement(t);

        image = new Image();
        image.setPath("/images/Sunset3.jpg");
        datas.addElement(image);

        image = new Image();
        image.setPath("/images/Sunset3.jpg");
        datas.addElement(image);

        image = new Image();
        image.setPath("/images/Sunset3.jpg");
        datas.addElement(image);

        image = new Image();
        image.setPath("/images/Sunset3.jpg");
        datas.addElement(image);

        t = new Text();
        t.setContent("در انتها نیاز بود که داده‌های بسیار طولانی در محیط قرارداده شود تا از این طریق اعمالی از قبیل شکستن متن مورد آزمون واقع شود!");
        datas.addElement(t);


        retValue.setPrimitiveDatas(datas);


        return retValue;
    }

    protected void startApp() throws MIDletStateChangeException {
        ASynchChapter chapter = (ASynchChapter) createDummyASynchChapter();
        ASynchContentViewerMediator ASCVM = new ASynchContentViewerMediator();
        ASCVM.setChapter(chapter);
              convas  =new primitive(chapter.getPrimitiveDatas());
   
        Display.getDisplay(this).setCurrent(convas);
    }

    protected void pauseApp() {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    protected void destroyApp(boolean b) throws MIDletStateChangeException {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    public void commandAction(Command command, Displayable displayable) {
       

         }

}
