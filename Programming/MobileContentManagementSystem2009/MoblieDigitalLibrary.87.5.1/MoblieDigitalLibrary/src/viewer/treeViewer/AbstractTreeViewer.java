/**
 *                                      In the name of Allah
 *                                       The best will come
 */


package viewer.treeViewer;

import util.Direction;
import util.StringTokenizer;
import viewer.viewers;

import javax.microedition.lcdui.Canvas;
import javax.microedition.lcdui.Graphics;
import java.io.IOException;
import java.util.Vector;

public abstract class AbstractTreeViewer extends viewers {

    private javax.microedition.lcdui.Image arrow;
    protected Vector treeNodesView;
    private int startIndex;
    private int selectedIndex;
    private int fontHeight;

    public AbstractTreeViewer(Object data, int clipY, int clipX, int clipHeight, int clipWidth, Direction direction) throws IOException {
        super(clipX, clipY, clipWidth, clipHeight);

        this.arrow = javax.microedition.lcdui.Image.createImage("/images/arrow.jpg");
        this.startIndex = 0;
        this.selectedIndex = 0;
        this.fontHeight = 0;
        this.treeNodesView = new Vector();
        this.direction = direction;
        prepareTree(data, 0);
    }

    protected abstract void prepareTree(Object root, int tab);

    protected void paint(Graphics graphics) {
        if (clipX == -1) {
            clipX = graphics.getClipX();
            clipY = graphics.getClipY();
            clipWidth = graphics.getClipWidth();
            clipHeight = graphics.getClipHeight();
            fontHeight = graphics.getFont().getHeight();
        }

        cursorY = 0;
        resetCursorX();
        graphics.setColor(bgColor);
        graphics.fillRect(clipX, clipY, clipWidth, clipHeight);
        graphics.setColor(0);
        for (int cnt = startIndex; cnt < treeNodesView.size() && cursorY < clipY + clipHeight; cnt++) {
            if (cnt == selectedIndex)
                drawImage(graphics, arrow);
            resetCursorX();
            updateCursorX(arrow.getWidth() + 2);
            drawSentence(graphics, ((TreeViewNode) treeNodesView.elementAt(cnt)).getTitle(), ((TreeViewNode) treeNodesView.elementAt(cnt)).getTab());
            gotoNextLine(graphics);
        }
    }

    protected void gotoNextLine(Graphics graphics) {
        cursorY += fontHeight;
        resetCursorX();
    }

    private void drawTab(Graphics graphics, int tab) {
        updateCursorX(graphics.getFont().stringWidth(" ") * tab * 3);
    }

    private void drawWord(Graphics graphics, String data, int tab) {
        int wordWidth = graphics.getFont().stringWidth(data);
        if (!isInClip(wordWidth)) {
            gotoNextLine(graphics);
            drawTab(graphics, tab);
        }
        if (isInClip(wordWidth)) {
            graphics.drawString(data, cursorX, cursorY, getPosition());
            updateCursorX(wordWidth);
        } else {
            //Todo check for long words!
        }
    }

    public void drawSentence(Graphics graphics, String sentence, int tab) {
        drawTab(graphics, tab);
        for (StringTokenizer tokenizer = new StringTokenizer(sentence, " \t"); tokenizer.hasMoreTokens();) {
            drawWord(graphics, tokenizer.nextToken(), tab);
            if (tokenizer.hasMoreTokens())
                drawWord(graphics, " ", tab);
        }

    }


    protected void keyRepeated(int keyCode) {
        int action = getGameAction(keyCode);
        switch (action) {
            case Canvas.LEFT:
            case Canvas.RIGHT:
            case Canvas.UP:
            case Canvas.DOWN:
                keyPressed(keyCode);
                break;
            default:
                break;
        }
    }

    protected void keyPressed(int keyCode) {

        int action = getGameAction(keyCode);

        switch (action) {
            case Canvas.DOWN:
                selectedIndex += selectedIndex != treeNodesView.size() - 1 ? 1 : 0;
                if (clipY + clipHeight < (selectedIndex - startIndex + 2) * fontHeight )
                    startIndex++;
                repaint();
                break;
            case Canvas.UP:
                selectedIndex -= selectedIndex != 0 ? 1 : 0;
                if (selectedIndex == startIndex - 1)
                    startIndex--;
                repaint();
                break;
        }
    }

    protected class TreeViewNode {
        private int tab;
        private String title;
        private Object data;

        public TreeViewNode(int tab, String title, Object reference) {
            this.tab = tab;
            this.title = title;
            this.data = reference;
        }

        public int getTab() {
            return tab;
        }

        public void setTab(int tab) {
            this.tab = tab;
        }

        public Object getData() {
            return data;
        }

        public void setData(Object data) {
            this.data = data;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }
    }

}