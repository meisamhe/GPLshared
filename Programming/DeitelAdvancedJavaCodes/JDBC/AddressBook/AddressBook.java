/**
 * Exemplo de manipulação de um banco de dados de um Address Book com as 
 * operações básicas de inserir, atualizar, apagar e consultar. Também é 
 * utilizado controle de transação.
 */


package AddressBook;

import java.awt.*;
import java.awt.event.*;
import java.sql.*;

import javax.swing.*;
import javax.swing.event.*;

public class AddressBook extends JFrame {
   
   // reference for manipulating multiple document interface
   private JDesktopPane desktop;
   
   // reference to database access object
   private AddressBookDataAccess database;

   // references to Actions
   Action newAction, saveAction, deleteAction, searchAction, exitAction;
   
   /** configura a conexao com o BD e a GUI */
   public AddressBook() 
   {
      super( "Address Book" );
      
      /* cria a conexao com o banco de dados */
      try {
         database = new FirebirdDataAccess();
      }
      
      /* detecta problemas com a conexao */
      catch ( Exception exception ) {
         exception.printStackTrace();
         System.exit( 1 );
      } //catch
      
      /* cria a GUI se conectar com o BD */
      JToolBar toolBar = new JToolBar();
      JMenu fileMenu = new JMenu( "File" );
      fileMenu.setMnemonic( 'F' );
      
      /* Configura as ações. Private inner classes processam as ações */
      newAction = new NewAction();
      saveAction = new SaveAction();
      saveAction.setEnabled( false );    // disabled by default
      deleteAction = new DeleteAction();
      deleteAction.setEnabled( false );  // disabled by default
      searchAction = new SearchAction();
      exitAction = new ExitAction();
      
      /* adiciona as ações para a barra de ferramentas */
      toolBar.add( newAction );
      toolBar.add( saveAction );
      toolBar.add( deleteAction );
      toolBar.add( new JToolBar.Separator() );
      toolBar.add( searchAction );

      /* adiciona as acões para o menu File */
      fileMenu.add( newAction );
      fileMenu.add( saveAction );
      fileMenu.add( deleteAction );
      fileMenu.addSeparator();
      fileMenu.add( searchAction );
      fileMenu.addSeparator();
      fileMenu.add( exitAction );
      
      /* configura a barra de ferramentas */
      JMenuBar menuBar = new JMenuBar();
      menuBar.add( fileMenu );
      setJMenuBar( menuBar );
      
      /* configura o desktop */
      desktop = new JDesktopPane();
      
      /* obtem o content pane */
      Container c = getContentPane();
      c.add( toolBar, BorderLayout.NORTH );
      c.add( desktop, BorderLayout.CENTER );
      
      /* registrar o evento windowClosing para fechar a aplicação */
      this.addWindowListener( new WindowAdapter() {
            public void windowClosing( WindowEvent event ) {
               shutDown();
            } //windowClosing
         } //WindowAdapter
      );
      
      /* configura o tamanho da janela */
      Toolkit toolkit = getToolkit();
      Dimension dimension = toolkit.getScreenSize();
      
      /* centraliza na tela */
      this.setBounds( 100, 100, dimension.width - 200, dimension.height - 200 );
      
      this.show();
   }  // end AddressBook constructor
     
   /** fecha o banco de dados e termina o programa */
   private void shutDown() {
      database.close();   
      System.exit( 0 );   
   } //shutDown
   
   /** cria um novo AddressBookEntryFrame e registra um listener */
   private AddressBookEntryFrame createAddressBookEntryFrame()
   {
      AddressBookEntryFrame frame = new AddressBookEntryFrame();
      setDefaultCloseOperation( DISPOSE_ON_CLOSE );
      
      frame.addInternalFrameListener( new InternalFrameAdapter() {
            /* frame interno torna-se ativo no desktop */
            public void internalFrameActivated(InternalFrameEvent event) {
               saveAction.setEnabled( true );  
               deleteAction.setEnabled( true );  
            } //internalFrameActivated

            /* frame interno torna-se inativo no desktop */
            public void internalFrameDeactivated(InternalFrameEvent event) {
               saveAction.setEnabled( false );  
               deleteAction.setEnabled( false );  
            } //internalFrameDesactivated
            
         }  // end InternalFrameAdapter anonymous inner class
      ); // end call to addInternalFrameListener
      
      return frame;  
   }  // end method createAddressBookEntryFrame

   
   /** método principal: executa o  programa */
   public static void main( String args[] )
   {
      new AddressBook();
   }
   
   
   /**
    * Private inner class define a ação que permite um usuário inserir uma nova
    * entrada. o usuário deve salvar (Save) entrada depois de entrar 
    */
   private class NewAction extends AbstractAction {
      
      /** configura o nome da ação, icone, descrição e mnemonic */
      public NewAction() {
         putValue( NAME, "New" );
         putValue( SMALL_ICON, new ImageIcon(
             getClass().getResource( "images/New24.png" ) ) );
         putValue( SHORT_DESCRIPTION, "New" );
         putValue( LONG_DESCRIPTION, "Add a new address book entry" );
         putValue( MNEMONIC_KEY, new Integer( 'N' ) );
      } //NewAction
      
      /** visualiza a janela na qual o usuário pode entrar com os dados */
      public void actionPerformed( ActionEvent e ) {
         /* cria uma nova janela interna */
         AddressBookEntryFrame entryFrame = createAddressBookEntryFrame();
         
         /* configura a nova AddressBookEntry na janela */
         entryFrame.setAddressBookEntry(new AddressBookEntry());
         
         /* visualiza a janela */
         desktop.add( entryFrame );
         entryFrame.setVisible( true );
      } //actionPerformed
      
   }  // end inner class NewAction
   
   
   /**
    * Inner class que define uma ação para salvar ou atualizar uma entrada
    */
   private class SaveAction extends AbstractAction {
      
      /** configura o nome da ação, icone, descrição e mnemonic */
      public SaveAction() {
         putValue( NAME, "Save" );
         putValue( SMALL_ICON, new ImageIcon(
            getClass().getResource( "images/Save24.png" ) ) );
         putValue( SHORT_DESCRIPTION, "Save" );
         putValue( LONG_DESCRIPTION, "Save an address book entry" );
         putValue( MNEMONIC_KEY, new Integer( 'S' ) );
      } //SaveAction
      
      /** salva uma nova entrada ou atualiza a existente */
      public void actionPerformed( ActionEvent e )  {
         /* obtem a janela ativa */
         AddressBookEntryFrame currentFrame = 
            ( AddressBookEntryFrame ) desktop.getSelectedFrame();

         /* obtem AddressBookEntry da janela */
         AddressBookEntry person = currentFrame.getAddressBookEntry();
    
         /* insere uma pessoa no livro de endereços */
         try {
            /* Obtem personID. If 0, this is uma nova entrada, caso contrario
             * uma atualização deve ser executada */ 
            int personID = person.getPersonID();
            
            /* determina a string para a caixa de mensagem */
            String operation = ( personID == 0 ) ? "Insertion" : "Update";
               
            /* insere ou atualiza uma nova entrada */
            if ( personID == 0 ) 
                database.newPerson( person );
            else
               database.savePerson( person );
               
            /* visualiza mensagem de sucesso */
            JOptionPane.showMessageDialog( desktop, operation + " successful" );
         } // try
         
         /* detecta erro no BD */
         catch ( DataAccessException exception ) {
            JOptionPane.showMessageDialog( desktop, exception,
               "DataAccessException", JOptionPane.ERROR_MESSAGE );
            exception.printStackTrace();  
         } //cath
         
         /* fecha a janela corrente */
         currentFrame.dispose();
         
      }  // end method actionPerformed
      
   }  // end inner class SaveAction
   
   
   /**
    * Inner class que define a ação que deleta uma entrada
    */
   private class DeleteAction extends AbstractAction {
      
      /** configura o nome da ação, icone, descrição e mnemonic */
      public DeleteAction(){
         putValue( NAME, "Delete" );
         putValue( SMALL_ICON, new ImageIcon(
            getClass().getResource( "images/Delete24.png" ) ) );
         putValue( SHORT_DESCRIPTION, "Delete" );
         putValue( LONG_DESCRIPTION, "Delete an address book entry" );
         putValue( MNEMONIC_KEY, new Integer( 'D' ) );
      } //DeleteAction
      
      /** apaga entrada */
      public void actionPerformed( ActionEvent e ) {
         /* obtem a janela corrente */
         AddressBookEntryFrame currentFrame = 
            ( AddressBookEntryFrame ) desktop.getSelectedFrame();
         
         /* obtem AddressBookEntry da janela */
         AddressBookEntry person = currentFrame.getAddressBookEntry();
         
         /* se personID é 0, esta nova entrada não foi inserida. Consequentemente,
            deletar nao é necessário */
         if ( person.getPersonID() == 0 ) {
            JOptionPane.showMessageDialog( desktop, 
               "New entries must be saved before they can be " +
               "deleted. \nTo cancel a new entry, simply " + 
               "close the window containing the entry" );
            return;            
         }
         
         // delete person
         try {
            database.deletePerson( person );
            
            // display message indicating success
            JOptionPane.showMessageDialog( desktop,
               "Deletion successful" );         
         }
         
         // detect problems deleting person
         catch ( DataAccessException exception ) {
            JOptionPane.showMessageDialog( desktop, exception,
               "Deletion failed", JOptionPane.ERROR_MESSAGE );   
            exception.printStackTrace();  
         }
         
         // close current window and dispose of resources
         currentFrame.dispose();
         
      }  // end method actionPerformed 
      
   }  // end inner class DeleteAction
   
   
   
   /* Inner class que define ação que localiza entrada */
   private class SearchAction extends AbstractAction {
      
      /** configura o nome da ação, icone, descrição e mnemonic */
      public SearchAction() {
         putValue( NAME, "Search" );
         putValue( SMALL_ICON, new ImageIcon(
            getClass().getResource( "images/Find24.png" ) ) );
         putValue( SHORT_DESCRIPTION, "Search" );
         putValue( LONG_DESCRIPTION, "Search for an address book entry" );
         putValue( MNEMONIC_KEY, new Integer( 'r' ) );
      } //SearchAction
      
      /** localiza uma entrada existente */
      public void actionPerformed( ActionEvent e ) {
         String lastName = JOptionPane.showInputDialog(desktop, "Enter last name");
         
         /* se nome foi entrado, localize; casocontrario, não faça nada */
         if ( lastName != null ) {
            /*  Executa  a busca */
            AddressBookEntry person = database.findPerson( lastName );

            if ( person != null ) {
               /* cria uma janela para visualizar a AddressBookEntry*/
               AddressBookEntryFrame entryFrame = createAddressBookEntryFrame();
                 
               /* configura o AddressBookEntry para visualizar */
               entryFrame.setAddressBookEntry( person );
                  
               /* visualizar a janela */
               desktop.add( entryFrame );
               entryFrame.setVisible( true );
            } else
               JOptionPane.showMessageDialog( desktop, 
                  "Entry with last name \"" + lastName + 
                  "\" not found in address book" );
         }  // end "if ( lastName == null )"
         
      }  // end method actionPerformed
      
   }  // end inner class SearchAction
   
   /**
    * Inner class que define a ação para fechar a conexão com o BD e terminar o 
    * programa
    */
   private class ExitAction extends AbstractAction {
      
      /** configura o nome da ação, icone, descrição e mnemonic */
      public ExitAction() {
         putValue( NAME, "Exit" );
         putValue( SHORT_DESCRIPTION, "Exit" );
         putValue( LONG_DESCRIPTION, "Terminate the program" );
         putValue( MNEMONIC_KEY, new Integer( 'x' ) );
      } //ExitAction
      
      /* finaliza o programa */
      public void actionPerformed( ActionEvent e ) {
         shutDown();  
      }     
      
   }  // end inner class ExitAction 
}



/**************************************************************************
 * (C) Copyright 2001 by Deitel & Associates, Inc. and Prentice Hall.     *
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
