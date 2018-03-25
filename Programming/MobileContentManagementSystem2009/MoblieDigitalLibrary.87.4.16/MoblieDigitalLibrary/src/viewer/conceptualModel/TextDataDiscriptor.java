/**                                 In the name of Allah
 *                                   The best will come
 */


package viewer.conceptualModel;

import entities.Text;

public class TextDataDiscriptor {
    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getEnd() {
        return end;
    }

    public void setEnd(int end) {
        this.end = end;
    }

    public Text getText() {
        return text;
    }

    public void setText(Text text) {
        this.text = text;
    }

    private int start;
    private int end;
    private Text text;

    public TextDataDiscriptor(int start, int end, Text primitive) {
        this.start = start;
        this.end = end;
        this.text = primitive;
    }
}