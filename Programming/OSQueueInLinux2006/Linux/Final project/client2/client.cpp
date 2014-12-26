#include <qapplication.h>
#include  "clientform.h"
#include <iostream>

using namespace std;
int main(int argc,char **argv)
{
	QApplication App(argc,argv);
 	ClientForm myClientForm;
 	myClientForm.show();
 	App.setMainWidget(&myClientForm);
	return App.exec();
}