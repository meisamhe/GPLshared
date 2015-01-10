/**
 * Class ClientChat
 * @author Rodrigo Campiolo
 *
 */

import chat.*;
import chat.servidor.*;
import chat.cliente.*;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.util.*;

import org.omg.CORBA.*;
import org.omg.CosNaming.*;
import org.omg.CosNaming.NamingContextExtPackage.*;
import org.omg.PortableServer.*;
import org.omg.PortableServer.POA;


public class ClientChat extends JFrame implements ActionListener {

    /* Declaração das variáveis */
    private JTextField txtMensagem;
    private JTextArea textArea;
    private JList lstID;
    private DefaultListModel lstModelID;
    private JPanel pnlMensagem, pnlBotao, pnlEnviar;
    private JButton btnEnviar, btnConectar, btnDesconectar;

    public String nick;
    private ClientListener chatClientListener;
    private ChatService chatService;

    /** Construtor */
    public ClientChat(String servidor, String apelido) {
        nick = apelido;

        /* inicializa os componentes da interface */
        this.initComponents();

        /* inicializa e encontra o servico */
        try {
            /* configura e inicializa o ORB */
            Properties props = new Properties();
            props.put("org.omg.CORBA.ORBInitialPort", "6666");
            props.put("org.omg.CORBA.ORBInitialHost", servidor);

            String[] args = {};
	    ORB orb = ORB.init(args, props);

            POA rootpoa = POAHelper.narrow(orb.resolve_initial_references("RootPOA"));
            rootpoa.the_POAManager().activate();

            ClientChatListener listener = new ClientChatListener(this);

            org.omg.CORBA.Object refListener = rootpoa.servant_to_reference(listener);
            chatClientListener = ClientListenerHelper.narrow(refListener);

            /* obtem a raiz do contexto de nome */
            org.omg.CORBA.Object objRef = orb.resolve_initial_references("NameService");

           /* Usa NamingContextExt ao inves de NamingContext */
            NamingContextExt ncRef = NamingContextExtHelper.narrow(objRef);

           /* obtem a Referencia do Objeto pelo "nome" */
           String name = "ChatService";
           chatService  = ChatServiceHelper.narrow(ncRef.resolve_str(name));

        } catch (Exception e) {
            System.out.println(e);
        } //catch

    } //construtor


    /** Inicializa os componentes */
    private void initComponents() {
        textArea = new JTextArea();
        lstModelID = new DefaultListModel();
        lstID = new JList(lstModelID);
        pnlMensagem = new JPanel();
        txtMensagem = new JTextField();
        pnlEnviar = new JPanel();
        btnEnviar = new JButton();
        pnlBotao = new JPanel();
        btnConectar = new JButton();
        btnDesconectar = new JButton();

        this.getContentPane().setLayout(new java.awt.BorderLayout(2, 0));

        this.setTitle("Chat Cliente - " + nick);

        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowClosing(java.awt.event.WindowEvent evt) {
                exitForm(evt);
            }
        });

        textArea.setColumns(30);
        textArea.setEditable(false);
        textArea.setBorder(null);
        JScrollPane areaScrollPane = new JScrollPane(textArea);
        areaScrollPane.setPreferredSize(new Dimension(300, 280));
        this.getContentPane().add(areaScrollPane, BorderLayout.CENTER);

        lstID.setFixedCellWidth(20);
        lstID.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        JScrollPane listScrollPane = new JScrollPane(lstID);
        listScrollPane.setPreferredSize(new Dimension(100, 280));
        this.getContentPane().add(listScrollPane, BorderLayout.EAST);

        pnlMensagem.setLayout(new FlowLayout(FlowLayout.LEFT, 2, 2));

        pnlMensagem.setBorder(new javax.swing.border.EtchedBorder());
        pnlMensagem.setPreferredSize(new Dimension(440, 35));
        txtMensagem.setColumns(30);
        pnlMensagem.add(txtMensagem);

        pnlEnviar.setLayout(new FlowLayout(FlowLayout.CENTER, 0, 0));

        pnlEnviar.setPreferredSize(new Dimension(102, 28));
        btnEnviar.setMnemonic('E');
        btnEnviar.setText("Enviar");
        btnEnviar.addActionListener(this);
        pnlEnviar.add(btnEnviar);

        pnlMensagem.add(pnlEnviar);

        getContentPane().add(pnlMensagem, BorderLayout.NORTH);

        pnlBotao.setLayout(new java.awt.FlowLayout(FlowLayout.RIGHT, 10, 3));

        pnlBotao.setBorder(new javax.swing.border.EtchedBorder());
        pnlBotao.setPreferredSize(new Dimension(10, 35));
        btnConectar.setMnemonic('C');
        btnConectar.setText("Conectar");
        btnConectar.setPreferredSize(new Dimension(120, 26));
        btnConectar.addActionListener(this);

        pnlBotao.add(btnConectar);

        btnDesconectar.setMnemonic('D');
        btnDesconectar.setText("Desconectar");
        btnDesconectar.setPreferredSize(new Dimension(120, 26));
        btnDesconectar.setEnabled(false);
        btnDesconectar.addActionListener(this);

        pnlBotao.add(btnDesconectar);

        getContentPane().add(pnlBotao, BorderLayout.SOUTH);

        setSize(470,300);
    } //initComponents

    /** processa os eventos */
    public void actionPerformed(ActionEvent evt) {
        try {
            /* btnConectar */
            if (evt.getSource() == btnConectar) {

                String[] lista;

                /* conecta e recebe a lista de clientes conectados */
               lista = chatService.conectar(nick, chatClientListener);

               if (lista != null) {
                   /* desabilita o botao conectar e abilita o desconectar*/
                   btnConectar.setEnabled(false);
                   btnDesconectar.setEnabled(true);

                   /* atualiza a interface */
                   for (int i=0; i<lista.length; i++)
                       lstModelID.addElement(lista[i]);
               } //if
            } //btnConectar

            /* btnDesconectar */
            else if (evt.getSource() == btnDesconectar) {
                /* desabilita o botao desconectar e abilita o conectar*/
                btnDesconectar.setEnabled(false);
                btnConectar.setEnabled(true);

                /* desconecta do servidor */
                chatService.desconectar(nick, chatClientListener);

                /* atualizar a interface */
                lstModelID.removeAllElements();
            } //btnDesconectar

            /* btnEnviar */
            else if (evt.getSource() == btnEnviar) {
                /* cria um objeto de mensagem */
                Mensagem msg = new Mensagem(nick, txtMensagem.getText());

		Integer id = new Integer(lstID.getSelectedIndex());
                if (id.intValue() >= 0) {
                    /* envia a mensagem (invoca o enviar) */
                    String destino = String.valueOf(lstID.getSelectedValue());
                    chatService.enviaMensagem(destino, msg);

                    /* atualizar a interface */
                    if (id.intValue() != 0 )
                       this.writeMessage(nick, txtMensagem.getText());
                    txtMensagem.setText("");

                } else JOptionPane.showMessageDialog(this, "Não há nenhum nome selecionado",
                                                    "Alerta", JOptionPane.WARNING_MESSAGE);

                txtMensagem.requestFocus();
            } //btnEnviar

        } catch (Exception e) {
            System.out.println(e);
        } //catch
    } // actionPerformed


    /** Finaliza a aplicação */
    private void exitForm(WindowEvent evt) {
        if (btnDesconectar.isEnabled()) {
           try {
               /* desconecta e avisa os outros hosts */
                chatService.desconectar(nick, chatClientListener);

           } catch (Exception e) {
               System.out.println ("Erro ao finalizar aplicativo" + e);
           } //catch
        } //if
        System.exit(0);
    } //exitForm


    /**
     * Escreve uma mensagem na área de mensagens
     */
    public void writeMessage(String ID, String Mensagem) {
        textArea.append("<" + ID + "> " + Mensagem + "\n");
        textArea.setCaretPosition(textArea.getText().length());
    } //writeMessage

    /**
     * Adiciona um novo apelido a lista
     */
    public void addNick (String ID) {
        System.out.println("Adiciona um elemento " + ID);
        if (!ID.equals(nick))
           lstModelID.addElement(ID);
    } //addNewConnection


    /**
     * Remove um apelido da lista
     */
    public void removeNick (String ID) {
        System.out.println("Remove um elemento" + ID);
        lstModelID.removeElement(ID);
    } //removeConneciton

    /**
     * Método Principal
     */
    public static void main(String args[]) {
        new ClientChat(args[0], args[1]).show();
    } //main

} //ClientChat
