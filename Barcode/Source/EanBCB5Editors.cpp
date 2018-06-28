//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("EanBCB5Editors.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("EanRegEditors.pas");
USEPACKAGE("qrpt50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("vclbde50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("EanBCB5.bpi");
USEFORM("EanBCB5Editors.cpp", Form1);
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
