/**
 *                                      In the name of Allah
 *                                       The best will come
 */


package viewer.treeViewer;

import util.Direction;

import java.io.IOException;
import java.util.Vector;

public class BooksListViewer extends AbstractTreeViewer {
    public BooksListViewer(Object data, int clipY, int clipX, int clipHeight, int clipWidth, Direction direction) throws IOException {
        super(data, clipY, clipX, clipHeight, clipWidth, direction);
    }

    protected void prepareTree(Object root, int tab) {
        Vector booksName = (Vector) root;
        for(int cnt = 0; cnt < booksName.size(); cnt++)
            treeNodesView.addElement(new TreeViewNode(0, (String) booksName.elementAt(cnt), booksName.elementAt(cnt)));
    }
}