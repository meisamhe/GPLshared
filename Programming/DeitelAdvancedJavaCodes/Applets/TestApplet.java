/*
 * TestApplet.java
 * Created on March 15, 2004, 4:43 PM
 */

import java.util.ArrayList;
import javax.swing.*;


/**
 * Classe que implementa um exemplo de applet
 * @author  rcampiol
 */
public class TestApplet extends JApplet {
    private ArrayList arrayNumbers;
    private JTextArea textArea;
    
    /** inicializa as variáveis e componentes do applet */
    public void init () {
        String valor;
        Double v;

        /** cria e insere o JTextArea no Applet */
        textArea = new JTextArea();
        java.awt.Container c = this.getContentPane();
        c.add(textArea);
        
        valor = JOptionPane.showInputDialog(null, "Quantos valores serão digitados?");
        arrayNumbers = new ArrayList(Integer.parseInt(valor));
        
        /** leitura dos valores */
        int limite = Integer.parseInt(valor);
        for (int i=0; i<limite; i++) {
            valor = JOptionPane.showInputDialog(null, "Valor " + String.valueOf(i+1) + "?");
            v = Double.valueOf(valor);
            arrayNumbers.add(v);
        } //for    
        
        /** formatação dos valores */
        for (int i=0; i<limite; i++) {
            java.text.NumberFormat formatador = java.text.NumberFormat.getCurrencyInstance();
//            java.text.NumberFormat formatador = java.text.NumberFormat.getCurrencyInstance(new java.util.Locale("pt","BR"));
//            formatador.setMinimumFractionDigits(2);
            String valorMoeda = formatador.format(arrayNumbers.get(i));
            textArea.append(valorMoeda + "\n");
        } //for    
        
    } //init
    
    
    /** renderiza os componentes do Applet */
    public void paint (java.awt.Graphics g) {
        super.paint(g);
    } //paint    
    
} //class TestApplet
