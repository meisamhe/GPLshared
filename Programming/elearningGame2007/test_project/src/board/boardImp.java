package board;

/**
 * <p>Title: </p>
 *
 * <p>Description: </p>
 *
 * <p>Copyright: Copyright (c) 2007</p>
 *
 * <p>Company: </p>
 *
 * @author not attributable
 * @version 1.0
 */
import java.awt.*;
import javax.swing.*;
import java.applet.*;
import java.awt.BorderLayout;
import java.awt.event.MouseMotionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseAdapter;
import java.io.*;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.nio.channels.FileChannel;

public class boardImp extends JApplet {
    boolean check;
    String imageFolder;
    board mainBoard;
    int selecting; // this is for knowing the element that is selected
    boolean oneSelected; // this is for knowing that wither it is first click or second
    int firstSelected; // for knowing the second that is selected
    int secondSelected; // for knowing the first one that is selected
    boardImp This;
    boolean trueMovement; //for knowing wether we should took back or not
    boolean falseDone; // when selecting tow non neibore cells
    int movementDelay;
    public boardImp() {
        try {
            mainBoard = new board();
            movementDelay = 20;
            imageFolder = "gifc/leaf";
            selecting = -1;
            firstSelected = -1;
            secondSelected = -1;
            jbInit();
            This = this;
            oneSelected = false;
            falseDone = false;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void init() {
        // Create the menu bar
        JMenuBar menuBar = new JMenuBar();
        JMenu fileMenu = new JMenu("File"); // create file menu
        fileMenu.setMnemonic('F'); // set mnemonic to F
        JMenu configurationMenu = new JMenu("Configuration"); // create format menu
        configurationMenu.setMnemonic('C'); // set mnemonic to r
        // create About... menu item
        JMenuItem aboutItem = new JMenuItem("About...");
        aboutItem.setMnemonic('A'); // set mnemonic to A
        fileMenu.add(aboutItem); // add about item to file menu
        aboutItem.addActionListener(

                new ActionListener() { // anonymous inner class
            // display message dialog when user selects About...
            public void actionPerformed(ActionEvent event) {
                JOptionPane.showMessageDialog(This,
                                              "This is wordLearning game\n Written by Meisam Hejazynia\n for Elearning Course",
                                              "About",
                                              JOptionPane.PLAIN_MESSAGE);
            } // end method actionPerformed
        } // end anonymous inner class
        ); // end call to addActionListener
        fileMenu.addSeparator();
        JMenuItem exitItem = new JMenuItem("Exit"); // create exit item
        exitItem.setMnemonic('x'); // set mnemonic to x
        fileMenu.add(exitItem); // add exit item to file menu
        exitItem.addActionListener(
                new ActionListener() { // anonymous inner class
            // terminate application when user clicks exitItem
            public void actionPerformed(ActionEvent event) {
                System.exit(0); // exit application
            } // end method actionPerformed
        } // end anonymous inner class
        ); // end call to addActionListener

        JMenuItem colorMenu = new JMenuItem("AddWord.."); // create color menu
        colorMenu.setMnemonic('A'); // set mnemonic to C
        configurationMenu.add(colorMenu);
        colorMenu.addActionListener(
                new ActionListener() { // anonymous inner class
            // terminate application when user clicks exitItem
            public void actionPerformed(ActionEvent event) {
                JFrame frame = new JFrame();
                JFileChooser chooser = new JFileChooser();

                chooser.addChoosableFileFilter(new MyFilter());

                chooser.showOpenDialog(frame);
                File file = chooser.getSelectedFile();
                System.out.println(file);
                try {
                    // Create channel on the source
                    FileChannel srcChannel = new FileInputStream(file).
                                             getChannel();

                    // Create channel on the destination
                    FileChannel dstChannel = new FileOutputStream("words.xls").
                                             getChannel();

                    // Copy file contents from source to destination
                    dstChannel.transferFrom(srcChannel, 0, srcChannel.size());

                    // Close the channels
                    srcChannel.close();
                    dstChannel.close();
                    excelParser excelparser = new excelParser();
                    excelparser.readDB();
                } catch (IOException e) {
                    System.out.println(e);
                }

            } // end method actionPerformed
        }
        ); // end call to addActionListener

        JMenu HelpMenu = new JMenu("Help"); // create format menu

        menuBar.add(fileMenu);

        menuBar.add(configurationMenu);

        menuBar.add(HelpMenu);

        this.setJMenuBar(menuBar);

        setVisible(true);

        Thread t = new Thread(new Runnable() {
            public void run() {
                while (1 == 1) {
                    AudioClip sound;
                    sound = getAudioClip(getDocumentBase(), "gamemusic.wav");
                    //   System.out.print(getDocumentBase());
                    sound.play();
                    Delay(110000);
                    sound.stop();
                }
            }
        });
        t.start();

        if (this.getWidth() != 1280) {
            this.setSize(1280, 1000);
        }
        super.setSize(1280, 1000);

        //    System.out.print(this.getWidth());
        check = true;
    }


    public void paint(Graphics g) {
        if (check == true) {
            this.setSize(1280, 1000);
            //         System.out.print(this.WIDTH);
            check = false;
        }
        //     System.out.print(this.getWidth());
        super.paint(g); // call superclass's paint method
        Color c3 = new Color(164, 87, 158);
        g.setColor(c3);
        g.fillRect(0, 20, 1280, 1000);
        Color c = new Color(143, 253, 128);
        g.setColor(c);
        g.fillRect(100, 100, 800, 800);
        //drawing image
        try {
            /*   ImageIcon im = new ImageIcon(
                       "gifc/fruit1.gif");
               if (im.getImageLoadStatus() == MediaTracker.ERRORED) {
                   //         System.out.print(im.getImageLoadStatus());
               }
               im.paintIcon(this, g, 200, 200);
               im = new ImageIcon("gifc/leaf5.gif");
               if (im.getImageLoadStatus() == MediaTracker.ERRORED) {
                   //        System.out.print(im.getImageLoadStatus());
               }
               im.paintIcon(this, g, 100, 100);*/

        } catch (Exception e) {
            System.out.print("\n");
            System.out.print(e);
        }
        ImageIcon im;
        for (int i = 0; i < 64; i++) {
            if (oneSelected == false && firstSelected != -1 &&
                (i == firstSelected || i == secondSelected) && falseDone == false) {
                //meanse we are in moving stage
                // here we dont paint them and after this for we will
                // paint them indevisually

            } else {
                //  Delay(200);
                /*      System.out.println(mainBoard.boardCell[i / 8][i % 8].getContent1() +
                 " " + mainBoard.boardCell[i / 8][i % 8].getFont()+
                              " "+mainBoard.boardCell[i / 8][i % 8].en);*/
                if (mainBoard.boardCell[i / 8][i % 8].getPlace()) {
                    if (mainBoard.boardCell[i / 8][i % 8].getPlace()) {
                        im = new ImageIcon( //we can use also fruit
                                imageFolder +
                                mainBoard.boardCell[i / 8][i %
                                8].getImageNum() +
                                "c.gif");
                    } else {
                        im = new ImageIcon( //we can use also fruit
                                imageFolder +
                                mainBoard.boardCell[i / 8][i %
                                8].getImageNum() +
                                ".gif");
                    }
                } else {
                    if (mainBoard.boardCell[i / 8][i % 8].getPlace()) {
                        im = new ImageIcon( //we can use also fruit
                                imageFolder +
                                mainBoard.boardCell[i / 8][i %
                                8].getImageNum() +
                                "c.gif");
                    } else {
                        im = new ImageIcon( //we can use also fruit
                                imageFolder +
                                mainBoard.boardCell[i / 8][i %
                                8].getImageNum() +
                                ".gif");
                    }

                }

                im.paintIcon(this, g, mainBoard.boardCell[i / 8][i % 8].x,
                             mainBoard.boardCell[i / 8][i % 8].y - 50);

                if (mainBoard.boardCell[i / 8][i % 8].getRowCount() == 1 &&
                    mainBoard.boardCell[i / 8][i % 8].en == true) {
                    g.setFont(new Font("Sylfaen", Font.ITALIC,
                                       mainBoard.boardCell[i / 8][i %
                                       8].getFont()));
                    g.setColor(Color.BLACK);
                    g.drawString(mainBoard.boardCell[i / 8][i %
                                 8].getContent1(),
                                 mainBoard.boardCell[i / 8][i % 8].start1 +
                                 mainBoard.boardCell[i / 8][i % 8].x,
                                 mainBoard.boardCell[i / 8][i % 8].y);

                }
                if (mainBoard.boardCell[i / 8][i % 8].getRowCount() == 3 &&
                    mainBoard.boardCell[i / 8][i % 8].en == true) {
                    g.setFont(new Font("Sylfaen", Font.ITALIC,
                                       mainBoard.boardCell[i / 8][i %
                                       8].getFont()));
                    g.setColor(Color.BLACK);
                    g.drawString(mainBoard.boardCell[i / 8][i %
                                 8].getContent1(),
                                 mainBoard.boardCell[i / 8][i % 8].start1 +
                                 mainBoard.boardCell[i / 8][i % 8].x,
                                 mainBoard.boardCell[i / 8][i % 8].y - 25);

                    g.drawString(mainBoard.boardCell[i / 8][i %
                                 8].getContent2(),
                                 mainBoard.boardCell[i / 8][i % 8].start2 +
                                 mainBoard.boardCell[i / 8][i % 8].x,
                                 mainBoard.boardCell[i / 8][i % 8].y);

                    g.drawString(mainBoard.boardCell[i / 8][i %
                                 8].getContent3(),
                                 mainBoard.boardCell[i / 8][i % 8].start3 +
                                 mainBoard.boardCell[i / 8][i % 8].x,
                                 mainBoard.boardCell[i / 8][i % 8].y + 25);
                }
                if (mainBoard.boardCell[i / 8][i % 8].getRowCount() == 1 &&
                    mainBoard.boardCell[i / 8][i % 8].en == false) {
                    g.setFont(new Font("B Mitra", Font.CENTER_BASELINE,
                                       mainBoard.boardCell[i / 8][i %
                                       8].getFont()));
                    g.setColor(Color.BLACK);
                    g.drawString(mainBoard.boardCell[i / 8][i %
                                 8].getContent1(),
                                 mainBoard.boardCell[i / 8][i % 8].start1 +
                                 mainBoard.boardCell[i / 8][i % 8].x,
                                 mainBoard.boardCell[i / 8][i % 8].y);

                }
                if (mainBoard.boardCell[i / 8][i % 8].getRowCount() == 3 &&
                    mainBoard.boardCell[i / 8][i % 8].en == false) {
                    g.setFont(new Font("B Mitra", Font.CENTER_BASELINE,
                                       mainBoard.boardCell[i / 8][i %
                                       8].getFont()));
                    g.setColor(Color.BLACK);
                    g.drawString(mainBoard.boardCell[i / 8][i %
                                 8].getContent1(),
                                 mainBoard.boardCell[i / 8][i % 8].start1 +
                                 mainBoard.boardCell[i / 8][i % 8].x,
                                 mainBoard.boardCell[i / 8][i % 8].y - 25);

                    g.drawString(mainBoard.boardCell[i / 8][i %
                                 8].getContent2(),
                                 mainBoard.boardCell[i / 8][i % 8].start2 +
                                 mainBoard.boardCell[i / 8][i % 8].x,
                                 mainBoard.boardCell[i / 8][i % 8].y);

                    g.drawString(mainBoard.boardCell[i / 8][i %
                                 8].getContent3(),
                                 mainBoard.boardCell[i / 8][i % 8].start3 +
                                 mainBoard.boardCell[i / 8][i % 8].x,
                                 mainBoard.boardCell[i / 8][i % 8].y + 25);
                }

            }
        }
        if (oneSelected == false && firstSelected != -1 && falseDone == false) { // for simulate movement
            move(g, firstSelected, secondSelected, trueMovement);
            returnNormalForm();
        }
        //line drawing
        g.setColor(Color.BLACK);
        g.drawLine(500, 100, 500, 900);
        // next drawing
        //line drawing
        g.setColor(Color.BLACK);
        g.drawLine(100, 500, 900, 500);
        // next drawing
        //line drawing
        g.setColor(Color.BLACK);
        g.drawLine(100, 300, 900, 300);
        // next drawing
        //line drawing
        g.setColor(Color.BLACK);
        g.drawLine(100, 700, 900, 700);
        // next drawing
        //line drawing
        g.setColor(Color.BLACK);
        g.drawLine(300, 100, 300, 900);
        // next drawing
        //line drawing
        g.setColor(Color.BLACK);
        g.drawLine(700, 100, 700, 900);
        // next drawing
        //line drawing
        g.setColor(Color.BLACK);
        g.drawLine(800, 100, 800, 900);
        // next drawing
        //line drawing
        g.setColor(Color.BLACK);
        g.drawLine(600, 100, 600, 900);
        // next drawing
        g.setColor(Color.BLACK);
        g.drawLine(400, 100, 400, 900);
        // next drawing
        // next drawing
        g.setColor(Color.BLACK);
        g.drawLine(200, 100, 200, 900);
        // next drawing
        //line drawing
        g.setColor(Color.BLACK);
        g.drawLine(100, 400, 900, 400);
        // next drawing
        //line drawing
        g.setColor(Color.BLACK);
        g.drawLine(100, 600, 900, 600);
        // next drawing
        //line drawing
        g.setColor(Color.BLACK);
        g.drawLine(100, 800, 900, 800);
        // next drawing
        //line drawing
        g.setColor(Color.BLACK);
        g.drawLine(100, 200, 900, 200);
        // next drawing

        g.setColor(Color.BLACK);
        g.drawRect(100, 100, 800, 800);
        Color c1 = new Color(249, 245, 189);
        g.setColor(c1);
        g.fillRoundRect(950, 100, 250, 500, 50, 50);
        Color c2 = new Color(254, 167, 208);
        g.setColor(Color.BLACK);
        g.drawRoundRect(950, 100, 250, 500, 50, 50);
        g.setColor(c2);
        g.fillRoundRect(950, 620, 250, 280, 50, 50);
        g.setColor(Color.BLACK);
        g.drawRoundRect(950, 620, 250, 280, 50, 50);
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
        //     g.fillOval(100,100,100,100);
        /*       g.setFont(new Font("Sylfaen", Font.ITALIC, 20));
               g.setColor(Color.yellow);
               g.setColor(Color.BLACK);
               g.drawString("untidis", 125, 125);
               g.drawString("stablishment", 100, 150);
               g.drawString("rialism", 125, 175);
               g.setFont(new Font("B Mitra", Font.CENTER_BASELINE, 15));
               String s = "ãÈÇÑÒå Úá\u06CCå Í˜æãÊ ˜á\u06CCÓÇåÇ";
               g.drawString(s, 225, 250);*/
//        System.out.println("refresh");
        //    doing selection
        if (selecting != -1) {
            g.setColor(Color.RED);
            g.fillRect((selecting % 8 + 1) * 100, (selecting / 8 + 1) * 100,
                       5,
                       100);
            g.fillRect((selecting % 8 + 1) * 100, (selecting / 8 + 1) * 100,
                       100, 5);
            g.fillRect((selecting % 8 + 2) * 100 - 5,
                       (selecting / 8 + 1) * 100,
                       5, 100);
            g.fillRect((selecting % 8 + 1) * 100,
                       (selecting / 8 + 2) * 100 - 5,
                       100, 5);
            //      g.draw3DRect((i+1) * 100, (j+1) * 100, 100, 100,false);
        }

        //  Delay(60);
//
        //     g.drawImage(im)
//
//      g.setColor( Color.MAGENTA );
//      g.drawOval( 195, 100, 90, 55 );
//      g.fillOval( 290, 100, 90, 55 );

    } // end method paint

    void move(Graphics g, int firstSelected, int secondSelected, boolean sw) { //sw is knowing wither it is true movement or not
        int tempSelected;
        if (firstSelected - secondSelected > 0) { // smaller is firstSelected
            tempSelected = secondSelected;
            secondSelected = firstSelected;
            firstSelected = tempSelected;

        }
        int x, y; // could be 0 or 1
        x = (secondSelected - firstSelected) % 8;
        y = (secondSelected - firstSelected) / 8;
        for (int i = 0; i < 4; i++) {
            //each time of move we first clear the windows that is repainted
            g.clearRect(mainBoard.boardCell[firstSelected /
                        8][firstSelected %
                        8].x,
                        mainBoard.boardCell[firstSelected /
                        8][firstSelected %
                        8].y - 50, x * 100 + 100, y * 100 + 100);
            Color c = new Color(143, 253, 128);
            g.setColor(c);
            g.fillRect(mainBoard.boardCell[firstSelected / 8][firstSelected %
                       8].x,
                       mainBoard.boardCell[firstSelected / 8][firstSelected %
                       8].y - 50, x * 100 + 100, y * 100 + 100);

            drawMovement(g, firstSelected, x * (i + 1) * 25,
                         y * (i + 1) * 25);
            drawMovement(g, secondSelected, -x * (i + 1) * 25,
                         -y * (i + 1) * 25);
            Delay(movementDelay);
        }

        swap(firstSelected, secondSelected);

        if (sw == false) { // it was false movement
            Delay(movementDelay);
            for (int i = 0; i < 4; i++) {
                //each time of move we first clear the windows that is repainted
                g.clearRect(mainBoard.boardCell[firstSelected /
                            8][firstSelected %
                            8].x,
                            mainBoard.boardCell[firstSelected /
                            8][firstSelected %
                            8].y - 50, x * 100 + 100, y * 100 + 100);
                Color c = new Color(143, 253, 128);
                g.setColor(c);
                g.fillRect(mainBoard.boardCell[firstSelected /
                           8][firstSelected %
                           8].x,
                           mainBoard.boardCell[firstSelected /
                           8][firstSelected %
                           8].y - 50, x * 100 + 100, y * 100 + 100);

                drawMovement(g, secondSelected, -x * (i + 1) * 25,
                             -y * (i + 1) * 25);
                drawMovement(g, firstSelected, x * (i + 1) * 25,
                             y * (i + 1) * 25);
                Delay(movementDelay);
            }
            swap(firstSelected, secondSelected);
        }
    }

    void returnNormalForm() {
        firstSelected = -1;
        selecting = -1;

    }

    void swap(int firstSelected, int secondSelected) {
        int tempX, tempY, tempStart;
        cell tempCell; // change place of two cell
        tempCell = mainBoard.boardCell[secondSelected / 8][secondSelected %
                   8];
        mainBoard.boardCell[secondSelected / 8][secondSelected %
                8] = mainBoard.boardCell[firstSelected / 8][firstSelected %
                     8];
        mainBoard.boardCell[firstSelected / 8][firstSelected %
                8] = tempCell;
        tempX = mainBoard.boardCell[firstSelected / 8][firstSelected %
                8].x;
        mainBoard.boardCell[firstSelected / 8][firstSelected %
                8].x = mainBoard.boardCell[secondSelected /
                       8][secondSelected %
                       8].x;
        mainBoard.boardCell[secondSelected / 8][secondSelected %
                8].x = tempX;
        tempY = mainBoard.boardCell[firstSelected / 8][firstSelected %
                8].y;
        mainBoard.boardCell[firstSelected / 8][firstSelected %
                8].y = mainBoard.boardCell[secondSelected /
                       8][secondSelected %
                       8].y;
        mainBoard.boardCell[secondSelected / 8][secondSelected %
                8].y = tempY;
    }

    void drawMovement(Graphics g, int whichSelected, int transformX,
                      int transformY) { // trans. is - or +
        ImageIcon im;
        if (mainBoard.boardCell[whichSelected / 8][whichSelected %
            8].getPlace()) {
            im = new ImageIcon( //we can use also fruit
                    imageFolder +
                    mainBoard.boardCell[whichSelected / 8][whichSelected %
                    8].getImageNum() +
                    "c.gif");
        } else {
            im = new ImageIcon( //we can use also fruit
                    imageFolder +
                    mainBoard.boardCell[whichSelected / 8][whichSelected %
                    8].getImageNum() +
                    ".gif");
        }

        im.paintIcon(this, g,
                     mainBoard.boardCell[whichSelected / 8][whichSelected %
                     8].x + transformX,
                     mainBoard.boardCell[whichSelected / 8][whichSelected %
                     8].y - 50 + transformY);
        if (mainBoard.boardCell[whichSelected / 8][whichSelected %
            8].getRowCount() == 1 &&
            mainBoard.boardCell[whichSelected / 8][whichSelected % 8].en == true) {
            g.setFont(new Font("Sylfaen", Font.ITALIC,
                               mainBoard.boardCell[whichSelected /
                               8][whichSelected %
                               8].getFont()));
            g.setColor(Color.BLACK);
            g.drawString(mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].getContent1(),
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].start1 +
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].x + transformX,
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].y + transformY);

        }
        if (mainBoard.boardCell[whichSelected / 8][whichSelected %
            8].getRowCount() == 3 &&
            mainBoard.boardCell[whichSelected / 8][whichSelected % 8].en == true) {
            g.setFont(new Font("Sylfaen", Font.ITALIC,
                               mainBoard.boardCell[whichSelected /
                               8][whichSelected %
                               8].getFont()));
            g.setColor(Color.BLACK);
            g.drawString(mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].getContent1(),
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].start1 +
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].x + transformX,
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].y - 25 + transformY);

            g.drawString(mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].getContent2(),
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].start2 +
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].x + transformX,
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].y + transformY);

            g.drawString(mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].getContent3(),
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].start3 +
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].x + transformX,
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].y + 25 + transformY);
        }
        if (mainBoard.boardCell[whichSelected / 8][whichSelected %
            8].getRowCount() == 1 &&
            mainBoard.boardCell[whichSelected / 8][whichSelected % 8].en == false) {
            g.setFont(new Font("B Mitra", Font.CENTER_BASELINE,
                               mainBoard.boardCell[whichSelected /
                               8][whichSelected %
                               8].getFont()));
            g.setColor(Color.BLACK);
            g.drawString(mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].getContent1(),
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].start1 +
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].x + transformX,
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].y + transformY);

        }
        if (mainBoard.boardCell[whichSelected / 8][whichSelected %
            8].getRowCount() == 3 &&
            mainBoard.boardCell[whichSelected / 8][whichSelected % 8].en == false) {
            g.setFont(new Font("B Mitra", Font.CENTER_BASELINE,
                               mainBoard.boardCell[whichSelected /
                               8][whichSelected %
                               8].getFont()));
            g.setColor(Color.BLACK);
            g.drawString(mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].getContent1(),
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].start1 +
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].x + transformX,
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].y - 25 + transformY);

            g.drawString(mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].getContent2(),
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].start2 +
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].x + transformX,
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].y + transformY);

            g.drawString(mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].getContent3(),
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].start3 +
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].x + transformX,
                         mainBoard.boardCell[whichSelected /
                         8][whichSelected %
                         8].y + 25 + transformY);
        }

    }

    String convertUnicode(String s) {
        byte[] utf8 = s.getBytes();

        // Convert from UTF-8 to Unicode
        String result = null;
        try {
            result = new String(utf8, "UTF-8");
        } catch (UnsupportedEncodingException ex) {
        }
        return result;
    }

    public void Delay(int delayTime) {
        try {
            Thread.sleep(delayTime); /* call Java's sleep method */
        } catch (InterruptedException e) {
            /* when the sleep() call above is over, Java will */
            /* be interuppted and we fall into this block of code */
            /* because our intention is simply slow down things */
            /* wed do nothing in our exception code and just get out */
        }
    }

    private void jbInit() throws Exception {
        jPanel1.setToolTipText("");
        this.getContentPane().add(jPanel1, java.awt.BorderLayout.NORTH);

        // set up mouse motion event handling
        addMouseListener(
                // anonymous inner class to handle mouse events
                new MouseAdapter() {
            public void mouseClicked(MouseEvent event) {
                if (event.getX() > 100 && event.getX() < 900 &&
                    event.getY() > 100 &&
                    event.getY() < 900) {
                    int x = event.getX() / 100;
                    int y = event.getY() / 100;
                    x--;
                    y--;
                    if (oneSelected == false) {
                        selecting = y * 8 + x;
                        oneSelected = true;
                        This.repaint((selecting % 8 + 1) * 100,
                                     (selecting / 8 + 1) * 100, 100, 100);
                        firstSelected = selecting;
                        falseDone = false;
                    } else {
                        selecting = -1;
                        oneSelected = false;
                        int lastSelecting = selecting;
                        secondSelected = y * 8 + x;
                        int tempFirstSelected = firstSelected;
                        int tempSecondSelected = secondSelected;
                        if (secondSelected - firstSelected == 8 || //these means that they are neibour
                            secondSelected - firstSelected == -8 ||
                            secondSelected - firstSelected == 1 ||
                            secondSelected - firstSelected == -1) {
                            trueMovement = false; // we want to start checking if this move is true or not
                            int truePut = mainBoard.check(mainBoard.
                                    boardCell[
                                    firstSelected /
                                    8][firstSelected %
                                    8].meaningContent,
                                    firstSelected, firstSelected,
                                    secondSelected);
                            int tempTruePut = truePut;
                            //                        System.out.println("truePut is:" + truePut);
                            if (truePut != -1) { // means it is put in the true place
                                mainBoard.updateBoard(firstSelected,
                                        truePut);
                                trueMovement = true;
                            }
                            truePut = mainBoard.check(mainBoard.boardCell[
                                    secondSelected /
                                    8][secondSelected %
                                    8].meaningContent,
                                    secondSelected,
                                    secondSelected, firstSelected);
                            //                        System.out.println("truePut is:" + truePut);
                            if (truePut != -1) { // means it is put in the true place
                                mainBoard.updateBoard(secondSelected,
                                        truePut);
                                trueMovement = true;
                            }
                            if (trueMovement == false) { // means if these change is not true
                                mainBoard.boardCell[tempSecondSelected /
                                        8][tempSecondSelected %
                                        8].setOneFalseDone(true); //means it dones false
                                mainBoard.boardCell[tempFirstSelected /
                                        8][tempFirstSelected %
                                        8].setOneFalseDone(true); //means it dones false
                            }
                            int tempSelected;
                            if (firstSelected - secondSelected > 0) { // smaller is firstSelected
                                tempSelected = secondSelected;
                                secondSelected = firstSelected;
                                firstSelected = tempSelected;

                            }
                            int windowX, windowY; // could be 0 or 1
                            windowX = (secondSelected - firstSelected) % 8;
                            windowY = (secondSelected - firstSelected) / 8;
                            //each time of move we first clear the windows that is repainted
                            This.repaint(mainBoard.boardCell[firstSelected /
                                         8][firstSelected %
                                         8].x,
                                         mainBoard.boardCell[firstSelected /
                                         8][firstSelected %
                                         8].y - 50, windowX * 100 + 100,
                                         windowY * 100 + 100);
                            This.Delay(This.movementDelay);
                            This.repaint(((tempFirstSelected) % 8 + 1) *
                                         100,
                                         ((tempFirstSelected) / 8 + 1) *
                                         100,
                                         100,
                                         100);
                            This.repaint(((tempSecondSelected) % 8 + 1) *
                                         100,
                                         ((tempSecondSelected) / 8 + 1) *
                                         100,
                                         100,
                                         100);

                            This.repaint(((tempTruePut) % 8 + 1) * 100,
                                         ((tempTruePut) / 8 + 1) * 100, 100,
                                         100);
                            This.repaint(((truePut) % 8 + 1) * 100,
                                         ((truePut) / 8 + 1) * 100, 100,
                                         100);
                            //       This.returnNormalForm();
                            if (mainBoard.updateBoard()) {
                                if (oneSelected == false &&
                                    firstSelected != -1 &&
                                    falseDone == false) { // for simulate movement
                                    This.returnNormalForm();
                                }
                                This.Delay(This.movementDelay);
                                int maxChanges = mainBoard.getMaxChange();
                                System.out.println(
                                        "board is going to be updated" +
                                        maxChanges);
                                for (int i = maxChanges; i >= 0; i--) {
                                    This.repaint(100,
                                                 (i * 2) * 100, 800,
                                                 200);
                                    Delay(This.movementDelay);
                                }
                            }
                        } else {
                            int temp = firstSelected;
                            firstSelected = -1;
                            selecting = -1;
                            oneSelected = false;
                            falseDone = true; // means you have Done False
                            This.repaint(((temp) % 8 + 1) * 100,
                                         ((temp) / 8 + 1) * 100, 100, 100);

                            JOptionPane.showMessageDialog(null,
                                    "Please Choose Neihbour Cells",
                                    "Neihbour Choose!",
                                    JOptionPane.
                                    INFORMATION_MESSAGE);
                        }
                    }
                    System.out.println("x is:" + event.getX() + "y is:" +
                                       event.getY());
                } // end method mouseClicked
            }
        }
        );
        jPanel1.setSize(1000, 100);
    }

    JPanel jPanel1 = new JPanel();
}
