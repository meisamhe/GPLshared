/* CLASSE MntItemPedido
 * ------------------------------------
 * Sistema..: Vendas
 * Descrição: Esta classe montará a Janela dos Items de Pedido
 * Direitos.: Java JDBC (c) Visual Books - 2001
 * Autor....: Fernando Anselmo
 * Versão...: 1.0
 */

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class MntItemPedido extends JDialog {

  private JLabel lbItemPedido = new JLabel("Item: 100");
  private JLabel JLabel2 = new JLabel("Material:");
  private JLabel JLabel3 = new JLabel("Quantid.:");
  private JButton btCancelar = new JButton("Cancelar");
  private JButton btGravar = new JButton("Grava");
  private JComboBox cbMaterial = new JComboBox();
  private JTextField edQuantidade = new JTextField("");
  private String[] codMater;
  private int numPedido;

  public MntItemPedido(int nPedido) {
    try {
      numPedido = nPedido;
      mostra();
    } catch(Exception ex) {
      ex.printStackTrace();
    }
  }

  public void mostra() throws Exception {

    this.getContentPane().setLayout(null);
    this.setSize(347, 162);
    this.setTitle("Item do Pedido");
    this.setResizable(false);
    this.setModal(true);

    lbItemPedido.setText("Item: " + numPedido);
    lbItemPedido.setBounds(new Rectangle(31, 13, 57, 13));
    this.getContentPane().add(lbItemPedido, null);
    JLabel2.setBounds(new Rectangle(8, 36, 57, 13));
    this.getContentPane().add(JLabel2, null);
    JLabel3.setBounds(new Rectangle(8, 60, 57, 13));
    this.getContentPane().add(JLabel3, null);
    btCancelar.setBounds(new Rectangle(227, 99, 100, 30));
    this.getContentPane().add(btCancelar, null);
    btCancelar.addActionListener (new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        dispose();
    }});
    btGravar.setBounds(new Rectangle(116, 99, 100, 30));
    this.getContentPane().add(btGravar, null);
    btGravar.addActionListener (new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        incItem();
    }});
    carrMaterial();
    cbMaterial.setBounds(new Rectangle(67, 31, 260, 21));
    this.getContentPane().add(cbMaterial, null);
    edQuantidade.setBounds(new Rectangle(67, 56, 100, 21));
    this.getContentPane().add(edQuantidade, null);
    this.addWindowListener(new java.awt.event.WindowAdapter() {
       public void windowClosing(WindowEvent e) {
          dispose();
       }
    });
  }

  private void carrMaterial() {
    Acesso ac = new Acesso();
    if (ac.conecta()) {
      codMater = new String[ac.veExiste("MERCADORIA")];
      ac.carrCombo(cbMaterial, codMater, "DES_MERCADORIA, COD_MERCADORIA from MERCADORIA");
      ac.desconecta();  
    }
  }
  
  private void incItem() {
    Acesso ac = new Acesso();
    if (ac.conecta()) {
      // Pega a quantidade de itens de pedido existente somando mais 1
      int numItPedido = ac.veExiste("ItemPedido Where Num_Pedido = " + numPedido) + 1;
      // Monta o Insert
      String qry = "Insert Into ItemPedido (Num_Pedido, Num_Item_Pedido, Cod_Mercadoria, Qtd_Vendida) values (" + 
        numPedido + ", " + 
        numItPedido + ", " +
        codMater[cbMaterial.getSelectedIndex()] + ", " + 
        edQuantidade.getText() + ")";
      // Executa
      ac.execSQL(qry);
      ac.desconecta();  
    }
  }
  
}
