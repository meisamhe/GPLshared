import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class exToggleButton extends JFrame {

  public exToggleButton() { 
    this.setSize(264, 150);
    this.setTitle("Exemplo do JToggleButton");
    // Cria um objeto JPanel para conter os JToggleButton
    JPanel painel = new JPanel();
	 // Define o Layout do Painel para 3 Linhas e 1 coluna
	 painel.setLayout(new GridLayout(3,1, 10, 10)); 
	 // Insere o primeiro botão
	 painel.add(new JToggleButton("Marca 1")); 
	 // Insere o segundo botão
	 painel.add(new JToggleButton("Marca 2")); 
	 // Insere o terceiro botão
 	 painel.add(new JToggleButton("Marca 3")); 
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
    exToggleButton nova = new exToggleButton();
    nova.show();
  }
}
