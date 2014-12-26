#include <qapplication.h>
#include "form2.h"

int main( int argc, char ** argv )
{
    QApplication a( argc, argv );
    Form2 w;
    w.show();
    a.connect( &a, SIGNAL( lastWindowClosed() ), &a, SLOT( quit() ) );
    return a.exec();
}
