// Fig. 13.22: KeyDemo.java
// Demonstrating keystroke events.
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class KeyDemo extends JFrame implements KeyListener {
   private String line1 = "", line2 = "", line3 = "";
   private JTextArea textArea;

   // set up GUI
   public KeyDemo()
   {
      super( "Demonstrating Keystroke Events" );

      // set up JTextArea
      textArea = new JTextArea( 10, 15 );
      textArea.setText( "Press any key on the keyboard..." );
      textArea.setEnabled( false );
      textArea.setDisabledTextColor( Color.BLACK );
      getContentPane().add( textArea );

      addKeyListener( this );  // allow frame to process Key events
      
      setSize( 350, 100 );
      setVisible( true );

   } // end KeyDemo constructor

   // handle press of any key
   public void keyPressed( KeyEvent event )
   {
      line1 = "Key pressed: " + event.getKeyText( event.getKeyCode() );
      setLines2and3( event );
   }

   // handle release of any key
   public void keyReleased( KeyEvent event )
   {
      line1 = "Key released: " + event.getKeyText( event.getKeyCode() );
      setLines2and3( event );
   }

   // handle press of an action key
   public void keyTyped( KeyEvent event )
   {
      line1 = "Key typed: " + event.getKeyChar();
      setLines2and3( event );
   }

   // set second and third lines of output
   private void setLines2and3( KeyEvent event )
   {
      line2 = "This key is " + ( event.isActionKey() ? "" : "not " ) +
         "an action key";

      String temp = event.getKeyModifiersText( event.getModifiers() );

      line3 = "Modifier keys pressed: " + 
         ( temp.equals( "" ) ? "none" : temp );

      textArea.setText( line1 + "\n" + line2 + "\n" + line3 + "\n" );
   }

   public static void main( String args[] )
   {
      KeyDemo application = new KeyDemo();
      application.setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE );
   }

} // end class KeyDemo


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
