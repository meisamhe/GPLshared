import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class exTextField extends JFrame {

  public exTextField() { 
    this.setSize(264, 110);
    this.setTitle("Exemplo do JTextField");
    // Cria um objeto JPanel para conter os JTextField
    JPanel painel = new JPanel();
    // Cria e adiciona um JTextField
    JTextField edNormal = new JTextField("Normal"); 
    painel.add(edNormal); 
    // Cria um segundo JTextField
    JTextField edGrande = new JTextField(" Pela Direita "); 
    // Instancia um objeto Font para usar com o JTextField
    Font fonGrande = new Font("Serif", Font.BOLD | Font.ITALIC, 32); 
    // Associa a fonte ao JTextField
    edGrande.setFont(fonGrande); 
    // Obriga a entrada de texto pela direita do JTextField
    edGrande.setHorizontalAlignment(JTextField.RIGHT); 
    // Adiciona o JTextField ao Painel
    painel.add(edGrande); 
    // Adiciona o painel ao Formulário
    this.getContentPane().add(painel, BorderLayout.CENTER);
    this.addWindowListener(
      new WindowAdapter() {
        public void windowClosing(WindowEvent e) {
          System.exit(0);
      }
    });
  }

  public static void main(String args[]) {
    exTextField nova = new exTextField();
    nova.show();
  }
}
