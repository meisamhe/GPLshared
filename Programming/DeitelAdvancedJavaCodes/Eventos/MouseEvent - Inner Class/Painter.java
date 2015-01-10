// Fig. 13.19: Painter.java
// Using class MouseMotionAdapter.
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class Painter extends JFrame {
   private int pointCount = 0;

   // array of 1000 java.awt.Point references
   private Point points[] = new Point[ 1000 ];  

   // set up GUI and register mouse event handler
   public Painter()
   {
      super( "A simple paint program" );

      // create a label and place it in SOUTH of BorderLayout
      getContentPane().add( new JLabel( "Drag the mouse to draw" ),
         BorderLayout.SOUTH );

      addMouseMotionListener(

         new MouseMotionAdapter() {  // anonymous inner class

            // store drag coordinates and repaint
            public void mouseDragged( MouseEvent event )
            {
               if ( pointCount < points.length ) {
                  points[ pointCount ] = event.getPoint();
                  ++pointCount;
                  repaint();
               }
            }   
        
         } // end anonymous inner class

      ); // end call to addMouseMotionListener

      setSize( 300, 150 );  
      setVisible( true );  

   } // end Painter constructor

   // draw oval in a 4-by-4 bounding box at specified location on window
   public void paint( Graphics g )
   {
      super.paint( g ); // clears drawing area

      for ( int i = 0; i < points.length && points[ i ] != null; i++ )
         g.fillOval( points[ i ].x, points[ i ].y, 4, 4 );
   }

   public static void main( String args[] )
   {
      Painter application = new Painter();
      application.setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE );
   }

} // end class Painter


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