//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#pragma link "gdiplus.lib"
USERES("AdvOfficeTabSetPkgC5.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("AdvOfficeTabSetRegDE.pas");
USEUNIT("AdvOfficeTabSetReg.pas");
USERES("AdvOfficeTabSetReg.dcr");
USEPACKAGE("vcldb50.bpi");
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
