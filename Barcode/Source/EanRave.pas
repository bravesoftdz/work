unit EanRave;

interface

uses Classes, RvClass, RVCsStd;

{$IFDEF DESIGNER}
  {$R *.RES}
{$ENDIF}

type
  TRaveEan=class(TRaveControl)
  end;
  TRaveDBEan=class(TRaveEan)
  end;

  procedure RaveRegister;

implementation


procedure RaveRegister;
begin
  RegisterRaveGroup('PSOFT','PSOFT Barcode');
  RegisterRaveComponents('PSOFT',[TRaveEan,TRaveDBEan]);
  RegisterRaveProperties(TRaveEan,
     {Beginner}     '',
     {Intermediate} '',
     {Developer}    '',
     {Hidden}       '');
  RegisterRaveProperties(TRaveDBEan,
     {Beginner}     '',
     {Intermediate} '',
     {Developer}    '',
     {Hidden}       '');

end;

initialization

  RegisterProc('RVCL',RaveRegister);

end.
