/* CLASSE MstFilme
 * ------------------------------------
 * Sistema..: Locadora
 * Descrição: Mostra os Filmes
 * Direitos.: Java JDBC (c) Visual Books - 2001
 * Autor....: Fernando Anselmo
 * Versão...: 1.0
 */

import java.awt.*;
import java.applet.*;
import java.net.*;
import java.awt.event.*;
import javax.swing.*;

public class MstFilme extends JApplet {

  private JLabel lbFoto = new JLabel();
  private JScrollPane jScrollPane1 = new JScrollPane();
  private JButton btAnterior = new JButton("Anterior");
  private JButton btProximo = new JButton("Proximo");
  private JLabel lbNomFilme = new JLabel("[Nome Filme]");
  // Objetos Acessórios
  private String[] codsFilme;
  private int iCorre = 0;

  public MstFilme() {
    try {
      mostra();
    } catch(Exception ex) {
      ex.printStackTrace();
    }
  }
  
  public void mostra() throws Exception {
    this.getContentPane().setLayout(null);
    jScrollPane1.setBounds(new Rectangle(44, 36, 140, 210));
    jScrollPane1.getViewport().add(lbFoto, null);
    this.getContentPane().add(jScrollPane1, null);
    btAnterior.setBounds(new Rectangle(5, 253, 100, 30));
    this.getContentPane().add(btAnterior, null);
    btAnterior.addActionListener (new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        acaoBtAnterior();
    }});
    btProximo.setBounds(new Rectangle(124, 253, 100, 30));
    this.getContentPane().add(btProximo, null);
    btProximo.addActionListener (new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        acaoBtProximo();
    }});
    lbNomFilme.setBounds(new Rectangle(13, 14, 200, 13));
    this.getContentPane().add(lbNomFilme, null);
    // ***
    Acesso ac = new Acesso();
    if (ac.conecta()) {
      codsFilme = new String[ac.veExiste("filme")];
      ac.trazLinhas(codsFilme, "cod_filme from filme");
      ac.desconecta();
      carregaImg();
    }
  }

  private void carregaImg() {
    String[] campos = new String[3];
    Acesso ac = new Acesso();
    if (ac.conecta()) {
      ac.retCampos(campos, "Nom_Filme, Loc_Imagem, Sit_Filme", "Filme where Cod_Filme = '" + codsFilme[iCorre] + "'");
      ac.desconecta();
      if (campos[2].equals("L")) {
        lbNomFilme.setText(campos[0] + " - Livre");
      } else {
        lbNomFilme.setText(campos[0] + " - Alugado");
      }
      lbFoto.setIcon(new ImageIcon(MstFilme.class.getResource(campos[1])));
      btAnterior.setEnabled(iCorre > 0);
      btProximo.setEnabled(iCorre < codsFilme.length-1);
    }
  }

  private void acaoBtAnterior() {
    iCorre--;
    carregaImg();
  }  

  private void acaoBtProximo() {
    iCorre++;
    carregaImg();
  }  
}
