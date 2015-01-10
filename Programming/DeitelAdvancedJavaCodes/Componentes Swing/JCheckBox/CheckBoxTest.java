// Fig. 13.11: CheckBoxTest.java
// Creating JCheckBox buttons.
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class CheckBoxTest extends JFrame {
   private JTextField field;
   private JCheckBox bold, italic;

   // set up GUI
   public CheckBoxTest()
   {
      super( "JCheckBox Test" );

      // get content pane and set its layout
      Container container = getContentPane();
      container.setLayout( new FlowLayout() );

      // set up JTextField and set its font
      field = new JTextField( "Watch the font style change", 20 );
      field.setFont( new Font( "Serif", Font.PLAIN, 14 ) );
      container.add( field );

      // create checkbox objects
      bold = new JCheckBox( "Bold" );
      container.add( bold );     

      italic = new JCheckBox( "Italic" );
      container.add( italic );

      // register listeners for JCheckBoxes
      CheckBoxHandler handler = new CheckBoxHandler();
      bold.addItemListener( handler );
      italic.addItemListener( handler );

      setSize( 275, 100 );
      setVisible( true );

   } // end CheckBoxText constructor

   public static void main( String args[] )
   { 
      CheckBoxTest application = new CheckBoxTest();
      application.setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE );
   }

   // private inner class for ItemListener event handling
   private class CheckBoxHandler implements ItemListener {
      private int valBold = Font.PLAIN;
      private int valItalic = Font.PLAIN;

      // respond to checkbox events
      public void itemStateChanged( ItemEvent event )
      {
         // process bold checkbox events
         if ( event.getSource() == bold )
            valBold = bold.isSelected() ? Font.BOLD : Font.PLAIN;
               
         // process italic checkbox events
         if ( event.getSource() == italic )
            valItalic = italic.isSelected() ? Font.ITALIC : Font.PLAIN;

         // set text field font
         field.setFont( new Font( "Serif", valBold + valItalic, 14 ) );

      } // end method itemStateChanged

   } // end private inner class CheckBoxHandler

} // end class CheckBoxTest

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
