import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class exRadioButton extends JFrame {

  public exRadioButton() { 
    this.setSize(264, 150);
    this.setTitle("Exemplo do RadioButton");
    // Cria um objeto JPanel para conter os JRadioButton
    JPanel painel = new JPanel();
    painel.setLayout(new GridLayout(6,1, 10, 10)); 

    // Cria um único objeto radioButton
    JRadioButton radioButton;

    // Cria os objetos ButtonGroup 
    ButtonGroup rbg1 = new ButtonGroup();
    ButtonGroup rbg2 = new ButtonGroup();

    // Cria labels para os títulos dos grupos
    JLabel lab1 = new JLabel("Sexo: ");
    JLabel lab2 = new JLabel("Gosta de: ");
    lab1.setFont(new Font("SansSerif", Font.BOLD, 14));
    lab2.setFont(new Font("SansSerif", Font.BOLD, 14));

    // Começa a montar o primeiro grupo
    painel.add(lab1);
    // Cria o primeiro botão do primeiro Grupo
    radioButton = new JRadioButton("Masculino");
    // Adiciona ao Grupo
    painel.add(radioButton);
    rbg1.add(radioButton);
    // Marca como default
    radioButton.setSelected(true);
    // Cria o segundo botão do primeiro Grupo
    radioButton = new JRadioButton("Feminino");
    painel.add(radioButton);
    rbg1.add(radioButton);

    // Começa a montar o segundo grupo
    painel.add(lab2);
    // Cria o primeiro botão do primeiro Grupo
    radioButton = new JRadioButton("Carro");
    // Adiciona ao Grupo
    painel.add(radioButton);
    rbg2.add(radioButton);
    // Marca como default
    radioButton.setSelected(true);
    // Cria o segundo botão do primeiro Grupo
    radioButton = new JRadioButton("Roupas");
    painel.add(radioButton);
    rbg2.add(radioButton);

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
    exRadioButton nova = new exRadioButton();
    nova.show();
  }
}
