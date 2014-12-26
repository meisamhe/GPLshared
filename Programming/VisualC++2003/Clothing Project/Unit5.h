//---------------------------------------------------------------------------

#ifndef Unit5H
#define Unit5H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
class TconfigForm : public TForm
{
__published:	// IDE-managed Components
        TLabel *Label1;
        TButton *backBtn;
        void __fastcall backBtnClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TconfigForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TconfigForm *configForm;
//---------------------------------------------------------------------------
#endif
