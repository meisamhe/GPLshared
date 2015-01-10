/* CLASSE impExemplo2
 * ------------------------------------
 * Projeto..: Exemplo de Impressão com o Book
 */

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.awt.print.*;

public class impExemplo2 extends JFrame {

  private JButton btImprime = new JButton("Imprimir");
  private PageFormat formPag;

  public impExemplo2() {
    try {
      mostra();
    } catch(Exception ex) {
      ex.printStackTrace();
    }
  }

  public void mostra() throws Exception {
    this.getContentPane().setLayout(null);
    this.setSize(200, 119);
    this.setTitle("Teste Impressão");
    this.setResizable(false);

    btImprime.setBounds(new Rectangle(45, 31, 100, 30));
    this.getContentPane().add(btImprime, null);
    btImprime.addActionListener (new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        PrinterJob prnJob = PrinterJob.getPrinterJob();
   	  PagImp pi = new PagImp();
        prnJob.setPageable(constroiBook());
        if(prnJob.printDialog()) {
          try {
            prnJob.print();
          } catch (Exception PrinterException) {
            JOptionPane.showMessageDialog(null, PrinterException, "Erro", JOptionPane.ERROR_MESSAGE);             
          }
        }
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

  private Book constroiBook() {
    if (formPag == null) {
      PrinterJob printJob = PrinterJob.getPrinterJob();
      formPag = printJob.defaultPage();
    }
    Book book = new Book();
    PagImp pags = new PagImp();
    int qtdPag = 3;
    book.append(pags, formPag, qtdPag);
    return book;
  }

  public static void main(String args[]) {
    impExemplo2 janela = new impExemplo2();
    janela.show();
  }
}

class PagImp extends JPanel implements Printable {
  
  public int print(Graphics g, PageFormat pf, int pi)
    throws PrinterException {
    if (pi >= 3) {
      return Printable.NO_SUCH_PAGE;
    }
    Graphics2D g2 = (Graphics2D) g;
    g2.translate(pf.getImageableX(), pf.getImageableY());
    g2.setColor(Color.black);
    Font f = new Font("Monospaced", Font.PLAIN, 12);
    g2.setFont(f);
    char direitos = '\u00A9';
    g2.drawString("Fernando Anselmo " + direitos + " Jan/2001",30,10);
    g2.drawString("Item               Preço",15,50);
    g2.drawString("---------------------------",15,67);
    for (int i=80; i < 300; i+=17) {
      g2.drawString("Sabão em Pó        R$ 20,00",15,i);
    }
    paint(g2);
    return Printable.PAGE_EXISTS;
  }
}
