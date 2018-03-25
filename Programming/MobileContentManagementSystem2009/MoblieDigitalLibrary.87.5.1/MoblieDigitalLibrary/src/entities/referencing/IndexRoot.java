/**
 *                                      In the name of Allah
 *                                       The best will come
 */


package entities.referencing;

public class IndexRoot {

    protected String title;
    protected Reference reference;

    public IndexRoot(String title, Reference reference) {
        this.title = title;
        this.reference = reference;
    }

    public IndexRoot() {

    }

    public Reference getReference() {
        return reference;
    }

    public void setReference(Reference reference) {
        this.reference = reference;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}