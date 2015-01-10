/**
 * CLASSE JanSenha
 * ------------------------------------
 * Sistema..: Locadora
 * Descrição: Janela que solicita a identificação do usuário
 * Direitos.: Java JDBC (c) Visual Books - 2001
 * Autor....: Fernando Anselmo
 * Versão...: 1.0
 */

import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class JanSenha extends JDialog {
  // Criação dos Objetos
  private JLabel JLabel1 = new JLabel("Usuário:");
  private JTextField edUsuario = new JTextField("",8);
  private JPasswordField edSenha = new JPasswordField("",8);
  private JLabel JLabel2 = new JLabel("Senha:");
  private JButton btOk = new JButton("OK");
  private JButton btCancelar = new JButton("Cancelar");
  private JLabel lbStatus = new JLabel("Informe o Usuário e a Senha");
  // Variáveis de Suporte
  public boolean volta = false;
  public String login = "";
  public String senha = "";
  // Constructor do Objeto
  public JanSenha() {
    try {
      mostra();
    }
    catch(Exception ex) {
      ex.printStackTrace();
    }
  }
  // Montagem da Janela
  public void mostra() throws Exception {
    this.getContentPane().setLayout(null);
    this.setSize(264, 197);
    this.setResizable(false);
    this.setModal(true);
    this.setTitle("Entrada do Sistema");
    // Cria os Controles na Janela
    JLabel1.setBounds(new Rectangle(48, 28, 57, 13));
    this.getContentPane().add(JLabel1, null);
    edUsuario.setBounds(new Rectangle(110, 24, 100, 21));
    this.getContentPane().add(edUsuario, null);
    edSenha.setBounds(new Rectangle(110, 53, 100, 21));
    this.getContentPane().add(edSenha, null);
    JLabel2.setBounds(new Rectangle(52, 56, 57, 13));
    this.getContentPane().add(JLabel2, null);
    btOk.setBounds(new Rectangle(6, 97, 100, 30));
    btOk.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        acaoBtOk(e);
      }
    });
    this.getContentPane().add(btOk, null);
    btCancelar.setBounds(new Rectangle(146, 97, 100, 30));
    this.getContentPane().add(btCancelar, null);
    btCancelar.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        acaoBtCancelar(e);
      }
    });
    lbStatus.setBounds(new Rectangle(27, 147, 200, 13));
    this.getContentPane().add(lbStatus, null);
  }
  // Eventos da Janela
  private String devSenha(char[] senInfor) {
    String devString = "";
    for (int i = 0; i < senInfor.length; i++) {
      devString += senInfor[i];
    }
    return devString;
  }
  // Ao pressionar o botão OK
  private void acaoBtOk(ActionEvent e) {
    Acesso ac = new Acesso();
    senha = devSenha(edSenha.getPassword());
    login = edUsuario.getText();
    if (ac.conecta()) {
      volta = (ac.veExiste("usuario where des_login = '" + login +
        "' and des_senha = '" + senha + "'") > 0);
      ac.desconecta();
    }
    if (volta) {
      dispose();
    }
  }
  // Ao pressionar o botão Cancelar
  private void acaoBtCancelar(ActionEvent e) {
    dispose();
  }
}