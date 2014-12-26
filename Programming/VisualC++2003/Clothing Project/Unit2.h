//---------------------------------------------------------------------------

#ifndef Unit2H
#define Unit2H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
class TanbarForm : public TForm
{
__published:	// IDE-managed Components
        TLabel *Label1;
        TButton *addBtn;
        TButton *configureBtn;
        TButton *insertBtn;
        TButton *reportBtn;
        TButton *backBtn;
        void __fastcall addBtnClick(TObject *Sender);
        void __fastcall configureBtnClick(TObject *Sender);
        void __fastcall insertBtnClick(TObject *Sender);
        void __fastcall reportBtnClick(TObject *Sender);
        void __fastcall backBtnClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TanbarForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TanbarForm *anbarForm;
//---------------------------------------------------------------------------
#endif
