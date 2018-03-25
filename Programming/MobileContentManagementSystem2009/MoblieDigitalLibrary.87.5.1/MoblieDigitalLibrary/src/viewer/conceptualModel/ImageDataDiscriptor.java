/**                                 In the name of Allah
 *                                   The best will come
 */

package viewer.conceptualModel;

import entities.Image;

public class ImageDataDiscriptor {
    private Image image;
    private javax.microedition.lcdui.Image viewableImage;

    public Image getImage() {
        return image;
    }

    public void setImage(Image image) {
        this.image = image;
    }

    public javax.microedition.lcdui.Image getViewableImage() {
        return viewableImage;
    }

    public void setViewableImage(javax.microedition.lcdui.Image viewableImage) {
        this.viewableImage = viewableImage;
    }

    public ImageDataDiscriptor(Image image, javax.microedition.lcdui.Image viewableImage) {
        this.image = image;
        this.viewableImage = viewableImage;
    }
}