//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
#include "Unit2.h"
#include "Unit3.h"
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------


void __fastcall TForm1::exitbtnClick(TObject *Sender)
{
        fcloseall();
        exit(0);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::storebtnMouseMove(TObject *Sender,
      TShiftState Shift, int X, int Y)
{
        storebtn->Cursor=crHandPoint;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::anbarbtnMouseMove(TObject *Sender,
      TShiftState Shift, int X, int Y)
{
        anbarbtn->Cursor=crHandPoint;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::storebtnClick(TObject *Sender)
{
       storeForm->Show();
       Form1->Hide();
}
//---------------------------------------------------------------------------
void __fastcall TForm1::anbarbtnClick(TObject *Sender)
{
       anbarForm->Show();
       Form1->Hide();
}
//---------------------------------------------------------------------------


void __fastcall TForm1::FormCreate(TObject *Sender)
{
        sellFile = fopen("C:\\sell.dat", "r+b");
        incomeFile = fopen("C:\\income.dat", "r+b");
        customerFile = fopen("C:\\customer.dat", "r+b");
        goodsFile = fopen("C:\\goods.dat", "r+b");
        sourceFile = fopen("C:\\source.dat", "r+b");
        char temp[10];
        int count=0;
        long int code=0;
        fread(temp, 10*sizeof(char), 1, sellFile);
        while (!feof(sellFile))
        {
                sell.insert(temp, count);
                count+=(10*sizeof(char)+2*sizeof(long int)+4*sizeof(int));
                fseek(sellFile, count, SEEK_SET);
                fread(temp, 10*sizeof(char), 1, sellFile);
        }//end while
        count=0;
        fread(temp, 10*sizeof(char), 1, incomeFile);
        while (!feof(incomeFile))
        {
                income.insert(temp, count);
                count+=(10*sizeof(char)+5*sizeof(int));
                fseek(incomeFile, count, SEEK_SET);
                fread(temp, 10*sizeof(char), 1, incomeFile);
        }//end while
        count=0;
        fread(temp, 10*sizeof(char), 1, sourceFile);
        while (!feof(sourceFile))
        {
                source.insert(temp, count);
                count+=(10*sizeof(char)+2*sizeof(int)+sizeof(long int));
                fseek(sourceFile, count, SEEK_SET);
                fread(temp, 10*sizeof(char), 1, sourceFile);
        }//end while
        count=0;
        long int tempCode;
        fread(&tempCode, sizeof(long int), 1, goodsFile);
        while (!feof(goodsFile))
        {
                good.insert(tempCode, count);
                count+=(5*sizeof(int)+sizeof(long int));
                fseek(goodsFile, count, SEEK_SET);
                fread(&tempCode, sizeof(long int), 1, goodsFile);
        }//end while
}
//---------------------------------------------------------------------------


