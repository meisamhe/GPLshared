/**
 * CLASSE EmpFilme
 * ------------------------------------
 * Sistema..: Locadora
 * Descrição: Empréstimo dos Filmes
 * Direitos.: Java JDBC (c) Visual Books - 2001
 * Autor....: Fernando Anselmo
 * Versão...: 1.0
 */

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class EmpFilme extends JDialog {
  private JLabel JLabel1 = new JLabel("Cliente:");
  private JLabel lbNomCliente = new JLabel("[ Nome do Cliente ]");
  private JTextField edCodCliente = new JTextField("");
  private JLabel JLabel3 = new JLabel("Filme:");
  private JLabel lbNomFilme = new JLabel("[ Nome do Filme ]");
  private JTextField edCodFilme = new JTextField("");
  private JButton btEmprestar = new JButton("Emprestar");
  private JButton btLimpar = new JButton("Limpar");
  // Variáveis Utilizadas
  private boolean exCliente = false;
  private boolean exFilme = false;
  
  public EmpFilme() {
    try {
      mostra();
      acaoBtLimpar();
    } catch(Exception ex) {
      ex.printStackTrace();
    }
  }

  public void mostra() throws Exception {
    this.getContentPane().setLayout(null);
    this.setSize(420, 132);
    this.setTitle("Empréstimo de Filmes");
    this.setResizable(false);
    this.setModal(true);
    // ***
    JLabel1.setBounds(new Rectangle(14, 15, 57, 13));
    this.getContentPane().add(JLabel1, null);
    lbNomCliente.setBounds(new Rectangle(176, 14, 230, 13));
    this.getContentPane().add(lbNomCliente, null);
    edCodCliente.setBounds(new Rectangle(74, 12, 100, 21));
    this.getContentPane().add(edCodCliente, null);
    edCodCliente.addFocusListener (new FocusAdapter() {
      public void focusLost(FocusEvent e) {
        sairEdCodCliente();
    }});
    JLabel3.setBounds(new Rectangle(18, 41, 57, 13));
    this.getContentPane().add(JLabel3, null);
    btEmprestar.setBounds(new Rectangle(304, 70, 100, 30));
    this.getContentPane().add(btEmprestar, null);
    btEmprestar.addActionListener (new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        acaoBtEmprestar();
    }});
    edCodFilme.setBounds(new Rectangle(74, 36, 100, 21));
    this.getContentPane().add(edCodFilme, null);
    edCodFilme.addFocusListener (new FocusAdapter() {
      public void focusLost(FocusEvent e) {
        sairEdCodFilme();
    }});
    lbNomFilme.setBounds(new Rectangle(178, 39, 230, 13));
    this.getContentPane().add(lbNomFilme, null);
    btLimpar.setBounds(new Rectangle(200, 70, 100, 30));
    this.getContentPane().add(btLimpar, null);
    btLimpar.addActionListener (new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        acaoBtLimpar();
    }});

    this.addWindowListener(new WindowAdapter() {
      public void windowClosing(WindowEvent e) {
        aoFechar(e);
      }
    });
  }

  private void sairEdCodCliente() {
    Acesso ac = new Acesso();
    if (ac.conecta()) {
      exCliente = (ac.veExiste("cliente where (cod_cliente = '" + edCodCliente.getText() + "')") > 0);
      edCodCliente.setEnabled(((exCliente) ? false : true));
      if (exCliente) { // Pesquisa Resto
        String[] rCampos = new String[1];
        ac.retCampos(rCampos, "nom_cliente", 
          "cliente where (cod_cliente = '" + edCodCliente.getText() + "')");
        lbNomCliente.setText(rCampos[0]);
      } else {
        lbNomCliente.setText("Cliente não Existe");
      }
      ac.desconecta();
    }
    btEmprestar.setEnabled(((exCliente) && (exFilme)));  
  }

  private void sairEdCodFilme() {
    Acesso ac = new Acesso();
    if (ac.conecta()) {
      exFilme = (ac.veExiste("filme where (cod_filme = '" + edCodFilme.getText() + 
        "') and (sit_filme = 'L')") > 0);
      edCodFilme.setEnabled(((exFilme) ? false : true));
      if (exFilme) { // Pesquisa Resto
        String[] rCampos = new String[1];
        ac.retCampos(rCampos, "nom_filme", 
          "Filme where (cod_filme = '" + edCodFilme.getText() + "')");
        lbNomFilme.setText(rCampos[0]);
      } else {
        lbNomFilme.setText("Filme não Disponível");
      }
      ac.desconecta();
    }
    btEmprestar.setEnabled(((exCliente) && (exFilme)));  
  }

  private void acaoBtLimpar() {
    btEmprestar.setEnabled(false);
    exCliente = false;
    exFilme = false;
    edCodCliente.setEnabled(true);
    edCodFilme.setEnabled(true);
    edCodCliente.setText("");
    edCodFilme.setText("");
    lbNomCliente.setText("");
    lbNomFilme.setText("");
    edCodCliente.requestFocus();
  }

  private void acaoBtEmprestar() {
    Acesso ac = new Acesso();
    if (ac.conecta()) {
      ac.execSQL("Insert into Locacao (cod_cliente, cod_filme) " + 
        "values ('" + edCodCliente.getText() + "', '" + edCodFilme.getText() + "')");
      ac.execSQL("Update Filme set sit_filme = 'A' " + 
        " where cod_filme ='" + edCodFilme.getText() + "'");
      ac.desconecta();
      btEmprestar.setEnabled(false);
		exFilme = false;
      lbNomFilme.setText("");
      edCodFilme.setText("");
      edCodFilme.setEnabled(true);
      edCodFilme.requestFocus();
    }
  }

  private void aoFechar(WindowEvent e) {
    dispose();
  }
}
