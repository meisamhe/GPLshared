package databaseTest;

import javax.microedition.midlet.*;
import javax.microedition.lcdui.*;

import java.util.Enumeration;

import org.garret.perst.StorageFactory;
import org.garret.perst.Storage;
import org.garret.perst.Key;
import org.garret.perst.Index;
import org.garret.perst.Types;
import org.garret.perst.StorageError;

public class TestIndex extends MIDlet implements CommandListener
{
    static Command QUIT_CMD = new Command("Quit", Command.EXIT, 1);
    static Command STOP_CMD = new Command("Stop", Command.CANCEL, 1);
    static Command BACK_CMD = new Command("Back", Command.BACK, 1);

    static final int N_INSERT_RECORDS = 1000;
    static final int GAUGE_UPDATE_INTERVAL = 10;

    protected void destroyApp(boolean unconditional) {
   //     storage.close();    // get commented by meisam hejazinia
    }

    protected  void pauseApp() {
    }

    void error(String msg) {
        Alert alert = new Alert("Error",
                                msg,
                                null,
                                AlertType.ERROR);
        alert.setTimeout(Alert.FOREVER);
        Display.getDisplay(this).setCurrent(alert);
    }
     //created by meisam hejazinia
    protected void openDB() {
         long startTime = System.currentTimeMillis();
         storage = StorageFactory.getInstance().createStorage();
        try {
            storage.open("testindex.dbs");
   //         error("done successfully")  ;
        } catch (StorageError x) {
            error("Failed to open database");
            return;
        }
        root = (Index)storage.getRoot();
        new ResultForm(this, "Open", root != null ? root.size() : 0, System.currentTimeMillis() - startTime);

        if (root == null) {
            root = storage.createIndex(Types.Long, true);
            storage.setRoot(root);
        } else {
            long key = lastKey;
            for (int n = root.size(); --n >= 0;) {
                key = (3141592621L*key + 2718281829L) % 1000000007L;
            }
            lastKey = key;
        }
     }
    //created by meisam hejazinia
    protected void closeDB(){
          storage.close();
     }

    protected void startApp()
    {
   //     openDB();
        firstKey = lastKey = 1999L;
        menu = new List("Operations", List.IMPLICIT, new String[]{"Insert", "Iterate", "Search", "Remove"}, null);
        menu.addCommand(QUIT_CMD);
        menu.setCommandListener(this);
        Display.getDisplay(this).setCurrent(menu);
   //     closeDB();
    }

    void quit() {
        destroyApp(true);
        notifyDestroyed();
    }

    abstract class RunTestThread extends Thread {
        RunTestThread(RunTestForm form) {
            this.form = form;
            start();
        }

        public abstract boolean runTest();

        protected boolean increment(int i) {
            if (stopped) {
                new ResultForm(TestIndex.this, form.getTitle(), i, System.currentTimeMillis() - startTime);
                return false;
            } else {
                if (i % GAUGE_UPDATE_INTERVAL == 0) {
                    form.progress.setValue(i);
                }
                return true;
            }
        }

        public void run() {
            startTime = System.currentTimeMillis();
            if (runTest()) {
                if (form.progress == null) {
                    error("No elements");
                } else {
                    new ResultForm(TestIndex.this, form.getTitle(), form.progress.getMaxValue(), System.currentTimeMillis() - startTime);
                }
            }
        }

        private RunTestForm form;
        private long        startTime;
    }

    class InsertThread extends RunTestThread {
        InsertThread(RunTestForm form) {
            super(form);
        }

        public boolean runTest() {
            openDB();
            long key = lastKey;
            for (int i = 0; i < N_INSERT_RECORDS && increment(i); i++) {
              key = (3141592621L*key + 2718281829L) % 1000000007L;
                Record rec = new Record(key);
                if (!root.put(new Key(rec.key), rec)) {
                    error("Duplicates in tree");
                    closeDB();
                    return false;
                }
            }
            lastKey = key;
//            storage.commit();
//            key = lastKey;
//            for (int i = 0; i < N_INSERT_RECORDS && increment(i); i++) {
//                key = (3141592621L*key + 2718281829L) % 1000000007L;
//                Record rec = new Record(key);
//                if (!root.put(new Key(rec.key), rec)) {
//                    error("Duplicates in tree");
//                    closeDB();
//                    return false;
//                }
//            }
//            lastKey=key;
            storage.commit();
             closeDB();
            return true;
        }   
    }

    class IterateThread extends RunTestThread {
        IterateThread(RunTestForm form) {
            super(form);
        }

        public boolean runTest() {
            openDB();
            Enumeration e = root.iterator();
            long prevKey = Long.MIN_VALUE;
            int i;
            for (i = 0; e.hasMoreElements() && increment(i); i++) {
                Record rec = (Record)e.nextElement();
                if (rec.key <= prevKey) {
                    error("Order is not correct");
                    closeDB();
                    return false;
                }
                prevKey = rec.key;
            }
            if (!e.hasMoreElements() && i != root.size()) {
                error("Number of elements doesn't match");
                closeDB();
                return false;
            }
            closeDB();
            return true;
        }
    }

    class SearchThread extends RunTestThread {
        SearchThread(RunTestForm form) {
            super(form);
        }

        public boolean runTest() {
            openDB();
            long key = firstKey;
            for (int i = 0, n = root.size(); i < n; i++) {
                key = (3141592621L*key + 2718281829L) % 1000000007L;
                Record rec = (Record)root.get(new Key(key));
                if (rec == null || rec.key != key) {
                    error("Record not found");
                    closeDB();
                    return false;
                }
                increment(i);
            }
            closeDB();
            return true;
        }
    }

    class RemoveThread extends RunTestThread {
        RemoveThread(RunTestForm form) {
            super(form);
        }

        public boolean runTest() {
            openDB();
            long key = firstKey;
            for (int i = 0, n = root.size(); i < n; i++) {
                key = (3141592621L*key + 2718281829L) % 1000000007L;
                Record rec = (Record)root.get(new Key(key));
                if (rec == null || rec.key != key) {
                    error("Record not found");
                    closeDB();
                    return false;
                }
                root.remove(new Key(key));
                increment(i);
            }
            lastKey = firstKey;
            storage.commit();
            closeDB();
            return true;
        }
    }

    public void commandAction(Command c, Displayable d)
    {
        if (c == QUIT_CMD) {
            quit();
        } else {
            stopped = false;
            switch (menu.getSelectedIndex()) {
            case 0:
                new InsertThread(new RunTestForm(this, "Insert", N_INSERT_RECORDS));
                break;
            case 1:
                new IterateThread(new RunTestForm(this, "Iterate", root.size()));
                break;
            case 2:
                new SearchThread(new RunTestForm(this, "Search", root.size()));
                break;
            case 3:
                new RemoveThread(new RunTestForm(this, "Remove", root.size()));
                break;
            }
        }
    }

    long             firstKey;
    long             lastKey;
    Storage          storage;
    Index            root;
    boolean          stopped;
    List             menu;
}
