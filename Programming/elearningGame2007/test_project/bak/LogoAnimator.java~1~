// Fig. 19.2: LogoAnimator.java
// Animation of a series of images.
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class LogoAnimator extends JPanel implements ActionListener {

   private final static String IMAGE_NAME = "deitel"; // base image name
   protected ImageIcon images[];     // array of images

   private int totalImages = 30;     // number of images
   private int currentImage = 0;     // current image index
   private int animationDelay = 50;  // millisecond delay
   private int width;                // image width
   private int height;               // image height

   private Timer animationTimer; // Timer drives animation

   // initialize LogoAnimator by loading images
   public LogoAnimator()
   {
      images = new ImageIcon[ totalImages ];

      // load images
      for ( int count = 0; count < images.length; ++count )
         images[ count ] = new ImageIcon( getClass().getResource(
            "images/" + IMAGE_NAME + count + ".gif" ) );
 
      // this example assumes all images have the same width and height
      width = images[ 0 ].getIconWidth();   // get icon width
      height = images[ 0 ].getIconHeight(); // get icon height
   }

   // display current image 
   public void paintComponent( Graphics g )
   {
      super.paintComponent( g );

      images[ currentImage ].paintIcon( this, g, 0, 0 );
      
      // move to next image only if timer is running
      if ( animationTimer.isRunning() )  
         currentImage = ( currentImage + 1 ) % totalImages;
   }

   // respond to Timer's event
   public void actionPerformed( ActionEvent actionEvent )
   {
      repaint(); // repaint animator
   }

   // start or restart animation
   public void startAnimation()
   {
      if ( animationTimer == null ) {
         currentImage = 0;  
         animationTimer = new Timer( animationDelay, this );
         animationTimer.start();
      }
      else // continue from last image displayed
         if ( ! animationTimer.isRunning() )
            animationTimer.restart();
   }

   // stop animation timer
   public void stopAnimation()
   {
      animationTimer.stop();
   }

   // return minimum size of animation
   public Dimension getMinimumSize()
   { 
      return getPreferredSize(); 
   }

   // return preferred size of animation
   public Dimension getPreferredSize()
   {
      return new Dimension( width, height );
   }

   // execute animation in a JFrame
   public static void main( String args[] )
   {
      LogoAnimator animation = new LogoAnimator(); // create LogoAnimator

      JFrame window = new JFrame( "Animator test" ); // set up window
      window.setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE );

      Container container = window.getContentPane();
      container.add( animation );

      window.pack();  // make window just large enough for its GUI
      window.setVisible( true );   // display window
      animation.startAnimation();  // begin animation

   } // end method main

} // end class LogoAnimator

/**************************************************************************
 * (C) Copyright 1992-2003 by Deitel & Associates, Inc. and               *
 * Prentice Hall. All Rights Reserved.                                    *
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
