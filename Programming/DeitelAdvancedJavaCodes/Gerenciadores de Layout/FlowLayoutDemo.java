// Fig. 12.24: FlowLayoutDemo.java
// Demonstrating FlowLayout alignments.

// Java core packages
import java.awt.*;
import java.awt.event.*;

// Java extension packages
import javax.swing.*;

public class FlowLayoutDemo extends JFrame {
   private JButton leftButton, centerButton, rightButton;
   private Container container;
   private FlowLayout layout;
   
   /* inicialização e configuração da GUI */
   public FlowLayoutDemo() {
      super( "FlowLayout Demo" );

      layout = new FlowLayout();

      /* obtem o content pane e altera seu layout */
      container = getContentPane();
      container.setLayout( layout );

      // configura o letfButton e registra um listener
      leftButton = new JButton( "Left" );
      container.add( leftButton );

      leftButton.addActionListener(
      // anonymous inner class
         new ActionListener() {
            // process leftButton event  
            public void actionPerformed( ActionEvent event )
            {
               layout.setAlignment( FlowLayout.LEFT );

               // re-align attached components
               layout.layoutContainer( container );
            }
         }  // end anonymous inner class
      ); // end call to addActionListener


      // configura o centerButton e registra um listener
      centerButton = new JButton( "Center" );
      container.add( centerButton );

      centerButton.addActionListener(
         // anonymous inner class
         new ActionListener() {
            // process centerButton event  
            public void actionPerformed( ActionEvent event )
            {
               layout.setAlignment( FlowLayout.CENTER );
               // re-align attached components
               layout.layoutContainer( container );
            }
         }
      );


      // configura o rightButton and registra um listener
      rightButton = new JButton( "Right" );
      container.add( rightButton );

      rightButton.addActionListener(
         // anonymous inner class
         new ActionListener() {
            // process rightButton event  
            public void actionPerformed( ActionEvent event ) {
               layout.setAlignment( FlowLayout.RIGHT );

               // re-align attached components
               layout.layoutContainer( container );
            }
         }
      );


      /* altera o espaço horizontal entre os componentes */
      layout.setHgap(10);
      
      /* altera o espaço vertival entre os componentes */
      layout.setVgap(10);
      
      setSize( 300, 75 );
      setVisible( true );
   } //construtor
  
   /* programa principal */
   public static void main( String args[] ) { 
      FlowLayoutDemo application = new FlowLayoutDemo();

      application.setDefaultCloseOperation(
         JFrame.EXIT_ON_CLOSE );
   }

}  // end class FlowLayoutDemo


/**************************************************************************
 * (C) Copyright 2002 by Deitel & Associates, Inc. and Prentice Hall.     *
 * All Rights Reserved.                                                   *
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
