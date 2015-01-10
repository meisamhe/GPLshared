import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class exScrollPane extends JFrame {

  public exScrollPane() { 
    this.setSize(264, 110);
    this.setTitle("Exemplo do JScrollPane");
    // Cria um objeto Ícone para conter a imagem do cão
    Icon icoCao = new ImageIcon("cao.gif"); 
    // Cria um objeto Label para conter o ícone
    JLabel labCao = new JLabel(icoCao); 
    // Cria um objeto ScrollPane para conter o Label
    JScrollPane scrollPane = new JScrollPane(labCao); 
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
    exJScrollPane nova = new exJScrollPane();
    nova.show();
  }
}