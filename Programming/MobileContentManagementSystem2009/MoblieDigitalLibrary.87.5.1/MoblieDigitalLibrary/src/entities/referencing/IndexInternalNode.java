/**
 *                                      In the name of Allah
 *                                       The best will come
 */


package entities.referencing;

import java.util.Vector;

public class IndexInternalNode extends IndexRoot {
    private Vector childs;

    public IndexInternalNode(String title, Reference reference) {
        super(title, reference);
        childs = new Vector();
    }

    public Vector getChilds() {
        return childs;
    }

    public void setChilds(Vector childs) {
        this.childs = childs;
    }

    public void addChild(IndexRoot root) {
        childs.addElement(root);
    }
}