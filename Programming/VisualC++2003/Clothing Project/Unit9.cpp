//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include <stdio.h>
#include <io.h>
#include "dateBst.h"
#include "codeBst.h"
#include "def.h"
#include "Unit9.h"
#include "Unit2.H"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TinsertForm *insertForm;
//---------------------------------------------------------------------------
__fastcall TinsertForm::TinsertForm(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TinsertForm::backBtnClick(TObject *Sender)
{
        anbarForm->Show();
        insertForm->Hide();
}
//---------------------------------------------------------------------------

void __fastcall TinsertForm::colorComboSelect(TObject *Sender)
{
        if (colorCombo->ItemIndex==0) colorEdit->Color=clRed;
        if (colorCombo->ItemIndex==1) colorEdit->Color=clBlue;
        if (colorCombo->ItemIndex==2) colorEdit->Color=clWhite;
        if (colorCombo->ItemIndex==3) colorEdit->Color=clBlack;
        if (colorCombo->ItemIndex==4) colorEdit->Color=clGreen;
        if (colorCombo->ItemIndex==5) colorEdit->Color=clYellow;
        if (colorCombo->ItemIndex==6) colorEdit->Color=clPurple;
        if (colorCombo->ItemIndex==7) colorEdit->Color=clCream;
        if (colorCombo->ItemIndex==8) colorEdit->Color=clGray;
}
//---------------------------------------------------------------------------

void __fastcall TinsertForm::seasonRadioClick(TObject *Sender)
{
        if (seasonRadio->ItemIndex==0)
        {
                coolwarmCombo->Text="Select Cooling Degree";
                lengthCombo->Text="Select Shortness";
        }
        if (seasonRadio->ItemIndex==1)
        {
                coolwarmCombo->Text="Select Warming Degree";
                lengthCombo->Text="Select Longness";
        }
        if (seasonRadio->ItemIndex==0)
        {
                if (casualRadio->ItemIndex==0)
                {
                        itemCombo00->Show();
                        itemCombo01->Hide();
                        itemCombo02->Hide();
                        itemCombo10->Hide();
                        itemCombo11->Hide();
                        itemCombo12->Hide();
                        tripCombo->Show();
                        zerafatCombo->Hide();
                        pictureCombo->Hide();
                        tangiCombo->Hide();
                }
                if (casualRadio->ItemIndex==1)
                {
                        itemCombo00->Hide();
                        itemCombo01->Show();
                        itemCombo02->Hide();
                        itemCombo10->Hide();
                        itemCombo11->Hide();
                        itemCombo12->Hide();
                        tripCombo->Hide();
                        zerafatCombo->Hide();
                        pictureCombo->Show();
                        tangiCombo->Hide();
                }
                if (casualRadio->ItemIndex==2)
                {
                        itemCombo00->Hide();
                        itemCombo01->Hide();
                        itemCombo02->Show();
                        itemCombo10->Hide();
                        itemCombo11->Hide();
                        itemCombo12->Hide();
                        tripCombo->Hide();
                        zerafatCombo->Show();
                        pictureCombo->Hide();
                        tangiCombo->Show();
                }
        }
        if (seasonRadio->ItemIndex==1)
        {
                if (casualRadio->ItemIndex==0)
                {
                        itemCombo00->Hide();
                        itemCombo01->Hide();
                        itemCombo02->Hide();
                        itemCombo10->Show();
                        itemCombo11->Hide();
                        itemCombo12->Hide();
                        tripCombo->Show();
                        zerafatCombo->Hide();
                        pictureCombo->Hide();
                        tangiCombo->Hide();
                }
                if (casualRadio->ItemIndex==1)
                {
                        itemCombo00->Hide();
                        itemCombo01->Hide();
                        itemCombo02->Hide();
                        itemCombo10->Hide();
                        itemCombo11->Show();
                        itemCombo12->Hide();
                        tripCombo->Hide();
                        zerafatCombo->Hide();
                        pictureCombo->Show();
                        tangiCombo->Hide();
                }
                if (casualRadio->ItemIndex==2)
                {
                        itemCombo00->Hide();
                        itemCombo01->Hide();
                        itemCombo02->Hide();
                        itemCombo10->Hide();
                        itemCombo11->Hide();
                        itemCombo12->Show();
                        tripCombo->Hide();
                        zerafatCombo->Show();
                        pictureCombo->Hide();
                        tangiCombo->Show();
                }
        }


}
//---------------------------------------------------------------------------

void __fastcall TinsertForm::casualRadioClick(TObject *Sender)
{
        if (seasonRadio->ItemIndex==0)
        {
                if (casualRadio->ItemIndex==0)
                {
                        itemCombo00->Show();
                        itemCombo01->Hide();
                        itemCombo02->Hide();
                        itemCombo10->Hide();
                        itemCombo11->Hide();
                        itemCombo12->Hide();
                        tripCombo->Show();
                        zerafatCombo->Hide();
                        pictureCombo->Hide();
                        tangiCombo->Hide();
                }
                if (casualRadio->ItemIndex==1)
                {
                        itemCombo00->Hide();
                        itemCombo01->Show();
                        itemCombo02->Hide();
                        itemCombo10->Hide();
                        itemCombo11->Hide();
                        itemCombo12->Hide();
                        tripCombo->Hide();
                        zerafatCombo->Hide();
                        pictureCombo->Show();
                        tangiCombo->Hide();
                }
                if (casualRadio->ItemIndex==2)
                {
                        itemCombo00->Hide();
                        itemCombo01->Hide();
                        itemCombo02->Show();
                        itemCombo10->Hide();
                        itemCombo11->Hide();
                        itemCombo12->Hide();
                        tripCombo->Hide();
                        zerafatCombo->Show();
                        pictureCombo->Hide();
                        tangiCombo->Show();
                }
        }
        if (seasonRadio->ItemIndex==1)
        {
                if (casualRadio->ItemIndex==0)
                {
                        itemCombo00->Hide();
                        itemCombo01->Hide();
                        itemCombo02->Hide();
                        itemCombo10->Show();
                        itemCombo11->Hide();
                        itemCombo12->Hide();
                        tripCombo->Show();
                        zerafatCombo->Hide();
                        pictureCombo->Hide();
                        tangiCombo->Hide();
                }
                if (casualRadio->ItemIndex==1)
                {
                        itemCombo00->Hide();
                        itemCombo01->Hide();
                        itemCombo02->Hide();
                        itemCombo10->Hide();
                        itemCombo11->Show();
                        itemCombo12->Hide();
                        tripCombo->Hide();
                        zerafatCombo->Hide();
                        pictureCombo->Show();
                        tangiCombo->Hide();
                }
                if (casualRadio->ItemIndex==2)
                {
                        itemCombo00->Hide();
                        itemCombo01->Hide();
                        itemCombo02->Hide();
                        itemCombo10->Hide();
                        itemCombo11->Hide();
                        itemCombo12->Show();
                        tripCombo->Hide();
                        zerafatCombo->Show();
                        pictureCombo->Hide();
                        tangiCombo->Show();
                }
        }


}
//---------------------------------------------------------------------------

void __fastcall TinsertForm::registerBtnClick(TObject *Sender)
{
//Generate Code of Good
        long int code=0;
        code=code*10+(seasonRadio->ItemIndex+1);
        code=code*10+(casualRadio->ItemIndex+1);
        code=code*10+(colorCombo->ItemIndex+1);
        code=code*10+(kindCombo->ItemIndex+1);
        code=code*10+(sizeCombo->ItemIndex+1);
        code=code*10+(coolwarmCombo->ItemIndex+1);
        code=code*10+(lengthCombo->ItemIndex+1);
        if (seasonRadio->ItemIndex==0)
        {
                if (casualRadio->ItemIndex==0)
                {
                        code=code*10+(itemCombo00->ItemIndex+1);
                        code=code*10+(tripCombo->ItemIndex+1);
                        code=code*10+(1);
                }
                if (casualRadio->ItemIndex==1)
                {
                        code=code*10+(itemCombo01->ItemIndex+1);
                        code=code*10+(pictureCombo->ItemIndex+1);
                        code=code*10+(1);
                }
                if (casualRadio->ItemIndex==2)
                {
                        code=code*10+(itemCombo02->ItemIndex+1);
                        code=code*10+(zerafatCombo->ItemIndex+1);
                        code=code*10+(tangiCombo->ItemIndex+1);
                }
        }
        if (seasonRadio->ItemIndex==1)
        {
                if (casualRadio->ItemIndex==0)
                {
                        code=code*10+(itemCombo10->ItemIndex+1);
                        code=code*10+(tripCombo->ItemIndex+1);
                        code=code*10+(1);
                }
                if (casualRadio->ItemIndex==1)
                {
                        code=code*10+(itemCombo11->ItemIndex+1);
                        code=code*10+(pictureCombo->ItemIndex+1);
                        code=code*10+(1);
                }
                if (casualRadio->ItemIndex==2)
                {
                        code=code*10+(itemCombo12->ItemIndex+1);
                        code=code*10+(zerafatCombo->ItemIndex+1);
                        code=code*10+(tangiCombo->ItemIndex+1);
                }
        }
//End Generating Code
//---------------------------------
//Check the code for validate
        bool sw=true;
        codeEdit->Text=code;
        char strCode[10];
        ltoa (code, strCode, 10);
        for (int i=0; i<10; i++)
        {
                if (strCode[i]=='0')
                {
                  codeEdit->Text="Invalid Code";
                  Beep();
                  sw=false;
                }
        }//end for
//end checking
//---------------------------------
//insert in trees and files
        if (sw==true)
        {
                int seek=good.search(code);
                int tempCode=0;
                if (seek>=0)
                {
                        fseek(goodsFile, seek+sizeof(long int), SEEK_SET);
                        int count=0;
                        fread(&count, sizeof(int), 1, goodsFile);
                        count=count+MaskEdit1->Text.ToInt();
                        fseek (goodsFile, -sizeof(int), SEEK_CUR);
                        fwrite(&count, sizeof(int), 1, goodsFile);
                }//end if
                else
                {
//                        fseek (goodsFile, 6*sizeof(int)+sizeof(long int), SEEK_END);
                        fseek (goodsFile, 0, SEEK_END);
//                        fread(&tempCode, sizeof(long int), 1, goodsFile);
//                        good.insert(code, good.search(tempCode)+sizeof(long int)+6*sizeof(int));
                        good.insert(code, ftell(goodsFile));
//                        fseek(goodsFile, 0, SEEK_END);
                        fwrite(&code, sizeof(long int), 1, goodsFile);
                        int tempInt=0;
                        tempInt=MaskEdit1->Text.ToInt();
                        fwrite(&tempInt, sizeof(int), 1, goodsFile);
                        tempInt=MaskEdit2->Text.ToInt();
                        fwrite(&tempInt, sizeof(int), 1, goodsFile);
                        tempInt=MaskEdit3->Text.ToInt();
                        fwrite(&tempInt, sizeof(int), 1, goodsFile);
                        tempInt=MaskEdit4->Text.ToInt();
                        fwrite(&tempInt, sizeof(int), 1, goodsFile);
                        tempInt=MaskEdit5->Text.ToInt();
                        fwrite(&tempInt, sizeof(int), 1, goodsFile);
                        tempInt=MaskEdit6->Text.ToInt();
                        fwrite(&tempInt, sizeof(int), 1, goodsFile);
                }//end else
                if (!feof(sourceFile))
                {
                        char tempDate[10];
                        fseek(sourceFile, -(10+2*sizeof(int)+sizeof(long int)), SEEK_END);
                        fread(tempDate, 10, 1, sourceFile);
                        if (strcmp (tempDate, systemDate)!=0)
                        {
                                fseek(sourceFile, 0, SEEK_END);
                                source.insert(systemDate, ftell(sourceFile));
                        }//end if
                }//end if
                else
                {
                        source.insert(systemDate, 0);

                }//end else
                fseek(sourceFile, 0, SEEK_END);
                fwrite(systemDate, 10, 1, sourceFile);
                int tempInt=0;
                tempInt=MaskEdit1->Text.ToInt();
                fwrite(&tempInt, sizeof(int), 1, sourceFile);
                fwrite(&code, sizeof(long int), 1, sourceFile);
                tempInt=MaskEdit2->Text.ToInt();
                fwrite(&tempInt, sizeof(int), 1, sourceFile);
        }//end if


}//end
//---------------------------------------------------------------------------






