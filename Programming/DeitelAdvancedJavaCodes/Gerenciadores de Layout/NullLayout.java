/*
 * NullLayout.java
 *
 * Created on March 17, 2004, 6:06 PM
 */

import javax.swing.*;
import java.awt.*;
/**
 *
 * @author  rcampiol
 */
public class NullLayout extends JFrame {
    
    private JLabel lblNome;
    private JTextField txtNome;
    
    /** Creates a new instance of NullLayout */
    public NullLayout() {
        super("Testando o Null Layout");
        this.setSize(300, 250);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        
        Container c = this.getContentPane();
        
        c.setLayout(null);
        
        lblNome = new JLabel("Nome: ");
        txtNome = new JTextField(20);
        
        c.add(lblNome);
        c.add(txtNome);
        
        lblNome.setLocation(10, 10);
        lblNome.setSize(80, 24);

        txtNome.setLocation(100, 10);
        txtNome.setSize(80, 24);
        
        this.show();
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        NullLayout app = new NullLayout();
    }
    
}
