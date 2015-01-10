import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class exProgressBar extends JFrame {

  // Define a Barra de Progresso
  JProgressBar prbConta = new JProgressBar();
  // Define uma Thread para simular rodando
  Thread roda;

  public exProgressBar() { 
    this.setSize(264, 150);
    this.setTitle("Exemplo do JProgressBar");
    // Define o valor inicial da Barra
    prbConta.setMinimum(0);
    // Define o valor final da Barra de Progresso   
    prbConta.setMaximum(50);
    // Mostra o valor na barra
    prbConta.setStringPainted(true); 
    // Insere a barra
	 this.getContentPane().add(prbConta, BorderLayout.SOUTH); 
	 // Cria um botão para iniciar o processo
    JButton butInicia = new JButton("Inicia"); 
    // Ao acionar o botão
    butInicia.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        // Inicia o valor da Barra
        prbConta.setValue(prbConta.getMinimum());
        // Inicia o processo
        if (roda == null) {
          roda = new roda();
          roda.start(); 
        }
    }});
    // Insere o botão na Janela
	 this.getContentPane().add(butInicia, BorderLayout.NORTH); 

    this.addWindowListener(
      new WindowAdapter() {
        public void windowClosing(WindowEvent e) {
          System.exit(0);
      }
    });
  }

  class roda extends Thread { 
    public void run() {
      // Cria um objeto para atualizar a Barra
      Runnable runner = new Runnable() {
        public void run() {
          // Obtém o resultado atual da Barra
          int valor = prbConta.getValue();
          // Atualiza a Barra
          prbConta.setValue(valor+1);
        }
      };
      for (int i = 0; i < 50; i++) {
        // ---------------------------------
        // Faça aqui o processo a realizar
        // ---------------------------------

        // Atualiza a Barra de Progresso
        try {
          SwingUtilities.invokeAndWait(runner); 
        } catch (java.lang.reflect.InvocationTargetException e) { 
          break; 
        } catch (InterruptedException e) {
        }
      }
     roda = null; 
    }     
  }

  public static void main(String args[]) {
    exProgressBar nova = new exProgressBar();
    nova.show();
  }
}
