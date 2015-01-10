/**
 * CLASSE ResultsModel
 * ------------------------------------
 * Sistema..: Vendas
 * Descrição: Esta classe monta o objeto AbstractTableModel
 * Direitos.: Java JDBC (c) Visual Books - 2001
 * Autor....: Fernando Anselmo
 * Versão...: 1.0
 */

import java.util.*;
import javax.swing.table.*;
import javax.swing.*;

class ResultsModel extends AbstractTableModel {
  private String [] columnNames;
  private Vector dataRows;
  private Acesso ac = new Acesso();

  public void setResultSet(String query) {
    if (ac.conecta()) {
      columnNames = ac.carrNomes(query);
      dataRows = ac.carrVetor(query);
      ac.desconecta();
    }
  }
  
  public int getColumnCount() {
    return columnNames.length;  
  }
  
  public int getRowCount() {
    if (dataRows == null) {
      return 0;
    } else {
      return dataRows.size();  
    }
  }
  
  public Object getValueAt(int row, int col) {
    return ((String[])(dataRows.elementAt(row)))[col];
  }
  
  public String getColumnName(int col) {
    return columnNames[col] == null ? "Sem nome" : columnNames[col]; 
  }
}