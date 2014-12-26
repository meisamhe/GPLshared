package Storage;

/**
 * @author ManiBH
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
import java.util.Vector;
import javax.swing.JCheckBox;
import javax.swing.JPanel;
import java.awt.*;

import javax.swing.JDialog;
import javax.swing.JScrollPane;
import javax.swing.JSplitPane;
import javax.swing.JButton;

import com.borland.jbcl.layout.VerticalFlowLayout;
import com.borland.jbcl.layout.XYConstraints;
import com.borland.jbcl.layout.XYLayout;

import java.awt.event.ActionEvent;
import java.awt.event.MouseEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.util.Iterator;


public class CheckList extends JDialog {
    

    private int numberOfElements=0;
    private Vector elements=null;
    private Vector list=null;
    private JPanel northPanel =new JPanel();
    private BorderLayout borderLayout2 = new BorderLayout();
    private JScrollPane jScrollPane1 = new JScrollPane();
    private VerticalFlowLayout verticalFlowLayout1 = new VerticalFlowLayout();
    private JSplitPane mainSplitPane = new JSplitPane();
    private JPanel jSouthPanel = new JPanel();
    private XYLayout xYLayout1 = new XYLayout();
    private JButton jButtonUnCheck = new JButton();
    private JButton jButtonFinish = new JButton();
    private String note="";
    public CheckList(Vector elements,String note) {
        this.setModal(true);
        this.note=note;
        this.elements=elements;
        try {
			jbInit();
		}catch (Exception ex) {
            ex.printStackTrace();
        }     
    }
    private void jbInit(){
        this.setDefaultCloseOperation(EXIT_ON_CLOSE);
        this.getContentPane().setLayout(borderLayout2);
        northPanel.setLayout(verticalFlowLayout1);
        mainSplitPane.setOrientation(JSplitPane.VERTICAL_SPLIT);
        jSouthPanel.setLayout(xYLayout1);
        jButtonUnCheck.setText("Check All");
        jButtonUnCheck.addMouseListener(new
                                        CheckList_jButtonUnCheck_mouseAdapter(this));
        jButtonFinish.addMouseListener(new CheckList_jButtonFinish_mouseAdapter(this));
        jButtonFinish.setText("Finished");
        this.getContentPane().add(mainSplitPane, java.awt.BorderLayout.CENTER);
        jScrollPane1.getViewport().add(northPanel);
        mainSplitPane.add(jScrollPane1, JSplitPane.TOP);
        mainSplitPane.add(jSouthPanel, JSplitPane.BOTTOM);
        jSouthPanel.add(jButtonUnCheck, new XYConstraints(250, 8, -1, -1));
        jSouthPanel.add(jButtonFinish, new XYConstraints(45, 8, 86, -1));
        list=initCheckList();
        for(int i=0;i<list.size();i++)
            northPanel.add((JCheckBox)list.get(i));
        this.setBounds(300,100,400,500);
        this.setTitle(note);
        //this.pack();
        mainSplitPane.setDividerLocation(400);
    }
    private Vector initCheckList(){
        Vector vctr=new Vector();
        for(int i=0;i<elements.size();i++){
            vctr.add(new JCheckBox(((CheckStruct)elements.get(i)).doc));
        }
        return vctr;
    }
//    public static void main(String[] args) {
//       
//        CheckList checklist = new CheckList(elements);
//        checklist.setVisible(true);
//    }

    void jButtonUnCheck_mouseClicked(MouseEvent e) {
        Iterator it=list.iterator();
        if(jButtonUnCheck.getText().equals("Check All")){
           while(it.hasNext()){
               ((JCheckBox) it.next()).setSelected(true);
               jButtonUnCheck.setText("UnChecked All");
           }
        }
        else{
            while(it.hasNext()){
               ((JCheckBox) it.next()).setSelected(false);
               jButtonUnCheck.setText("Check All");
           }

        }
    }
	/**
	 * @param e
	 */
    private Vector results=new Vector();
	public void jButtonFinish_mouseClicked(MouseEvent e) {
		Iterator it=list.iterator();
		int cntr=0;
		while(it.hasNext()){
			((CheckStruct)elements.get(cntr++)).status=((JCheckBox)it.next()).isSelected();
		}
		this.setVisible(false);
	}


}


class CheckList_jButtonUnCheck_actionAdapter implements ActionListener {
    private CheckList adaptee;
    CheckList_jButtonUnCheck_actionAdapter(CheckList adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {
    }
}


class CheckList_jButtonUnCheck_mouseAdapter extends MouseAdapter {
    private CheckList adaptee;
    CheckList_jButtonUnCheck_mouseAdapter(CheckList adaptee) {
        this.adaptee = adaptee;
    }

    public void mouseClicked(MouseEvent e) {
        adaptee.jButtonUnCheck_mouseClicked(e);
    }
}
class CheckList_jButtonFinish_mouseAdapter extends MouseAdapter {
    private CheckList adaptee;
    CheckList_jButtonFinish_mouseAdapter(CheckList adaptee) {
        this.adaptee = adaptee;
    }

    public void mouseClicked(MouseEvent e) {
        adaptee.jButtonFinish_mouseClicked(e);
    }
}
class CheckStruct{
	String doc = null;
	boolean status=false;
	public CheckStruct(String doc){
		this.doc=doc;
	}
}
