import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class exMenu extends JFrame {

  public exMenu() {
    this.setSize(230, 150);
    this.setTitle("Exemplo do JMenu");
    JMenuBar jmb = new JMenuBar();
    // Adiciona um menu com figuras 
    JMenuItem item; 
    JMenu edit = new JMenu ("Com Figuras");
    edit.add (item = new JMenuItem ("Normal"));
    Icon carroIcon = new ImageIcon("carro.gif"); 
    edit.add (item = 
      new JMenuItem ("Carro Esquerda", carroIcon));
    item.setHorizontalTextPosition (JMenuItem.LEFT);
    edit.add (item = 
      new JMenuItem ("Carro Direita", carroIcon));
    jmb.add (edit);
    // Adiciona um menu de escolhas
    JMenu choice = new JMenu ("Escolha");
    JCheckBoxMenuItem check = 
      new JCheckBoxMenuItem ("Gostou ?");
    choice.add (check);
    ButtonGroup rbg = new ButtonGroup();
    JRadioButtonMenuItem rad = 
      new JRadioButtonMenuItem ("Nota 1");
    choice.add (rad);
    rbg.add (rad);
    rad = new JRadioButtonMenuItem ("Nota 2");
    choice.add (rad);
    rbg.add (rad);
    rad = new JRadioButtonMenuItem ("Nota 3");
    choice.add (rad);
    rbg.add (rad);
    jmb.add (choice);
    setJMenuBar (jmb);
    this.addWindowListener(
      new WindowAdapter() {
        public void windowClosing(WindowEvent e) {
          System.exit(0);
      }
    });
  }

  public static void main(String args[]) {
    exMenu nova = new exMenu();
    nova.show();
  }
}
