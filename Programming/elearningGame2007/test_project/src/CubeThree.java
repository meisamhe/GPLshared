/*
 *  Program:    CubeThree.java
 *  Purpose:    3D Movement Demo
 *  Author:     George Aroush
 *  Date:       1/1/1998
 *  Change Log: None
 *
 *  Full description of Program:
 *      Displays and "bounces" a cube on the screen in a 3D space,
 *      how to display a wire-frame 3D shape, connecting its vertex
 *      by a line segments
 */

import java.applet.*;
import java.awt.*;

public class CubeThree extends Applet
{
    final int   NP = 8;     /* number of points */
    final int   NE = 12;    /* number of edges */
    final int   CX = 320;   /* center of screen */
    final int   CY = 240;
    final int   MAXX = 512; /* used to check if a line is on the screen */
    final int   MAXY = 342;
    final int   X = 0;      /* the x, y, and z part of the array */
    final int   Y = 1;
    final int   Z = 2;

    public void paint(Graphics g)
    {
            /* Coordinates of cube. This array holds the shape that we want to define in a 3D space */
        float	coord[][] = {{75, 75, 325}, {75, -75, 325}, {-75, -75, 325}, {-75, 75, 325},
                             {75, 75, 475}, {75, -75, 475}, {-75, -75, 475}, {-75, 75, 475}};
            /* index numbers of coordinates for endpoints of edges */
        int     edge[][] = {{0, 1}, {1, 2}, {2, 3}, {3, 0},
                            {0, 4}, {1, 5}, {2, 6}, {3, 7},
                            {4, 5}, {5, 6}, {6, 7}, {7, 4}};

            /* velocity -- x, y, and z */
        float   trans[] = {10, 10, 10};

            /* Minimum & maximum x, y, & z values for vertex 0 (coord[0][0]) */
        float   limits[][] = {{-400, 400}, {-400, 400}, {300, 1111}};

            /* Holds the x & y points that are the result of projection */
        int		proj[][] = new int[NP][2];

        float   sd = 300;
        int     i, j;


            /* move cube, project it on screen, and display its vertices */
        for (j = 0; j < 2000; j++)
        {
            /* Translate cube on screen, moving it to a new place
             *
             * Translate() needs to know the followings:
             *
             *	coord --> an array holding the defined 3D shape data
             *	trans --> an array holding the x, y, & z movements
             *	NP -----> number of points in the array "coord"
             */
            Translate(coord, trans, NP);

                /* Test vertex 0 & reverse direction if it has crossed a limit.  Note that vertex 0 */
                /* consists of x, y, & z, so our loop will loop three times for one vertex, testing */
                /* x, y, & z one by one in the if_() statement in the for_() loop. */
            for (i = X; i <= Z; i++)    /* "same as:" for (i = 0; i <= 2; i++) */
            {
                if (coord[0][i] < limits[i][0] || coord[0][i] > limits[i][1])
                    trans[i] *= -1.0;       /* reverse direction */
            }

            Project(coord, proj, NP, sd);   /*calculates where each vertex will be on the 2D screen */

            g.clearRect(0, 0, 640, 480);

            /*
             * Displays a wire-frame of object.
             *
             * Display() needs to know the followings:
             *
             *	proj ---> an array in which the 2D shape are stored
             *	edge----> an array dells display() how to connect the shape
             *	sd -----> number of points in the array "coord"
             */

            Display(proj, edge, NE, g);

            Delay(60);
        }
    }


    /*
     *	void	Project(coord, proj, np, sd)
     *
     *	Projects coordinate array onto screen at given screen distance storing
     *	result as x and y coordinates in proj[][2] array
     */
    void	Project(float coord[][], int proj[][], int np, float sd)
    {
        int     i;

        for (i = 0; i < np; i++)
        {
            proj[i][X] = CX + (int) (coord[i][X] * sd / coord[i][Z]);
            proj[i][Y] = CY + (int) (coord[i][Y] * sd / coord[i][Z]);
        }
    }


    /*
     *	void	Translate(coord, trans, np)
     *
     *	Add three values of trans[3] to each vertex in coord[][3] thus moving vertices along all three axes
     */
    void	Translate(float coord[][], float trans[], int np)
    {
        int	i, j;

        for (i = 0; i < np; i++)    /* loop in the array */
        {
            for (j = 0; j < 3; j++)     /* loop in the vertex */
                coord[i][j] += trans[j];
        }
    }


    /*
     *	void	Display(proj, edge, ne)
     *
     *	Displays wire frame of object.  Uses values in edge[][2] to find starting and
     *	ending vertex for each edge
     */
    void	Display(int proj[][], int edge[][], int ne, Graphics g)
    {
        int     e;
        int     s, f;
        int     x1, y1, x2, y2;

        for (e = 0; e < ne; e++)
        {
            s = edge[e][0];     /* s -- is the starting vertex */
            f = edge[e][1];     /* f -- is the ending vertex */

            x1 = proj[s][X];    /* stating point of a line */
            y1 = proj[s][Y];

            x2 = proj[f][X];    /* ending point of a line */
            y2 = proj[f][Y];

                /* make sure the the line is on the screen */
            if (x1 >= 0 && x1 < MAXX && y1 >= 0 && y1 < MAXY &&
                x2 >= 0 && x2 < MAXX && y2 >= 0 && y2 < MAXY)
            {
                g.drawLine(x1, y1, x2, y2);
            }
        }
    }


    /*
     *  void    Delay()
     *
     *  Simply pauses for some time
     */
    public void Delay(int delayTime)
    {
        try
        {
            Thread.sleep(delayTime);    /* call Java's sleep method */
        }
        catch (InterruptedException e)
        {
            /* when the sleep() call above is over, Java will */
            /* be interuppted and we fall into this block of code */
            /* because our intention is simply slow down things */
            /* wed do nothing in our exception code and just get out */
        }
    }
}

