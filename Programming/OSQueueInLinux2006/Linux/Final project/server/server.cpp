#include <qapplication.h>
#include  "serverform.h"
#include <iostream>
using namespace std;

int main(int argc,char **argv)
	{
	cout << "---" << endl;
	QApplication App(argc,argv);
cout << "---" << endl;
	ServerForm myServerForm;
cout << "---" << endl;
	myServerForm.show();
cout << "---" << endl;
	App.setMainWidget(&myServerForm);
cout << "---" << endl;
	return App.exec();
	}
