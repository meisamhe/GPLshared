/**
 *                                      In the name of Allah
 *                                       The best will come
 */

package viewer;

import entities.ASynchChapter;

import javax.microedition.lcdui.Canvas;
import javax.microedition.lcdui.Graphics;

public class ASynchContentViewerMediator extends ContentViewerMediator {
    public ASynchContentViewerMediator() {
        viewCanvas = new ASynchContentViewerCanvas();
    }

    public Canvas getDefaultPremitiveDataViewer() {
        return viewCanvas;
    }

    private class ASynchContentViewerCanvas extends Canvas {

        protected void paint(Graphics graphics) {
            java.util.Vector datas = ((ASynchChapter) chapter).getPrimitiveDatas();
        }

        private ASynchContentViewerCanvas() {
            super();
        }

    }
}
