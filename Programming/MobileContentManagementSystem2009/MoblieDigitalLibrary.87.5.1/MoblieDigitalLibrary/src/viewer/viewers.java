/**
 *                                      In the name of Allah
 *                                       The best will come
 */

package viewer;

import util.Direction;

import javax.microedition.lcdui.Canvas;
import javax.microedition.lcdui.Graphics;
import java.util.Vector;

public abstract class viewers extends Canvas {

    protected int cursorX;
    protected int cursorY;
    protected int bgColor;
    protected int clipX = -1;
    protected int clipY;
    protected int clipWidth;
    protected int clipHeight;
    protected Direction direction;

    protected viewers(int clipX, int clipY, int clipWidth, int clipHeight) {
        this.clipX = clipX;
        this.clipY = clipY;
        this.clipWidth = clipWidth;
        this.clipHeight = clipHeight;
        bgColor = 0xFFFFFF;
    }

    protected void resetCursorX() {
        cursorX = direction == Direction.LEFT ? clipX : direction == Direction.RIGHT ? clipX + clipWidth : -1;
    }

    protected boolean isInClip(int width) {
        if (direction == Direction.RIGHT)
            return cursorX - width > clipX;
        if (direction == Direction.LEFT)
            return cursorX + width <= clipX + clipWidth;
        else
            return false;
    }

    protected int getPosition() {
        if (direction == Direction.RIGHT)
            return Graphics.RIGHT | Graphics.TOP;
        else if (direction == Direction.LEFT)
            return Graphics.LEFT | Graphics.TOP;
        else
            return -1;


    }

    protected void drawImage(Graphics graphics, javax.microedition.lcdui.Image image) {
        graphics.drawImage(image, cursorX, cursorY + ((graphics.getFont().getHeight() - image.getHeight()) / 2), getPosition());
        updateCursorX(image.getWidth());
    }

    protected void updateCursorX(int wordWidth) {
        cursorX += direction != Direction.LEFT ? direction != Direction.RIGHT ? -1 : -wordWidth : wordWidth;
    }

    protected abstract void gotoNextLine(Graphics graphics);
}