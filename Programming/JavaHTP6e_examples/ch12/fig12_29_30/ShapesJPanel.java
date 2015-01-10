// Fig. 12.29: ShapesJPanel.java
// Demonstrating some Java 2D shapes.
import java.awt.Color;
import java.awt.Graphics;
import java.awt.BasicStroke;
import java.awt.GradientPaint;
import java.awt.TexturePaint;
import java.awt.Rectangle;
import java.awt.Graphics2D;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Rectangle2D;
import java.awt.geom.RoundRectangle2D;
import java.awt.geom.Arc2D;
import java.awt.geom.Line2D;
import java.awt.image.BufferedImage;
import javax.swing.JPanel;

public class ShapesJPanel extends JPanel 
{
   // draw shapes with Java 2D API
   public void paintComponent( Graphics g )
   {
      super.paintComponent( g ); // call superclass's paintComponent

      Graphics2D g2d = ( Graphics2D ) g; // cast g to Graphics2D

      // draw 2D ellipse filled with a blue-yellow gradient
      g2d.setPaint( new GradientPaint( 5, 30, Color.BLUE, 35, 100, 
         Color.YELLOW, true ) );  
      g2d.fill( new Ellipse2D.Double( 5, 30, 65, 100 ) );

      // draw 2D rectangle in red
      g2d.setPaint( Color.RED );                  
      g2d.setStroke( new BasicStroke( 10.0f ) ); 
      g2d.draw( new Rectangle2D.Double( 80, 30, 65, 100 ) );

      // draw 2D rounded rectangle with a buffered background
      BufferedImage buffImage = new BufferedImage( 10, 10, 
         BufferedImage.TYPE_INT_RGB );

      // obtain Graphics2D from bufferImage and draw on it
      Graphics2D gg = buffImage.createGraphics();   
      gg.setColor( Color.YELLOW ); // draw in yellow
      gg.fillRect( 0, 0, 10, 10 ); // draw a filled rectangle
      gg.setColor( Color.BLACK );  // draw in black
      gg.drawRect( 1, 1, 6, 6 ); // draw a rectangle
      gg.setColor( Color.BLUE ); // draw in blue
      gg.fillRect( 1, 1, 3, 3 ); // draw a filled rectangle
      gg.setColor( Color.RED ); // draw in red
      gg.fillRect( 4, 4, 3, 3 ); // draw a filled rectangle

      // paint buffImage onto the JFrame
      g2d.setPaint( new TexturePaint( buffImage, 
         new Rectangle( 10, 10 ) ) );
      g2d.fill(
         new RoundRectangle2D.Double( 155, 30, 75, 100, 50, 50 ) );

      // draw 2D pie-shaped arc in white
      g2d.setPaint( Color.WHITE );
      g2d.setStroke( new BasicStroke( 6.0f ) ); 
      g2d.draw(
         new Arc2D.Double( 240, 30, 75, 100, 0, 270, Arc2D.PIE ) );

      // draw 2D lines in green and yellow
      g2d.setPaint( Color.GREEN );
      g2d.draw( new Line2D.Double( 395, 30, 320, 150 ) );

      // draw 2D line using stroke
      float dashes[] = { 10 }; // specify dash pattern
      g2d.setPaint( Color.YELLOW );    
      g2d.setStroke( new BasicStroke( 4, BasicStroke.CAP_ROUND,
         BasicStroke.JOIN_ROUND, 10, dashes, 0 ) ); 
      g2d.draw( new Line2D.Double( 320, 30, 395, 150 ) );
   } // end method paintComponent
} // end class ShapesJPanel

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
