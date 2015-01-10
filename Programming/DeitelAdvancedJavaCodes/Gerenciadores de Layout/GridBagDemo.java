// Fig. 13.20: GridBagDemo.java
// Demonstrating GridBagLayout.

// Java core packages
import java.awt.*;
import java.awt.event.*;

// Java extension packages
import javax.swing.*;

public class GridBagDemo extends JFrame { 
   private Container container;
   private GridBagLayout layout;
   private GridBagConstraints constraints; 
    
   /* configura e inicializa a GUI */
   public GridBagDemo() {
      super( "GridBagLayout Demo" );

      /* obtem o container e inicializa o GridBagLayout */
      container = getContentPane();
      layout = new GridBagLayout();
      container.setLayout( layout );   

      /* inicializa as restrições do gridbag */
      constraints = new GridBagConstraints();

      /* cria componentes GUI */
      JTextArea textArea1 = new JTextArea( "TextArea1", 5, 10 );
      JTextArea textArea2 = new JTextArea( "TextArea2", 2, 2 );

      String names[] = { "Iron", "Steel", "Brass" };
      JComboBox comboBox = new JComboBox( names );

      JTextField textField = new JTextField( "TextField" );
      JButton button1 = new JButton( "Button 1" );
      JButton button2 = new JButton( "Button 2" );
      JButton button3 = new JButton( "Button 3" );

      // textArea1
      // weightx and weighty are both 0: the default
      // anchor for all components is CENTER: the default
      constraints.fill = GridBagConstraints.BOTH;
      addComponent( textArea1, 0, 0, 1, 3 );    
      
     
      // weightx and weighty are both 0: the default
      constraints.fill = GridBagConstraints.HORIZONTAL;
      addComponent( button1, 0, 1, 2, 1 );
      
      // comboBox
      // weightx and weighty are both 0: the default
      // fill is HORIZONTAL
      addComponent( comboBox, 2, 1, 2, 1 );             

      // button2
      constraints.weightx = 1000;  // can grow wider
      constraints.weighty = 1;     // can grow taller
      constraints.fill = GridBagConstraints.BOTH;
      addComponent( button2, 1, 1, 1, 1 );
       
      // button3
      // fill is BOTH
      constraints.weightx = 0;
      constraints.weighty = 0;    
      addComponent( button3, 1, 2, 1, 1 );
       
      // textField
      // weightx and weighty are both 0, fill is BOTH
      addComponent( textField, 3, 0, 2, 1 );

      // textArea2
      // weightx and weighty are both 0, fill is BOTH
      addComponent( textArea2, 3, 2, 1, 1 );

      setSize( 300, 150 );
      setVisible( true );
   }

   // method to set constraints on 
   private void addComponent( Component component,
       int row, int column, int width, int height ) {
           
      /* especifica coluna e a linha */
      constraints.gridx = column;  // coluna
      constraints.gridy = row;     // linha 

      /* tamanho a ser ocupado: quantas colunas e quantas linhas */
      constraints.gridwidth = width;   
      constraints.gridheight = height;

      /* configura restrições e adiciona o componente */
      layout.setConstraints( component, constraints );  
      container.add( component );      
   }

   /* programa principal */
   public static void main( String args[] ) {
      GridBagDemo application = new GridBagDemo();

      application.setDefaultCloseOperation(
         JFrame.EXIT_ON_CLOSE );
   } //main

}  // end class GridBagDemo

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
