/*
 * Created on Jul 10, 2005
 *
 *  To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package Retrieval;

import java.awt.event.MouseEvent;
import java.io.File;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Properties;

import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JFrame;
import javax.swing.JTextField;
import javax.swing.JLabel;
import javax.swing.JPasswordField;
import javax.swing.JButton;

import Storage.FileIO;
/**
 * @author ManiBH
 *
 * To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class ALogin {

	private JPanel jContentPaneLogin = null;
	private JFrame jFrameLogin = null;  //  @jve:decl-index=0:visual-constraint="76,-19"
	private JTextField jTextField = null;
	private JLabel jLabelName = null;
	private JLabel jLabel = null;
	private JPasswordField jPassword = null;
	private JButton jButtonLogin = null;
	private String secAddress="c:\\Cotlet.sec";
	private JButton jButtonSignIn = null;
	private FileIO io=new FileIO();
	private Secure mbh=new Secure();
	private String path="";
	/**
	 * 
	 */
	public ALogin() {
		super();
		// Auto-generated constructor stub
		if(io.isExists("c:\\cotlet.log")){
			path=io.readFileAsString(new File("c:\\cotlet.log"),1);
			if(path==null){
				JOptionPane.showMessageDialog(null,"The Setup is not properly ended or ","Error Ocured!",JOptionPane.ERROR_MESSAGE);
				System.exit(0);
			}
		}
		else{
			JOptionPane.showMessageDialog(null,"Please Run Setup First","Error Occured!",JOptionPane.ERROR_MESSAGE);
			System.exit(0);
		}
	}

	/**
	 * This method initializes jContentPane	
	 * 	
	 * @return javax.swing.JPanel	
	 */    
	private JPanel getJContentPaneLogin() {
		if (jContentPaneLogin == null) {
			jLabelName = new JLabel();
			jLabel = new JLabel();
			jContentPaneLogin = new JPanel();
			jContentPaneLogin.setLayout(null);
			jContentPaneLogin.setBorder(javax.swing.BorderFactory.createEtchedBorder(javax.swing.border.EtchedBorder.RAISED));
			jLabelName.setBounds(101, 32, 81, 18);
			jLabelName.setText("User Name");
			jLabelName.setForeground(java.awt.SystemColor.activeCaptionText);
			jLabelName.setFont(new java.awt.Font("Dialog", java.awt.Font.PLAIN, 12));
			jLabel.setBounds(101, 61, 82, 19);
			jLabel.setText("Password");
			jLabel.setFont(new java.awt.Font("Dialog", java.awt.Font.PLAIN, 12));
			jContentPaneLogin.add(getJTextField(), null);
			jContentPaneLogin.add(jLabelName, null);
			jContentPaneLogin.add(jLabel, null);
			jContentPaneLogin.add(getJPassword(), null);
			jContentPaneLogin.add(getJButtonLogin(), null);
			jContentPaneLogin.add(getJButtonSignIn(), null);
		}
		return jContentPaneLogin;
	}
	/**
	 * This method initializes jFrame	
	 * 	
	 * @return javax.swing.JFrame	
	 */    
	private JFrame getJFrameLogin() {
		if (jFrameLogin == null) {
			jFrameLogin = new JFrame();
			jFrameLogin.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
			jFrameLogin.setContentPane(getJContentPaneLogin());
			jFrameLogin.setTitle("Login Window");
			jFrameLogin.setSize(448, 196);
		}
		return jFrameLogin;
	}
	/**
	 * This method initializes jTextField	
	 * 	
	 * @return javax.swing.JTextField	
	 */    
	private JTextField getJTextField() {
		if (jTextField == null) {
			jTextField = new JTextField();
			jTextField.setBounds(194, 31, 136, 20);
		}
		return jTextField;
	}
	/**
	 * This method initializes jPasswordField	
	 * 	
	 * @return javax.swing.JPasswordField	
	 */    
	private JPasswordField getJPassword() {
		if (jPassword == null) {
			jPassword = new JPasswordField();
			jPassword.setBounds(195, 60, 135, 21);
			jPassword.setEchoChar('*');
		}
		return jPassword;
	}
	/**
	 * This method initializes jButton	
	 * 	
	 * @return javax.swing.JButton	
	 */    
	private JButton getJButtonLogin() {
		if (jButtonLogin == null) {
			jButtonLogin = new JButton();
			jButtonLogin.setBounds(156, 100, 73, 24);
			jButtonLogin.setName("Login");
			jButtonLogin.setText("Login");
			jButtonLogin.setFont(new java.awt.Font("Dialog", java.awt.Font.PLAIN, 12));
			jButtonLogin.addMouseListener(new java.awt.event.MouseAdapter() { 
				public void mouseClicked(java.awt.event.MouseEvent e) {    
					loginClicked(e);
				}
			});
		}
		return jButtonLogin;
	}
	private void loginClicked(MouseEvent e){
		String UserName=jTextField.getText();
		if(!io.isExists(secAddress))
			return;
		HashMap hash=io.readObjectFromFile(new File(secAddress));
		if(hash.get(UserName)!=null){
//			String pass=((UserObject)hash.get(UserName)).pas;
//			SecretKey key=((UserObject)hash.get(UserName)).key;
//			pass=Security(pass,1,key);
			String pass=(String)hash.get(UserName);
			if(pass.equals(jPassword.getText())){
				//Login succesfuly
				JOptionPane.showMessageDialog(null,"Welcome To MySearch Search Engin","Congratulation Login Succesfully",JOptionPane.INFORMATION_MESSAGE);
				(getJFrameLogin()).setVisible(false);
				SearchFrame sf=new SearchFrame(UserName,path);

			}
			else{
				JOptionPane.showMessageDialog(null,"Oops, Please reenter your password!","Password is not Currect",JOptionPane.OK_OPTION);
				jPassword.setText("");
			}
		}else{
			JOptionPane.showMessageDialog(null,"You are not valid user please sign in first!","User Name Not Valid",JOptionPane.OK_OPTION);
		}
		
	}
	class UserObject{
		String user="";
		String pas="";
		SecretKey key = null;
	}
	private void signInClicked(MouseEvent e){
//		UserObject mbh=new UserObject();
		HashMap hash=null;
		String userName=jTextField.getText();
		String pass=jPassword.getText();
//			SecretKey key = KeyGenerator.getInstance("DES").generateKey();
//			mbh.user=userName;
//			mbh.pas=pass;
//			mbh.key=key;			
		if(io.isExists(secAddress))
			hash=io.readObjectFromFile(new File(secAddress));
		else
			hash=new HashMap();
		if(hash.get(userName)!=null){
			JOptionPane.showMessageDialog(null,"Please change your User Name and Sign in Again!","Doublicate User Name",JOptionPane.INFORMATION_MESSAGE);
			jTextField.setText("");
			jPassword.setText("");
		}else
			hash.put(userName,pass);
		
		if(!io.isExists(secAddress)){
			io.writeObjectToFile(hash,io.createFile(secAddress));
			hash.clear();
		}else{
			io.writeObjectToFile(hash,new File(secAddress));
			hash.clear();
		}
	}
	private String padding(String str){
		int len=8-str.length();
		if(len>0){
			for(int i=0;i<len;i++){
				str=str+"#";
			}
		}
		return str;
	}
	/**
	 * 
	 * @param str : this class will encrypt or decrypt this string.
	 * @param i : if i=0 then your string will be encrypted and if i=1 
	 * then your string will be decrypted.
	 * @return the return parameter is in string format.
	 */
	private String Security(String str,int i,SecretKey key){
		String code="";
		try {
	        DesEncrypter encrypter = new DesEncrypter(key);
	        if(i==0){// Encrypt
	        	code = encrypter.encrypt(str);
	        }else if(i==1)// Decrypt
	        	code = encrypter.decrypt(str);
	    } catch (Exception exp) {
	    	System.out.println(exp.getMessage());
	    }
	    return code;
	}
	/**
	 * This method initializes jButton	
	 * 	
	 * @return javax.swing.JButton	
	 */    
	private JButton getJButtonSignIn() {
		if (jButtonSignIn == null) {
			jButtonSignIn = new JButton();
			jButtonSignIn.setBounds(248, 100, 79, 24);
			jButtonSignIn.setText("Sign In");
			jButtonSignIn.setFont(new java.awt.Font("Dialog", java.awt.Font.PLAIN, 12));
			jButtonSignIn.addMouseListener(new java.awt.event.MouseAdapter() { 
				public void mouseClicked(java.awt.event.MouseEvent e) {    
					signInClicked(e);
				}
			});
		}
		return jButtonSignIn;
	}
       	public static void main(String[] args) {
      		ALogin login = new ALogin();
      		login.getJFrameLogin().setVisible(true);
      		login.getJFrameLogin().setLocation(290,250);
      		

	}
}
