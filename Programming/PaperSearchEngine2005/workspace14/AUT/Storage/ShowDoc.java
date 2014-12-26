package Storage;

import java.awt.BorderLayout;
import java.awt.Font;
import java.io.File;

import javax.swing.BorderFactory;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;

public class ShowDoc extends JDialog {
    BorderLayout borderLayout1 = new BorderLayout();
    JPanel jPanelMain = new JPanel();
    BorderLayout borderLayout2 = new BorderLayout();
    JScrollPane jScrollPane1 = new JScrollPane();
    JTextArea jTextAreaDoc = new JTextArea();
    FileIO io=new FileIO();
    int docNo=0;
    String doc="",path="";
    public ShowDoc(int docNumber,String path){
        docNo=docNumber;
        this.path=path;
    	try {
    		init();
            jbInit();
        } catch (Exception exception) {
            exception.printStackTrace();
        }
    }
    private void init(){
    	doc=io.readFileAsString(new File(path+"document.txt"),docNo);
    }
    private void jbInit() throws Exception {
    	this.setTitle("Document Overviow");
        getContentPane().setLayout(borderLayout1);
        jPanelMain.setLayout(borderLayout2);
        jTextAreaDoc.setFont(new java.awt.Font("Arial", Font.BOLD, 13));
        jTextAreaDoc.setBorder(BorderFactory.createEtchedBorder());
        jTextAreaDoc.setEnabled(true);
        jTextAreaDoc.setEditable(false);
        jTextAreaDoc.setLineWrap(true);
        jTextAreaDoc.setWrapStyleWord(true);
        this.getContentPane().add(jPanelMain, java.awt.BorderLayout.CENTER);
        jPanelMain.add(jScrollPane1, java.awt.BorderLayout.CENTER);
        jScrollPane1.getViewport().add(jTextAreaDoc);
        jTextAreaDoc.setText(doc);
        this.setBounds(100,100,200,300);
        this.setDefaultCloseOperation(EXIT_ON_CLOSE);
        this.setVisible(true);
    }
}