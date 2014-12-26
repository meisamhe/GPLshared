/****************************************************************************
** clientfrm meta object code from reading C++ file 'form1.h'
**
** Created: Sun Jul 2 13:48:32 2006
**      by: The Qt MOC ($Id: qt/moc_yacc.cpp   3.3.4   edited Jan 21 18:14 $)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#undef QT_NO_COMPAT
#include "../.ui/form1.h"
#include <qmetaobject.h>
#include <qapplication.h>

#include <private/qucomextra_p.h>
#if !defined(Q_MOC_OUTPUT_REVISION) || (Q_MOC_OUTPUT_REVISION != 26)
#error "This file was generated using the moc from 3.3.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

const char *clientfrm::className() const
{
    return "clientfrm";
}

QMetaObject *clientfrm::metaObj = 0;
static QMetaObjectCleanUp cleanUp_clientfrm( "clientfrm", &clientfrm::staticMetaObject );

#ifndef QT_NO_TRANSLATION
QString clientfrm::tr( const char *s, const char *c )
{
    if ( qApp )
	return qApp->translate( "clientfrm", s, c, QApplication::DefaultCodec );
    else
	return QString::fromLatin1( s );
}
#ifndef QT_NO_TRANSLATION_UTF8
QString clientfrm::trUtf8( const char *s, const char *c )
{
    if ( qApp )
	return qApp->translate( "clientfrm", s, c, QApplication::UnicodeUTF8 );
    else
	return QString::fromUtf8( s );
}
#endif // QT_NO_TRANSLATION_UTF8

#endif // QT_NO_TRANSLATION

QMetaObject* clientfrm::staticMetaObject()
{
    if ( metaObj )
	return metaObj;
    QMetaObject* parentObject = QDialog::staticMetaObject();
    static const QUParameter param_slot_0[] = {
	{ 0, &static_QUType_QString, 0, QUParameter::Out }
    };
    static const QUMethod slot_0 = {"sendCommand", 1, param_slot_0 };
    static const QUMethod slot_1 = {"send", 0, 0 };
    static const QUMethod slot_2 = {"languageChange", 0, 0 };
    static const QMetaData slot_tbl[] = {
	{ "sendCommand()", &slot_0, QMetaData::Public },
	{ "send()", &slot_1, QMetaData::Public },
	{ "languageChange()", &slot_2, QMetaData::Protected }
    };
    metaObj = QMetaObject::new_metaobject(
	"clientfrm", parentObject,
	slot_tbl, 3,
	0, 0,
#ifndef QT_NO_PROPERTIES
	0, 0,
	0, 0,
#endif // QT_NO_PROPERTIES
	0, 0 );
    cleanUp_clientfrm.setMetaObject( metaObj );
    return metaObj;
}

void* clientfrm::qt_cast( const char* clname )
{
    if ( !qstrcmp( clname, "clientfrm" ) )
	return this;
    return QDialog::qt_cast( clname );
}

bool clientfrm::qt_invoke( int _id, QUObject* _o )
{
    switch ( _id - staticMetaObject()->slotOffset() ) {
    case 0: static_QUType_QString.set(_o,sendCommand()); break;
    case 1: send(); break;
    case 2: languageChange(); break;
    default:
	return QDialog::qt_invoke( _id, _o );
    }
    return TRUE;
}

bool clientfrm::qt_emit( int _id, QUObject* _o )
{
    return QDialog::qt_emit(_id,_o);
}
#ifndef QT_NO_PROPERTIES

bool clientfrm::qt_property( int id, int f, QVariant* v)
{
    return QDialog::qt_property( id, f, v);
}

bool clientfrm::qt_static_property( QObject* , int , int , QVariant* ){ return FALSE; }
#endif // QT_NO_PROPERTIES
