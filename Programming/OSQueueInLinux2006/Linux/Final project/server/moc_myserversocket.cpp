/****************************************************************************
** MyServerSocket meta object code from reading C++ file 'myserversocket.h'
**
** Created: Fri Jun 30 16:25:19 2006
**      by: The Qt MOC ($Id: qt/moc_yacc.cpp   3.3.5   edited Sep 2 14:41 $)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#undef QT_NO_COMPAT
#include "myserversocket.h"
#include <qmetaobject.h>
#include <qapplication.h>

#include <private/qucomextra_p.h>
#if !defined(Q_MOC_OUTPUT_REVISION) || (Q_MOC_OUTPUT_REVISION != 26)
#error "This file was generated using the moc from 3.3.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

const char *MyServerSocket::className() const
{
    return "MyServerSocket";
}

QMetaObject *MyServerSocket::metaObj = 0;
static QMetaObjectCleanUp cleanUp_MyServerSocket( "MyServerSocket", &MyServerSocket::staticMetaObject );

#ifndef QT_NO_TRANSLATION
QString MyServerSocket::tr( const char *s, const char *c )
{
    if ( qApp )
	return qApp->translate( "MyServerSocket", s, c, QApplication::DefaultCodec );
    else
	return QString::fromLatin1( s );
}
#ifndef QT_NO_TRANSLATION_UTF8
QString MyServerSocket::trUtf8( const char *s, const char *c )
{
    if ( qApp )
	return qApp->translate( "MyServerSocket", s, c, QApplication::UnicodeUTF8 );
    else
	return QString::fromUtf8( s );
}
#endif // QT_NO_TRANSLATION_UTF8

#endif // QT_NO_TRANSLATION

QMetaObject* MyServerSocket::staticMetaObject()
{
    if ( metaObj )
	return metaObj;
    QMetaObject* parentObject = QServerSocket::staticMetaObject();
    metaObj = QMetaObject::new_metaobject(
	"MyServerSocket", parentObject,
	0, 0,
	0, 0,
#ifndef QT_NO_PROPERTIES
	0, 0,
	0, 0,
#endif // QT_NO_PROPERTIES
	0, 0 );
    cleanUp_MyServerSocket.setMetaObject( metaObj );
    return metaObj;
}

void* MyServerSocket::qt_cast( const char* clname )
{
    if ( !qstrcmp( clname, "MyServerSocket" ) )
	return this;
    return QServerSocket::qt_cast( clname );
}

bool MyServerSocket::qt_invoke( int _id, QUObject* _o )
{
    return QServerSocket::qt_invoke(_id,_o);
}

bool MyServerSocket::qt_emit( int _id, QUObject* _o )
{
    return QServerSocket::qt_emit(_id,_o);
}
#ifndef QT_NO_PROPERTIES

bool MyServerSocket::qt_property( int id, int f, QVariant* v)
{
    return QServerSocket::qt_property( id, f, v);
}

bool MyServerSocket::qt_static_property( QObject* , int , int , QVariant* ){ return FALSE; }
#endif // QT_NO_PROPERTIES
