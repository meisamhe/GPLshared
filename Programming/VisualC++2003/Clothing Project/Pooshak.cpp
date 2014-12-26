//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
//---------------------------------------------------------------------------
USEFORM("Unit1.cpp", Form1);
USEFORM("Unit4.cpp", sellForm);
USEFORM("Unit5.cpp", configForm);
USEFORM("Unit6.cpp", storeReportForm);
USEFORM("Unit7.cpp", addForm);
USEFORM("Unit8.cpp", changeForm);
USEFORM("Unit9.cpp", insertForm);
USEFORM("Unit10.cpp", anbarReportForm);
USEFORM("Unit2.cpp", anbarForm);
USEFORM("Unit3.cpp", storeForm);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
        try
        {
                 Application->Initialize();
                 Application->CreateForm(__classid(TForm1), &Form1);
                 Application->CreateForm(__classid(TsellForm), &sellForm);
                 Application->CreateForm(__classid(TconfigForm), &configForm);
                 Application->CreateForm(__classid(TstoreReportForm), &storeReportForm);
                 Application->CreateForm(__classid(TaddForm), &addForm);
                 Application->CreateForm(__classid(TchangeForm), &changeForm);
                 Application->CreateForm(__classid(TinsertForm), &insertForm);
                 Application->CreateForm(__classid(TanbarReportForm), &anbarReportForm);
                 Application->CreateForm(__classid(TanbarForm), &anbarForm);
                 Application->CreateForm(__classid(TstoreForm), &storeForm);
                 Application->Run();
        }
        catch (Exception &exception)
        {
                 Application->ShowException(&exception);
        }
        catch (...)
        {
                 try
                 {
                         throw Exception("");
                 }
                 catch (Exception &exception)
                 {
                         Application->ShowException(&exception);
                 }
        }
        return 0;
}
//---------------------------------------------------------------------------
