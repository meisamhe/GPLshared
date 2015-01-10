// Fig. 21.2: LogoAnimatorJPanel.java
// Animation of a series of images.
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.Graphics;
import javax.swing.ImageIcon;
import javax.swing.JPanel;
import javax.swing.Timer;

public class LogoAnimatorJPanel extends JPanel 
{
   private final static String IMAGE_NAME = "deitel"; // base image name
   protected ImageIcon images[]; // array of images
   private final int TOTAL_IMAGES = 30;  // number of images
   private int currentImage = 0; // current image index
   private final int ANIMATION_DELAY = 50; // millisecond delay
   private int width; // image width
   private int height; // image height

   private Timer animationTimer; // Timer drives animation

   // constructor initializes LogoAnimatorJPanel by loading images
   public LogoAnimatorJPanel()
   {
      images = new ImageIcon[ TOTAL_IMAGES ];

      // load 30 images
      for ( int count = 0; count < images.length; count++ )
         images[ count ] = new ImageIcon( getClass().getResource(
            "images/" + IMAGE_NAME + count + ".gif" ) );
 
      // this example assumes all images have the same width and height
      width = images[ 0 ].getIconWidth();   // get icon width
      height = images[ 0 ].getIconHeight(); // get icon height
   } // end LogoAnimatorJPanel constructor

   // display current image 
   public void paintComponent( Graphics g )
   {
      super.paintComponent( g ); // call superclass paintComponent

      images[ currentImage ].paintIcon( this, g, 0, 0 );
      
      // set next image to be drawn only if timer is running
      if ( animationTimer.isRunning() )  
         currentImage = ( currentImage + 1 ) % TOTAL_IMAGES;
   } // end method paintComponent

   // start animation, or restart if window is redisplayed
   public void startAnimation()
   {
      if ( animationTimer == null ) 
      {
         currentImage = 0; // display first image

         // create timer
         animationTimer = 
            new Timer( ANIMATION_DELAY, new TimerHandler() );

         animationTimer.start(); // start timer
      } // end if
      else // animationTimer already exists, restart animation
      {
         if ( ! animationTimer.isRunning() )
            animationTimer.restart();
      } // end else
   } // end method startAnimation

   // stop animation timer
   public void stopAnimation()
   {
      animationTimer.stop();
   } // end method stopAnimation

   // return minimum size of animation
   public Dimension getMinimumSize()
   { 
      return getPreferredSize(); 
   } // end method getMinimumSize

   // return preferred size of animation
   public Dimension getPreferredSize()
   {
      return new Dimension( width, height );
   } // end method getPreferredSize

   // inner class to handle action events from Timer
   private class TimerHandler implements ActionListener 
   {
      // respond to Timer's event
      public void actionPerformed( ActionEvent actionEvent )
      {
         repaint(); // repaint animator
      } // end method actionPerformed
   } // end class TimerHandler
} // end class LogoAnimatorJPanel

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
