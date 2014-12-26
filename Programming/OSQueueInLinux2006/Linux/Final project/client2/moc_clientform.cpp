/****************************************************************************
** ClientForm meta object code from reading C++ file 'clientform.h'
**
** Created: Fri Jun 30 17:34:15 2006
**      by: The Qt MOC ($Id: qt/moc_yacc.cpp   3.3.5   edited Sep 2 14:41 $)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#undef QT_NO_COMPAT
#include "clientform.h"
#include <qmetaobject.h>
#include <qapplication.h>

#include <private/qucomextra_p.h>
#if !defined(Q_MOC_OUTPUT_REVISION) || (Q_MOC_OUTPUT_REVISION != 26)
#error "This file was generated using the moc from 3.3.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

const char *ClientForm::className() const
{
    return "ClientForm";
}

QMetaObject *ClientForm::metaObj = 0;
static QMetaObjectCleanUp cleanUp_ClientForm( "ClientForm", &ClientForm::staticMetaObject );

#ifndef QT_NO_TRANSLATION
QString ClientForm::tr( const char *s, const char *c )
{
    if ( qApp )
	return qApp->translate( "ClientForm", s, c, QApplication::DefaultCodec );
    else
	return QString::fromLatin1( s );
}
#ifndef QT_NO_TRANSLATION_UTF8
QString ClientForm::trUtf8( const char *s, const char *c )
{
    if ( qApp )
	return qApp->translate( "ClientForm", s, c, QApplication::UnicodeUTF8 );
    else
	return QString::fromUtf8( s );
}
#endif // QT_NO_TRANSLATION_UTF8

#endif // QT_NO_TRANSLATION

QMetaObject* ClientForm::staticMetaObject()
{
    if ( metaObj )
	return metaObj;
    QMetaObject* parentObject = QDialog::staticMetaObject();
    static const QUMethod slot_0 = {"startButton_clicked", 0, 0 };
    static const QUMethod slot_1 = {"sendButton_clicked", 0, 0 };
    static const QUMethod slot_2 = {"socket_connected", 0, 0 };
    static const QUMethod slot_3 = {"socket_readyRead", 0, 0 };
    static const QUMethod slot_4 = {"languageChange", 0, 0 };
    static const QMetaData slot_tbl[] = {
	{ "startButton_clicked()", &slot_0, QMetaData::Public },
	{ "sendButton_clicked()", &slot_1, QMetaData::Public },
	{ "socket_connected()", &slot_2, QMetaData::Public },
	{ "socket_readyRead()", &slot_3, QMetaData::Public },
	{ "languageChange()", &slot_4, QMetaData::Protected }
    };
    metaObj = QMetaObject::new_metaobject(
	"ClientForm", parentObject,
	slot_tbl, 5,
	0, 0,
#ifndef QT_NO_PROPERTIES
	0, 0,
	0, 0,
#endif // QT_NO_PROPERTIES
	0, 0 );
    cleanUp_ClientForm.setMetaObject( metaObj );
    return metaObj;
}

void* ClientForm::qt_cast( const char* clname )
{
    if ( !qstrcmp( clname, "ClientForm" ) )
	return this;
    return QDialog::qt_cast( clname );
}

bool ClientForm::qt_invoke( int _id, QUObject* _o )
{
    switch ( _id - staticMetaObject()->slotOffset() ) {
    case 0: startButton_clicked(); break;
    case 1: sendButton_clicked(); break;
    case 2: socket_connected(); break;
    case 3: socket_readyRead(); break;
    case 4: languageChange(); break;
    default:
	return QDialog::qt_invoke( _id, _o );
    }
    return TRUE;
}

bool ClientForm::qt_emit( int _id, QUObject* _o )
{
    return QDialog::qt_emit(_id,_o);
}
#ifndef QT_NO_PROPERTIES

bool ClientForm::qt_property( int id, int f, QVariant* v)
{
    return QDialog::qt_property( id, f, v);
}

bool ClientForm::qt_static_property( QObject* , int , int , QVariant* ){ return FALSE; }
#endif // QT_NO_PROPERTIES
