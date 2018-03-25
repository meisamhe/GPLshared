/**                                 In the name of Allah
 *                                   The best will come
 */

package viewer.conceptualModel;

import java.util.Vector;

public class LineDiscriptor {
  private  int height;

    public LineDiscriptor(int height, Vector data) {
        this.height = height;
        this.data = data;
    }

    private Vector data;
    public Vector getData() {
    return data;
}

    public void setData(Vector data) {
        this.data = data;
    }

    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }


}