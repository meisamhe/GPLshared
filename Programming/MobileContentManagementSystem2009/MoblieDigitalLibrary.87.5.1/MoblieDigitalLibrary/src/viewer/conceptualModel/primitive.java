/**
 *                                      In the name of Allah
 *                                       The best will come
 */

package viewer.conceptualModel;

import entities.BreakLine;
import entities.Image;
import entities.PrimitiveData;
import entities.Text;
import util.Direction;
import util.StringTokenizer;

import javax.microedition.lcdui.Canvas;
import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Graphics;
import java.io.IOException;
import java.util.Vector;

public class primitive extends Canvas {

    private Vector data;
    private Vector primitiveDataInLineIndeces;
    private int dataIndex;
    private int interDataIndex;
    private Direction direction;
    private int cursorX;
    private int cursorY;
    private int fontMaxHeightInLine;
    private int bgColor;
    Vector strVector;
    private int clipX;
    private int clipY;
    private int clipWidth;
    private int clipHeight;
    int ofset = 0;

    public primitive(int clipX, int clipY, int clipWidth, int clipHeight) {
        this();
        this.clipX = clipX;
        this.clipY = clipY;
        this.clipWidth = clipWidth;
        this.clipHeight = clipHeight;

    }

    public primitive(Vector data, int clipY, int clipX, int clipHeight, int clipWidth) {
        this();
        this.data = data;
        this.clipY = clipY;
        this.clipX = clipX;
        this.clipHeight = clipHeight;
        this.clipWidth = clipWidth;
    }

    public primitive(Vector data) {
        this();
        this.data = data;
    }

    public primitive() {
        primitiveDataInLineIndeces = new Vector();
        dataIndex = 0;
        interDataIndex = 0;
        direction = Direction.RIGHT;
        bgColor = 0xffffff;
        clipX = -1;
        cursorX = clipX + clipWidth;
        cursorY = 0;


    }

    public void appendData(PrimitiveData primitiveData) {
        data.addElement(primitiveData);
    }

    public void removeFirstData() {
        data.removeElementAt(0);
    }


    private boolean isInClip(int cursorX, int width) {
        if (direction == Direction.RIGHT)
            return cursorX - width > clipX;
        if (direction == Direction.LEFT)
            return cursorX + width <= clipX + clipWidth;
        else
            return false;
    }

    public Vector createPrimitiveDataInLineIndeces(Graphics graphics, Vector data) {
        Vector buffer = new Vector();
        int cursorX = resetCursorX(), cursorY = 0;
        int maxHeight = -1;
        Vector dummy = new Vector();

        for (int cnt = dataIndex; cnt < data.size(); cnt++) {
            PrimitiveData primitiveData = (PrimitiveData) data.elementAt(cnt);
            if (primitiveData instanceof Text) {
                String sentence = ((Text) primitiveData).getContent();
                int start = 0;
                StringTokenizer tokenizer = new StringTokenizer(sentence, " \t");
                int end = start;

                for (; tokenizer.hasMoreTokens();) {
                    String word = tokenizer.nextToken();
                    int wordWidth = graphics.getFont().stringWidth(word);
                    int wordHeght = graphics.getFont().getHeight();

                    if (isInClip(cursorX, wordWidth)) {
                        cursorX = updataCursorX(cursorX, wordWidth);
                        maxHeight = Math.max(maxHeight, wordHeght);
                        end++;
                    } else {
                        cursorX = resetCursorX();
                        cursorY += maxHeight;   ///??????????
                        dummy.addElement(new TextDataDiscriptor(start, end, (Text) primitiveData));
                        buffer.addElement(new LineDiscriptor(maxHeight, dummy));
                        dummy = new Vector();
                        maxHeight = -1;
                        start = end;
                        if (isInClip(cursorX, wordWidth)) {
                            cursorX = updataCursorX(cursorX, wordWidth);
                            maxHeight = Math.max(maxHeight, wordHeght);
                            end++;
                        } else {
                            //Todo: Think about huge Text!
                        }
                    }

                }
                if (start != end) {
                    dummy.addElement(new TextDataDiscriptor(start, end, (Text) primitiveData));

                }

            } else if (primitiveData instanceof Image) {
                try {
                    Image pData = (Image) primitiveData;
                    javax.microedition.lcdui.Image viewableImage = javax.microedition.lcdui.Image.createImage(pData.getPath());
                    if (isInClip(cursorX, viewableImage.getWidth())) {
                        dummy.addElement(new ImageDataDiscriptor(pData, viewableImage));
                        cursorX = updataCursorX(cursorX, viewableImage.getWidth());
                        maxHeight = Math.max(maxHeight, viewableImage.getHeight());
                    } else {
                        cursorX = resetCursorX();
                        cursorY += maxHeight;
                        buffer.addElement(new LineDiscriptor(maxHeight, dummy));
                        dummy = new Vector();
                        maxHeight = -1;
                        if (isInClip(cursorX, viewableImage.getWidth())) {
                            dummy.addElement(new ImageDataDiscriptor(pData, viewableImage));
                            cursorX = updataCursorX(cursorX, viewableImage.getWidth());
                            maxHeight = Math.max(maxHeight, viewableImage.getHeight());
                        } else {
                            //Todo: Think about huge images!
                        }
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }


        return buffer;
    }

    private int updataCursorX(int cursorX, int width) {
        return cursorX + (direction != Direction.LEFT ? direction != Direction.RIGHT ? -1 : -width : width);
    }

    private int resetCursorX() {
        return direction == Direction.LEFT ? 0 : direction == Direction.RIGHT ? clipWidth : -1;
    }


    protected void paint(Graphics graphics) {
        if (clipX == -1) {
            clipX = graphics.getClipX();
            clipY = graphics.getClipY();
            clipWidth = graphics.getClipWidth();
            clipHeight = graphics.getClipHeight();
        }
        Vector buffer = createPrimitiveDataInLineIndeces(graphics, data);
        graphics.setColor(bgColor);
        graphics.fillRect(clipX, clipY, clipWidth, clipHeight);
        graphics.setColor(0);
        try {
            for (int cnt = 0; cnt < buffer.size(); cnt++) {
                LineDiscriptor lineDiscriptor = (LineDiscriptor) buffer.elementAt(cnt);
                for (int i = 0; i < lineDiscriptor.getData().size(); i++) {
                    Object o = lineDiscriptor.getData().elementAt(i);
                    if (o instanceof TextDataDiscriptor) {
                        Text textData = ((TextDataDiscriptor) o).getText();
                        StringTokenizer tokenizer = new StringTokenizer(textData.getContent(), " \t");
                        for (int j = 0; j < ((TextDataDiscriptor) o).getEnd(); j++) {
                            String word = tokenizer.nextToken();
                            drawWord(graphics, word);
                            if (tokenizer.hasMoreTokens())
                                drawWord(graphics, " ");
                        }
                    } else if (o instanceof ImageDataDiscriptor) {
                        Image imageData = ((ImageDataDiscriptor) o).getImage();
                        drawImage(graphics, javax.microedition.lcdui.Image.createImage(imageData.getPath()));
                    } else if (o instanceof BreakLine) ;
                }
            }
        }
        catch (IOException e) {
            e.printStackTrace();
        }
    }

    private boolean isInClip(int width) {
        if (direction == Direction.RIGHT)
            return cursorX - width > clipX;
        if (direction == Direction.LEFT)
            return cursorX + width <= clipX + clipWidth;
        else
            return false;
    }

    private void gotoNextLine(Graphics graphics) {
        cursorY += fontMaxHeightInLine;
        fontMaxHeightInLine = -1;
        cursorX = direction != Direction.LEFT ? direction != Direction.RIGHT ? -1 : clipX + clipWidth : clipX;

    }

    private void updateCursorX(int wordWidth) {
        cursorX += direction != Direction.LEFT ? direction != Direction.RIGHT ? -1 : -wordWidth : wordWidth;
    }

    private int getPosition() {
        if (direction == Direction.RIGHT)
            return Graphics.RIGHT | Graphics.TOP;
        else if (direction == Direction.LEFT)
            return Graphics.LEFT | Graphics.TOP;
        else
            return -1;


    }

    private void drawWord(Graphics graphics, String data) {
        int wordWidth = graphics.getFont().stringWidth(data);
        if (!isInClip(wordWidth)) {
            gotoNextLine(graphics);

        }
        if (isInClip(wordWidth)) {
            graphics.drawString(data, cursorX, cursorY, getPosition());
            fontMaxHeightInLine = Math.max(fontMaxHeightInLine, graphics.getFont().getHeight());
            updateCursorX(wordWidth);
        } else {
            //Todo check for long words!
        }
    }

    public void drawSentence(Graphics graphics, String sentence) {
        for (StringTokenizer tokenizer = new StringTokenizer(sentence, " \t"); tokenizer.hasMoreTokens();) {
            drawWord(graphics, tokenizer.nextToken());
            if (tokenizer.hasMoreTokens())
                drawWord(graphics, " ");
        }

    }

    private void drawImage(Graphics graphics, javax.microedition.lcdui.Image image) {
        if (isInClip(image.getWidth())) {
            graphics.drawImage(image, cursorX, cursorY, getPosition());
            fontMaxHeightInLine = Math.max(fontMaxHeightInLine, image.getHeight());
            updateCursorX(image.getWidth());
        } else {
            gotoNextLine(graphics);
            if (isInClip(image.getWidth())) {
                graphics.drawImage(image, cursorX, cursorY, getPosition());
                fontMaxHeightInLine = Math.max(fontMaxHeightInLine, image.getHeight());
                updateCursorX(image.getWidth());
            }
        }
    }

    protected void keyRepeated(int keyCode) {
        int action = getGameAction(keyCode);
        switch (action) {
            case Canvas.LEFT:
            case Canvas.RIGHT:
            case Canvas.UP:
                keyPressed(keyCode);
                break;
            case Canvas.DOWN:
                keyPressed(keyCode);
                break;
            default:
                break;
        }
    }

    protected void keyPressed(int keyCode) {

        // Protect the data from changing during painting.

        int action = getGameAction(keyCode);

        switch (action) {

            case Canvas.DOWN:
                ofset -= 10;

                cursorY = ofset;
                cursorX = resetCursorX();
                repaint();

                break;
            case Canvas.UP:
                ofset += 10;
                cursorY = ofset;
                cursorX = resetCursorX();

                repaint();
                break;

            default:
                return;
        }
    }

    public void commandAction(Command command, Displayable displayable) {
        //To change body of implemented methods use File | Settings | File Templates.
    }
}
