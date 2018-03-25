/**
 *                                      In the name of Allah
 *                                       The best will come
 */

import entities.Chapter;
import entities.ASynchChapter;
import entities.Text;
import entities.Image;

import java.util.Vector;

import viewer.PrimitiveDataViewer;
import viewer.ASynchContentViewerMediator;

import javax.microedition.midlet.MIDlet;
import javax.microedition.midlet.MIDletStateChangeException;
import javax.microedition.lcdui.*;

public class TestMain extends MIDlet implements CommandListener  {

    Display display = null;
    PrimitiveDataViewer convas;
    List mainMenu = null; // main menu
    TextBox input = null;
    DateField date = new DateField("Today's date: ", DateField.DATE);
    Ticker ticker = new Ticker("Test GUI Components");
    List bookMenu = null;

    static final Command backCommand = new Command("Back", Command.BACK, 0);
    static final Command mainMenuCommand = new Command("Main", Command.SCREEN, 1);
    static final Command exitCommand = new Command("Exit", Command.STOP, 2);

    String currentMenu = null;

    private static Chapter createDummyASynchChapter() {
        ASynchChapter retValue = new ASynchChapter();
        retValue.setTitle("Sample1");
        Vector datas = new Vector();
        Text t = new Text();
        t.setContent("This is the first line of test data.");
        datas.addElement(t);

        t = new Text();
        t.setContent("این دومین محتوایی است که در صفحه قرار می‌گیرد و باید نمایش داده شود");
        datas.addElement(t);

        Image image = new Image();
        image.setPath("/images/Sunset1.jpg");
        datas.addElement(image);

        t = new Text();
        t.setContent("And the third segment of text data is longer than first one!.");
        datas.addElement(t);

        image = new Image();
        image.setPath("/images/Sunset2.jpg");
        datas.addElement(image);

        image = new Image();
        image.setPath("/images/Sunset3.jpg");
        datas.addElement(image);

        t = new Text();
        t.setContent("چهارمین محتوا خیلی کوچک است!");
        datas.addElement(t);

        image = new Image();
        image.setPath("/images/Sunset3.jpg");
        datas.addElement(image);

        image = new Image();
        image.setPath("/images/Sunset3.jpg");
        datas.addElement(image);

        image = new Image();
        image.setPath("/images/Sunset3.jpg");
        datas.addElement(image);

        image = new Image();
        image.setPath("/images/Sunset3.jpg");
        datas.addElement(image);

        t = new Text();
        t.setContent("در انتها نیاز بود که داده‌های بسیار طولانی در محیط قرارداده شود تا از این طریق اعمالی از قبیل شکستن متن مورد آزمون واقع شود!");
        datas.addElement(t);


        retValue.setPrimitiveDatas(datas);


        return retValue;
    }

    protected void startApp() throws MIDletStateChangeException {

        display = Display.getDisplay(this);
        
        mainMenu = new List("Main Menu", Choice.IMPLICIT);
        mainMenu.append("Books", null);
        mainMenu.append("Test Date", null);
        mainMenu.addCommand(exitCommand);
        mainMenu.setCommandListener(this);
        mainMenu.setTicker(ticker);

        mainMenu();
    }

    void mainMenu() {
        display.setCurrent(mainMenu);
        currentMenu = "Main";
    }

    public void openBooksList() {
        bookMenu = new List("Books Menu", Choice.IMPLICIT);
        bookMenu.addCommand(backCommand);
        bookMenu.setCommandListener(this);
        bookMenu.append("Book 1", null);
        bookMenu.append("Book 2", null);
        bookMenu.append("Book 3", null);
        display.setCurrent(bookMenu);
        currentMenu = "list";
    }

    public void testDate() {
        java.util.Date now = new java.util.Date();
        date.setDate(now);
        Form f = new Form("Today's date");
        f.append(date);
        f.addCommand(backCommand);
        f.setCommandListener(this);
        display.setCurrent(f);
        currentMenu = "date";
    }

    protected void pauseApp() {
        display = null;
        mainMenu = null;
        ticker = null;
    }

    protected void destroyApp(boolean b) throws MIDletStateChangeException {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    public void commandAction(Command command, Displayable displayable) {
        String label = command.getLabel();
        if (label.equals("Exit")) {
            try {
                destroyApp(true);
            } catch (MIDletStateChangeException e) {
                e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
            }
        } else if (label.equals("Back")) {
            if(currentMenu.equals("list") || currentMenu.equals("input") ||
            currentMenu.equals("date") || currentMenu.equals("form")) {
                // go back to menu
                mainMenu();
            }

        } else {
            List down = (List)display.getCurrent();
            if (down.getTitle().equals("Main Menu")) {
                switch(down.getSelectedIndex()) {
                case 0: openBooksList();break;
                case 1: testDate();break;
                }
            } else if (down.getTitle().equals("Books Menu")) {
                switch(down.getSelectedIndex()) {
                case 0: openBook();break;
                case 1: ;break;
            }
        }
    }

    }

    public void openBook() {
        ASynchChapter chapter = (ASynchChapter) createDummyASynchChapter();
        ASynchContentViewerMediator ASCVM = new ASynchContentViewerMediator();
        ASCVM.setChapter(chapter);
        convas  =new PrimitiveDataViewer(chapter.getPrimitiveDatas());

        Display.getDisplay(this).setCurrent(convas);
    }

}
