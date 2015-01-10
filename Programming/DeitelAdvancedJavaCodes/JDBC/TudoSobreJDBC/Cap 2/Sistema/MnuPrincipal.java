/**
 * CLASSE MnuPrincipal
 * ------------------------------------
 * Sistema..: Locadora
 * Descrição: Menu Principal do Sistema
 * Direitos.: Java JDBC (c) Visual Books - 2001
 * Autor....: Fernando Anselmo
 * Versão...: 1.0
 * ------------------------------------
 * SUBCLASSES 
 *   JanSobre  - Janela Sobre o Sistema
 *   JanSplash - Janela Splash
 */

import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class MnuPrincipal extends JFrame {

  // Objetos Utilizados
  private JMenuBar meuMenu = new JMenuBar();
  private JMenu mArquivo = new JMenu("Arquivo");
  private JMenu mCadastro = new JMenu("Cadastro");
  private JMenuItem miFilme = new JMenuItem("Filme");
  private JMenuItem miCliente = new JMenuItem("Cliente");
  private JMenuItem miSair = new JMenuItem("Sair");
  private JMenu mMovimenta = new JMenu("Movimentação");
  private JMenuItem miAluguel = new JMenuItem("Aluguel");
  private JMenuItem miDevolucao = new JMenuItem("Devolução");
  private JMenuItem miMstFilme = new JMenuItem("Mostra Filme");
  private JMenu mAuxilio = new JMenu("Auxílio");
  private JMenuItem miSobre = new JMenuItem("Sobre...");
  // ***
  private JLabel lbUsuario = new JLabel("Usuário Autorizado: xxx");

  // Variáveis Utilizadas
  private static Thread run = new Thread();

  // Constructor do Objeto
  public MnuPrincipal() {
    try {
      mostra();
    } catch(Exception e) {
      e.printStackTrace();
    }
  }

  // Montagem da Janela
  public void mostra() throws Exception {
    this.getContentPane().setLayout(null);
    this.setTitle("Menu Principal do Sistema");
    this.setSize(500,350);
    this.addWindowListener(
      new WindowAdapter() {
        public void windowClosing(WindowEvent e) {
          aoFechar(e);
      }
    });
    // Definições complementares do Menu
    mArquivo.setMnemonic('A');
    mCadastro.setMnemonic('C');
    miFilme.setMnemonic('F');
    miFilme.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        opCadFilme(e);
      }
    });
    miCliente.setMnemonic('C');
    miCliente.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        opCadCliente(e);
      }
    });
    miSair.setMnemonic('S');
    miSair.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        opSaida(e);
      }
    });
    mMovimenta.setMnemonic('M');
    miAluguel.setMnemonic('A');
    miAluguel.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        opAlugFilme(e);
      }
    });
    miDevolucao.setMnemonic('D');
    miDevolucao.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        opDevolFilme(e);
      }
    });
    miMstFilme.setMnemonic('M');
    miMstFilme.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        opMstFilme(e);
      }
    });
    mAuxilio.setMnemonic('x');
    miSobre.setMnemonic('S');
    miSobre.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        opSobreSis(e);
      }
    });
    // ***
    lbUsuario.setBounds(new Rectangle(10, 269, 381, 17));
    // ***
    meuMenu.add(mArquivo);
    meuMenu.add(mMovimenta);
    meuMenu.add(mAuxilio);
    mArquivo.add(mCadastro);
    mArquivo.addSeparator();
    mArquivo.add(miSair);
    mCadastro.add(miFilme);
    mCadastro.add(miCliente);
    mMovimenta.add(miAluguel);
    mMovimenta.add(miDevolucao);
    mMovimenta.addSeparator();
    mMovimenta.add(miMstFilme);
    mAuxilio.add(miSobre);
    // ***
    this.setJMenuBar(meuMenu);
    this.getContentPane().add(lbUsuario, null);
  }

  // Eventos da Janela

  // Ao Fechar a Janela
  private void aoFechar(WindowEvent e) {
    System.exit(0);
  }
  // Cadastro dos Filmes
  private void opCadFilme(ActionEvent e) {
    CadFilme janela = new CadFilme();
    janela.show();
  }
  // Cadastro dos Clientes
  private void opCadCliente(ActionEvent e) {
    CadCliente janela = new CadCliente();
    janela.show();
  }
  // Saída do Sistema
  private void opSaida(ActionEvent e) {
    System.exit(0);
  }
  // Aluguel dos Filmes
  private void opAlugFilme(ActionEvent e) {
    EmpFilme janela = new EmpFilme();
    janela.show();
  }
  // Devolução dos Filmes
  private void opDevolFilme(ActionEvent e) {
    DevFilme janela = new DevFilme();
    janela.show();
  }
  // Mostra os Filmes
  private void opMstFilme(ActionEvent e) {
    JDialog janela = new JDialog();
    janela.setSize(239, 323);
    janela.setTitle("Mostra Filme");
    janela.setResizable(false);
    janela.setModal(true);
    MstFilme conteudo = new MstFilme();
    janela.getContentPane().add(conteudo, null);
    janela.show();
  }
  // Sobre o Sistema
  private void opSobreSis(ActionEvent e) {
    JanSobre janela = new JanSobre("Globo.jpg");
    janela.setLocation((800-380)/2 , (600-300)/2);
    janela.show();
  }

  // Métodos Genéricos 

  // Chamada Principal
  public static void main(String[] args) {
    JanSplash splash = new JanSplash("Globo.jpg");
    splash.setSize(380,270);
    splash.setLocation((800-380)/2 , (600-300)/2);
    splash.show();
    delay(100);
    splash.dispose();
    JanSenha janela = new JanSenha();
    janela.show();
    if (janela.volta) {
      MnuPrincipal janPrinc = new MnuPrincipal();
      janPrinc.lbUsuario.setText("Usuário Autorizado: " + janela.login);
      janPrinc.show();
    } else {
      System.out.println("Usuário não autorizado...");
      System.exit(1);
    }
  }

  // Procedimento de Espera para a janela Splash  
  public static void delay(int tempo) {
    run.start();
    for (int i = 0; i < 50; i++) {
      try{Thread.sleep(tempo);
      } catch(InterruptedException e){}
    }
  }
}

/* JanSobre 
 * ------------------------------------
 * A Classes a seguir foi definida para a janela "Sobre o Sistema..."
 */

class JanSobre extends JDialog {
  private Image imagem;

  public JanSobre(String imageURL) {
    imagem = getToolkit().getImage(imageURL);
    this.setSize(380,300);
    this.setTitle("Sobre o Sistema...");
    this.setResizable(false);
    this.setModal(true);
    repaint();
  }

  public void paint(Graphics g) {
    char direitos = '\u00A9';
    g.drawImage(imagem, 0, 22, this);
    g.drawImage(imagem, 0, 112, this);
    g.drawImage(imagem, 0, 202, this);
    g.drawString("SimplesLoca " + direitos + " Jan/2001",125,125);
    g.drawString("Autor: Fernando Anselmo",125,140);
    g.drawString("Sistema de Locadora", 125, 155);
    g.drawString("Versão 1.0 - Demonstração",125,170);
  }
}

/* JanSplash 
 * ------------------------------------
 * A Classe a seguir foi definida para a janela de Splash
 */

class JanSplash extends JWindow {
  private Image imagem;

  public JanSplash(String imageURL) {
    imagem = getToolkit().getImage(imageURL);
    repaint();
  }

  public void paint(Graphics g) {
    char direitos = '\u00A9';
    g.drawImage(imagem, 0, 0, this);
    g.drawImage(imagem, 0, 90, this);
    g.drawImage(imagem, 0, 180, this);
    g.drawString("SimplesLoca " + direitos + " Jan/2001",125,125);
    g.drawString("Autor: Fernando Anselmo",125,140);
    g.drawString("Sistema de Locadora", 125, 155);
    g.drawString("Versão 1.0 - Demonstração",125,170);
  }
}