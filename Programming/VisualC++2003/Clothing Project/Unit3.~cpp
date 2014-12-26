//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
#include "Unit3.h"
#include "Unit4.h"
#include "Unit5.h"
#include "Unit6.h"


//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TstoreForm *storeForm;
//---------------------------------------------------------------------------
__fastcall TstoreForm::TstoreForm(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TstoreForm::configBtnClick(TObject *Sender)
{
        configForm->Show();
        storeForm->Hide();

}
//---------------------------------------------------------------------------
void __fastcall TstoreForm::reportBtnClick(TObject *Sender)
{
        storeReportForm->Show();
        storeForm->Hide();
}
//---------------------------------------------------------------------------
void __fastcall TstoreForm::backBtnClick(TObject *Sender)
{
        Form1->Show();
        storeForm->Hide();
}
//---------------------------------------------------------------------------
void __fastcall TstoreForm::sellBtnClick(TObject *Sender)
{
        sellForm->Show();
        storeForm->Hide();        
}
//---------------------------------------------------------------------------

