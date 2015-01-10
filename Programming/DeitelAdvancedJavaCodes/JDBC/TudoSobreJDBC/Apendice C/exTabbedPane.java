import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class exTabbedPane extends JFrame {

  public exTabbedPane() { 
    this.setSize(270, 130);
    this.setTitle("Exemplo do JTabbedPane");
    // Cria um Array com o nome das Abas
    String abas[] = {"Aba 1", "Aba 2", "Aba 3", "Aba 4"}; 
    // Cria o objeto
    JTabbedPane tabbedPane = new JTabbedPane(); 
    // Cria as Abas e para cada uma adiciona a partir do método
    for (int i=0; i < abas.length; i++)
      tabbedPane.addTab(abas[i], criaLabs(abas[i])); 
    // Coloca a segunda Aba como Default inicial    
    tabbedPane.setSelectedIndex(1); 
    this.getContentPane().add(tabbedPane, BorderLayout.CENTER); 
    this.addWindowListener(
      new WindowAdapter() {
        public void windowClosing(WindowEvent e) {
          System.exit(0);
      }
    });
  }

  // função que criará os objetos para as Abas
  private JPanel criaLabs(String s) { 
    JPanel p = new JPanel(); 
    p.add(new JLabel("Label para a "+s)); 
    return p; 
  } 

  public static void main(String args[]) {
    exTabbedPane nova = new exTabbedPane();
    nova.show();
  }
}

