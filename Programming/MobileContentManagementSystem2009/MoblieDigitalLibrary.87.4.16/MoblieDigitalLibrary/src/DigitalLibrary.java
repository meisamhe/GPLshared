/**
 *                                      In the name of Allah
 *                                       The best will come
 */

import entities.Chapter;
import entities.ASynchChapter;
import entities.Text;
import entities.Image;

import java.util.Vector;

import viewer.ASynchContentViewerMediator;
import viewer.conceptualModel.primitive;

import javax.microedition.midlet.MIDlet;
import javax.microedition.midlet.MIDletStateChangeException;
import javax.microedition.lcdui.*;

public class DigitalLibrary extends MIDlet implements CommandListener  {

    // display manager
    Display display = null;
    //   private Command levelCommand = new Command("Change Level", Command.SCREEN,24);
  primitive convas;
    // a menu with items
    List menu = null; // main menu
    // textbox
    TextBox input = null;
    // date
    DateField date = new DateField("Today's date: ", DateField.DATE);
    // ticker
    Ticker ticker = new Ticker("پیام روز!");
    // list of choices
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
        t.setContent("This is the first line of DigitalLibrary data.");
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

        menu = new List("Main Menu", Choice.IMPLICIT);
//        menu.append("Test TextBox", null);
        menu.append("کتاب اول", null);
//        menu.append("Test Date", null);
        //menu.append("Test Form", null);
        menu.addCommand(exitCommand);
        menu.setCommandListener(this);
        menu.setTicker(ticker);

        mainMenu();
    }

    // main menu
    void mainMenu() {
        display.setCurrent(menu);
        currentMenu = "Main";
    }

    public void testTextBox() {
        input = new TextBox("Enter Some Text:", "", 10, TextField.ANY);
        input.setTicker(new Ticker("Testing TextBox"));
        input.addCommand(backCommand);
        input.setCommandListener(this);
        input.setString("");
        display.setCurrent(input);
        currentMenu = "input";
    }

    public void openBooksList() {
        bookMenu = new List("Books Menu", Choice.IMPLICIT);
        bookMenu.addCommand(backCommand);
        bookMenu.setCommandListener(this);
        bookMenu.append("کتاب آزمایشی 1", null);
        bookMenu.append("کتاب آزمایشی 2", null);
        bookMenu.append("کتاب آزمایشی 3", null);
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
        menu = null;
        ticker = null;
    }

    protected void destroyApp(boolean b) throws MIDletStateChangeException {

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
//                switch(down.getSelectedIndex()) {
//                case 0: testTextBox();break;
//                case 1: openBooksList();break;
//                case 2: testDate();break;
//                }
//            } else if (down.getTitle().equals("Books Menu")) {
                switch(down.getSelectedIndex()) {
                case 0: openBook();break;
                case 1: openBook();break;
                case 2: openBook();break;
            }
        }
    }

    }

    public void openBook() {
        ASynchChapter chapter = (ASynchChapter) createDummyASynchChapter();
        ASynchContentViewerMediator ASCVM = new ASynchContentViewerMediator();
        ASCVM.setChapter(chapter);
        convas  =new primitive(chapter.getPrimitiveDatas());
         Display.getDisplay(this).setCurrent(convas);
    }

}
