/**
 *                                      In the name of Allah
 *                                       The best will come
 */

package util;


public class Direction {

    public static final Direction RIGHT = new Direction("RIGHT");
    public static final Direction LEFT = new Direction("LEFT");
    public static final Direction CENTER = new Direction("CENTER");
    private final String myName;

    private Direction(String name) {
        myName = name;
    }

    public String toString() {
        return myName;
    }

}
