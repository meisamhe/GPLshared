// Fig. 13.4: LabelTest.java
// Demonstrating the JLabel class.
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class LabelTest extends JFrame {
   private JLabel label1, label2, label3;

   // set up GUI
   public LabelTest()
   {
      super( "Testing JLabel" );

      // get content pane and set its layout
      Container container = getContentPane();
      container.setLayout( new FlowLayout() );

      // JLabel constructor with a string argument
      label1 = new JLabel( "Label with text" );
      label1.setToolTipText( "This is label1" );
      container.add( label1 );

      // JLabel constructor with string, Icon and alignment arguments
      Icon bug = new ImageIcon( "bug1.gif" );
      label2 = new JLabel( "Label with text and icon", bug, 
         SwingConstants.LEFT );
      label2.setToolTipText( "This is label2" );
      container.add( label2 );

      // JLabel constructor no arguments
      label3 = new JLabel();
      label3.setText( "Label with icon and text at bottom" );
      label3.setIcon( bug );
      label3.setHorizontalTextPosition( SwingConstants.CENTER );
      label3.setVerticalTextPosition( SwingConstants.BOTTOM );
      label3.setToolTipText( "This is label3" );
      container.add( label3 );

      setSize( 275, 170 );
      setVisible( true );

   } // end constructor

   public static void main( String args[] )
   { 
      LabelTest application = new LabelTest();
      application.setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE );
   }

} // end class LabelTest


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
