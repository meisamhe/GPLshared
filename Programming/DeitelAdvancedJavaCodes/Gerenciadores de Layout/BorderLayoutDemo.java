// Fig. 12.25: BorderLayoutDemo.java
// Demonstrating BorderLayout.

// Java core packages
import java.awt.*;
import java.awt.event.*;

// Java extension packages
import javax.swing.*;

public class BorderLayoutDemo extends JFrame implements ActionListener {

   private JButton buttons[];
   private String names[] = { "Ocultar Norte", "Ocultar Sul", "Ocultar Leste", 
           "Ocultar Oeste", "Ocultar Centro" };
   private BorderLayout layout;

   /* inicialização e configuração da GUI */
   public BorderLayoutDemo() {
      super( "BorderLayout Demo" );

      layout = new BorderLayout( 5, 5 );

      /* obtem o content pane e altera seu layout */
      Container container = getContentPane();
      container.setLayout( layout );

      /* inicializa o vetor de JButton */
      buttons = new JButton[ names.length ];

      for ( int count = 0; count < names.length; count++ ) {
         buttons[ count ] = new JButton( names[ count ] );
         buttons[ count ].addActionListener( this );
      }

      /* posiciona o botões em um BorderLayout; ordem não é importante */
      container.add( buttons[ 0 ], BorderLayout.NORTH ); 
      container.add( buttons[ 1 ], BorderLayout.SOUTH ); 
      container.add( buttons[ 2 ], BorderLayout.EAST );  
      container.add( buttons[ 3 ], BorderLayout.WEST );  
      container.add( buttons[ 4 ], BorderLayout.CENTER ); 

      setSize( 300, 200 );
      setVisible( true );
   } //construtor

   /* tratamento de eventos */
   public void actionPerformed( ActionEvent event )
   {
      for ( int count = 0; count < buttons.length; count++ )

         if ( event.getSource() == buttons[ count ] )
            buttons[ count ].setVisible( false );
         else
            buttons[ count ].setVisible( true );

      /* reconfigura o content pane */
      layout.layoutContainer( getContentPane() );
   }

   /* programa principal */
   public static void main( String args[] )
   { 
      BorderLayoutDemo application = new BorderLayoutDemo();

      application.setDefaultCloseOperation(
         JFrame.EXIT_ON_CLOSE );
   }

}  // end class BorderLayoutDemo

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
