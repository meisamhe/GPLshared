/**
 *                                      In the name of Allah
 *                                       The best will come
 */

package viewer;

import entities.ASynchChapter;
import entities.Chapter;
import entities.Text;

import javax.microedition.lcdui.Canvas;
import javax.microedition.lcdui.Graphics;
import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.Displayable;
import javax.microedition.midlet.MIDletStateChangeException;
import java.util.Vector;

public class ASynchContentViewerMediator extends ContentViewerMediator {

    public ASynchContentViewerMediator() {
        //viewCanvas = new ASynchContentViewerCanvas();
        viewCanvas = new PrimitiveDataViewer();
        chapter = (ASynchChapter) createDummyASynchChapter();
        command = new Command("Back", Command.BACK, 0);
    }

    public Canvas getDefaultPremitiveDataViewer() {
        return viewCanvas;
    }

    public void commandAction(Command command, Displayable displayable) {
        String label = command.getLabel();
                

    }

    /////////////////////////////////////////
    private static Chapter createDummyASynchChapter() {
        ASynchChapter retValue = new ASynchChapter();
        retValue.setTitle("Sample1");
        Vector datas = new Vector();
        Text t = new Text();
        t.setContent("This is the first line of test data.");
        datas.addElement(t);

        t = new Text();
        t.setContent("این دومین محتوایی است که در صفحه قرار می‌گیرد و باید نمایش داده شود");
        datas.addElement(t);

        entities.Image image = new entities.Image();
        image.setPath("/images/Sunset1.jpg");
        datas.addElement(image);

        t = new Text();
        t.setContent("And the third segment of text data is longer than first one!.");
        datas.addElement(t);

        image = new entities.Image();
        image.setPath("/images/Sunset2.jpg");
        datas.addElement(image);

        image = new entities.Image();
        image.setPath("/images/Sunset3.jpg");
        datas.addElement(image);

        t = new Text();
        t.setContent("چهارمین محتوا خیلی کوچک است!");
        datas.addElement(t);

        image = new entities.Image();
        image.setPath("/images/Sunset3.jpg");
        datas.addElement(image);

        image = new entities.Image();
        image.setPath("/images/Sunset3.jpg");
        datas.addElement(image);

        image = new entities.Image();
        image.setPath("/images/Sunset3.jpg");
        datas.addElement(image);

        image = new entities.Image();
        image.setPath("/images/Sunset3.jpg");
        datas.addElement(image);

        t = new Text();
        t.setContent("در انتها نیاز بود که داده‌های بسیار طولانی در محیط قرارداده شود تا از این طریق اعمالی از قبیل شکستن متن مورد آزمون واقع شود!");
        datas.addElement(t);


        retValue.setPrimitiveDatas(datas);


        return retValue;
    }
}
