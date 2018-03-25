/**
 *                                      In the name of Allah
 *                                       The best will come
 */

package entities;

import java.util.Vector;

public class Book {

    private String title;
    private Vector authors;
    private Vector chapters;

    public Book() {
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
}