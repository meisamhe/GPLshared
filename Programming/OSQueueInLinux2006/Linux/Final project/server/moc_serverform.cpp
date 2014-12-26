/****************************************************************************
** ServerForm meta object code from reading C++ file 'serverform.h'
**
** Created: Fri Jun 30 17:34:21 2006
**      by: The Qt MOC ($Id: qt/moc_yacc.cpp   3.3.5   edited Sep 2 14:41 $)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#undef QT_NO_COMPAT
#include "serverform.h"
#include <qmetaobject.h>
#include <qapplication.h>

#include <private/qucomextra_p.h>
#if !defined(Q_MOC_OUTPUT_REVISION) || (Q_MOC_OUTPUT_REVISION != 26)
#error "This file was generated using the moc from 3.3.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

const char *ServerForm::className() const
{
    return "ServerForm";
}

QMetaObject *ServerForm::metaObj = 0;
static QMetaObjectCleanUp cleanUp_ServerForm( "ServerForm", &ServerForm::staticMetaObject );

#ifndef QT_NO_TRANSLATION
QString ServerForm::tr( const char *s, const char *c )
{
    if ( qApp )
	return qApp->translate( "ServerForm", s, c, QApplication::DefaultCodec );
    else
	return QString::fromLatin1( s );
}
#ifndef QT_NO_TRANSLATION_UTF8
QString ServerForm::trUtf8( const char *s, const char *c )
{
    if ( qApp )
	return qApp->translate( "ServerForm", s, c, QApplication::UnicodeUTF8 );
    else
	return QString::fromUtf8( s );
}
#endif // QT_NO_TRANSLATION_UTF8

#endif // QT_NO_TRANSLATION

QMetaObject* ServerForm::staticMetaObject()
{
    if ( metaObj )
	return metaObj;
    QMetaObject* parentObject = QDialog::staticMetaObject();
    static const QUMethod slot_0 = {"pushButton1_clicked", 0, 0 };
    static const QUMethod slot_1 = {"socket_readyBytes", 0, 0 };
    static const QUMethod slot_2 = {"languageChange", 0, 0 };
    static const QMetaData slot_tbl[] = {
	{ "pushButton1_clicked()", &slot_0, QMetaData::Public },
	{ "socket_readyBytes()", &slot_1, QMetaData::Public },
	{ "languageChange()", &slot_2, QMetaData::Protected }
    };
    metaObj = QMetaObject::new_metaobject(
	"ServerForm", parentObject,
	slot_tbl, 3,
	0, 0,
#ifndef QT_NO_PROPERTIES
	0, 0,
	0, 0,
#endif // QT_NO_PROPERTIES
	0, 0 );
    cleanUp_ServerForm.setMetaObject( metaObj );
    return metaObj;
}

void* ServerForm::qt_cast( const char* clname )
{
    if ( !qstrcmp( clname, "ServerForm" ) )
	return this;
    return QDialog::qt_cast( clname );
}

bool ServerForm::qt_invoke( int _id, QUObject* _o )
{
    switch ( _id - staticMetaObject()->slotOffset() ) {
    case 0: pushButton1_clicked(); break;
    case 1: socket_readyBytes(); break;
    case 2: languageChange(); break;
    default:
	return QDialog::qt_invoke( _id, _o );
    }
    return TRUE;
}

bool ServerForm::qt_emit( int _id, QUObject* _o )
{
    return QDialog::qt_emit(_id,_o);
}
#ifndef QT_NO_PROPERTIES

bool ServerForm::qt_property( int id, int f, QVariant* v)
{
    return QDialog::qt_property( id, f, v);
}

bool ServerForm::qt_static_property( QObject* , int , int , QVariant* ){ return FALSE; }
#endif // QT_NO_PROPERTIES
