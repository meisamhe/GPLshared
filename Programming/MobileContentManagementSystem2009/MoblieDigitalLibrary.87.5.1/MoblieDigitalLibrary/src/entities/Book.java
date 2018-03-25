/**
 *                                      In the name of Allah
 *                                       The best will come
 */

package entities;

import entities.referencing.IndexRoot;
import entities.referencing.ContinuePoint;

import java.util.Vector;

public class Book {

    private String title;
    private Vector authors;
    private Vector chapters;
    private TableOfContent tableOfContent;
    private ContinuePoint continuePoint;

    public Book() {
    }

    public TableOfContent getTableOfContent() {
        return tableOfContent;
    }

    public void setTableOfContent(TableOfContent tableOfContent) {
        this.tableOfContent = tableOfContent;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Vector getAuthors() {
        return authors;
    }

    public void setAuthors(Vector authors) {
        this.authors = authors;
    }

    public Vector getChapters() {
        return chapters;
    }

    public void setChapters(Vector chapters) {
        this.chapters = chapters;
    }

    public ContinuePoint getContinuePoint() {
        return continuePoint;
    }

    public void setContinuePoint(ContinuePoint continuePoint) {
        this.continuePoint = continuePoint;
    }
}