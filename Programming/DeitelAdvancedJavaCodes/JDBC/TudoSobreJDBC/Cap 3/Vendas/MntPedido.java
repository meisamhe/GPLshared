/**
 * CLASSE MntPedido
 * ------------------------------------
 * Sistema..: Vendas
 * Descrição: Esta classe montará a Janela dos Pedidos
 * Direitos.: Java JDBC (c) Visual Books - 2001
 * Autor....: Fernando Anselmo
 * Versão...: 1.0
 */

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.util.*;
import java.text.*;

public class MntPedido extends JDialog {
  private JLabel lbPedido = new JLabel("Pedido Nº");
  private JLabel JLabel2 = new JLabel("Vendedor:");
  private JComboBox cbVendedor = new JComboBox();
  private JScrollPane jScrollPane1 = new JScrollPane();
  private JButton btInclui = new JButton("Inclui Pedido");
  private JComboBox cbNumPedido = new JComboBox();
  // Objetos de uso geral
  private MontaGrid pedido;
  private String[] codVend;

  public MntPedido() {
    try {
      mostra();
      carrVendedor();
      carrNumPedido();
    } catch(Exception ex) {
      ex.printStackTrace();
    }
  }

  public void mostra() throws Exception {
    this.getContentPane().setLayout(null);
    this.setSize(425, 419);
    this.setTitle("Pedidos");
    this.setResizable(false);
    this.setModal(true);
    lbPedido.setBounds(new Rectangle(11, 14, 60, 13));
    this.getContentPane().add(lbPedido, null);
    JLabel2.setBounds(new Rectangle(13, 41, 60, 13));
    this.getContentPane().add(JLabel2, null);
    cbVendedor.setBounds(new Rectangle(77, 38, 330, 21));
    this.getContentPane().add(cbVendedor, null);
    jScrollPane1.setBounds(new Rectangle(10, 69, 400, 280));
    this.getContentPane().add(jScrollPane1, null);
    btInclui.setBounds(new Rectangle(10, 357, 130, 30));
    this.getContentPane().add(btInclui, null);
    btInclui.addActionListener (new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        incPedido();
    }});
    cbNumPedido.setBounds(new Rectangle(77, 10, 130, 21));
    this.getContentPane().add(cbNumPedido, null);
    cbNumPedido.addActionListener (new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        carrPedido();
    }});
    this.addWindowListener(new java.awt.event.WindowAdapter() {
      public void windowClosing(WindowEvent e) {
        aoFechar(e);
      }
    });
  }

  private void aoFechar(WindowEvent e) {
    System.exit(0);
  }

  private void carrVendedor() {
    Acesso ac = new Acesso();
    if (ac.conecta()) {
      codVend = new String[ac.veExiste("VENDEDOR")];
      ac.carrCombo(cbVendedor, codVend, 
        "NOM_VENDEDOR, CPF_VENDEDOR from VENDEDOR");
      ac.desconecta();  
    }
  }  

  private void carrNumPedido() {
    int numPedido = 0;
    Acesso ac = new Acesso();
    if (ac.conecta()) {
      numPedido = ac.veExiste("PEDIDO") + 2;
      ac.desconecta();  
    }
    cbNumPedido.removeAllItems();
    for (int i = 1; i < numPedido; i++)
      cbNumPedido.addItem(""+i);
  }
    
  private void incPedido() {
    // Verifica se já existe o pedido
    Acesso ac = new Acesso();
    if (ac.conecta()) {
      if (ac.veExiste("PEDIDO Where NUM_PEDIDO = " + cbNumPedido.getSelectedItem()) == 0) {
        // Acerta a Data
        Date hoje = new Date();
        SimpleDateFormat formatData = new SimpleDateFormat("yyyy/MM/dd");
        String hojeString = formatData.format(hoje);
        // Grava o Pedido
        String qry = "Insert Into Pedido (Num_Pedido, Cpf_Vendedor, Dat_Venda) values (" + 
          cbNumPedido.getSelectedItem() + ", '" + 
          codVend[cbVendedor.getSelectedIndex()] + "', " + 
          hojeString + ")";
        ac.execSQL(qry);
      }
      ac.desconecta();
      // Chama a Tela para efetuar o item de pedido
      MntItemPedido janela = new MntItemPedido(Integer.parseInt("" + cbNumPedido.getSelectedItem()));
      janela.show();
      // Recarrega os Pedidos no Combo
      carrNumPedido();
    }
  }

  private void carrPedido() {
    pedido = new MontaGrid(
      "ip.NUM_ITEM_PEDIDO Item, m.DES_MERCADORIA Mercadoria, ip.QTD_VENDIDA Qtd" +
      " FROM ITEMPEDIDO ip, MERCADORIA m WHERE (m.COD_MERCADORIA = ip.COD_MERCADORIA)" + 
      " and (ip.NUM_PEDIDO = " + cbNumPedido.getSelectedItem() + ")");
    jScrollPane1.getViewport().add(pedido, null);
  }  

  public static void main(String args[]) {
    MntPedido janela = new MntPedido();
    janela.show();
  }
}