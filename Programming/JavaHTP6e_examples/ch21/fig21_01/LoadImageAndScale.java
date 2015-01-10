// Fig. 21.1: LoadImageAndScale.java
// Load an image and display it in its original size and twice its 
// original size. Load and display the same image as an ImageIcon.
import java.awt.Graphics;
import java.awt.Image;
import javax.swing.ImageIcon;
import javax.swing.JApplet;

public class LoadImageAndScale extends JApplet 
{
   private Image image1; // create Image object      
   private ImageIcon image2; // create ImageIcon object

   // load image when applet is loaded
   public void init()
   {
      image1 = getImage( getDocumentBase(), "redflowers.png" );
      image2 = new ImageIcon( "yellowflowers.png" );
   } // end method init

   // display image
   public void paint( Graphics g )
   {
      super.paint( g );

      g.drawImage( image1, 0, 0, this ); // draw original image

      // draw image to fit the width and the height less 120 pixels
      g.drawImage( image1, 0, 120, getWidth(), getHeight() - 120, this );

      // draw icon using its paintIcon method
      image2.paintIcon( this, g, 180, 0 );
   } // end method paint
} // end class LoadImageAndScale


/**************************************************************************
 * (C) Copyright 1992-2005 by Deitel & Associates, Inc. and               *
 * Pearson Education, Inc. All Rights Reserved.                           *
 *                                                                        *
 * DISCLAIMER: The authors and publisher of this book have used their     *
 * best efforts in preparing the book. These efforts include the          *
 * development, research, and testing of the theories and programs        *
 * to determine their effectiveness. The authors and publisher make       *
 * no warranty of any kind, expressed or implied, with regard to these    *
 * programs or to the documentation contained in these books. The authors *
 * and publisher shall not be liable in any event for incidental or       *
 * consequential damages in connection with, or arising out of, the       *
 * furnishing, performance, or use of these programs.                     *
 *************************************************************************/
