/**
 * CLASSE CadCliente
 * ------------------------------------
 * Sistema..: Locadora
 * Descrição: Janela de Cadastro dos Clientes
 * Direitos.: Java JDBC (c) Visual Books - 2001
 * Autor....: Fernando Anselmo
 * Versão...: 1.0
 */

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class CadCliente extends JFrame {
  // Criação dos Objetos
  private JLabel JLabel1 = new JLabel("Código:");
  private JLabel JLabel2 = new JLabel("Nome:");
  private JTextField edCodigo = new JTextField("");
  private JTextField edNome = new JTextField("");
  private JButton btGravar = new JButton("Gravar");
  private JButton btExcluir = new JButton("Excluir");
  private JButton btLimpar = new JButton("Limpar");
  // Variáveis Utilizadas
  private boolean altera;
  // Constructor da Classe
  public CadCliente() {
    try {
      mostra();
    } catch(Exception ex) {
      ex.printStackTrace();
    }
  }
  // Montagem da Janela
  public void mostra() throws Exception {
    this.getContentPane().setLayout(null);
    this.setSize(409, 148);
    this.setTitle("Cadastro de Clientes");
    this.setResizable(false);
    JLabel1.setBounds(new Rectangle(35, 17, 57, 13));
    this.getContentPane().add(JLabel1, null);
    JLabel2.setBounds(new Rectangle(42, 48, 50, 13));
    this.getContentPane().add(JLabel2, null);
    edCodigo.setBounds(new Rectangle(92, 14, 100, 21));
    this.getContentPane().add(edCodigo, null);
    edCodigo.addFocusListener (new FocusAdapter() {
      public void focusLost(FocusEvent e) {
        sairEdCodigo(e);
    }});
    edNome.setBounds(new Rectangle(92, 45, 300, 21));
    this.getContentPane().add(edNome, null);
    btGravar.setBounds(new Rectangle(10, 86, 100, 30));
    this.getContentPane().add(btGravar, null);
    btGravar.addActionListener (new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        acaoBtGravar(e);
    }});
    btExcluir.setBounds(new Rectangle(114, 86, 100, 30));
    this.getContentPane().add(btExcluir, null);
    btExcluir.addActionListener (new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        acaoBtExcluir(e);
    }});
    btLimpar.setBounds(new Rectangle(218, 86, 100, 30));
    this.getContentPane().add(btLimpar, null);
    btLimpar.addActionListener (new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        acaoBtLimpar(e);
    }});
    this.addWindowListener(new WindowAdapter() {
      public void windowClosing(WindowEvent e) {
        aoFechar(e);
      }
    });
  }
  // Ao Sair do Código
  private void sairEdCodigo(FocusEvent e) {
    Acesso ac = new Acesso();
    if (ac.conecta()) {
      altera = (ac.veExiste("Cliente where (cod_cliente = '" + edCodigo.getText() + "')") > 0);
      edCodigo.setEnabled(((altera) ? false : true));
      if (altera) { // Pesquisa Resto
        String[] rCampos = new String[1];
        ac.retCampos(rCampos, "nom_cliente", 
          "Cliente where (cod_cliente = '" + edCodigo.getText() + "')");
        edNome.setText(rCampos[0]);
      }
      ac.desconecta();
    }
  }
  // Gravar
  private void acaoBtGravar(ActionEvent e) {
    Acesso ac = new Acesso();
    if (ac.conecta()) {
      if (altera) {
        ac.execSQL("Update cliente Set " + 
          "nom_cliente = '" + edNome.getText() + "' " +
          "Where (cod_cliente = '" + edCodigo.getText() + "')");
      } else {
        ac.execSQL("Insert into cliente (cod_cliente, nom_cliente) " + 
           "values ('" + edCodigo.getText() +
           "', '" + edNome.getText() + "')");
      }
      ac.desconecta();
      acaoBtLimpar(e);
    }
  }
  // Excluir
  private void acaoBtExcluir(ActionEvent e) {
    if (altera) {
      Acesso ac = new Acesso();
      if (ac.conecta()) {
        ac.execSQL("Delete from cliente " + 
           "where (cod_cliente = '" + edCodigo.getText() + "')");
        ac.desconecta();
        acaoBtLimpar(e);
      }
    }
  }
  // Limpar
  private void acaoBtLimpar(ActionEvent e) {
    edCodigo.setText("");
    edNome.setText("");
    edCodigo.setEnabled(true);
    edCodigo.requestFocus();
  }
  // Ao fechar a Janela
  private void aoFechar(WindowEvent e) {
    dispose();
  }
}