import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class exList extends JFrame {

  public exList() { 
    this.setSize(270, 130);
    this.setTitle("Exemplo do JList");
    // Cria um array com as escolhas
    String escolha[] = {
      "Azul", "Amarelo", "Rosa", 
      "Vermelho", "Castanho", "Laranja", 
      "Lilás","Preto", "Branco"};
    // Cria o objeto List
    JList lst1 = new JList(escolha);
    // Insere a lista dentro do ScrollPane
    JScrollPane scrollPane = new JScrollPane(lst1); 
    // Insere o ScrollPane na Janela
    this.getContentPane().add(scrollPane, BorderLayout.CENTER);
    this.addWindowListener(
      new WindowAdapter() {
        public void windowClosing(WindowEvent e) {
          System.exit(0);
      }
    });
  }

  public static void main(String args[]) {
    exList nova = new exList();
    nova.show();
  }
}