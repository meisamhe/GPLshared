import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class exToolBar extends JFrame {

  public exToolBar() { 
    this.setSize(270, 130);
    this.setTitle("Exemplo do JToolBar");
    // Cria a Barra de Ferramentas
    JToolBar toolbar = new JToolBar(); 
    // Cria um objeto para a figura
    Icon icoCarro = new ImageIcon("carro.gif"); 
    // Insere esta em um Label
    JLabel labTeste = new JLabel(icoCarro); 
    // Insere o objeto Label na Barra
    toolbar.add(labTeste); 
    // Insere um separador
    toolbar.addSeparator(); 
    // Cria e insere um objeto do Tipo CheckBox
    toolbar.add(new JCheckBox("ObjCheck")); 
    // Insere um separador
    toolbar.addSeparator(); 
    // Cria um objeto do tipo Botão
    JButton butTeste = new JButton("Sair"); 
    // Insere este na Barra
    toolbar.add(butTeste); 
    // Insere a Barra na Janela
    this.getContentPane().add(toolbar, BorderLayout.NORTH); 
    this.addWindowListener(
      new WindowAdapter() {
        public void windowClosing(WindowEvent e) {
          System.exit(0);
      }
    });
  }

  public static void main(String args[]) {
    exToolBar nova = new exToolBar();
    nova.show();
  }
}
