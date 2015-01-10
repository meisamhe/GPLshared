import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class exComboBox extends JFrame {

  public exComboBox() { 
    this.setSize(270, 130);
    this.setTitle("Exemplo do JComboBox");
    // Cria um array com as escolhas
    String escolha[] = {
      "Azul", "Amarelo", "Rosa", 
      "Vermelho", "Castanho", "Laranja", 
      "Lilás","Preto", "Branco"};
    // Cria dois objetos ComboBox
    JComboBox cbx1 = new JComboBox();
    JComboBox cbx2 = new JComboBox();
    // Carrega ambos objetos
    for (int i=0; i < escolha.length; i++) {
      cbx1.addItem (escolha[i]);
      cbx2.addItem (escolha[i]);
    }
    // Habilita a edição do segundo ComboBox
    cbx2.setEditable(true);
    // Mostra a String
    cbx2.setSelectedItem("Escreva");
    // Define o número de Linhas a mostrar na Caixa de Seleção
    cbx2.setMaximumRowCount(4);
    // Insere os objetos na Janela
    this.getContentPane().add(cbx1, BorderLayout.NORTH);
    this.getContentPane().add(cbx2, BorderLayout.SOUTH);
    this.addWindowListener(
      new WindowAdapter() {
        public void windowClosing(WindowEvent e) {
          System.exit(0);
      }
    });
  }

  public static void main(String args[]) {
    exComboBox nova = new exComboBox();
    nova.show();
  }
}

