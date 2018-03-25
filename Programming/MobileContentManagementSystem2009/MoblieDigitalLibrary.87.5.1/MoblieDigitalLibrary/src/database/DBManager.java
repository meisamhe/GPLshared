/**
 * Created by IntelliJ IDEA.
 * User: test
 * Date: Jul 12, 2008
 * Time: 12:06:39 PM
 * To change this template use File | Settings | File Templates.
 */
package database;

import entities.ASynchChapter;
import entities.Book;
import entities.Chapter;
import entities.Text;
import viewer.treeViewer.TOCTreeViewer;

import java.util.Vector;

public class DBManager {
    private static DBManager ourInstance = new DBManager();

    public static DBManager getInstance() {
        return ourInstance;
    }

    private DBManager() {
    }

    public Vector getBooksNames(){
        Vector retValue = new Vector();
        retValue.addElement("کتاب اول");
        retValue.addElement("کتاب دوم");
        return retValue;
    }

    public Book loadBook(String bookName) {
        return createDummyASynchBook();
    }

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

}
