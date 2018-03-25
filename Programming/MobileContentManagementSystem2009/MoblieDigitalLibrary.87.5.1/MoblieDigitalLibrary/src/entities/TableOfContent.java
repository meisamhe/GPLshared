/**
 *                                      In the name of Allah
 *                                       The best will come
 */


package entities;

import entities.referencing.IndexRoot;
import util.Direction;

public class TableOfContent {

    private IndexRoot indexRoot;
    private Direction direction;

    public IndexRoot getIndexRoot() {
    return indexRoot;
}

    public void setIndexRoot(IndexRoot indexRoot) {
        this.indexRoot = indexRoot;
    }

    public Direction getDirection() {
        return direction;
    }

    public void setDirection(Direction direction) {
        this.direction = direction;
    }
}