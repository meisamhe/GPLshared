//---------------------------------------------------------------------------

#ifndef Unit10H
#define Unit10H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>
#include <Mask.hpp>
//---------------------------------------------------------------------------
class TanbarReportForm : public TForm
{
__published:	// IDE-managed Components
        TLabel *Label1;
        TButton *backBtn;
        TGroupBox *GroupBox1;
        TRadioGroup *seasonRadio;
        TRadioGroup *casualRadio;
        TComboBox *colorCombo;
        TEdit *colorEdit;
        TComboBox *kindCombo;
        TComboBox *sizeCombo;
        TComboBox *coolwarmCombo;
        TComboBox *lengthCombo;
        TComboBox *itemCombo00;
        TComboBox *tripCombo;
        TComboBox *tangiCombo;
        TComboBox *itemCombo02;
        TComboBox *itemCombo01;
        TComboBox *itemCombo10;
        TComboBox *itemCombo12;
        TComboBox *itemCombo11;
        TComboBox *zerafatCombo;
        TComboBox *pictureCombo;
        TRadioGroup *reportRadio;
        TMaskEdit *monthEdit;
        TMaskEdit *yearEdit;
        TLabel *dayLabel;
        TLabel *monthLabel;
        TLabel *yearLabel;
        TButton *reportBtn;
        TEdit *dayCountEdit;
        TLabel *label2;
        TListBox *monthCountList;
        TListBox *yearCountList;
        TGroupBox *GroupBox2;
        TLabel *Label3;
        TMaskEdit *date;
        void __fastcall backBtnClick(TObject *Sender);
        void __fastcall reportRadioClick(TObject *Sender);
        void __fastcall reportBtnClick(TObject *Sender);
        void __fastcall seasonRadioClick(TObject *Sender);
        void __fastcall casualRadioClick(TObject *Sender);
        void __fastcall colorComboSelect(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TanbarReportForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TanbarReportForm *anbarReportForm;
//---------------------------------------------------------------------------
#endif
