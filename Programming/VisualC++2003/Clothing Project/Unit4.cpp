//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit4.h"
#include "Unit3.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TsellForm *sellForm;
//---------------------------------------------------------------------------
__fastcall TsellForm::TsellForm(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TsellForm::backBtnClick(TObject *Sender)
{
        storeForm->Show();
        sellForm->Hide();
}
//---------------------------------------------------------------------------
