// Fig. 12.14: LinesRectsOvals.java
// Drawing lines, rectangles and ovals.
import java.awt.*;
import javax.swing.*;
import java.applet.*;
import java.awt.BorderLayout;

public class LinesRectsOvals extends JApplet {
    boolean check;
    public LinesRectsOvals() {
        try {
            jbInit();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    // set window's title bar String and dimensions
  // public LinesRectsOvals()
  public void init()
   {
 //     super( "Drawing lines, rectangles and ovals" );
   //   setSize( 1280, 1000 );
      setVisible( true );
     // setResizable(false);
   //  this.setSize(0,0);
      AudioClip sound;
      sound = getAudioClip(getDocumentBase(),"gamemusic.wav");
      System.out.print(getDocumentBase());
      sound.play();
      if (this.getWidth()!=1280)
           this.setSize(1280,1000);
       super.setSize(1280,1000);
       System.out.print(this.getWidth());
       check = true;
     }

   // display various lines, rectangles and ovals
   public void paint( Graphics g )
   {
       if ( check == true)
       {
           this.setSize(1280,1000);
           System.out.print(this.WIDTH);
           check = false;
       }
              System.out.print(this.getWidth());
      super.paint( g );  // call superclass's paint method
      Color c3 = new Color(164,87,158);
       g.setColor(c3);
       g.fillRect(0,0,1280,1000);
       Color c = new Color(143,253,128);
        g.setColor( c );
        g.fillRect(100,100,800,800);
        //drawing image
        try{
    ImageIcon im = new ImageIcon(
            "gifc/fruit1.gif");
    if(im.getImageLoadStatus()== MediaTracker.ERRORED)
        System.out.print(im.getImageLoadStatus());
    im.paintIcon(this, g, 200, 200);
    im = new ImageIcon("gifc/leaf5.gif");
    if(im.getImageLoadStatus()== MediaTracker.ERRORED)
        System.out.print(im.getImageLoadStatus());
    im.paintIcon(this, g, 100, 100);

}catch(Exception e){
    System.out.print("\n");
    System.out.print(e);
}

        //line drawing
        g.setColor(Color.BLACK);
       g.drawLine(500,100,500,900);
       // next drawing
       //line drawing
       g.setColor(Color.BLACK);
       g.drawLine(100,500,900,500);
       // next drawing
       //line drawing
       g.setColor(Color.BLACK);
       g.drawLine(100,300,900,300);
       // next drawing
       //line drawing
       g.setColor(Color.BLACK);
       g.drawLine(100,700,900,700);
       // next drawing
       //line drawing
       g.setColor(Color.BLACK);
       g.drawLine(300,100,300,900);
       // next drawing
       //line drawing
       g.setColor(Color.BLACK);
       g.drawLine(700,100,700,900);
       // next drawing
       //line drawing
     g.setColor(Color.BLACK);
     g.drawLine(800,100,800,900);
     // next drawing
     //line drawing
     g.setColor(Color.BLACK);
     g.drawLine(600,100,600,900);
     // next drawing
     g.setColor(Color.BLACK);
     g.drawLine(400,100,400,900);
     // next drawing
     // next drawing
     g.setColor(Color.BLACK);
     g.drawLine(200,100,200,900);
     // next drawing
     //line drawing
     g.setColor(Color.BLACK);
     g.drawLine(100,400,900,400);
       // next drawing
       //line drawing
       g.setColor(Color.BLACK);
       g.drawLine(100,600,900,600);
       // next drawing
       //line drawing
       g.setColor(Color.BLACK);
       g.drawLine(100,800,900,800);
       // next drawing
       //line drawing
       g.setColor(Color.BLACK);
       g.drawLine(100,200,900,200);
       // next drawing

        g.setColor(Color.BLACK);
        g.drawRect(100,100,800,800);
        Color c1 = new Color(249,245,189);
        g.setColor(c1);
        g.fillRoundRect(950,100,250,500,50,50);
        Color c2 = new Color(254,167,208);
        g.setColor(Color.BLACK);
        g.drawRoundRect(950,100,250,500,50,50);
        g.setColor(c2);
        g.fillRoundRect(950,620,250,280,50,50);
        g.setColor(Color.BLACK);
        g.drawRoundRect(950,620,250,280,50,50);
  //    g.draw3DRect(100,100,700,800, false );

//      g.setColor( Color.BLUE );
//      g.drawRect( 5, 40, 90, 55 );
//      g.fillRect( 100, 40, 90, 55 );
//
//      g.setColor( Color.CYAN );
//      g.fillRoundRect( 195, 40, 90, 55, 50, 50 );
//      g.drawRoundRect( 290, 40, 90, 55, 20, 20 );
//
//      g.setColor(Color.BLACK);
//      g.setFont( new Font( "Serif", Font.BOLD, 12 ) );
//      g.drawString( "UNTIDISTABLISHMENTRIALISM", 100, 120 );
//      g.drawString( "UNTIDISTABLISHMENTRIALISM", 90, 65 );
//      g.setColor( Color.YELLOW );
//      g.draw3DRect( 5, 100, 90, 55, true );
//      g.fill3DRect( 100, 100, 90, 55, false );
  g.setFont( new Font( "Sylfaen", Font.ITALIC, 20 ) );
      g.setColor(Color.yellow);
 //     g.fillOval(100,100,100,100);
      g.setColor(Color.BLACK);
      g.drawString ("untidis",125, 125 );
      g.drawString("stablishment",100,150);
      g.drawString("rialism",125,175);
      g.setFont(new Font("B Mitra", Font.CENTER_BASELINE,15));
      String s ="������ ��\u06CC� ͘��� ��\u06CC����";
      g.drawString(s,225,250);

//
 //     g.drawImage(im)
//
//      g.setColor( Color.MAGENTA );
//      g.drawOval( 195, 100, 90, 55 );
//      g.fillOval( 290, 100, 90, 55 );

   } // end method paint

    private void jbInit() throws Exception {
        jPanel1.setToolTipText("");
        this.getContentPane().add(jPanel1, java.awt.BorderLayout.NORTH);
        jPanel1.setSize(1000,100);
    }

    JPanel jPanel1 = new JPanel();
    // execute application
//   public static void main( String args[] )
//   {
//      LinesRectsOvals application = new LinesRectsOvals();
//  //    application.setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE );
//   }

//    private void jbInit() throws Exception {
//        Color c3 = new Color(164,87,158);
// //       this.getContentPane().setBackground(Color.BLACK);
//   //     this.setBackground(Color.BLACK);
//        this.getContentPane().setBackground(UIManager.getColor(
//               "InternalFrame.inactiveTitleForeground"));
//        this.getContentPane().setBackground(SystemColor.controlDkShadow);
// //       this.setResizable(false);
//    }

} // end class LinesRectsOvals

/**************************************************************************
 * (C) Copyright 1992-2003 by Deitel & Associates, Inc. and               *
 * Prentice Hall. All Rights Reserved.                                    *
 *                                                                        *
 * DISCLAIMER: The authors and publisher of this book have used their     *
 * best efforts in preparing the book. These efforts include the          *
 * development, research, and testing of the theories and programs        *
 * to determine their effectiveness. The authors and publisher make       *
 * no warranty of any kind, expressed or implied, with regard to these    *
 * programs or to the documentation contained in these books. The authors *
 * and publisher shall not be liable in any event for incidental or       *
 * consequential damages in connection with, or arising out of, the       *
 * furnishing, performance, or use of these programs.                     *
 *************************************************************************/
