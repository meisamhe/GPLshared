/*
 * TestAppletMidi.java
 *
 * Created on March 18, 2004, 11:12 AM
 */

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import javax.sound.midi.Instrument;

/**
 * Applet que executa um midi com um instrumento escolhido pelo usuário
 * @author  rcampiol
 */
public class TestAppletMidi extends JApplet {
    private SynthesizerDemo synth;
    private JTextArea area;
    private JTextField txtInstrumento;
    private Instrument[] listaInstrumentos;
    
    public void init() {
        synth = new SynthesizerDemo();

        Container c = this.getContentPane();
        c.setLayout(new BorderLayout(10, 15));

        area = new JTextArea(10, 30);
        area.setEditable(false);
        JScrollPane scrollPane = new JScrollPane(area);
        scrollPane.setBorder(new javax.swing.border.TitledBorder(" Lista de Instrumentos Disponíveis "));
        c.add(scrollPane, BorderLayout.CENTER);
        
        txtInstrumento = new JTextField (30);
        c.add(txtInstrumento, BorderLayout.SOUTH);
        
        /* Imprime na area os instrumentos disponiveis */
        listaInstrumentos = synth.getInstrumentsList(); 
        for (int i=0; i<listaInstrumentos.length; i++)
            area.append(String.valueOf(i) + "\t" + listaInstrumentos[i].getName() + "\n");

        /* adiciona um evento para o txtInstrumento */
        txtInstrumento.addKeyListener(new KeyAdapter() {
            public void keyPressed (KeyEvent e) {
                if (e.VK_ENTER == e.getKeyCode()) {
                    try {
                        /* imprime na tela o tipo de instrumento sendo tocado */
                        int instrumento = Integer.parseInt(txtInstrumento.getText());
                        area.append("\nTocando instrumento ..." + listaInstrumentos[instrumento].getName());
                        txtInstrumento.setText(null);
                    
                        /* seleciona e toca o instrumento */
                        synth.setInstrument(instrumento);  
                        synth.playOctave(60);

                    } catch (Exception erro) {
                        JOptionPane.showMessageDialog(null, "Algo está errado!!!\n" + erro,
                                "Mensagem de erro", JOptionPane.ERROR_MESSAGE);
                    } //catch    
                } //if
            } //keyPressed
        });
        
    } //init
    
    
    public void paint(Graphics g) {
        super.paint(g);
    } //paint    
    
} //class TestAppletMidi
