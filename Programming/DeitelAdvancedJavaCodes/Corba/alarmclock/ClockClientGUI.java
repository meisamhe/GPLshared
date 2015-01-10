// GUI used by the AlarmClockClient.

// Java core packages
import java.awt.*;
import java.awt.event.*;

// Java extension packages
import javax.swing.*;

public class ClockClientGUI extends JFrame {
   private JLabel outputLabel;

   // set up GUI
   public ClockClientGUI()
   {
      super( "Clock GUI" );

      outputLabel =  new JLabel(  "The alarm has not gone off..." );
      getContentPane().add( outputLabel, BorderLayout.NORTH );

      setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE );
      setResizable( false );
      Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
      setSize( new Dimension( 450, 100 ) );
      setLocation( (screenSize.width - 450)/2, (screenSize.height - 100)/2 );
   }

   // set label's text
   public void setText( String message )
   {
      outputLabel.setText( message );
   }

} // end of class ClockClientGUI

