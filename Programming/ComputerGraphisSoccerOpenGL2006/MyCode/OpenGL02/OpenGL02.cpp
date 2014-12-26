// This program is for simple testing of OpenGL: a HELLO-WORLD program
// Written by Farzam Farbiz
// Date: 1383/12/17


#include <windows.h>
#include <stdlib.h>
#include <GL/gl.h>
#include <GL/glu.h>
#include <GL/glut.h>
//#include  <stdio.h>


/* vertices of cube about the origin */
GLfloat vertices[8][3] =
{{-1.0, -1.0, -1.0}, {1.0, -1.0, -1.0},
{1.0, 1.0, -1.0}, {-1.0, 1.0, -1.0}, {-1.0, -1.0, 1.0},
{1.0, -1.0, 1.0}, {1.0, 1.0, 1.0}, {-1.0, 1.0, 1.0}};
/* colors to be assigned to edges */
GLfloat colors[8][3] =
{{0.0, 0.0, 0.0}, {1.0, 0.0, 0.0},
{1.0, 1.0, 0.0}, {0.0, 1.0, 0.0}, {0.0, 0.0, 1.0},
{1.0, 0.0, 1.0}, {1.0, 1.0, 1.0}, {0.0, 1.0, 1.0}};


GLfloat theta[3] = {0.0, 0.0, 0.0};


GLfloat delta = 2.0;
GLint axis = 2;

int stop=0;

void spinCube()
{
/* spin cube delta degrees about selected axis */
	theta[axis] += delta;
	if (theta[axis] > 360.0) theta[axis] -= 360.0;
/* display result */
	glutPostRedisplay();
}


void face(int a, int b, int c, int d)
{
	glBegin(GL_POLYGON);
	glColor3fv (colors[a]);
	glVertex3fv(vertices[a]);
	glColor3fv (colors[b]);
	glVertex3fv(vertices[b]);
	glColor3fv (colors[c]);
	glVertex3fv(vertices[c]);
	glColor3fv (colors[d]);
	glVertex3fv(vertices[d]);
	glEnd();
}


void colorcube(void)
{
	face(0,3,2,1);
	face(2,3,7,6);
	face(0,4,7,3);
	face(1,2,6,5);
	face(4,5,6,7);
	face(0,1,5,4);
}



void display(void)
{
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glLoadIdentity();
	glRotatef(theta[0], 1.0, 0.0, 0.0);
	glRotatef(theta[1], 0.0, 1.0, 0.0);
	glRotatef(theta[2], 0.0, 0.0, 1.0);
	colorcube();
	glFlush();
	glutSwapBuffers();
}




void myReshape(int w, int h)
{
	GLfloat aspect = (GLfloat) w / (GLfloat) h;
	glViewport(0, 0, w, h);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	if (w <= h) /* aspect <= 1 */
	glOrtho(-2.0, 2.0, -2.0/aspect, 2.0/aspect, -10.0, 10.0);
	else /* aspect > 1 */
	glOrtho(-2.0*aspect, 2.0*aspect, -2.0, 2.0, -10.0, 10.0);
	glMatrixMode(GL_MODELVIEW);
}


void mouse(int btn, int state, int x, int y)
{
	if (btn==GLUT_LEFT_BUTTON
		&& state == GLUT_DOWN) axis = 0;
if (btn==GLUT_MIDDLE_BUTTON
		&& state == GLUT_DOWN) axis = 1;
if (btn==GLUT_RIGHT_BUTTON
		&& state == GLUT_DOWN) axis = 2;
}



void keyboard(unsigned char key, int x, int y)
{
	if (key=='q' || key == 'Q') exit(0);
	if (key==' ') {stop = !stop;};
	if (stop)
		glutIdleFunc(NULL);
	else
		glutIdleFunc(spinCube);
}


int main(int argc, char **argv)
{
	glutInit(&argc, argv);
	/* double buffering for smooth animation */
	glutInitDisplayMode	(GLUT_DOUBLE | GLUT_DEPTH | GLUT_RGB);

	/* window creation and callbacks here */
	glutInitWindowSize(500, 500);
	glutCreateWindow("cube");
	glutReshapeFunc(myReshape);
	glutDisplayFunc(display);
	glutIdleFunc(spinCube);
	glutMouseFunc(mouse);
	glutKeyboardFunc(keyboard);

	glEnable(GL_DEPTH_TEST);
	glutMainLoop();
	return(0);
}
