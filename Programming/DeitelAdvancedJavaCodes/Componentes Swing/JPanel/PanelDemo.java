// Fig. 13.27: PanelDemo.java
// Using a JPanel to help lay out components.
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class PanelDemo extends JFrame {
   private JPanel buttonPanel;
   private JButton buttons[];

   // set up GUI
   public PanelDemo()
   {
      super( "Panel Demo" );

      // get content pane
      Container container = getContentPane();

      // create buttons array
      buttons = new JButton[ 5 ];

      // set up panel and set its layout
      buttonPanel = new JPanel();
      buttonPanel.setLayout( new GridLayout( 1, buttons.length ) );

      // create and add buttons
      for ( int count = 0; count < buttons.length; count++ ) {
         buttons[ count ] = new JButton( "Button " + ( count + 1 ) );
         buttonPanel.add( buttons[ count ] );
      }

      container.add( buttonPanel, BorderLayout.SOUTH );

      setSize( 425, 150 );
      setVisible( true );

   } // end constructor PanelDemo

   public static void main( String args[] )
   {
      PanelDemo application = new PanelDemo();
      application.setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE );
   }

} // end class PanelDemo


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
