import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class Exemplo extends JFrame {

  // Aqui ser�o inseridos os dados da Cria��o dos Objetos

  public Exemplo() {
    try {
      mostra();
    } catch(Exception ex) {
      ex.printStackTrace();
    }
  }

  private void mostra() throws Exception {
    // Aqui ser�o inseridos os dados da Cria��o da Janela
    // Aqui ser�o inseridos os dados da Cria��o dos Controles na Janela
    this.addWindowListener(new java.awt.event.WindowAdapter() {
      public void windowClosing(WindowEvent e) {
        aoFechar(e);
      }
    });
  }

  private void aoFechar(WindowEvent e) {
    System.exit(0);
  }

  public static void main(String args[]) {
    Exemplo janela = new Exemplo();
    janela.show();
  }
}
