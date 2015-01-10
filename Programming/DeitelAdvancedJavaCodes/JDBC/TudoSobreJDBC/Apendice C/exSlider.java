import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class exSlider extends JFrame {

  public exSlider() { 
    this.setSize(264, 150);
    this.setTitle("Exemplo do JSlider");
    // Define o primeiro Slider em pé
	 JSlider sld1 = new JSlider(JSlider.VERTICAL, 0, 100, 50); 
    // Define a régua de traços
	 sld1.setPaintTicks(true); 
	 // Define o maior tamanho do traço
	 sld1.setMajorTickSpacing(10); 
	 // Define o menor tamanho do traço
	 sld1.setMinorTickSpacing(2); 
    // Insere este no canto a direita
    this.getContentPane().add(sld1, BorderLayout.EAST); 
    // Define outro Slider em pé
	 JSlider sld2 = new JSlider(JSlider.VERTICAL, 0, 100, 50); 
	 // Marca uma régua de traços
	 sld2.setPaintTicks(true); 
	 // Define o tamanho de um único traço
	 sld2.setMinorTickSpacing(5); 
	 // Insere este no canto a esquerda
	 this.getContentPane().add(sld2, BorderLayout.WEST); 
	 // Define um Slider deitado
	 JSlider sld3 = new JSlider(JSlider.HORIZONTAL, 0, 100, 50); 
    // Define o salto
    sld3.setMajorTickSpacing (10); 
    // Mostra as marcações numéricas
    sld3.setPaintLabels(true); 
	 // Insere este na canto abaixo
	 this.getContentPane().add(sld3, BorderLayout.SOUTH); 
    this.addWindowListener(
      new WindowAdapter() {
        public void windowClosing(WindowEvent e) {
          System.exit(0);
      }
    });
  }

  public static void main(String args[]) {
    exSlider nova = new exSlider();
    nova.show();
  }
}