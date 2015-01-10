/**
 * CLASSE MontaGrid
 * ------------------------------------
 * Sistema..: Vendas
 * Descrição: Esta classe criará um Painel com o Grid de Pedidos
 * Direitos.: Java JDBC (c) Visual Books - 2001
 * Autor....: Fernando Anselmo
 * Versão...: 1.0
 */

import javax.swing.*;
import javax.swing.table.*;

public class MontaGrid extends JPanel {
  // ***
  public MontaGrid(String qry) {
    ResultsModel model = new ResultsModel();
    model.setResultSet(qry);
    JTable tabela = new JTable(model);
    JScrollPane scr = new JScrollPane(tabela);
    this.removeAll();
    this.add(scr);
  } 
}