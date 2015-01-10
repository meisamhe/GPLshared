/**
 * CLASSE Acesso
 * ------------------------------------
 * Sistema..: Vendas
 * Descrição: Esta classe fará o papel da camada intermediária de
 *            Acesso ao banco de dados.
 * Direitos.: Java JDBC (c) Visual Books - 2001
 * Autor....: Fernando Anselmo
 * Versão...: 1.0
 */

import java.sql.*;
import javax.swing.*;
import java.util.*;

public class Acesso {
  private Connection con;
  final static public String url = "jdbc:mysql://localhost:3306/vendas";
  final static public String drv = "org.gjt.mm.mysql.Driver";
  
  /** + conecta(): boolean
   * ------------------------------------
   * Estabelece uma conexão com o banco de dados devolvendo
   * uma resposta lógica que indica se o Acesso foi estabelecido
   * ou não
   */
  public boolean conecta() {
    boolean retorno = true;
    try {
      Class.forName(drv);
      con = DriverManager.getConnection(url,"","");
    } catch (java.lang.ClassNotFoundException er1) {
      System.out.println(er1.getMessage());
      retorno = false;
    } catch (SQLException er2) {
      System.out.println(er2.getMessage());
      retorno = false;
    }
    return retorno;
  }

  /** + desconecta()
   * ------------------------------------
   * Encerra a conexão com o banco de dados
   */
  public void desconecta() {
    try {
      con.close();
    } catch (SQLException er2) {
      System.out.println(er2.getMessage());
    }
  }

  /** + veExiste(par1: String): int
   * ------------------------------------
   * Recebe (em par1) um complemento para uma Query 
   * [SELECT COUNT(*) FROM] do tipo [tabela WHERE condicao] 
   * e devolve o total de registros encontrados
   */
  public int veExiste(String cmplQuery) {
    int valor = 0;
    try {
      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery("Select COUNT(*) From " + cmplQuery);
      rs.next();
      valor = rs.getInt(1);
      rs.close();
      stmt.close();
    } catch (SQLException er) {
      System.out.println("Problemas na Query: Select COUNT(*) From " + cmplQuery);
    }
    return valor;
  }      

  /** + retCampos(par1: String[], par2: String, par3: String)
   * ------------------------------------
   * Recebe complementos de uma determinada query do tipo
   * SELECT [par2] FROM [par3] e devolve o array definido (em par1)
   * as colunas de um registro desta query
   */
  public void retCampos(String[] cmps, String qry1, String qry2) {
    try {
      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery("Select " + qry1 + " From " + qry2);
      if (rs.next()) {
        for (int i = 0; i < cmps.length; i++) {
          cmps[i] = rs.getString(i + 1);
        }
      }
      rs.close();
      stmt.close();
    } catch (SQLException er) {
      System.out.println("Problemas na Query: Select " + qry1 + " From " + qry2);
    }
  }      
      
  /** + trazLinhas(par1: String[], par2: String)
   * ------------------------------------
   * Recebe complementos de uma determinada query do tipo
   * SELECT [par2] e devolve o array definido (em par1)
   * com todas as linhas de um campo desta query
   */
  public void trazLinhas(String[] cmps, String qry) {
    try {
      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery("Select " + qry);
      int i = 0;
      while (rs.next())
        cmps[i++] = rs.getString(1);
      rs.close();
      stmt.close();
    } catch (SQLException er) {
      System.out.println("Problemas na Query: Select " + qry);
    }
  }      

  /** + execSQL(par1: String): int
   * ------------------------------------
   * Recebe uma query (em par1) do tipo manutenção de dados 
   * que pode ser:
   *   INSERT INTO tabela (cmp1, cmp2) VALUES (val1, val2)
   *   UPDATE tabela SET cmp1 = val1 WHERE condição
   *   DELETE FROM tabela WHERE condição
   * e devolve um valor inteiro com o total de linha afetadas
   */
  public int execSQL(String qry) {
    int valor = 0;
    try {
      Statement stmt = con.createStatement();
      valor = stmt.executeUpdate(qry);
      stmt.close();
    } catch (SQLException er) {
      System.out.println("Problemas na Query " + qry);
    }
    return valor;
  }      

  /** + trazCodigo(par1: String): String
   * ------------------------------------
   * Retorna um único campo baseado em uma Query enviada
   * através do par1
   */
  public String trazCodigo(String qry) {
    String cmp = "";
    Statement stm;
    try {
      stm = con.createStatement();
      ResultSet rs = stm.executeQuery("Select " + qry);
      if (rs.next()) {
        cmp = rs.getString(1);
      }
    } catch (SQLException e) {
     System.out.println("Problemas na Query: Select " + qry);
    }
    return cmp;
  }

  /** + carrLista(par1: JList, par2, par3: String)
   * ------------------------------------
   * Carrega um objeto do tipo JList (recebido em par1)
   * baseado no complemento de uma determinada query do tipo
   * SELECT [par2] FROM [par3].
   */
  public void carrLista(JList lista, String qry1, String qry2) {
    try {
      Vector linha = new Vector();
      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery("Select " + qry1 + " From " 
        +  qry2);
      while (rs.next()) {
        linha.addElement(rs.getString(1));
      }
      lista.setListData(linha); 
      rs.close();
      stmt.close();
    } catch (SQLException er) {
     System.out.println("Problemas na Query: Select " + qry1 + " From " + qry2);
    }
  }      

  /** + carrCombo(par1: JComboBox, par2, par3: String)
   * ------------------------------------
   * Carrega um objeto do tipo JComboBox (recebido em par1)
   * baseado no complemento de uma determinada query do tipo
   * SELECT [par2] FROM [par3].
   */
  public void carrCombo(JComboBox combo, String qry1, String qry2) {
    try {
      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery("Select " + qry1 + " From " 
        +  qry2);
      combo.removeAllItems();
      while (rs.next()) {
        combo.addItem(rs.getString(1));
      }
      rs.close();
      stmt.close();
    } catch (SQLException er) {
     System.out.println("Problemas na Query: Select " + qry1 + " From " + qry2);
    }
  }      

  /** + carrCombo(par1: JComboBox, par2: String[], par3: String)
   * ------------------------------------
   * Recebe complemento de uma determinada query do tipo
   * SELECT [par2] e carrega um JComboBox preenchido (em par1)
   * com o 1o. cmp desta query e um Array com o 2o. cmp
   */
  public void carrCombo(JComboBox carrCombo, String[] cods, String qry) {
    int i = 0;
    try {
      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery("Select " + qry);
      while (rs.next()) {
        carrCombo.addItem(rs.getString(1));
        cods[i] = rs.getString(2);
        i++;
      }
      rs.close();
      stmt.close();
    } catch (SQLException err) {
      System.out.println("Problemas na Query: Select " + qry);
    }
  }      

  /** + carrNomes(par1: String[], par2: String)
   * ------------------------------------
   * Carrega um Array (em par1) com os nomes dos campos 
   * através do SQL determinado (com o este passado por par2).
   */
  public String[] carrNomes(String qry) {
    String[] colNomes = new String[0];
    try {
      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery("Select " + qry);
      ResultSetMetaData rsmd = rs.getMetaData();
      int nCol = rsmd.getColumnCount();
      colNomes = new String[nCol];
      for (int i = 0; i < nCol; i++) {
        colNomes[i] = rsmd.getColumnName(i+1);
      }
      rs.close();
    } catch (SQLException err) {
      System.out.println("Problemas na Query: Select " + qry);
    }
    return colNomes;
  }

  /** + carrVetor(par2: String)
   * ------------------------------------
   * Devolve um do tipo Vetor baseado no complemento
   * de uma determinada Query (em par1)
   */
  public Vector carrVetor(String qry) {
    Vector vetResp = new Vector();
    String[] dados;
    try {
      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery("SELECT " + qry);
      ResultSetMetaData rsmd = rs.getMetaData();
      int nCol = rsmd.getColumnCount();
      // Carrega o Vetor
      while (rs.next()) {
        dados = new String[nCol];
        for (int i = 0; i < nCol; i++) {
          dados[i] = rs.getString(i+1);
        }          
        vetResp.addElement(dados);
      }
      rs.close();
      stmt.close();
    } catch (SQLException err) {
      System.out.println("Problemas na Query: Select " + qry);
    }
    return vetResp;
  }      
}