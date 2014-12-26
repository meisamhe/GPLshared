//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit10.h"
#include "Unit2.h"
#include "def.h"
#include <stdlib.h>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TanbarReportForm *anbarReportForm;
//---------------------------------------------------------------------------
__fastcall TanbarReportForm::TanbarReportForm(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TanbarReportForm::backBtnClick(TObject *Sender)
{
        anbarForm->Show();
        anbarReportForm->Hide();
}
//---------------------------------------------------------------------------
void __fastcall TanbarReportForm::reportRadioClick(TObject *Sender)
{
        if (reportRadio->ItemIndex==0)
        {
                reportBtn->Visible=true;
                label2->Visible=true;
                dayLabel->Visible=true;
                monthLabel->Visible=false;
                yearLabel->Visible=false;
                date->Visible=true;
                monthEdit->Visible=false;
                yearEdit->Visible=false;
        }
        else if (reportRadio->ItemIndex==1)
        {
                reportBtn->Visible=true;
                label2->Visible=true;
                dayLabel->Visible=false;
                monthLabel->Visible=true;
                yearLabel->Visible=false;
                date->Visible=false;
                monthEdit->Visible=true;
                yearEdit->Visible=false;
        }//end else
        else
        {
                reportBtn->Visible=true;
                label2->Visible=true;
                dayLabel->Visible=false;
                monthLabel->Visible=false;
                yearLabel->Visible=true;
                date->Visible=false;
                monthEdit->Visible=false;
                yearEdit->Visible=true;
        }//end else

}
//---------------------------------------------------------------------------

void __fastcall TanbarReportForm::reportBtnClick(TObject *Sender)
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
//-----------------------------------------
//Check the code for validate
        bool sw=true;
//        codeEdit->Text=code;
        char strCode[10];
        ltoa (code, strCode, 10);
        for (int i=0; i<10; i++)
        {
                if (strCode[i]=='0')
                {
                        Label3->Visible=true;
                        label2->Visible=false;
//                        Beep();
//                        sw=false;
                        return;
                }
        }//end for
//end checking
        label2->Visible=true;
        Label3->Visible=false;

        if (reportRadio->ItemIndex==0)
        {
                int seek = source.search(date->Text.c_str());
                if (seek==-1)
                {
                        dayCountEdit->Text="0";
                }//end if
                else
                {
                        int Count=0;
                        int tempCount=0;
                        char tempDate[10];
                        fseek (sourceFile, seek, SEEK_SET);
                        fread (tempDate, 10, 1, sourceFile);
                        while (strcmp (tempDate, date->Text.c_str()))
                        {
                                fread (&tempCount, sizeof(int), 1, sourceFile);
                                Count+=tempCount;
                                fseek (sourceFile, sizeof(long int)+sizeof(int), SEEK_CUR);
                                fread (tempDate, 10, 1, sourceFile);
                        }//end while
                        dayCountEdit->Text=Count;
                }//end else
        }//end if
        if (reportRadio->ItemIndex==1)
        {
                int dayCounter=2;
                AnsiString temp;
                temp=monthEdit->Text+"01";
                while (source.search(temp.c_str())==-1 && dayCounter<=31)
                {
                                if (dayCounter<10)
                                {
                                        temp=monthEdit->Text+"0"+dayCounter;
                                        dayCounter++;
                                }//end if
                                else
                                {
                                        temp=monthEdit->Text+dayCounter;
                                        dayCounter++;
                                }//end else
                }//end while
                if (dayCounter>31)
                {
                        monthCountList->Clear();

                }//end if
                else
                {
                        monthCountList->Clear();
//                        TObject obj;
//                        monthCountList->AddItem("0", obj);
                }//end else

        }//end if


}
//---------------------------------------------------------------------------

void __fastcall TanbarReportForm::seasonRadioClick(TObject *Sender)
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

void __fastcall TanbarReportForm::casualRadioClick(TObject *Sender)
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


void __fastcall TanbarReportForm::colorComboSelect(TObject *Sender)
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


