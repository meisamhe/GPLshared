//---------------------------------------------------------------------------

#ifndef Unit9H
#define Unit9H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Mask.hpp>
//---------------------------------------------------------------------------
class TinsertForm : public TForm
{
__published:	// IDE-managed Components
        TLabel *Label1;
        TButton *backBtn;
        TLabel *quantityLabel;
        TLabel *buyLabel;
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
        TEdit *codeEdit;
        TComboBox *itemCombo02;
        TComboBox *itemCombo01;
        TComboBox *itemCombo10;
        TComboBox *itemCombo12;
        TComboBox *itemCombo11;
        TComboBox *zerafatCombo;
        TComboBox *pictureCombo;
        TButton *registerBtn;
        TMaskEdit *MaskEdit1;
        TMaskEdit *MaskEdit2;
        TImage *Image1;
        TLabel *Label2;
        TLabel *sellLabel;
        TLabel *discountLabel;
        TLabel *seasonDisLabel;
        TLabel *Label7;
        TMaskEdit *MaskEdit3;
        TMaskEdit *MaskEdit4;
        TMaskEdit *MaskEdit5;
        TMaskEdit *MaskEdit6;
        void __fastcall backBtnClick(TObject *Sender);
        void __fastcall colorComboSelect(TObject *Sender);
        void __fastcall seasonRadioClick(TObject *Sender);
        void __fastcall casualRadioClick(TObject *Sender);
        void __fastcall registerBtnClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TinsertForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TinsertForm *insertForm;
//---------------------------------------------------------------------------
#endif
