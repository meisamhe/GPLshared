/**
 *                                      In the name of Allah
 *                                       The best will come
 */


package viewer.treeViewer;

import entities.TableOfContent;
import entities.referencing.IndexInternalNode;
import entities.referencing.IndexLeaf;
import entities.referencing.IndexRoot;
import util.Direction;

import java.io.IOException;

public class TOCTreeViewer extends AbstractTreeViewer {

    public TOCTreeViewer(Object data, int clipY, int clipX, int clipHeight, int clipWidth, Direction direction) throws IOException {
        super(data, clipY, clipX, clipHeight, clipWidth, direction);
    }

    protected void prepareTree(Object root, int tab) {
        treeNodesView.addElement(new TreeViewNode(tab, ((IndexRoot) root).getTitle(), ((IndexRoot) root).getReference()));
        if (root instanceof IndexLeaf)
            return;
        IndexInternalNode internalNode = (IndexInternalNode) root;
        for (int cnt = 0; cnt < internalNode.getChilds().size(); cnt++)
            prepareTree(internalNode.getChilds().elementAt(cnt), tab + 1);
    }

    public static TableOfContent createDummyData() {
        TableOfContent toc = new TableOfContent();
        toc.setDirection(Direction.RIGHT);
        IndexInternalNode root = new IndexInternalNode("فصل اولی", null);
        toc.setIndexRoot(root);

        IndexInternalNode node;

        node = new IndexInternalNode("بخش اول", null);
        IndexLeaf leaf = new IndexLeaf("زیر فصل اول", null);
        node.addChild(leaf);
        leaf = new IndexLeaf("زیر فصل دوم", null);
        node.addChild(leaf);
        root.addChild(node);


        node = new IndexInternalNode("بخش دوم", null);
        leaf = new IndexLeaf("زیر فصل اول", null);
        node.addChild(leaf);
        leaf = new IndexLeaf("زیر فصل اول", null);
        node.addChild(leaf);
        leaf = new IndexLeaf("زیر فصل اول", null);
        node.addChild(leaf);
        leaf = new IndexLeaf("زیر فصل اول", null);
        node.addChild(leaf);
        leaf = new IndexLeaf("زیر فصل اول", null);
        node.addChild(leaf);
        leaf = new IndexLeaf("زیر فصل اول", null);
        node.addChild(leaf);
        leaf = new IndexLeaf("زیر فصل اول", null);
        node.addChild(leaf);
        leaf = new IndexLeaf("زیر فصل اول", null);
        node.addChild(leaf);
        leaf = new IndexLeaf("زیر فصل اول", null);
        node.addChild(leaf);
        leaf = new IndexLeaf("زیر فصل اول", null);
        node.addChild(leaf);
        leaf = new IndexLeaf("زیر فصل اول", null);
        node.addChild(leaf);
        leaf = new IndexLeaf("زیر فصل اول", null);
        node.addChild(leaf);
        leaf = new IndexLeaf("زیر فصل اول", null);
        node.addChild(leaf);
        IndexInternalNode n2 = new IndexInternalNode("زیر فصل  دوم", null);
        leaf = new IndexLeaf("زیر فصلتر اول", null);
        n2.addChild(leaf);
        node.addChild(n2);
        leaf = new IndexLeaf("زیر فصل سوم", null);
        node.addChild(leaf);
        root.addChild(node);

        leaf = new IndexLeaf("بخش سوم", null);
        root.addChild(leaf);

        return toc;
    }
    
}