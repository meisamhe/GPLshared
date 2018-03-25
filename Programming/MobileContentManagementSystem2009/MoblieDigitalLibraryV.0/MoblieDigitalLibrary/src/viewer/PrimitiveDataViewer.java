/**
 *                                      In the name of Allah
 *                                       The best will come
 */

package viewer;

import entities.BreakLine;
import entities.Image;
import entities.PrimitiveData;
import entities.Text;

import java.io.IOException;
import java.util.Vector;
import javax.microedition.lcdui.*;
import javax.microedition.midlet.MIDletStateChangeException;

import util.Direction;
import util.StringTokenizer;

public class PrimitiveDataViewer extends Canvas implements CommandListener {

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
    int ofset=0;

    static final Command backCommand = new Command("Back", Command.BACK, 0);
   

    public PrimitiveDataViewer(int clipX, int clipY, int clipWidth, int clipHeight) {
        this();
        this.clipX = clipX;
        this.clipY = clipY;
        this.clipWidth = clipWidth;
        this.clipHeight = clipHeight;

        addCommand(backCommand);
        setCommandListener(this);
    }

    public PrimitiveDataViewer(Vector data, int clipY, int clipX, int clipHeight, int clipWidth) {
        this();
        this.data = data;
        this.clipY = clipY;
        this.clipX = clipX;
        this.clipHeight = clipHeight;
        this.clipWidth = clipWidth;

        addCommand(backCommand);
        setCommandListener(this);
    }

    public PrimitiveDataViewer(Vector data) {
        this();
        this.data = data;

        addCommand(backCommand);
        setCommandListener(this);
    }

    public PrimitiveDataViewer() {
        primitiveDataInLineIndeces = new Vector();
        dataIndex = 0;
        interDataIndex = 0;
        direction = Direction.RIGHT;
        bgColor = 0xffffff;
        clipX = -1;
        cursorX = clipX + clipWidth;
        cursorY = 0;

        addCommand(backCommand);
        setCommandListener(this);
    }

    public void appendData(PrimitiveData primitiveData) {
        data.addElement(primitiveData);
    }

    public void removeFirstData() {
        data.removeElementAt(0);
    }

    protected void paint(Graphics graphics) {
        if (clipX == -1) {
            clipX = graphics.getClipX();
            clipY = graphics.getClipY();
            clipWidth = graphics.getClipWidth();
            clipHeight = graphics.getClipHeight();
        }
        cursorY=ofset;
        graphics.setColor(bgColor);
        graphics.fillRect(clipX, clipY, clipWidth, clipHeight);
        graphics.setColor(0);
        try {
            for (int cnt = dataIndex;  clipHeight > cursorY && cnt < data.size(); cnt++) {
                PrimitiveData primitiveData = (PrimitiveData) data.elementAt(cnt);
                if (primitiveData instanceof Text)
                {   drawSentence(graphics, ((Text) primitiveData).getContent());

                }
                else if (primitiveData instanceof Image)
                    drawImage(graphics, javax.microedition.lcdui.Image.createImage(((Image) primitiveData).getPath()));
                else if (!(primitiveData instanceof BreakLine)) ;
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
        if (!isInClip(wordWidth))
            gotoNextLine(graphics);
        if (isInClip(wordWidth)) {
            graphics.drawString(data, cursorX, cursorY, getPosition());
            fontMaxHeightInLine = Math.max(fontMaxHeightInLine, graphics.getFont().getHeight());
            updateCursorX(wordWidth);
        }
        else {
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
                    repaint();

                       break;
            case Canvas.UP:
                ofset+=10;
                repaint();
                break;
                        // case 0: // Ignore keycode that don't map to actions.
            default:
                return;
            }
        }
    public void commandAction(Command command, Displayable displayable) {
        String label = command.getLabel();

        if (label.equals("Back")) {
            
        }
    }
    
}
