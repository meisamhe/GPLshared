//---------------------------------------------------------------------------

#ifndef Unit1H
#define Unit1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Graphics.hpp>
//------------------------------------------
#include "def.h"
#include <stdio.h>
#include <io.h>
#include "dateBst.h"
#include "codeBst.h"
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
        TButton *exitbtn;
        TImage *supporimg;
        TImage *storeimg;
        TButton *storebtn;
        TButton *anbarbtn;
        TLabel *Label1;
        void __fastcall exitbtnClick(TObject *Sender);
        void __fastcall storebtnMouseMove(TObject *Sender,
          TShiftState Shift, int X, int Y);
        void __fastcall anbarbtnMouseMove(TObject *Sender,
          TShiftState Shift, int X, int Y);
        void __fastcall storebtnClick(TObject *Sender);
        void __fastcall anbarbtnClick(TObject *Sender);
        void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
