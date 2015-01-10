import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class exButton extends JFrame {

  public exButton() { 
    this.setSize(270, 130);
    this.setTitle("Exemplo do JButton");
    // Cria um objeto JPanel para conter os JButtons
    JPanel painel = new JPanel();
    // Cria e adiciona um JButton 
    JButton butNormal = new JButton("JButton Normal"); 
    painel.add(butNormal); 
    // Adiciona um atalho ao JButton 
    butNormal.setMnemonic('J'); 
    // Cria um segundo JButton 
    JButton butGrande = new JButton("Letras Grandes"); 
    // Instancia um objeto Font para usar com o JLabel
    Font fonGrande = new Font("Serif", Font.BOLD | Font.ITALIC, 32); 
    // Associa a fonte ao JButton
    butGrande.setFont(fonGrande); 
    // Cria um Ícone
    Icon carro = new ImageIcon("carro.gif"); 
    // Adiciona o Ícone ao JButton
    butGrande.setIcon(carro); 
    // Alinha o texto a direita do JButton
    butGrande.setHorizontalAlignment(JLabel.RIGHT); 
    // Adiciona o JButton ao Painel
    painel.add(butGrande); 
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
    exButton nova = new exButton();
    nova.show();
  }
}
