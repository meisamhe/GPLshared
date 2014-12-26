/****************************************************************************
** os1frm meta object code from reading C++ file 'form1.h'
**
** Created: Mon May 15 11:38:26 2006
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

const char *os1frm::className() const
{
    return "os1frm";
}

QMetaObject *os1frm::metaObj = 0;
static QMetaObjectCleanUp cleanUp_os1frm( "os1frm", &os1frm::staticMetaObject );

#ifndef QT_NO_TRANSLATION
QString os1frm::tr( const char *s, const char *c )
{
    if ( qApp )
	return qApp->translate( "os1frm", s, c, QApplication::DefaultCodec );
    else
	return QString::fromLatin1( s );
}
#ifndef QT_NO_TRANSLATION_UTF8
QString os1frm::trUtf8( const char *s, const char *c )
{
    if ( qApp )
	return qApp->translate( "os1frm", s, c, QApplication::UnicodeUTF8 );
    else
	return QString::fromUtf8( s );
}
#endif // QT_NO_TRANSLATION_UTF8

#endif // QT_NO_TRANSLATION

QMetaObject* os1frm::staticMetaObject()
{
    if ( metaObj )
	return metaObj;
    QMetaObject* parentObject = QDialog::staticMetaObject();
    static const QUMethod slot_0 = {"send", 0, 0 };
    static const QUMethod slot_1 = {"recieveResult", 0, 0 };
    static const QUMethod slot_2 = {"languageChange", 0, 0 };
    static const QMetaData slot_tbl[] = {
	{ "send()", &slot_0, QMetaData::Public },
	{ "recieveResult()", &slot_1, QMetaData::Public },
	{ "languageChange()", &slot_2, QMetaData::Protected }
    };
    metaObj = QMetaObject::new_metaobject(
	"os1frm", parentObject,
	slot_tbl, 3,
	0, 0,
#ifndef QT_NO_PROPERTIES
	0, 0,
	0, 0,
#endif // QT_NO_PROPERTIES
	0, 0 );
    cleanUp_os1frm.setMetaObject( metaObj );
    return metaObj;
}

void* os1frm::qt_cast( const char* clname )
{
    if ( !qstrcmp( clname, "os1frm" ) )
	return this;
    return QDialog::qt_cast( clname );
}

bool os1frm::qt_invoke( int _id, QUObject* _o )
{
    switch ( _id - staticMetaObject()->slotOffset() ) {
    case 0: send(); break;
    case 1: recieveResult(); break;
    case 2: languageChange(); break;
    default:
	return QDialog::qt_invoke( _id, _o );
    }
    return TRUE;
}

bool os1frm::qt_emit( int _id, QUObject* _o )
{
    return QDialog::qt_emit(_id,_o);
}
#ifndef QT_NO_PROPERTIES

bool os1frm::qt_property( int id, int f, QVariant* v)
{
    return QDialog::qt_property( id, f, v);
}

bool os1frm::qt_static_property( QObject* , int , int , QVariant* ){ return FALSE; }
#endif // QT_NO_PROPERTIES
