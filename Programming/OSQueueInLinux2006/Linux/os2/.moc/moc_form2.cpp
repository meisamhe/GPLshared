/****************************************************************************
** Form2 meta object code from reading C++ file 'form2.h'
**
** Created: Mon May 15 11:39:44 2006
**      by: The Qt MOC ($Id: qt/moc_yacc.cpp   3.3.4   edited Jan 21 18:14 $)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#undef QT_NO_COMPAT
#include "../.ui/form2.h"
#include <qmetaobject.h>
#include <qapplication.h>

#include <private/qucomextra_p.h>
#if !defined(Q_MOC_OUTPUT_REVISION) || (Q_MOC_OUTPUT_REVISION != 26)
#error "This file was generated using the moc from 3.3.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

const char *Form2::className() const
{
    return "Form2";
}

QMetaObject *Form2::metaObj = 0;
static QMetaObjectCleanUp cleanUp_Form2( "Form2", &Form2::staticMetaObject );

#ifndef QT_NO_TRANSLATION
QString Form2::tr( const char *s, const char *c )
{
    if ( qApp )
	return qApp->translate( "Form2", s, c, QApplication::DefaultCodec );
    else
	return QString::fromLatin1( s );
}
#ifndef QT_NO_TRANSLATION_UTF8
QString Form2::trUtf8( const char *s, const char *c )
{
    if ( qApp )
	return qApp->translate( "Form2", s, c, QApplication::UnicodeUTF8 );
    else
	return QString::fromUtf8( s );
}
#endif // QT_NO_TRANSLATION_UTF8

#endif // QT_NO_TRANSLATION

QMetaObject* Form2::staticMetaObject()
{
    if ( metaObj )
	return metaObj;
    QMetaObject* parentObject = QDialog::staticMetaObject();
    static const QUMethod slot_0 = {"recievePath", 0, 0 };
    static const QUMethod slot_1 = {"sendResult", 0, 0 };
    static const QUMethod slot_2 = {"run", 0, 0 };
    static const QUMethod slot_3 = {"languageChange", 0, 0 };
    static const QMetaData slot_tbl[] = {
	{ "recievePath()", &slot_0, QMetaData::Public },
	{ "sendResult()", &slot_1, QMetaData::Public },
	{ "run()", &slot_2, QMetaData::Public },
	{ "languageChange()", &slot_3, QMetaData::Protected }
    };
    metaObj = QMetaObject::new_metaobject(
	"Form2", parentObject,
	slot_tbl, 4,
	0, 0,
#ifndef QT_NO_PROPERTIES
	0, 0,
	0, 0,
#endif // QT_NO_PROPERTIES
	0, 0 );
    cleanUp_Form2.setMetaObject( metaObj );
    return metaObj;
}

void* Form2::qt_cast( const char* clname )
{
    if ( !qstrcmp( clname, "Form2" ) )
	return this;
    return QDialog::qt_cast( clname );
}

bool Form2::qt_invoke( int _id, QUObject* _o )
{
    switch ( _id - staticMetaObject()->slotOffset() ) {
    case 0: recievePath(); break;
    case 1: sendResult(); break;
    case 2: run(); break;
    case 3: languageChange(); break;
    default:
	return QDialog::qt_invoke( _id, _o );
    }
    return TRUE;
}

bool Form2::qt_emit( int _id, QUObject* _o )
{
    return QDialog::qt_emit(_id,_o);
}
#ifndef QT_NO_PROPERTIES

bool Form2::qt_property( int id, int f, QVariant* v)
{
    return QDialog::qt_property( id, f, v);
}

bool Form2::qt_static_property( QObject* , int , int , QVariant* ){ return FALSE; }
#endif // QT_NO_PROPERTIES
