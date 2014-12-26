// This program is for simple testing of OpenGL: a HELLO-WORLD program
// Written by Farzam Farbiz
// Date: 1383/12/15

#include <windows.h>
#include <stdlib.h>
#include <GL/gl.h>
#include <GL/glu.h>
#include <GL/glut.h>


void display(void )
{
	glClearColor(0.5, 0.5, 0.5, 1);
	glClear(GL_COLOR_BUFFER_BIT);
	//glColor3f(1, 0, 0);
	glBegin(GL_TRIANGLES);
	glColor3f(1, 0, 0);
		glVertex2f(-0.5, -0.5);
	glColor3f(0, 0, 1);
		glVertex2f( 0.5, -0.5);
	glColor3f(0, 1, 0);
		glVertex2f( 0 , 0.5);
	glEnd( );
	glFlush( );
}


int main (int argc, char *argv[])
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_RGB);
	glutInitWindowSize(640, 480);
	glutCreateWindow("Hello World");
	glutDisplayFunc(display);
	glutMainLoop( );
	return(0);
}

