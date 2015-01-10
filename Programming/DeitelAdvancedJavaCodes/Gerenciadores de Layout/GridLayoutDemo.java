// Fig. 12.26: GridLayoutDemo.java
// Demonstrating GridLayout.

// Java core packages
import java.awt.*;
import java.awt.event.*;

// Java extension packages
import javax.swing.*;

public class GridLayoutDemo extends JFrame
   implements ActionListener {

   private JButton buttons[];
   private String names[] = { "one", "two", "three", "four", "five", "six" };
   private boolean toggle = true;
   private Container container;
   private GridLayout grid1, grid2;

   /* configura e inicializa a GUI */
   public GridLayoutDemo()
   {
      super( "GridLayout Demo" );

      /* inicializa o layout */
      grid1 = new GridLayout( 2, 3, 5, 5 );
      grid2 = new GridLayout( 3, 2 );

      /* obtem o content pane and configura seu layout */
      container = getContentPane();
      container.setLayout( grid1 );

      /* cria e adiciona botões */
      buttons = new JButton[ names.length ];

      for ( int count = 0; count < names.length; count++ ) {
         buttons[ count ] = new JButton( names[ count ] );
         buttons[ count ].addActionListener( this );
         container.add( buttons[ count ] );
      }

      setSize( 300, 150 );
      setVisible( true );
   }

   /* trata os eventos */
   public void actionPerformed( ActionEvent event )
   { 
      if ( toggle )
         container.setLayout( grid2 );
      else
         container.setLayout( grid1 );

      toggle = !toggle;   // set toggle to opposite value
      container.validate();
   }

   /* programa principal */
   public static void main( String args[] )
   {
      GridLayoutDemo application = new GridLayoutDemo();

      application.setDefaultCloseOperation(
         JFrame.EXIT_ON_CLOSE );
   } 

}  // end class GridLayoutDemo

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
