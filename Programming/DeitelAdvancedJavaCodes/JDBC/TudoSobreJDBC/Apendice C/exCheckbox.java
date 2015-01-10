import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class exCheckbox extends JFrame {

  Icon naoCheck = new trocaIcon(false);
  Icon check = new trocaIcon(true);

  public exCheckbox() {
    this.setSize(230, 80);
    this.setTitle("Exemplo do JCheckBox");
    // Cria um objeto JPanel para conter os JCheckBox
    JPanel painel = new JPanel();
    // Divide o Painel
    painel.setLayout(new GridLayout(2, 1));
    // Cria o primeiro checkbox com o ícone Padrão
    JCheckBox cb1 = new JCheckBox("Este é Padrão", true);
    // Cria o segundo checkbox e altera seu ícone
    JCheckBox cb2 = new JCheckBox("Este é Modificado", false);
    cb2.setIcon(naoCheck);
    cb2.setSelectedIcon(check);
    // adiciona os Checkbox ao Painel
    painel.add(cb1); 
    painel.add(cb2); 
    this.getContentPane().add(painel, BorderLayout.CENTER);

    this.addWindowListener(
      new WindowAdapter() {
        public void windowClosing(WindowEvent e) {
          System.exit(0);
      }
    });
  }

  // Cria uma classe para fazer as trocas dos ícones
  class trocaIcon implements Icon {
    boolean estado;

    public trocaIcon (boolean s) {
      estado = s;
    }
    public void paintIcon (Component c, Graphics g, int x, int y) {
      int width = getIconWidth();
      int height = getIconHeight();
      if (estado) {
        g.setColor (Color.green);
        g.fillRect (x, y, width, height);
      } else {
        g.setColor (Color.red);
        g.drawRect (x, y, width, height);
      }
    }
    public int getIconWidth() { 
      return 10; 
    } 
    public int getIconHeight() { 
      return 10; 
    }
  }

  public static void main(String args[]) {
    exCheckbox nova = new exCheckbox();
    nova.show();
  }
}
