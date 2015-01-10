import java.awt.*;
import java.awt.event.*;
import java.util.*;
import java.io.*;

public class BrincIni extends Frame {

  public BrincIni() {
    // Cria uma lista de Propriedades Vazia
    Properties propIni = new Properties();
    // Define as propriedades padrão
    propIni.put("Tamanho", "300 200");
    propIni.put("Mensagem", "Parâmetros Default");
    propIni.put("Cores", "250 50 50");
    try {      
      // Carrega um arquivo do tipo InputStream
      FileInputStream sf = new FileInputStream("teste.ini");
      // Carrega o arquivo de propriedades a partir deste
      propIni.load(sf);
    } catch (FileNotFoundException e) {
      // Se o arquivo não existe Salva
      try {
        PrintWriter grvIni = new PrintWriter(
			       new FileWriter("teste.ini"));
        grvIni.println("Tamanho="+propIni.getProperty("Tamanho"));
        grvIni.println("Mensagem="+propIni.getProperty("Mensagem"));
        grvIni.println("Cores="+propIni.getProperty("Cores"));
        grvIni.close();
      } catch (IOException e1) {}
    } catch (IOException e) {}
    // Lê as propriedades carregadas

    // Pega a Cor
    StringTokenizer stIni = new StringTokenizer(propIni.getProperty("Cores"));
    int verm = Integer.parseInt(stIni.nextToken());
    int verd = Integer.parseInt(stIni.nextToken());
    int azul = Integer.parseInt(stIni.nextToken());
    setBackground(new Color(verm, verd, azul));
    // Pega a Mensagem
    setTitle(propIni.getProperty("Mensagem"));
    // Pega o Tamanho da Janela
    stIni = new StringTokenizer(propIni.getProperty("Tamanho"));
    int horz = Integer.parseInt(stIni.nextToken());
    int vert = Integer.parseInt(stIni.nextToken());
    setSize(horz, vert);

    this.addWindowListener(new WindowAdapter() {
      public void windowClosing(WindowEvent e) {
        System.exit(0);
      }
    });
  }

  public static void main(String[] args) {
    BrincIni aplic = new BrincIni();
    aplic.show();
  }
  
}