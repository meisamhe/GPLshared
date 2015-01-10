import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class exTextArea extends JFrame {

  public exTextArea() { 
    this.setSize(264, 110);
    this.setTitle("Exemplo do JTextArea");
    // Cria um objeto JTextArea 
    JTextArea taNormal = new JTextArea();
    // Insere um texto de múltiplas linhas no objeto 
    taNormal.setText("Isto é\napenas um\nPequeno teste\npara demonstrar\neste objeto");
    // Cria um objeto ScrollPane para conter o JTextArea
    JScrollPane scrollPane = new JScrollPane(taNormal); 
    // Joga o objeto ScrollPane para a Janela
    this.getContentPane().add(scrollPane, BorderLayout.CENTER);
    this.addWindowListener(
      new WindowAdapter() {
        public void windowClosing(WindowEvent e) {
          System.exit(0);
      }
    });
  }

  public static void main(String args[]) {
    exTextArea nova = new exTextArea();
    nova.show();
  }
}