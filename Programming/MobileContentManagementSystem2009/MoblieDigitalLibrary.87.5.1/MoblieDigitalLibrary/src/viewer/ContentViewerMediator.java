/**
 *                                      In the name of Allah
 *                                       The best will come
 */

package viewer;

import entities.Chapter;

import javax.microedition.lcdui.Canvas;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Command;
import javax.microedition.midlet.MIDlet;
import java.util.Vector;

public abstract class ContentViewerMediator implements CommandListener {

    protected Chapter chapter;
    protected Canvas viewCanvas;
    protected Command command;
    protected static final Command exitCommand = new Command("Exit", Command.STOP, 2);
    protected MIDlet view;

    public ContentViewerMediator() {
    }

    public Canvas getViewCanvas() {
        return viewCanvas;
    }

    public Chapter getChapter() {
        return chapter;
    }

    public void setChapter(Chapter chapter) {
        this.chapter = chapter;
    }

    public abstract Canvas getDefaultPremitiveDataViewer();
}
