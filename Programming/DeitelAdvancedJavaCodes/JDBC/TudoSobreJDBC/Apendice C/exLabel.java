import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class exLabel extends JFrame {

  public exLabel() { 
    this.setSize(264, 110);
    this.setTitle("Exemplo do JLabel");
    // Cria um objeto JPanel para conter os JLabel
    JPanel painel = new JPanel();
    // Cria e adiciona um JLabel 
    JLabel labNormal = new JLabel("JLabel Normal"); 
    painel.add(labNormal); 
    // Cria um segundo JLabel 
    JLabel labGrande = new JLabel("Letras Grandes"); 
    // Instancia um objeto Font para usar com o JLabel
    Font fonGrande = new Font("Serif", Font.BOLD | Font.ITALIC, 32); 
    // Associa a fonte ao JLabel
    labGrande.setFont(fonGrande); 
    // Cria um Ícone
    Icon carro = new ImageIcon("carro.gif"); 
    // Adiciona o Ícone ao JLabel
    labGrande.setIcon(carro); 
    // Alinha o texto a direita do JLabel
    labGrande.setHorizontalAlignment(JLabel.RIGHT); 
    // Adiciona o JLabel ao Painel
    painel.add(labGrande); 
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
    exLabel nova = new exLabel();
    nova.show();
  }
}
