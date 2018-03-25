/**
 *                                      In the name of Allah
 *                                       The best will come
 */

package viewer;

import entities.Chapter;

import javax.microedition.lcdui.Canvas;

public abstract class ContentViewerMediator {

    protected Chapter chapter;
    protected Canvas viewCanvas;

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
