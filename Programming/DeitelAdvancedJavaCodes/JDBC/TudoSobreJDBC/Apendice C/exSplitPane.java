import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class exSplitPane extends JFrame {

  public exSplitPane() { 
    this.setSize(270, 130);
    this.setTitle("Exemplo do JSplitPane");
    // Define os arrays para carregar os objetos JList
    String[] Fruta = {"Morango", "Melancia", "Tomate", "Mamão", "Laranja", "Banana"}; 
    String[] Verdura = {"Repolho", "Alface", "Pepino", "Cebola", "Beterraba"}; 
    String[] Carne = {"Frango", "Peixe", "Vaca", "Soja", "Porco"}; 
    JList lstFruta = new JList(Fruta); 
    JList lstVerdura = new JList(Verdura); 
    JList lstCarne = new JList(Carne); 
    // Define os objetos JScrollPane a partir das JList
    JScrollPane priPane = new JScrollPane(lstFruta); 
    JScrollPane segPane = new JScrollPane(lstVerdura);
    JScrollPane terPane = new JScrollPane(lstCarne);
    // Insere os objetos em pé no objeto JSplitPane
    JSplitPane splPane1 = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, priPane, segPane); 
    // Acerta o tamanho da barra de separação
    splPane1.setDividerLocation(0.5); 
    // Define as setas de expansão da barra
    splPane1.setOneTouchExpandable(true); 
    // Joga este JSplitPane em um objeto JScroll
    JScrollPane quaPane = new JScrollPane(splPane1);
    // Cria mais um objeto JSplitPane
    JSplitPane splPane2 = new JSplitPane(JSplitPane.VERTICAL_SPLIT, quaPane, terPane); 
    // Acerta o tamanho da barra de separação
    splPane2.setDividerLocation(0.5); 
    // Define as setas de expansão da barra
    splPane2.setOneTouchExpandable(true); 
    // Insere este último na Janela
    this.getContentPane().add(splPane2, BorderLayout.CENTER); 
    this.addWindowListener(
      new WindowAdapter() {
        public void windowClosing(WindowEvent e) {
          System.exit(0);
      }
    });
  }

  public static void main(String args[]) {
    exSplitPane nova = new exSplitPane();
    nova.show();
  }
}