#include <qapplication.h>
#include "form1.h"

int main( int argc, char ** argv )
{
    QApplication a( argc, argv );
    os1frm w;
    w.show();
    a.connect( &a, SIGNAL( lastWindowClosed() ), &a, SLOT( quit() ) );
    return a.exec();
}
