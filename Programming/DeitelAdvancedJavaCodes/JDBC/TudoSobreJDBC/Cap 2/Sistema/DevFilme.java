/* CLASSE DevFilme
 * ------------------------------------
 * Sistema..: Locadora
 * Descrição: Devolução dos Filmes
 * Direitos.: Java JDBC (c) Visual Books - 2001
 * Autor....: Fernando Anselmo
 * Versão...: 1.0
 */

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class DevFilme extends JDialog {

  private JLabel JLabel1 = new JLabel("Cliente:");
  private JLabel JLabel2 = new JLabel("Filmes Alugados");
  private JComboBox cbCliente = new JComboBox();
  private JList lsFilme = new JList();
  private JScrollPane jScrollPane1 = new JScrollPane();
  private JButton btDevolver = new JButton("Devolver");

  public DevFilme() {
    try {
      mostra();
      carrCliente();
    } catch(Exception ex) {
      ex.printStackTrace();
    }
  }

  public void mostra() throws Exception {
    this.getContentPane().setLayout(null);
    this.setSize(292, 316);
    this.setTitle("Devolução de Filmes");
    this.setResizable(false);
    this.setModal(true);

    JLabel1.setBounds(new Rectangle(9, 21, 57, 13));
    this.getContentPane().add(JLabel1, null);
    JLabel2.setBounds(new Rectangle(17, 58, 100, 13));
    this.getContentPane().add(JLabel2, null);
    cbCliente.setBounds(new Rectangle(75, 16, 200, 21));
    this.getContentPane().add(cbCliente, null);
    cbCliente.addActionListener (new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        acertaFilme();
    }});
    jScrollPane1.setBounds(new Rectangle(15, 78, 260, 160));
    jScrollPane1.getViewport().add(lsFilme, null);
    this.getContentPane().add(jScrollPane1, null);
    btDevolver.setBounds(new Rectangle(175, 247, 100, 30));
    this.getContentPane().add(btDevolver, null);
    btDevolver.addActionListener (new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        acaoBtDevolver();
    }});

    this.addWindowListener(new WindowAdapter() {
      public void windowClosing(WindowEvent e) {
        aoFechar(e);
      }
    });
  }

  private void carrCliente() {
    Acesso ac = new Acesso();
    if (ac.conecta()) {
      ac.carrCombo(cbCliente, "cl.NOM_CLIENTE", 
        "Cliente cl INNER JOIN Locacao lc " +
        " ON cl.COD_CLIENTE = lc.COD_CLIENTE " +
		  "GROUP BY NOM_CLIENTE");
		ac.desconecta();
	 }
  }

  private void acertaFilme() {
    Acesso ac = new Acesso();
    if (ac.conecta()) {
      ac.carrLista(lsFilme, "fm.NOM_FILME", 
        "(Cliente AS cl INNER JOIN " +
        "Locacao AS lc ON cl.COD_CLIENTE = " +
        "lc.COD_CLIENTE) INNER JOIN Filme fm " + 
        "ON lc.COD_FILME = fm.COD_FILME " +
        "WHERE cl.NOM_CLIENTE = '" + cbCliente.getSelectedItem() + "'");
		ac.desconecta();
	 }
  }

  private void acaoBtDevolver() {
    Acesso ac = new Acesso();
    if (ac.conecta()) {
      String codCliente = ac.trazCodigo(
        "COD_CLIENTE FROM CLIENTE " +
        "WHERE NOM_CLIENTE = '" + cbCliente.getSelectedItem() + "'");
      String codFilme = "";
      while ((codFilme = ac.trazCodigo("COD_FILME FROM LOCACAO " +
        "WHERE COD_CLIENTE = '" + codCliente + "'")).length() > 0) {
        ac.execSQL("Update filme set sit_filme = 'L' " + 
          "where (cod_filme = '" + codFilme + "')");
        ac.execSQL("Delete from Locacao " + 
          "Where (cod_cliente = '" + codCliente + "') " +
          "  And (cod_filme = '" + codFilme + "')");
      }
		ac.desconecta();
    }
    carrCliente();
  }  

  private void aoFechar(WindowEvent e) {
    dispose();
  }
}