/**
 *                                      In the name of Allah
 *                                       The best will come
 */

import util.Direction;
import viewer.treeViewer.TOCTreeViewer;

import javax.microedition.lcdui.Display;
import javax.microedition.midlet.MIDlet;
import javax.microedition.midlet.MIDletStateChangeException;
import java.io.IOException;

public class TOCViewerTest extends MIDlet {
    protected void startApp() throws MIDletStateChangeException {
        try {
            Display.getDisplay(this).setCurrent(new TOCTreeViewer(TOCTreeViewer.createDummyData().getIndexRoot(), -1, -1, -1, -1, Direction.RIGHT));
        } catch (IOException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }

    }

    protected void pauseApp() {

    }

    protected void destroyApp(boolean b) throws MIDletStateChangeException {

    }
}