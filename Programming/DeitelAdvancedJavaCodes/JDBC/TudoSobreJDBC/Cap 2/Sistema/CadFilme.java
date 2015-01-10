/**
 * CLASSE CadFilme
 * ------------------------------------
 * Sistema..: Locadora
 * Descrição: Janela de Cadastro dos Filmes
 * Direitos.: Java JDBC (c) Visual Books - 2001
 * Autor....: Fernando Anselmo
 * Versão...: 1.0
 */

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class CadFilme extends JDialog {
  // Criação dos Objetos
  private JLabel JLabel1 = new JLabel("Código:");
  private JLabel JLabel2 = new JLabel("Nome:");
  private JLabel JLabel3 = new JLabel("Loc.Imagem:");
  private JTextField edCodigo = new JTextField("");
  private JTextField edNome = new JTextField("");
  private JTextField edLocal = new JTextField("");
  private JButton btGravar = new JButton("Gravar");
  private JButton btExcluir = new JButton("Excluir");
  private JButton btLimpar = new JButton("Limpar");
  // Variáveis Utilizadas
  private boolean altera;
  // Constructor da Classe
  public CadFilme() {
    try {
      mostra();
    } catch(Exception ex) {
      ex.printStackTrace();
    }
  }
  // Montagem da Janela
  public void mostra() throws Exception {
    this.getContentPane().setLayout(null);
    this.setSize(409, 182);
    this.setTitle("Cadastro de Filmes");
    this.setResizable(false);
    this.setModal(true);
    JLabel1.setBounds(new Rectangle(35, 17, 57, 13));
    this.getContentPane().add(JLabel1, null);
    JLabel2.setBounds(new Rectangle(42, 48, 50, 13));
    this.getContentPane().add(JLabel2, null);
    JLabel3.setBounds(new Rectangle(10, 78, 80, 13));
    this.getContentPane().add(JLabel3, null);
    edCodigo.setBounds(new Rectangle(92, 14, 100, 21));
    this.getContentPane().add(edCodigo, null);
    edCodigo.addFocusListener (new FocusAdapter() {
      public void focusLost(FocusEvent e) {
        sairEdCodigo(e);
    }});
    edNome.setBounds(new Rectangle(92, 45, 300, 21));
    this.getContentPane().add(edNome, null);
    edLocal.setBounds(new Rectangle(92, 75, 300, 21));
    this.getContentPane().add(edLocal, null);
    btGravar.setBounds(new Rectangle(10, 120, 100, 30));
    this.getContentPane().add(btGravar, null);
    btGravar.addActionListener (new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        acaoBtGravar(e);
    }});
    btExcluir.setBounds(new Rectangle(114, 120, 100, 30));
    this.getContentPane().add(btExcluir, null);
    btExcluir.addActionListener (new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        acaoBtExcluir(e);
    }});
    btLimpar.setBounds(new Rectangle(218, 120, 100, 30));
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
      altera = (ac.veExiste("filme where (cod_filme = '" + edCodigo.getText() + "')") > 0);
      edCodigo.setEnabled(((altera) ? false : true));
      if (altera) { // Pesquisa Resto
        String[] rCampos = new String[2];
        ac.retCampos(rCampos, "nom_filme, loc_imagem", 
          "Filme where (cod_filme = '" + edCodigo.getText() + "')");
        edNome.setText(rCampos[0]);
        edLocal.setText(rCampos[1]);
      }
      ac.desconecta();
    }
  }
  // Gravar
  private void acaoBtGravar(ActionEvent e) {
    Acesso ac = new Acesso();
    if (ac.conecta()) {
      if (altera) {
        ac.execSQL("Update filme Set " + 
          "nom_filme = '" + edNome.getText() + "', " +
          "loc_imagem = '" + edLocal.getText() + "' " +
          "Where (cod_filme = '" + edCodigo.getText() + "')");
      } else {
        ac.execSQL("Insert into filme (cod_filme, nom_filme, sit_filme, loc_imagem) " + 
           "values ('" + edCodigo.getText() +
           "', '" + edNome.getText() + "', 'L','" + 
           edLocal.getText() + "')");
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
        ac.execSQL("Delete from filme " + 
           "where (cod_filme = '" + edCodigo.getText() + "')");
        ac.desconecta();
        acaoBtLimpar(e);
      }
    }
  }
  // Limpar
  private void acaoBtLimpar(ActionEvent e) {
    edCodigo.setText("");
    edNome.setText("");
    edLocal.setText("");
    edCodigo.setEnabled(true);
    edCodigo.requestFocus();
  }
  // Ao fechar a Janela
  private void aoFechar(WindowEvent e) {
    dispose();
  }
}