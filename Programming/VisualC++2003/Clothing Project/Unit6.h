//---------------------------------------------------------------------------

#ifndef Unit6H
#define Unit6H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
class TstoreReportForm : public TForm
{
__published:	// IDE-managed Components
        TLabel *Label1;
        TButton *backBtn;
        void __fastcall backBtnClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TstoreReportForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TstoreReportForm *storeReportForm;
//---------------------------------------------------------------------------
#endif
