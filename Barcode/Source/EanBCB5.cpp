 //---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("EanBCB5.res");
USEUNIT("EanReg.pas");
USEPACKAGE("Vcl50.bpi");
USEPACKAGE("Vclx50.bpi");
USEPACKAGE("Vcldb50.bpi");
USEPACKAGE("VCLBDE50.bpi");
USEPACKAGE("Qrpt50.bpi");
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
