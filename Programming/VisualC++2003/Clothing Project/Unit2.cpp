//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
#include "Unit2.h"
#include "Unit7.h"
#include "Unit8.h"
#include "Unit9.h"
#include "Unit10.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TanbarForm *anbarForm;
//---------------------------------------------------------------------------
__fastcall TanbarForm::TanbarForm(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TanbarForm::addBtnClick(TObject *Sender)
{
        addForm->Show();
        anbarForm->Hide();
}
//---------------------------------------------------------------------------
void __fastcall TanbarForm::configureBtnClick(TObject *Sender)
{
        changeForm->Show();
        anbarForm->Hide();
}
//---------------------------------------------------------------------------
void __fastcall TanbarForm::insertBtnClick(TObject *Sender)
{
        insertForm->Show();
        anbarForm->Hide();
}
//---------------------------------------------------------------------------
void __fastcall TanbarForm::reportBtnClick(TObject *Sender)
{
        anbarReportForm->Show();
        anbarForm->Hide();
}
//---------------------------------------------------------------------------
void __fastcall TanbarForm::backBtnClick(TObject *Sender)
{
        Form1->Show();
        anbarForm->Hide();
}
//---------------------------------------------------------------------------


