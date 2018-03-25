/**
 *                                      In the name of Allah
 *                                       The best will come
 */

import entities.ASynchChapter;
import entities.Book;
import entities.Chapter;
import entities.Text;
import viewer.ASynchContentViewerMediator;
import viewer.conceptualModel.primitive;
import viewer.treeViewer.TOCTreeViewer;

import javax.microedition.lcdui.*;
import javax.microedition.midlet.MIDlet;
import javax.microedition.midlet.MIDletStateChangeException;
import java.util.Vector;


public class MobileDigitalLibrary extends MIDlet {
    Display display = null;
    primitive convas;
    Ticker ticker = new Ticker("Welcome !");
    java.util.Date now = new java.util.Date();
    List mainMenu = null;
    List booksMenu = null;
    List chaptersMenu = null;

    DateField date = new DateField("Today's date: ", DateField.DATE);
    String currentMenu = null;
    static final Command exitCommand = new Command("خروج", Command.STOP, 2);
    static final Command backCommand = new Command("بازگشت", Command.BACK, 0);

    protected void startApp() throws MIDletStateChangeException {
        display = Display.getDisplay(this);
        mainMenu = new List("Main Menu", Choice.IMPLICIT);
        mainMenu.append("کتابخانه", null);
        mainMenu.append("تاریخ", null);
        mainMenu.addCommand(exitCommand);
        mainMenu.setCommandListener(new MainCommandListener());
        currentMenu = "mainMenu";
        display.setCurrent(mainMenu);
    }

    protected void pauseApp() {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    protected void destroyApp(boolean b) throws MIDletStateChangeException {
        //To change body of implemented methods use File | Settings | File Templates.
    }


    public void openBooksList() {
        booksMenu = new List("Books Menu", Choice.IMPLICIT);
        booksMenu.addCommand(backCommand);
        booksMenu.addCommand(exitCommand);
        booksMenu.setCommandListener(new MainCommandListener());
        booksMenu.append("Book 1", null);
        booksMenu.append("Book 2", null);
        booksMenu.append("Book 3", null);
        display.setCurrent(booksMenu);
        currentMenu = "booksList";
    }

    public void getDate() {
        java.util.Date now = new java.util.Date();
        date.setDate(now);
        Form f = new Form("Today's date");
        f.append(date);
        f.addCommand(backCommand);
        f.addCommand(exitCommand);
        f.setCommandListener(new MainCommandListener());
        display.setCurrent(f);
        currentMenu = "date";
    }

    public void openChaptersList() {
        chaptersMenu = new List("Chapters Menu", Choice.IMPLICIT);
        chaptersMenu.addCommand(backCommand);
        chaptersMenu.addCommand(exitCommand);
        chaptersMenu.setCommandListener(new MainCommandListener());
        chaptersMenu.append("chapter 1", null);
        chaptersMenu.append("chapter 2", null);
        chaptersMenu.append("chapter 3", null);
        display.setCurrent(chaptersMenu);
        currentMenu = "chaptersList";
    }

    // It should b assigned to mediator
    public void openChapter() {
        ASynchChapter chapter = (ASynchChapter) createDummyASynchChapter();
        ASynchContentViewerMediator ASCVM = new ASynchContentViewerMediator();
        ASCVM.setChapter(chapter);
        convas = new primitive(chapter.getPrimitiveDatas());
        convas.addCommand(backCommand);
        convas.addCommand(exitCommand);
        convas.setCommandListener(new MainCommandListener());
        Display.getDisplay(this).setCurrent(convas);
        currentMenu = "chapterContent";
    }

    // It should b assigned to mediator
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

        entities.Image image = new entities.Image();
        image.setPath("/images/Sunset1.jpg");
        datas.addElement(image);

        t = new Text();
        t.setContent("And the third segment of text data is longer than first one!.");
        datas.addElement(t);

        image = new entities.Image();
        image.setPath("/images/Sunset2.jpg");
        datas.addElement(image);

        image = new entities.Image();
        image.setPath("/images/Sunset3.jpg");
        datas.addElement(image);

        t = new Text();
        t.setContent("چهارمین محتوا خیلی کوچک است!");
        datas.addElement(t);

        image = new entities.Image();
        image.setPath("/images/Sunset3.jpg");
        datas.addElement(image);

        image = new entities.Image();
        image.setPath("/images/Sunset3.jpg");
        datas.addElement(image);

        image = new entities.Image();
        image.setPath("/images/Sunset3.jpg");
        datas.addElement(image);

        image = new entities.Image();
        image.setPath("/images/Sunset3.jpg");
        datas.addElement(image);

        t = new Text();
        t.setContent("در انتها نیاز بود که داده‌های بسیار طولانی در محیط قرارداده شود تا از این طریق اعمالی از قبیل شکستن متن مورد آزمون واقع شود!");
        datas.addElement(t);


        retValue.setPrimitiveDatas(datas);


        return retValue;
    }

    private static Book createDummyASynchBook() {
        Book book = new Book();

        book.setTableOfContent(TOCTreeViewer.createDummyData());
        book.getChapters().addElement(createDummyASynchChapter());
        book.getChapters().addElement(createDummyASynchChapter());

        return book;
    }

    private class MainCommandListener implements CommandListener {

        public void commandAction(Command command, Displayable displayable) {
            String label = command.getLabel();
            if (label.equals("Exit")) {
                try {
                    destroyApp(true);
                } catch (MIDletStateChangeException e) {
                    e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
                }
            } else if (label.equals("Back")) {
                if (currentMenu.equals("booksList") || (currentMenu.equals("date"))) {
                    currentMenu = "mainMenu";
                    display.setCurrent(mainMenu);
                } else if (currentMenu.equals("chaptersList")) {
                    currentMenu = "booksList";
                    display.setCurrent(booksMenu);
                } else if (currentMenu.equals("chapterContent")) {
                    currentMenu = "chaptersList";
                    display.setCurrent(chaptersMenu);
                }

            } else {
                List down = (List) display.getCurrent();
                if (currentMenu.equals("mainMenu")) {
                    switch (down.getSelectedIndex()) {
                        case 0:
                            getDate();
                            break;
                        case 1:
                            openBooksList();
                            break;
                    }
                } else if (currentMenu.equals("booksList")) {
                    switch (down.getSelectedIndex()) {
                        case 0:
                            openChaptersList();
                            break;
                        case 1:
                            openChaptersList();
                            break;
                        case 2:
                            openChaptersList();
                            break;
                    }
                } else if (currentMenu.equals("chaptersList")) {
                    switch (down.getSelectedIndex()) {
                        case 0:
                            openChapter();
                            break;
                        case 1:
                            openChapter();
                            break;
                        case 2:
                            openChapter();
                            break;
                    }
                }

            }
        }
    }
}
